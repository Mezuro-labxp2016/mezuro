# Revision history for Mezuro module KalibroConfigurations

KalibroConfigurations is the configuration storage web service for Mezuro.

## Unreleased

- Do not use bin/rake script on bin/setup anymore
- Disable rubocop Lint/HandleExceptions cop for rake
- Drop SQLite 3 support
- Bump Ruby version 2.3.1

## v2.1.3 - 11/05/2016

- Fix the fix for tasks loading under production

## v2.1.2 - 11/05/2016

- Fix rake tasks loading under production

## v2.1.1 - 11/05/2016

- Add rubocop gem and configuration file
- Make Travis fail if unit test coverage is below 100%
- Cache bundle on travis
- Update README
- Create HACKING and CONTRIBUTING files

## v2.1.0 - 30/03/2016

- Set development Ruby version to 2.3.0
- Add seeds for PHPMD configuration

## v2.0.1 - 26/02/2016

- Fix default database.yml to avoid encoding conflicts in PostgreSQL

## v2.0.0 - 27/01/2016

- Use new scope format for metric snapshots

## v1.2.5 - 30/11/2015

- Fix Range validators

## v1.2.4 - 25/11/2015

- Fix response status code

## v1.2.3 - 09/11/2015

- Fix Procfile

## v1.2.2 - 09/11/2015

- Foreman

## v1.2.1 - 06/11/2015

- Backport for Ruby 2.0.0
- Fix seeds encoding

## v1.2.0 - 14/10/2015

- Lists MetricConfigurations by type (Tree or Hotspot)
- Improved test cases for KalibroRange

## v1.1.1 - 09/09/2015

- Ruby and Gem updates
- TestsController does not exist anymore under production

## v1.1.0 - 27/08/2015

- Added support for Python metrics using the Radon collector
- Added support for Hotspot metrics, that indicate positions in the code instead of measures
- Added support for the Flay ruby collector, that finds duplicated code spots
- Fixed bug where the Metric endpoint was returning undesired attributes for some metric types

## v1.0.0 - 27/07/2015

- First major release, with support for Java, C, C++ and Ruby metrics

---

Kalibro Configurations.
Copyright (C) 2015  The Mezuro Team

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
