# KolektiCCPHPMD

[![Code Climate](https://codeclimate.com/github/mezuro/kolekti_cc_phpmd.png)](https://codeclimate.com/github/mezuro/kolekti_cc_phpmd)

Generic parser for Analizo static code metrics collector.

## Contributing

Please, have a look the wiki pages about development workflow and code standards:

* https://github.com/mezuro/mezuro/wiki/Development-workflow
* https://github.com/mezuro/mezuro/wiki/Standards

## Installation

Add this line to your application's Gemfile:

    gem 'kolekti_cc_phpmd'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kolekti_cc_phpmd

## Usage

Just register it into Kolekti with

```ruby
require 'kolekti'
require 'kolekti_cc_phpmd'

Kolekti.register_collector(Kolekti::CcPhpMd::Collector.new)
```
