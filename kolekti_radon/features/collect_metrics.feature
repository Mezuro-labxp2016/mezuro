Feature: Collect Python metrics
  In order to analyze Python source codes
  As a Kolekti user
  I should be able to collect metrics using Radon

  @unregister_collectors @clear_repository_dir
  Scenario Outline: Running, parsing and collecting results
    Given Radon is registered on Kolekti
    And a persistence strategy is defined
    And I have a set of wanted metrics for all the supported ones
    And the "<address>" repository is cloned
    When I request Kolekti to collect the wanted metrics
    Then there should be metric results for all the wanted metrics

    Examples:
      | address                                         |
      | https://github.com/mezuro/kalibro_client_py.git |
      | https://github.com/ansible/ansible.git          |
