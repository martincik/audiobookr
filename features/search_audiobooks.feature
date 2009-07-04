Feature: Search audiobooks
  In order to find audiobooks I like
  As an user
  I want to search audiobooks with keywords
  
  Scenario: Finding audiobook by author as keyword
    Given I am on the homepage
    When I fill in "query" with "Ladislav"
    When I press "Search"
    Then I should see "Ladislav"
    And I should not see "Martincik"