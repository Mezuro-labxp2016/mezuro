Feature: Repository Creation
  In order to register my repositories
  As a regular user
  I should be able to create repositories

@kalibro_restart
Scenario: repository creation
  Given I am a regular user
  And I am signed in
  And I own a sample project
  And I have a sample configuration with native metrics
  And I am at the New Repository page
  And I fill the Name field with "Kalibro"
  And I set the select field Type as "GIT"
  And I fill the Address field with "https://github.com/mezuro/kalibro_entities.git"
  And I set the select field Configuration as the sample configuration
  When I press the Save button
  Then I should be in the Sample Project page
  And I should not see There are no repositories yet!
  And I should see "Kalibro"
  And I should see "GIT"
  And I should see "https://github.com/mezuro/kalibro_entities.git"

@kalibro_restart
Scenario: repository creation blank validations
  Given I am a regular user
  And I am signed in
  And I own a sample project
  And I have a sample configuration with native metrics
  And I am at the New Repository page
  And I set the select field Type as "GIT"
  And I set the select field Configuration as the sample configuration
  When I press the Save button
  Then I should see "Name can't be blank"
  And I should see "Address can't be blank"

@kalibro_restart
Scenario: repository creation with name already taken
  Given I am a regular user
  And I am signed in
  And I own a sample project
  And I have a sample configuration with native metrics
  And I have a sample repository within the sample project named "KalibroEntities"
  And I am at the New Repository page
  And I fill the Name field with "KalibroEntities"
  And I set the select field Type as "GIT"
  And I fill the Address field with "https://github.com/mezuro/kalibro_entities.git"
  And I set the select field Configuration as the sample configuration
  When I press the Save button
  Then I should see "There's already"