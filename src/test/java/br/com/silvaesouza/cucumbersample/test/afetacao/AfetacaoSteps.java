package br.com.silvaesouza.cucumbersample.test.afetacao;

import java.io.File;
import java.sql.Connection;
import java.util.Date;

import javax.sql.DataSource;

import org.dbunit.JdbcDatabaseTester;
import org.dbunit.database.DatabaseConnection;
import org.dbunit.database.IDatabaseConnection;
import org.dbunit.dataset.Column;
import org.dbunit.dataset.DefaultDataSet;
import org.dbunit.dataset.DefaultTable;
import org.dbunit.dataset.IDataSet;
import org.dbunit.dataset.datatype.DataType;
import org.dbunit.dataset.xml.FlatXmlDataSetBuilder;
import org.dbunit.operation.DatabaseOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;

import br.com.silvaesouza.cucumbersample.entity.TA;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

@ContextConfiguration(locations = { "/applicationContext_test.xml" })
public class AfetacaoSteps {

	@Autowired
	private DataSource dataSource;

	private String fileDataSet = "src/main/resources/DatabaseInMemory/TADataSet.xml";

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public IDatabaseConnection getConnection() throws Exception {
		Connection con = dataSource.getConnection();
		IDatabaseConnection connection = new DatabaseConnection(con);
		return connection;
	}

	public IDataSet getDataSet() throws Exception {
		FlatXmlDataSetBuilder builder = new FlatXmlDataSetBuilder();
		return builder.build(new File(fileDataSet));
	}

	@Given("^Existe conexão com base de dados$")
	public void existe_conexão_com_base_de_dados() throws Throwable {
		// TODO implementar validação da base de dados
	}

	@Then("^Limpar registros$")
	public void limpar_registros() throws Throwable {
		final DefaultTable table = new DefaultTable("TBL_TA");
		final DefaultDataSet dataSet = new DefaultDataSet(table);
		DatabaseOperation.TRUNCATE_TABLE.execute(getConnection(), dataSet);
	}

	@Given("^Ta (\\d+) inserido com sucesso$")
	public void ta_inserido_com_sucesso(Integer ta) throws Throwable {
		ta_vinculado_ao_TA_inserido_com_sucesso(ta, null);
	}

	@Given("^Ta (\\d+) vinculado ao TA (\\d+) inserido com sucesso$")
	public void ta_vinculado_ao_TA_inserido_com_sucesso(Integer ta, Integer taRaiz) throws Throwable {
		RunAfetacaoTest.tasVozAtual.put(ta, 0);
		TA taEntity = new TA();

		final DefaultTable table = new DefaultTable("TBL_TA",
				new Column[] { new Column("TQA_CODIGO", DataType.INTEGER),
						new Column("TQA_DATA_CRIACAO", DataType.TIMESTAMP),
						new Column("TQA_SOMA_VOZ", DataType.INTEGER), 
						new Column("TQA_RAIZ", DataType.INTEGER) });

		table.addRow(new Object[] { ta, new Date(), 0, taRaiz });

		final DefaultDataSet dataSet = new DefaultDataSet(table);

		DatabaseOperation.INSERT.execute(getConnection(), dataSet);

		RunAfetacaoTest.tasDePara.put(taEntity.getTqaCodigo(), ta);
	}

	@When("^Inserir afetacao de voz igual a (\\d+) no TA (\\d+)$")
	public void inserir_afetacao_de_voz_igual_a_no_TA(Integer novaVoz, Integer ta) throws Throwable {
		RunAfetacaoTest.tasVozAtual.put(ta, novaVoz);
		Integer atualVozMaxima = RunAfetacaoTest.tasVozMaxima.get(ta);
		if (atualVozMaxima == null || novaVoz > atualVozMaxima) {
			RunAfetacaoTest.tasVozMaxima.put(ta, novaVoz);
		}
		// TODO EXECUTAR CHAMADA DO INSERT DE AFETAÇÃO
	}

	@When("^Recalcular afetacao$")
	public void recalcular_afetacao() throws Throwable {
		// TODO EXECUTAR CHAMADA DA PROCEDURE QUE RECALCULA
		// create or replace PROCEDURE ATUALIZAR_SOMA_AFETACOES (p_TQA_CODIGO
		// NUMBER) IS
	}

	@Then("^a afetacao VOZ atual do TA (\\d+) deve ser (\\d+)$")
	public void a_afetacao_VOZ_atual_do_TA_deve_ser(Integer ta, Integer vozDeveSer) throws Throwable {
		// TODO EXECUTAR SELECT NO BANCO
		org.junit.Assert.assertEquals(vozDeveSer, RunAfetacaoTest.tasVozAtual.get(ta));
	}

	@Then("^a maior afetacao VOZ do TA (\\d+) foi (\\d+)$")
	public void a_maior_afetacao_VOZ_do_TA_foi(Integer ta, Integer maiorVoz) throws Throwable {
		// TODO EXECUTAR SELECT PARA VERIFICAR MAIOR AFETAÇÃO DO TA
		org.junit.Assert.assertEquals(maiorVoz, RunAfetacaoTest.tasVozMaxima.get(ta));
	}

	@Then("^a SOMA e MAX do TA (\\d+) devem ser (\\d+) e (\\d+)$")
	public void a_SOMA_e_MAX_do_TA_devem_ser_e(int ta1, int somaDeveSer, int MaxDeveSer) throws Throwable {
		// TODO EXECUTAR SELECT PARA VERIFICAR MAIOR SOMA E MAX DA ARVORE DO TA
	}

	@Given("^Mudar raiz do TA (\\d+) para null$")
	public void mudar_raiz_do_TA_para_null(int taX) throws Throwable {
		mudar_raiz_do_TA_para(taX, null);
	}

	@Given("^Mudar raiz do TA (\\d+) para (\\d+)$")
	public void mudar_raiz_do_TA_para(Integer taX, Integer taY) throws Throwable {
		final DefaultTable table = new DefaultTable("TBL_TA",
				new Column[] { new Column("TQA_CODIGO", DataType.INTEGER), 
						new Column("TQA_RAIZ", DataType.INTEGER) });
		table.addRow(new Object[] { taX, taY });

		final DefaultDataSet dataSet = new DefaultDataSet(table);

		DatabaseOperation.UPDATE.execute(getConnection(), dataSet);
	}

	@Given("^Atualizar afetacao mais antiga do TA (\\d+) para (\\d+)$")
	public void atualizar_afetacao_mais_antiga_do_TA_para(Integer ta, Integer novaVozAtualizada) throws Throwable {
		// TODO UPDATE EM AFETAÇÃO JÁ EXISTENTE
		Integer atualVozMaxima = RunAfetacaoTest.tasVozMaxima.get(ta);
		if (atualVozMaxima == null || novaVozAtualizada > atualVozMaxima) {
			RunAfetacaoTest.tasVozMaxima.put(ta, novaVozAtualizada);
		}
	}

}
