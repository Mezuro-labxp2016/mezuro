# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kolekti/version'

Gem::Specification.new do |spec|
  spec.name          = "kolekti"
  spec.version       = Kolekti::VERSION
  spec.authors       = ["Daniel Miranda",
                        "Diego Araújo",
                        "Eduardo Araújo",
                        "Rafael Reggiani Manzo"]
  spec.email         = ["danielkza2@gmail.com",
                        "diegoamc90@gmail.com",
                        "duduktamg@hotmail.com",
                        "rr.manzo@protonmail.com"]
  spec.license       = "LGPLv3"

  spec.summary       = %q{Kolekti is a code metric results parser framework.}
  spec.description   = %q{Kolekti is a code metric results parser framework. You can use it whenever you want structured unique output for different metric collectors.}
  spec.homepage      = "https://github.com/mezuro/kolekti"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "kalibro_client", "~> 4.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "cucumber", "~> 2.1.0"
  spec.add_development_dependency "mocha", "~> 1.1.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "factory_girl", "~> 4.5.0"
  spec.add_development_dependency "codeclimate-test-reporter"
end
