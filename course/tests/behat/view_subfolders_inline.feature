@core @core_course
Feature: View subfolders in a course in-line
  In order to provide different view options for folders
  As a teacher
  I need to add a folders and subfolders and view them inline

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
    And the following "courses" exist:
      | fullname | shortname | format | coursedisplay | numsections |
      | Course 1 | C1 | topics | 0 | 5 |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
    And the following "activities" exist:
      | activity | course | name        | display | showexpanded |
      | folder   | C1     | Test folder | 0       | 0            |
    And I am on the "Test folder" "folder activity" page logged in as "teacher1"
    And I press "Edit"
    And I press "Create folder"
    And I set the field "New folder name" to "Test subfolder 1"
    And I click on "button.fp-dlg-butcreate" "css_element" in the "div.fp-mkdir-dlg" "css_element"
    And I press "Save changes"

  @javascript
  Scenario: Add a folder with two subfolders - view on separate page
    Given I am on "Course 1" course homepage
    And I should not see "Test subfolder 1"
    And I am on the "Test folder" "folder activity" page
    And I should see "Test subfolder 1"
    And I press "Edit"
    And I press "Create folder"
    And I set the field "New folder name" to "Test subfolder 2"
    And I click on "button.fp-dlg-butcreate" "css_element" in the "div.fp-mkdir-dlg" "css_element"
    And I press "Save changes"
    When I am on "Course 1" course homepage
    Then I should not see "Test subfolder 2"
    And I am on the "Test folder" "folder activity" page
    And I should see "Test subfolder 2"
    And I am on the "Test folder" "folder activity editing" page
    And I set the field "Show subfolders expanded" to "1"
    When I am on "Course 1" course homepage
    Then I should not see "Test subfolder 2"
    And I am on the "Test folder" "folder activity" page
    And I should see "Test subfolder 2"

  @javascript
  Scenario: Make the subfolders viewable inline on the course page
    Given I press "Edit"
    And I click on "div.fp-filename" "css_element" in the "div.fp-filename-field" "css_element"
    And I press "Create folder"
    And I set the field "New folder name" to "Test sub subfolder"
    And I click on "button.fp-dlg-butcreate" "css_element" in the "div.fp-mkdir-dlg" "css_element"
    And I press "Save changes"
    And I navigate to "Settings" in current page administration
    When I set the field "Display folder contents" to "Inline on a course page"
    And I press "Save and return to course"
    Then I should see "Test subfolder 1"
    And I should not see "Test sub subfolder"
    And I am on the "Test folder" "folder activity editing" page
    And I set the field "Show subfolders expanded" to "1"
    And I press "Save and return to course"
    Then I should see "Test subfolder 1"
    And I should see "Test sub subfolder"
