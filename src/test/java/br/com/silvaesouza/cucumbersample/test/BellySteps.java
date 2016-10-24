package br.com.silvaesouza.cucumbersample.test;

import org.junit.Assert;

import br.com.silvaesouza.cucumbersample.main.Belly;
import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

public class BellySteps {
	
	private Belly belly;
    private int waitingTime;
    
    /*
    Feature : Describes the feature to be tested
    Scenario : Describes the scenario
    Given : Sets the preconditions
    When : Describes the action to be performed
    And : Adds additional condition to above statement
    Then : Here the validations are performed.
    */
    
    @Before
    public void setUp() throws Exception {
    	System.out.println("chamou belly");
       /* new DBUnitHelper().cleanInsert("/tabelas/editora.xml");
        new DBUnitHelper().cleanInsert("/tabelas/livro.xml");
        repository = new GenericRepository<>(Livro.class);*/
    }

    @Given("^Eu tenho (\\d+) cukes in my belly$")
    public void eu_tenho_cukes_in_my_belly(int cukes) throws Throwable {
        belly = new Belly();
        belly.eat(cukes);
    }

    @When("^I wait (\\d+) hour$")
    public void i_wait_hour(int waitingTime) throws Throwable {
        this.waitingTime = waitingTime;
    }

    @Then("^my belly should \"(.*?)\"$")
    public void my_belly_should_growl(String expectedSound) throws Throwable {
        String actualSound = belly.getSound(waitingTime);
        Assert.assertEquals(actualSound, expectedSound);
    }

}
