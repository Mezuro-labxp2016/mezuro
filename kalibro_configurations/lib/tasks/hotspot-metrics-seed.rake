require 'yaml'

desc 'Generate a seeds file from a metrics YAML file'
task :hotspot_metrics_seed, [:name, :yml_file] do |_, args|
  metrics = YAML.load_file(args[:yml_file])[:metrics]
  file_name = args[:name].tr(' ', '_').downcase

  File.open("db/#{file_name}.rb", 'w') do |file|
    file.puts <<RUBY
#{file_name}_configuration = KalibroConfiguration.create(
  name: #{args[:name].inspect},
  description: "Example #{args[:name]} configuration"
)

RUBY

    metrics.each do |code, metric_info|
      if metric_info[:type] != 'HotspotMetricSnapshot'
        warn "Could not create #{code}. Only implemented for hotspot metrics!"
        next
      end

      file.puts <<RUBY
#{code} = HotspotMetricSnapshot.create(
  name: #{metric_info[:name].inspect},
  code: #{code.to_s.inspect},
  metric_collector_name: #{args[:name].inspect},
  scope: {'type' => "SOFTWARE"},
  description: #{metric_info[:description].inspect}
)
MetricConfiguration.create(
  metric_snapshot_id: #{code}.id, kalibro_configuration_id: #{file_name}_configuration.id
)

RUBY
    end
  end
end
