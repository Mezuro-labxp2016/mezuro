# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kolekti_cc_phpmd/version'

Gem::Specification.new do |spec|
  spec.name          = "kolekti_cc_phpmd"
  spec.version       = KolektiCcPhpmd::VERSION
  spec.authors       = ["Rafael Reggiani Manzo"]
  spec.authors       = ["Daniel Miranda",
                        "Diego Araújo",
                        "Eduardo Araújo",
                        "Rafael Reggiani Manzo"]
  spec.email         = ["danielkza2@gmail.com",
                        "diegoamc90@gmail.com",
                        "duduktamg@hotmail.com",
                        "rr.manzo@protonmail.com"]

  spec.summary       = %q{Metric collecting support for PHP that servers Kolekti.}
  spec.homepage      = "https://github.com/mezuro/kolekti_cc_phpmd"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  unless spec.respond_to?(:metadata)
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "codeclimate", "~>0.21"
  spec.add_dependency "kolekti"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "cucumber", "~> 2.1.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "factory_girl", "~> 4.5.0"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "byebug"
end
