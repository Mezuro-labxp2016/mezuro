require 'kolekti/radon/parser/base'
require 'kolekti/radon/parser/cyclomatic'
require 'kolekti/radon/parser/maintainability'
require 'kolekti/radon/parser/raw'

module Kolekti
  module Radon
    module Parser
      PARSERS = {
        :cc       => Cyclomatic,
        :mi       => Maintainability,
        :loc      => Raw,
        :lloc     => Raw,
        :sloc     => Raw,
        :multi    => Raw,
        :blank    => Raw,
        :comments => Raw,
      }
    end
  end
end

