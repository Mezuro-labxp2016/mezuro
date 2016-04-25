module Kolekti
  module Radon
    class Collector < Kolekti::Collector
      def self.available?
        system('radon', '--version', [:out, :err] => '/dev/null') ? true : false
      end
    end
  end
end
