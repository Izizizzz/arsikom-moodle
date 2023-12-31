@gradeexport @gradeexport_txt
Feature: I need to export grades as text
  In order to easily review marks
  As a teacher
  I need to have a export grades as text

  Background:
    Given the following "courses" exist:
      | fullname | shortname | category | groupmode |
      | Course 1 | C1 | 0 | 1 |
    And the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
      | student1 | Student | 1 | student1@example.com |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
      | student1 | C1 | student |
    And the following "activities" exist:
      | activity | course | idnumber | name | intro | assignsubmission_onlinetext_enabled |
      | assign | C1 | a1 | Test assignment name | Submit your online text | 1 |
      | assign | C1 | a2 | Test assignment name 2 | Submit your online text | 1 |
    And the following "grade grades" exist:
      | gradeitem            | user     | grade |
      | Test assignment name | student1 | 80.00 |
    And I am on the "Course 1" "grades > Grader report > View" page logged in as "teacher1"

  @javascript
  Scenario: Export grades as text
    When I navigate to "Plain text file" export page in the course gradebook
    And I expand all fieldsets
    And I click on "Course total" "checkbox"
    And I set the field "Grade export decimal places" to "1"
    And I press "Download"
    Then I should see "Student,1"
    And I should see "80.0"
    And I should not see "Course total"
    And I should not see "80.00"

  @javascript
  Scenario: Export grades as text using real
    When I navigate to "Plain text file" export page in the course gradebook
    And I expand all fieldsets
    And  I set the following fields to these values:
      | Real        | 1                        |
    And I click on "Course total" "checkbox"
    And I press "Download"
    Then I should see "Student,1"
    And I should see "80.00"

  @javascript
  Scenario: Export grades as text using percentages and letters
    When I navigate to "Plain text file" export page in the course gradebook
    And  I set the following fields to these values:
      | Percentage   | 1                        |
      | Letter       | 1                        |
    And I press "Download"
    Then I should see "Student,1"
    And I should see "80.00 %"
    And I should see "B-"
    And I should not see "40.00 %"
    And I should not see ",F,"

  @javascript
  Scenario: Export grades as text using real, percentages and letters
    When I navigate to "Plain text file" export page in the course gradebook
    And  I set the following fields to these values:
      | Real         | 1                        |
      | Percentage   | 1                        |
      | Letter       | 1                        |
    And I press "Download"
    Then I should see "Student,1"
    And I should see "80.00"
    And I should see "80.00 %"
    And I should see "B-"
    And I should not see "40.00 %"
    And I should not see ",F,"
