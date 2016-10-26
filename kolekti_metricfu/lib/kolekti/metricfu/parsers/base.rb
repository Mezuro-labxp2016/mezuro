module Kolekti
  module Metricfu
    module Parsers
      class Base < Kolekti::Parser
        def self.module_name_suffix(module_name)
          return '' if module_name.to_s.end_with?('#none')

          # Replace Saikuro's representation of a class method (#self.method) with Flog's
          # (::method) so we can treat both the same later.
          module_name = module_name.gsub('#self.', '::')
          # Now split up the last component of the module name so it doesn't get it's
          # prefixes (# or ::) replaced with . (our own separator).
          module_path, prefix, module_name = module_name.rpartition(/#|::/)
          # Replace the separators in the path (and only the path) with dots
          module_path.gsub!(/#|::/, '.')
          # Put everything back together
          '.' + module_path + '.' + prefix + module_name
        end
      end
    end
  end
end
