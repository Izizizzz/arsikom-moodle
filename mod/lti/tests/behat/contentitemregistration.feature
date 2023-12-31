@mod @mod_lti
Feature: Create/edit tool configuration that has Deep Linking support
  In order to provide external tools that support Deep Linking for teachers and learners
  As an admin
  I need to be able to configure external tool registrations that support Deep Linking.

  Background:
    Given I log in as "admin"
    And I navigate to "Plugins > Activity modules > External tool > Manage tools" in site administration

  Scenario: Verifying ContentItemSelectionRequest selection support in external tool registration
    When I follow "Manage external tool registrations"
    And I follow "Configure a new external tool registration"
    Then I should see "ContentItemSelectionRequest" in the "Capabilities" "select"

  @javascript
  Scenario: Creating and editing tool configuration that has Content-Item support
    When I follow "configure a tool manually"
    And I set the field "Tool name" to "Test tool"
    And I set the field "Tool URL" to local url "/mod/lti/tests/fixtures/tool_provider.php"
    And I set the field "Tool configuration usage" to "Show in activity chooser and as a preconfigured tool"
    And I expand all fieldsets
    And I set the field "Supports Deep Linking (Content-Item Message)" to "1"
    And I press "Save changes"
    And I follow "Edit"
    And I expand all fieldsets
    Then the field "Supports Deep Linking (Content-Item Message)" matches value "1"
    And I set the field "Supports Deep Linking (Content-Item Message)" to "0"
    And I press "Save changes"
    And I follow "Edit"
    And I expand all fieldsets
    And the field "Supports Deep Linking (Content-Item Message)" matches value "0"
