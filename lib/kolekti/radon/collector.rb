module Kolekti
  module Radon
    class Collector < Kolekti::Collector
      def self.available?
        system('radon', '--version', [:out, :err] => '/dev/null') ? true : false
      end

      def initialize
        supported_metrics = parse_supported_metrics(
          File.expand_path('../metrics.yml', __FILE__), 'Radon', [:PYTHON])

        super('Radon', 'Set of Python metric tools', supported_metrics)
      end
    end
  end
end
