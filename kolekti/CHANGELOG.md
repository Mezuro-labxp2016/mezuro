# Revision history for Kolekti gem

The Kolekti gem provides a basic API for KalibroProcessor's collectors

## Unreleased

## v1.1.3 - 15/04/2016

* Update Collector#collect_metrics signature
* Fix requiring memory persistence strategy alone


## v1.1.2 - 06/04/2016

* Add missing argument persistence_strategy to Parser#parse


## v1.1.1 - 06/04/2016

* Add missing argument metric_configuration to Parser#parse


## v1.1.0 - 06/04/2016

* Introduce the Parser class


## v1.0.2 - 30/03/2016

* Update Ruby to 2.3.0
* Update Kalibro Client to version 4


## v1.0.1 - 23/03/2016

* Fix collector selection logic for metrics and correct tests

## v1.0.0 - 01/03/2016

* Only register collectors if they are available and not already registered

## v0.0.2 - 24/02/2016

* Add backport for Array#to_h on ruby-2.0.0-p598

## v0.0.1 - 19/02/2016

* And the Mezuro team said: "Let there be parsers!"

---

Kolekti. Copyright (C) 2015  The Mezuro Team

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
details.

You should have received a copy of the GNU Affero General Public License along
with this program.  If not, see <http://www.gnu.org/licenses/>.

