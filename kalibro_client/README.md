# KalibroClient

[![Build Status](https://travis-ci.org/mezuro/kalibro_client.png?branch=master)](https://travis-ci.org/mezuro/kalibro_client)
[![Code Climate](https://codeclimate.com/github/mezuro/kalibro_client.png)](https://codeclimate.com/github/mezuro/kalibro_client)
[![Test Coverage](https://codeclimate.com/github/mezuro/kalibro_client/badges/coverage.svg)](https://codeclimate.com/github/mezuro/kalibro_client)

KalibroClient is a Ruby gem intended to be an interface for Ruby applications who want to use the open source code analysis webservices from Kalibro (https://github.com/mezuro/kalibro_processor and https://github.com/mezuro/kalibro_configurations).

## Contributing

Please, have a look the wiki pages about development workflow and code standards:

* https://github.com/mezuro/mezuro/wiki/Development-workflow
* https://github.com/mezuro/mezuro/wiki/Standards

## Installation

Add this line to your application's Gemfile:

    gem 'kalibro_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kalibro_client

## Usage

KalibroClient is intended to be an easy interface that encapsulates the usage of all the Kalibro service's endpoints. So have a look at the available entities at `lib/kalibro_client/entities`.

All the entities are subclasses from `KalibroClient::Entities::Base`, so have a good look at it. Specially notice that all the entities have methods:

* `save`
* `exists?`
* `find`
* `destroy`

These four methods should be useful.

We hope to make available soon a full documentation on RDoc that will make easier to understand all this.

A good example on how to get everything from KalibroClient should be Prezento (https://github.com/mezuro/prezento). So, have a look there for some examples.

### Cucumber helpers

Acceptance tests with the Kalibro webservice can be painful. But we've created cucumber hooks that make it easy.

Just add to your `env.rb` the following:

    require 'kalibro_client/kalibro_cucumber_helpers/hooks.rb'

The test configurations available are:

* `kalibro_processor_address`
* `kalibro_configurations_address`

An example on how to change them is:

```ruby
KalibroClient::KalibroCucumberHelpers.configure do |config|
  config.kalibro_processor_address = "http://localhost:8082"
end
```

We hope to make available soon an YAML parser for test configurations.
