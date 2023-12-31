@core @core_user
Feature: The purpose of each input field collecting information about the user can be determined

  Background:
    Given the following "users" exist:
      | username | firstname          | lastname | email                           |
      | unicorn  | unicorn | 1        | unicorn@example.com |
    And the following "courses" exist:
      | fullname | shortname | category | groupmode |
      | Course 1 | C1        | 0        | 1         |
    And the following "course enrolments" exist:
      | user                | course | role    |
      | unicorn             | C1     | student |

  @javascript
  Scenario: Fields for other users are not auto filled
    When I am on the "unicorn@example.com" "user > editing" page logged in as "admin"
    And I expand all fieldsets
    Then the field "Username" should not have purpose "username"
    And the field "First name" should not have purpose "given-name"
    And the field "Last name" should not have purpose "family-name"
    And the field "Email" should not have purpose "email"
    And the field "Select a country" should not have purpose "country"
    And I press "Cancel"
    And I follow "Preferred language"
    And the field "Preferred language" should not have purpose "language"

  @javascript
  Scenario: My own user fields are auto filled
    Given I log in as "unicorn"
    When I open my profile in edit mode
    And I expand all fieldsets
    Then the field "First name" should have purpose "given-name"
    And the field "Last name" should have purpose "family-name"
    And the field "Email" should have purpose "email"
    And the field "Select a country" should have purpose "country"
    And I press "Cancel"
    And I follow "Preferences" in the user menu
    And I follow "Preferred language"
    And the field "Preferred language" should have purpose "language"
