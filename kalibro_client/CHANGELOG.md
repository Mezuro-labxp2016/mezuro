# Revision history for Kalibro Client gem

The Kalibro Client gem abstracts communication with all the services in the Mezuro
platform, with an uniform Ruby API.

## Unreleased
- Drop Ruby 2.0.0 and 2.1.5 support

## v4.0.0 - 30/03/2016
- Extract HTTP request handling code to the Likeno gem (https://github.com/mezuro/likeno)
- Refactor MetricCollector and MetricCollectoDetails finding methods
- Remove savon's leftovers
- Add deprecation warnings on error classes
- Use Likeno errors instead of KalibroClient errors

## v3.0.1 - 29/02/2016
- Relax faraday_middleware version requirement
- Bump version

## v3.0.0 - 16/02/2016
- Relax RSpec and Cucumber version requirement
- Update to Ruby 2.3.0
- Add inheritance for Granularity from Base
- Send metric snapshot's scope with {type: granularity} format

## v2.1.2 - 23/10/2015
- Use a ruby metric configuration on features
- Fix supported metrics instantiation

## v2.1.1 - 19/10/2015
- Fix MetricResult#module_result

## v2.1.0 - 15/10/2015
- Implement hotspot and tree metric result retrieval
- Add module_result method to MetricResult
- Fix granularity method calls on kalibro module factory

## v2.0.0 - 30/09/2015
- Make all requests raise exceptions in case of HTTP errors instead of ignoring them
- Make Entities::Base#save! raise an exception on error
- Split MetricResult into a superclass with TreeMetricResult subclass
- Implemente HotspotMetricResult
- Implemente hotspot_metric_results on module_result
- Remove deprecated method ModuleResult#metric_results.
- Fix outdated AggregationOptions
- Fix Entities::Base#request sending parameters for :get calls

## v1.4.1 - 14/09/2015
- Adds missing hotspot attributes to MetricResult

## v1.4.0 - 11/09/2015
- Update dependencies: faraday_middleware, cucumber
- Updates to Ruby 2.2.3
- Added range method to kalibro range
- Implemented range method for RangeSnapshot
- Updated kalibro range boundaries to delay validation

## v1.3.0 - 28/08/2015
- Fixes MetricConfiguration#find to return the new instance with true valued persisted attribute
- Undo deprecation of NativeMetric's constructor
- Implemented HotspotMetric
- Implemented HotspotMetrics on MetricConfiguration

## v1.2.2 - 21/08/2015
- Version fix release: should be identical to v1.2.2

## v1.2.1 - 21/08/2015
- Raise errors on comparison between function and class granularities

## v1.2.0 - 17/08/2015
- Removed processing from metric collector details
- Removed wanted_metrics from metric collector details
- Granularity comparisons using Comparable Module

## v0.5.0 - 17/08/2015
- Implemented FUNCTION Granularity
- Make Granularity comparisons use the Comparable Module

## v1.1.0 - 06/07/2015
- Refactored the repository method all to match the new API of kalibro processor

## v0.4.0 - 06/07/2015
- Refactored the repository method all to match the new API of kalibro processor

## v1.0.0 - 08/05/2015
- Delete deprecated methods in MetricResult and Processing
- Make Processing independent of Repository
- Update rspec gem

## v0.3.0 - 16/06/2015
- Adding the branch attribute on repository.
- Added branches method on Repository

## v0.2.0 - 29/05/2015
- Adding new entity to show statistic of the metrics

## v0.1.1 - 08/05/2015
- Update to Ruby 2.2.2
- Performance improvement

## v0.1.0 - 01/04/2015
- Update dependencies: factory_girl, rspec
- Added name and short_name methods to kalibro module
- Fix Granularity comparisons

## v0.0.2 - 11/02/2015
- Added repositories method to project
- Fix base entity #save return value (should be false on failure)
- make has_processing method use GET instead of POST
- Fix cancel_processing and module_result_history_of bugs
- Fixed errors hash returned on metric configuration
- Fixed error handling on save error
- Added readings method to reading group
- Add update action for entities
- Correctly set persisted attribute when creating new entities
- Fix supported metrics on metric collector details
- Changing metric on metric collector details to find metric by name or code
- Adding kalibro ranges method to metric configuration
- Change created_at and updated_at methods to return Time instances
- Fix constructor for supported metrics on metric collector
- Add Processing retrieval methods inside Repository instance
- Alias `granularity` for KalibroModule method `granlrty`
- Added metric_configuration_id= to MetricResult and implemented ModuleResult metric_results instance method
- Add ModuleResult processing method

## v0.0.1 - 22/01//2015 (Initial release) 
- Rename from Kalibro Gatekeeper Client to Kalibro Client
- Refactor package structure to include Entites
- Update XML methods
- Add acceptance tests using Cucumber
- Add hash conversion method to entities
- Update to Ruby 2.1.0
- Replace Savon gem with Faraday
- Implement destroy methods for many entities
