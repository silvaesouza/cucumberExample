package br.com.silvaesouza.cucumbersample.test;
import org.junit.runner.RunWith;

import cucumber.api.junit.Cucumber;
import cucumber.api.CucumberOptions;

@RunWith(Cucumber.class)
@CucumberOptions(
        format = { "pretty", "html:target/cucumber" },
        		features = {"classpath:br/com/silvaesouza/cucumbersample/test/CalcularAfetacao.feature"}
        /*features = {"classpath:br/com/silvaesouza/cucumbersample/test/belly.feature" , 
        		    "classpath:br/com/silvaesouza/cucumbersample/test/calculator.feature"}*/
)

public class RunCukesTest {
	
	//private GenericDAO<Livro> repository;
}