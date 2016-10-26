Feature: kalibro_module
  In order to be able to retrieve the ModuleResult's KalibroModule
  As a developer
  I want to make the proper requests

  @kalibro_configuration_restart @kalibro_processor_restart
  Scenario: find a valid module result
    Given I have a project with name "Kalibro"
    And I have a kalibro configuration with name "Conf"
    And I have a reading group with name "Group"
    And I have a "saikuro" configuration within the given kalibro configuration
    And the given project has the following Repositories:
      |   name    | scm_type |                   address                        |
      |  Kalibro  |    GIT   | https://github.com/mezuro/kalibro_processor.git  |
    And I call the process method for the given repository
    And I wait up for a ready processing
    When I ask for the kalibro_module of the processing root module result
    Then I should get a KalibroModule
