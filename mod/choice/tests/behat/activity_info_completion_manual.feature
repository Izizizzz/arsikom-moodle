@mod @mod_choice @core_completion
Feature: Manual completion in the choice activity
  To avoid navigating from the choice activity to the course homepage to mark the choice activity as complete
  As a student
  I need to be able to mark the choice activity as complete within the choice activity itself

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email                 |
      | teacher1 | Teacher   | 1        | teacher1@example.com  |
      | student1 | Student   | 1        | student1@example.com  |
    And the following "course" exists:
      | fullname          | Course 1  |
      | shortname         | C1        |
      | category          | 0         |
      | enablecompletion  | 1         |
    And the following "activity" exists:
      | activity    | choice                  |
      | name        | What to drink?          |
      | intro       | Friday drinks, anyone?  |
      | course      | C1                      |
      | idnumber    | choice1                 |
      | completion  | 1                       |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | student1 | C1     | student        |
      | teacher1 | C1     | editingteacher |

  @javascript
  Scenario: Toggle manual completion as a student
    Given I am on the "What to drink?" "choice activity" page logged in as student1
    And the manual completion button of "What to drink?" is displayed as "Mark as done"
    When I toggle the manual completion state of "What to drink?"
    Then the manual completion button of "What to drink?" is displayed as "Done"
    But "Mark as done" "button" should not exist
    # Just make sure that the change persisted.
    And I reload the page
    And I wait until the page is ready
    And I should not see "Mark as done"
    And the manual completion button of "What to drink?" is displayed as "Done"
    And I toggle the manual completion state of "What to drink?"
    And the manual completion button of "What to drink?" is displayed as "Mark as done"
    But "Done" "button" should not exist
    # Just make sure that the change persisted.
    And I reload the page
    And the manual completion button of "What to drink?" is displayed as "Mark as done"
    But "Done" "button" should not exist

  Scenario: Viewing a choice activity with manual completion as a teacher
    When I am on the "What to drink?" "choice activity" page logged in as teacher1
    Then the manual completion button for "What to drink?" should be disabled

  @javascript
  Scenario: Overriding a manual choice completion for a user to done
    Given I am on the "Course 1" course page logged in as teacher1
    And I navigate to "Reports" in current page administration
    And I click on "Activity completion" "link"
    And I click on "Student 1, What to drink?: Not completed" "link"
    And I press "Save changes"
    And I log out
    When I am on the "What to drink?" "choice activity" page logged in as student1
    Then the manual completion button of "What to drink?" overridden by "Teacher 1" is displayed as "Done"
    And I toggle the manual completion state of "What to drink?"
    And the manual completion button of "What to drink?" is displayed as "Mark as done"

  @javascript
  Scenario: Overriding a manual choice completion for a user to not done
    Given I am on the "What to drink?" "choice activity" page logged in as student1
    And I press "Mark as done"
    And I wait until the page is ready
    And I log out
    And I am on the "Course 1" course page logged in as teacher1
    And I navigate to "Reports" in current page administration
    And I click on "Activity completion" "link"
    And I click on "Student 1, What to drink?: Completed" "link"
    And I press "Save changes"
    And I log out
    Given I am on the "What to drink?" "choice activity" page logged in as student1
    Then the manual completion button of "What to drink?" overridden by "Teacher 1" is displayed as "Mark as done"
    And I toggle the manual completion state of "What to drink?"
    And the manual completion button of "What to drink?" is displayed as "Done"
