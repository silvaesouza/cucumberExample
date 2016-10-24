package br.com.silvaesouza.cucumbersample.test;

import java.util.HashMap;
import java.util.Map;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

@RunWith(Cucumber.class)
@CucumberOptions(
        		features = {"classpath:cucumber/CalcularAfetacao.feature"} ,
        				glue = {"classpath:br/com/silvaesouza/cucumbersample/test/afetacao"}  ,
        		tags = "@afetacao" ,
        	    plugin = {"pretty", "html:target/cucumber"}
        /*features = {"classpath:br/com/silvaesouza/cucumbersample/test/belly.feature" , 
        		    "classpath:br/com/silvaesouza/cucumbersample/test/calculator.feature"}*/
)

public class RunAfetacaoTest {
	
	public static Map<Integer, Integer> tasVozAtual;
	public static Map<Integer, Integer> tasVozMaxima;
	
	@BeforeClass
    public static void setup() {
		tasVozAtual = new HashMap<Integer, Integer>();
		tasVozMaxima = new HashMap<Integer, Integer>();
        System.out.println("Ran the before");
    }

    @AfterClass
    public static void teardown() {
        System.out.println("Ran the after");
        
        System.out.println(tasVozAtual.toString());
        System.out.println(tasVozMaxima.toString());
    }
	
	
	//private GenericDAO<Livro> repository;
}