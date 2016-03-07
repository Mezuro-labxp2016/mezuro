require 'kolekti/collector'

module Kolekti
  module CcPhpMd
    class Collector < Kolekti::Collector
      def self.available?
        system('codeclimate version', [:out, :err] => '/dev/null') ? true : false
      end

      def initialize
        supported_metrics = parse_supported_metrics(
          File.expand_path("../metrics.yml", __FILE__), 'CodeClimate PHPMD', [:PHP])
        super('CodeClimate PHPMD', 'PHP Mess Detector', supported_metrics)
      end
    end
  end
end
