package br.com.silvaesouza.cucumbersample.test;

import java.util.HashMap;
import java.util.Map;

import org.dbunit.JdbcDatabaseTester;
import org.dbunit.database.IDatabaseConnection;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

@RunWith(Cucumber.class)
@CucumberOptions(features = { "classpath:cucumber/CalcularAfetacao.feature" }, glue = {
		"classpath:br/com/silvaesouza/cucumbersample/test/afetacao" }, tags = "@afetacao")
public class RunAfetacaoTest extends FeaturesBase {

	public static Map<Integer, Integer> tasVozAtual;
	public static Map<Integer, Integer> tasVozMaxima;

	// private static DataSource dataSource;

	/*
	 * @Autowired public void setDataSource(DataSource dataSource) { dataSource
	 * = dataSource; }
	 */

	private static IDatabaseConnection connection;

	/*
	 * public IDatabaseConnection getConnection() throws Exception { Connection
	 * con = dataSource.getConnection(); IDatabaseConnection connection = new
	 * DatabaseConnection(con); return connection; }
	 */

	@BeforeClass
	public static void setup() {
		tasVozAtual = new HashMap<Integer, Integer>();
		tasVozMaxima = new HashMap<Integer, Integer>();
		try {
			JdbcDatabaseTester databaseTester = new JdbcDatabaseTester("oracle.jdbc.driver.OracleDriver",
					"jdbc:oracle:thin:@localhost:1521/XE", "silvaesouza", "1234");

			connection = databaseTester.getConnection();
			connection.getConnection().createStatement().execute("{call p_recalc_monthly_sales(1, DATE '2012-07-02')}");

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

}