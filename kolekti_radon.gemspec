# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kolekti/radon/version'

Gem::Specification.new do |spec|
  spec.name          = "kolekti_radon"
  spec.version       = KolektiRadon::VERSION
  spec.authors       = ["Diego Araújo", "Daniel Miranda", "Rafael Reggiani Manzo"]
  spec.email         = ["diegoamc@protonmail.ch", "danielkza2@gmail.com", "rr.manzo@protonmail.com"]

  spec.summary       = %q{Metric collecting support for Python that serves Kolekti.}
  spec.homepage      = "https://github.com/mezuro/kolekti_radon.git"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
