Feature: Kalibro Configuration Metric Configuration arraying
  In order to obtain the metric configurations from a kalibo configuration
  As a developer
  I should be able to obtain all metric configurations or filtered by type (Hotspot or Tree)

  Scenario: A kalibro configuration with no metric configurations
    Given I have a sample kalibro configuration
    When I ask for the metric configurations of the sample kalibro configuration
    Then I should not get any metric configuration
    When I ask for the tree metric configurations of the sample kalibro configuration
    Then I should not get any metric configuration
    When I ask for the hotspot metric configurations of the sample kalibro configuration
    Then I should not get any metric configuration

  Scenario: A kalibro configuration with tree metric configurations
    Given I have a sample kalibro configuration
    And the sample kalibro configuration has tree metric configurations
    When I ask for the metric configurations of the sample kalibro configuration
    Then I should get the tree metric configurations
    When I ask for the tree metric configurations of the sample kalibro configuration
    Then I should get the tree metric configurations
    When I ask for the hotspot metric configurations of the sample kalibro configuration
    Then I should not get any metric configuration

  Scenario: A kalibro configuration with hotspot metric configurations
    Given I have a sample kalibro configuration
    And the sample kalibro configuration has hotspot metric configurations
    When I ask for the metric configurations of the sample kalibro configuration
    Then I should get the hotspot metric configurations
    When I ask for the tree metric configurations of the sample kalibro configuration
    Then I should not get any metric configuration
    When I ask for the hotspot metric configurations of the sample kalibro configuration
    Then I should get the hotspot metric configurations

  Scenario: A kalibro configuration with tree metric configurations and hostpot metric configurations
    Given I have a sample kalibro configuration
    And the sample kalibro configuration has tree metric configurations
    And the sample kalibro configuration has hotspot metric configurations
    When I ask for the metric configurations of the sample kalibro configuration
    Then I should get the tree metric configurations
    And I should get the hotspot metric configurations
    When I ask for the tree metric configurations of the sample kalibro configuration
    Then I should get only the tree metric configurations
    When I ask for the hotspot metric configurations of the sample kalibro configuration
    Then I should get only the hotspot metric configurations
