Feature: Collect PHPMD metrics
  In order to analyze PHP source codes
  As a Kolekti user
  I should be able to collect metrics using PHPMD

  @wip @unregister_collectors @clear_repository_dir
  Scenario: Running, parsing and collecting results
    Given PHPMD is registered on Kolekti
    And a persistence strategy is defined
    And I have a set of wanted metrics for PHPMD
    And the "https://github.com/anapaula/Arquigrafia-Laravel" repository is cloned
    When I request Kolekti to collect the wanted metrics
    Then there should be tree metric results to be saved
    And there should be tree metric results for all the wanted metrics
