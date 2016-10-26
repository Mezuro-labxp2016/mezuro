# Revision history for Kolekti MetricFu

The Kolekti MetricFu gem implements a collector for Ruby metrics and issues
using MetricFu

## Unreleased

## v0.0.4 - 10/06/2016

* Prevent incompatible versions of metric_fu and flog to get installed together
 - That issue is being worked on by the metric_fu people, so this change will be
 reverted as soon as that is fixed.

## v0.0.3 - 16/05/2016

* Add backwards compatibility up to ruby 2.0.0-p594 (CentOS 7 version)

## v0.0.2 - 11/05/2016

* Support Ruby 2.0.0

## v0.0.1 - 25/04/2016

*   Fix handling of duplicated methods in saikuro and flog compared with
    KalibroProcessor implementation
*   Fix metric code handling in parsers
*   Implement default value handling
*   Implementation of parsers and collector

---

Kolekti MetricFu. Copyright (C) 2016  The Mezuro Team

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
details.

You should have received a copy of the GNU General Public License along with
this program.  If not, see <http://www.gnu.org/licenses/>.
