@mod @mod_lti
Feature: Configure tool types
  In order to allow teachers to add external LTI tools
  As an admin
  I need to be able to add, remove and configure tool types

  Background:
    Given I log in as "admin"
    And I navigate to "Plugins > Activity modules > External tool > Manage tools" in site administration

  @javascript
  Scenario: Add a tool type from a cartridge URL
    When I set the field "url" to local url "/mod/lti/tests/fixtures/ims_cartridge_basic_lti_link.xml"
    And I press "Add Legacy LTI"
    Then I should see "Enter your consumer key and shared secret"
    And I press "Save changes"
    And I should see "Example tool"

  @javascript
  Scenario: Try to add a non-existant cartridge
    When I set the field "url" to local url "/mod/lti/tests/fixtures/nonexistant.xml"
    And I press "Add Legacy LTI"
    Then I should see "Enter your consumer key and shared secret"
    And I press "Save changes"
    And I should see "Failed to create new tool. Please check the URL and try again."

  @javascript
  Scenario: Attempt to add a tool type from a configuration URL, then cancel
    When I set the field "url" to local url "/mod/lti/tests/fixtures/tool_provider.php"
    And I press "Add Legacy LTI"
    Then I should see "Cancel"
    And I press "cancel-external-registration"
