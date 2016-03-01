require 'kolekti/collector'

module Kolekti
  module CcPhpMd
    class Collector < Kolekti::Collector
      def self.available?
        system('codeclimate version', [:out, :err] => '/dev/null') ? true : false
      end
    end
  end
end
