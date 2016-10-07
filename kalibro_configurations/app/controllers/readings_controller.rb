class ReadingsController < ApplicationController
  def index
    if set_reading_group
      respond_with_json(readings: @reading_group.readings)
    end
  end

  def show
    respond_with_json(reading: @reading) if set_reading
  end

  def exists
    respond_with_json exists: Reading.exists?(params[:id].to_i)
  end

  def create
    reading = Reading.new(reading_params)
    reading.reading_group_id = params[:reading_group_id]

    if reading.save
      respond_with_json({ reading: reading }, :created)
    else
      respond_with_json({ errors: reading.errors.full_messages }, :unprocessable_entity)
    end
  end

  def update
    if set_reading
      if @reading.update(reading_params)
        respond_with_json({ reading: @reading }, :created)
      else
        respond_with_json({ errors: @reading.errors.full_messages }, :unprocessable_entity)
      end
    end
  end

  def destroy
    if set_reading
      @reading.destroy
      respond_with_json
    end
  end

  private

  def set_reading_group
    begin
      @reading_group = ReadingGroup.find(params[:reading_group_id].to_i)
      true
    rescue ActiveRecord::RecordNotFound => exception
      respond_with_json({ errors: [exception.message] }, :not_found)
      false
    end
  end

  def set_reading
    begin
      @reading = Reading.find(params[:id].to_i)
      true
    rescue ActiveRecord::RecordNotFound => exception
      respond_with_json({ errors: [exception.message] }, :not_found)
      false
    end
  end

  def reading_params
    params.require(:reading).permit(:label, :grade, :color, :reading_group_id)
  end
end
