package br.com.silvaesouza.cucumbersample.test;

import java.util.HashMap;
import java.util.Map;

import org.dbunit.DBTestCase;
import org.dbunit.IDatabaseTester;
import org.dbunit.JdbcDatabaseTester;
import org.dbunit.dataset.IDataSet;
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

public class RunAfetacaoTest extends DBTestCase {
	
	public static Map<Integer, Integer> tasVozAtual;
	public static Map<Integer, Integer> tasVozMaxima;
	
	 private static IDatabaseTester databaseTester;
	
	@BeforeClass
    public static void setup() {
		tasVozAtual = new HashMap<Integer, Integer>();
		tasVozMaxima = new HashMap<Integer, Integer>();
		//databaseTester = new JdbcDatabaseTester("org.hsqldb.jdbcDriver", "jdbc:hsqldb:sample", "sa", "");
		try {
			databaseTester = new JdbcDatabaseTester("oracle.jdbc.driver.OracleDriver", "jdbc:oracle:thin:@localhost:1521/XE", "silvaesouza", "1234");
			// initialize your dataset here
			IDataSet dataSet = null;
			// ...

			databaseTester.setDataSet(dataSet);
			
			databaseTester.getConnection();
			// will call default setUpOperation
			//databaseTester.onSetup();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
        System.out.println("Ran the before");
    }

    @AfterClass
    public static void teardown() {
        System.out.println("Ran the after");
        
        System.out.println(tasVozAtual.toString());
        System.out.println(tasVozMaxima.toString());
    }

	@Override
	protected IDataSet getDataSet() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
}