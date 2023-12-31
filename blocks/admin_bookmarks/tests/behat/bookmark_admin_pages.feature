@block @block_admin_bookmarks
Feature: Add a bookmarks to an admin pages
  In order to speed up common tasks
  As an admin
  I need to add and access pages through bookmarks

  Background:
    Given I log in as "admin"
    And I navigate to "Server > Tasks > Scheduled tasks" in site administration
    And I click on "Bookmark this page" "link" in the "Admin bookmarks" "block"
    And I log out

  # Test bookmark functionality using the "User profile fields" page as our bookmark.
  Scenario: Admin page can be bookmarked
    Given I log in as "admin"
    And I navigate to "Users > Accounts > User profile fields" in site administration
    When I click on "Bookmark this page" "link" in the "Admin bookmarks" "block"
    Then I should see "User profile fields" in the "Admin bookmarks" "block"
    # See the existing bookmark is there too.
    And I should see "Scheduled tasks" in the "Admin bookmarks" "block"

  Scenario: Admin page can be accessed through bookmarks block
    Given I log in as "admin"
    And I navigate to "Notifications" in site administration
    And I click on "Scheduled tasks" "link" in the "Admin bookmarks" "block"
    # Verify that we are on the right page.
    Then I should see "Day of week" in the "admintable" "table"

  Scenario: Admin page can be removed from bookmarks
    Given I log in as "admin"
    And I navigate to "Notifications" in site administration
    And I click on "Scheduled tasks" "link" in the "Admin bookmarks" "block"
    When I click on "Unbookmark this page" "link" in the "Admin bookmarks" "block"
    Then I should see "Bookmark deleted"
    And I wait to be redirected
    And I should not see "Scheduled tasks" in the "Admin bookmarks" "block"
