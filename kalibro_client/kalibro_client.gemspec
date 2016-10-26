# This file is part of KalibroClient
# Copyright (C) 2013  it's respectives authors (please see the AUTHORS file)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kalibro_client/version'

Gem::Specification.new do |spec|
  spec.name          = "kalibro_client"
  spec.version       = KalibroClient::VERSION
  spec.authors       = ["Daniel Quadros Miranda", "Diego de Araújo Martinez Camarinha", "Heitor Reis Ribeiro", "Rafael Reggiani Manzo"]
  spec.email         = ["danielkza2@gmail.com", "diegamc90@gmail.com", "marcheing@gmail.com", "rr.manzo@gmail.com"]
  spec.description   = "KalibroClient is a Ruby gem intended to be an interface for Ruby applications who want to use the open source code analysis webservice Kalibro."
  spec.summary       = "KalibroClient is a communication interface with the KalibroProcessor and KalibroConfigurations services."
  spec.homepage      = "https://github.com/mezuro/kalibro_client"
  spec.license       = "LGPLv3"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.2.2'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "cucumber", "~> 2.0"
  spec.add_development_dependency "mocha", "~> 1.1.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "factory_girl", "~> 4.5.0"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "ruby-prof"

  spec.add_dependency "activesupport", ">= 2.2.1" #version in which underscore was introduced
  spec.add_dependency "faraday_middleware", "~> 0.9"
  spec.add_dependency "likeno", "~> 1.1"
end
