Feature: Create
  In order to manipulate metric configurations
  As a developer
  I want to create a metric configuration

  @kalibro_configuration_restart
  Scenario: creating a metric configuration
	  Given I have a kalibro configuration with name "Kalibro for Java"
    And I have a reading group with name "Group"
    When I have a "saikuro" configuration within the given kalibro configuration
    Then the metric configuration should exist

  @kalibro_configuration_restart
  Scenario: creating a hotspot metric configuration
    Given I have a kalibro configuration with name "Kalibro for Ruby"
    When I have a flay configuration within the given kalibro configuration
    Then the metric configuration should exist
    And its metric should be Hotspot one
