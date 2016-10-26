Feature: Process
  In order to be have repositories
  As a developer
  I want to cancel the repository processing

  @kalibro_processor_restart @kalibro_configuration_restart
  Scenario: With one repository
    Given I have a project with name "Kalibro"
    And I have a kalibro configuration with name "Conf"
    And the given project has the following Repositories:
      |   name    | scm_type |                       address                    |
      |  Kalibro  |    GIT   | https://github.com/mezuro/kalibro_processor.git  |
    When I call the cancel_process method for the given repository
    Then I should get success
