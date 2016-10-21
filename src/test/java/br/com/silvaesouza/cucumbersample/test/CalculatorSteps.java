package br.com.silvaesouza.cucumbersample.test;

import org.junit.Assert;

import br.com.silvaesouza.cucumbersample.main.Calculator;
import cucumber.api.PendingException;
import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

public class CalculatorSteps {
	
	Calculator calculator;
	
	@Before
	public void setup() {
		calculator = new Calculator();
	}
	
	@Given("^I have a calculator$")
	public void i_have_a_calculator() throws Throwable {
		Assert.assertNotNull(calculator);
	}

	@When("^I add (\\d+) and (\\d+)$")
	public void i_add_and(int arg1, int arg2) throws Throwable {
	    calculator.add(arg1, arg2);
	}

	@Then("^the result should be (\\d+)$")
	public void the_result_should_be(int arg1) throws Throwable {
	    Assert.assertEquals(arg1, calculator.getResult());
	}

}
