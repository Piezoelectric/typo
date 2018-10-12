Feature: Categories
  
  Background:
    Given the blog is set up
    And I am logged into the admin panel
    
  Scenario: View Categories
    Given I am on the admin page
    When I click the categories link
    Then I should see the categories page
    
  Scenario: Add Category
    When I click the categories link
    And I fill in "Name" with "nnn"
    And I fill in "Keywords" with "k1, k2"
    And I fill in "Description" with "dddd"
    And I press "Save"
    Then I should see the categories page
    And I should see "nnn"
    
  Scenario: Edit Category
    When I click the categories link
    And I click the "General" category
    And I fill in "Name" with "General1"
    And I press "Save"
    Then I should see the categories page
    And I should see "General1"
    
  Scenario: Delete Category
    When I click the categories link
    And I click Delete
    And I press "delete"
    Then I should see the categories page
    And I should not see "General"