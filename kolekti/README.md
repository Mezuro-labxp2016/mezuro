# Kolekti

[![Code Climate](https://codeclimate.com/github/mezuro/kolekti.png)](https://codeclimate.com/github/mezuro/kalibro_client)

Kolekti is a code metric results parser framework. You can use it whenever you want structured unique output for different metric collectors.

## Contributing

Please, have a look the wiki pages about development workflow and code standards:

* https://github.com/mezuro/mezuro/wiki/Development-workflow
* https://github.com/mezuro/mezuro/wiki/Standards

## Installation

Add this line to your application's Gemfile:

    gem 'kolekti'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kolekti

## Usage

You have one key class you need to extend `Kolekti::Collector` implementing the following methods:

* `collect_metrics(code_directory, wanted_metric_configurations)`
* `clean(code_directory, wanted_metric_configurations)`
* `default_value_from(metric_configuration)`

Actual examples are:

* [KolektiAnalizo](https://github.com/mezuro/kolekti_analizo)

## Versioning

Kolekti follows the [semantic versioning](http://semver.org/) policy.
