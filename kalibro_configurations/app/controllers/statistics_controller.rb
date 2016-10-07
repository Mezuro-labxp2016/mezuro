class StatisticsController < ApplicationController
  def metric_percentage
    count_metric_snapshot = MetricSnapshot.where(code: params[:metric_code]).count
    total_configuration = MetricConfiguration.count

    # This comparision is to avoid division by zero
    if total_configuration == 0
      metric_percentage = 0
    else
      metric_percentage = (count_metric_snapshot.to_f / total_configuration.to_f) * 100
    end

    respond_with_json metric_percentage: metric_percentage.round(2)
  end
end
