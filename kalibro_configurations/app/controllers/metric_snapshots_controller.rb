class MetricSnapshotsController < ApplicationController
  def index
    respond_with_json metric_snapshots: MetricSnapshot.all
  end

  def show
    respond_with_json(metric_snapshot: @metric_snapshot) if set_metric_snapshot
  end

  def metric_configuration
    respond_with_json(metric_configuration: @metric_snapshot.metric_configuration) if set_metric_snapshot
  end

  private

  def set_metric_snapshot
    begin
      @metric_snapshot = MetricSnapshot.find(params[:id].to_i)
      true
    rescue ActiveRecord::RecordNotFound => exception
      respond_with_json({ errors: [exception.message]}, :not_found)
      false
    end
  end
end
