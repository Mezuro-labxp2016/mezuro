class KalibroRangesController < ApplicationController
  before_action :set_interval_params, only: [:create, :update]

  def index
    respond_with_json(kalibro_ranges: @metric_configuration.kalibro_ranges) if set_metric_configuration
  end

  def show
    respond_with_json(kalibro_range: @kalibro_range) if set_kalibro_range
  end

  def create
    range = KalibroRange.new(kalibro_range_params)

    json = json_conversion(range)
    if range.save
      json['id'] = range.id
      respond_with_json({ kalibro_range: json }, :created)
    else
      respond_with_json({ errors: range.errors.full_messages }, :unprocessable_entity)
    end
  end

  def update
    if set_kalibro_range
      successful_update = @kalibro_range.update(kalibro_range_params)
      json = json_conversion(@kalibro_range)
      if successful_update
        respond_with_json({ kalibro_range: json }, :created)
      else
        respond_with_json({ errors: @kalibro_range.errors.full_messages }, :unprocessable_entity)
      end
    end
  end

  def destroy
    if set_kalibro_range
      @kalibro_range.destroy
      respond_with_json
    end
  end

  def exists
    respond_with_json(exists: KalibroRange.exists?(params[:id].to_i))
  end

  private

  def set_metric_configuration
    begin
      @metric_configuration = MetricConfiguration.find(params[:metric_configuration_id].to_i)
      true
    rescue ActiveRecord::RecordNotFound => exception
      respond_with_json({ errors: [exception.message] }, :not_found)
      false
    end
  end

  def set_kalibro_range
    begin
      @kalibro_range = KalibroRange.find(params[:id].to_i)
      true
    rescue ActiveRecord::RecordNotFound => exception
      respond_with_json({ errors: [exception.message] }, :not_found)
      false
    end
  end

  def kalibro_range_params
    params.require(:kalibro_range).permit(:beginning, :end, :comments, :reading_id, :metric_configuration_id)
  end

  def convert(value)
    if value == 'INF'
      return Float::INFINITY
    elsif value == '-INF'
      return -Float::INFINITY
    end
    value
  end

  def set_interval_params
    params[:kalibro_range][:beginning] = convert(params[:kalibro_range][:beginning])
    params[:kalibro_range][:end] = convert(params[:kalibro_range][:end])
  end

  def json_conversion(range)
    # JSON does not understand Infinity. That's why we have to make this series of conversions.
    hash = range.attributes
    hash['beginning'] = range.beginning.to_s if range.beginning == -Float::INFINITY
    hash['end'] = range.end.to_s if range.end == Float::INFINITY
    hash
  end
end
