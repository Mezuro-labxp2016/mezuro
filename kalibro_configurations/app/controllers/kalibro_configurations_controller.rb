class KalibroConfigurationsController < ApplicationController
  def all
    respond_with_json(kalibro_configurations: KalibroConfiguration.all)
  end

  def show
    return unless set_kalibro_configuration
    respond_with_json({ kalibro_configuration: @kalibro_configuration }, :ok)
  end

  def create
    kalibro_configuration = KalibroConfiguration.new(kalibro_configuration_params)

    if kalibro_configuration.save
      respond_with_json({ kalibro_configuration: kalibro_configuration }, :created)
    else
      respond_with_json({ errors: kalibro_configuration.errors.full_messages }, :unprocessable_entity)
    end
  end

  def update
    return unless set_kalibro_configuration
    if @kalibro_configuration.update(kalibro_configuration_params)
      respond_with_json({ kalibro_configuration: @kalibro_configuration }, :created)
    else
      respond_with_json({ errors: @kalibro_configuration.errors.full_messages }, :unprocessable_entity)
    end
  end

  def exists
    respond_with_json(exists: KalibroConfiguration.exists?(params[:id].to_i))
  end

  def metric_configurations
    request_metric_configurations :metric_configurations
  end

  def hotspot_metric_configurations
    request_metric_configurations :hotspot_metric_configurations
  end

  def tree_metric_configurations
    request_metric_configurations :tree_metric_configurations
  end

  def destroy
    return unless set_kalibro_configuration
    @kalibro_configuration.destroy
    respond_with_json({})
  end

  private

  def request_metric_configurations(message)
    return unless set_kalibro_configuration
    respond_with_json(message => @kalibro_configuration.send(message))
  end

  def set_kalibro_configuration
    @kalibro_configuration = KalibroConfiguration.find(params[:id].to_i)
    true
  rescue ActiveRecord::RecordNotFound => exception
    respond_with_json({ errors: [exception.message] }, :not_found)
    false
  end

  def kalibro_configuration_params
    params.require(:kalibro_configuration).permit(:name, :description)
  end
end
