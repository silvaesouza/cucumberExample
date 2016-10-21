Feature: Belly

  Scenario: a few cukes
    Given Eu tenho 42 cukes in my belly
    When I wait 1 hour
    Then my belly should "growl"

#Feature Belly : Describes the feature to be tested    
#Scenario : Describes the scenario
#Given : Sets the preconditions
#When : Describes the action to be performed
#And : Adds additional condition to above statement
#Then : Here the validations are performed.