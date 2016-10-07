class ReadingGroupsController < ApplicationController
  def all
    respond_with_json reading_groups: ReadingGroup.all
  end

  def show
    respond_with_json(reading_group: @reading_group) if set_reading_group
  end

  def create
    reading_group = ReadingGroup.new(reading_group_params)
    if reading_group.save
      respond_with_json({ reading_group: reading_group }, :created)
    else
      respond_with_json({ errors: reading_group.errors.full_messages }, :unprocessable_entity)
    end
  end

  def update
    if set_reading_group
      if @reading_group.update(reading_group_params)
        respond_with_json({ reading_group: @reading_group }, :created)
      else
        respond_with_json({ errors: @reading_group.errors.full_messages }, :unprocessable_entity)
      end
    end
  end

  def exists
    respond_with_json exists: ReadingGroup.exists?(params[:id].to_i)
  end

  def destroy
    if set_reading_group
      @reading_group.destroy
      respond_with_json
    end
  end

  private

  def set_reading_group
    begin
      @reading_group = ReadingGroup.find(params[:id].to_i)
      true
    rescue ActiveRecord::RecordNotFound => exception
      respond_with_json({ errors: [exception.message] }, :not_found)
      false
    end
  end

  def reading_group_params
    params.require(:reading_group).permit(:name, :description)
  end
end
