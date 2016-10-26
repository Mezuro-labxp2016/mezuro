Feature: /history of
  In order to be able to have the history of a module result
  As a developer
  I want to get the history of module results

  @kalibro_configuration_restart @kalibro_processor_restart
  Scenario: get the history of a module result
    Given I have a project with name "Kalibro"
    And I have a kalibro configuration with name "Conf"
    And I have a reading group with name "Group"
    And I have a "saikuro" configuration within the given kalibro configuration
    And the given project has the following Repositories:
      |   name    | scm_type |                   address                        |
      |  Kalibro  |    GIT   | https://github.com/mezuro/kalibro_processor.git  |
    And I call the process method for the given repository
    And I wait up for a ready processing
    And I get the module result of the processing
    When I ask for the history of the given module result
    Then I should get a list with date module results
