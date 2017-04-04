package br.com.silvaesouza.cucumbersample.test.afetacao;

import java.io.File;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.dbunit.database.DatabaseConnection;
import org.dbunit.database.IDatabaseConnection;
import org.dbunit.dataset.Column;
import org.dbunit.dataset.DataSetException;
import org.dbunit.dataset.DefaultDataSet;
import org.dbunit.dataset.DefaultTable;
import org.dbunit.dataset.IDataSet;
import org.dbunit.dataset.datatype.DataType;
import org.dbunit.dataset.xml.FlatXmlDataSetBuilder;
import org.dbunit.operation.DatabaseOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.annotation.AnnotationSessionFactoryBean;
import org.springframework.test.context.ContextConfiguration;

import br.com.silvaesouza.cucumbersample.entity.TA;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

@ContextConfiguration(locations = { "/applicationContext_test.xml" })
public class AfetacaoSteps {

	private final String TABELA_TA = "TBL_TA";
	private final String TABELA_TA_AFETACAO = "TBL_TA_AFETACAO_PARCIAL";
	private final String TABELA_AFETACAO_MAXIMA = "AFETACAO_MAXIMA_TA";
	private final String TABELA_RECALCULA_AFETACAO = "TBL_TA_RECALCULA_AFETACAO";
	// private final String SEQUENCE_TA = "SEQ_TA";
	private final String SEQUENCE_TA_AFETACAO = "SEQ_TA_AFETACAO_PARCIAL";

	@Autowired
	private DataSource dataSource;

	@Autowired
	AnnotationSessionFactoryBean sessionFactory;

	private Connection con;

	private String fileDataSet = "src/main/resources/DatabaseInMemory/TADataSet.xml";

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public IDatabaseConnection getConnection() throws Exception {
		if (con == null || con.isClosed()) {
			con = dataSource.getConnection();
		}
		//IDatabaseConnection connection = new DatabaseConnection(con, "sigitm");
		IDatabaseConnection connection = new DatabaseConnection(con, "SILVAESOUZA");
		return connection;
	}

	public IDataSet getDataSet() throws Exception {
		FlatXmlDataSetBuilder builder = new FlatXmlDataSetBuilder();
		return builder.build(new File(fileDataSet));
	}

	private Integer getSequenceNextVal(String sequenceName) throws SQLException, Exception {
		Statement st = this.getConnection().getConnection().createStatement();
		ResultSet rs = st.executeQuery("SELECT " + sequenceName + ".nextval FROM dual");
		rs.next();
		st = null;
		return new Integer(rs.getInt(1));
	}

	private Integer getCodigoAfetacaoMaisAntiga(Integer ta) throws SQLException, Exception {
		Statement st = this.getConnection().getConnection().createStatement();
		ResultSet rs = st.executeQuery("SELECT min(aap_codigo) FROM " + TABELA_TA_AFETACAO + " WHERE aap_ta = " + ta);
		rs.next();
		st = null;
		return new Integer(rs.getInt(1));
	}

	private DefaultDataSet getDataSetTa(Integer codigo, Date dataCriacao, Integer somaVoz, Integer raiz,
			Integer ultimaAfetacao) throws DataSetException {
		List<Column> columnsList = new ArrayList<Column>();
		List<Object> columnsValue = new ArrayList<Object>();
		if (codigo != null) {
			columnsList.add(new Column("TQA_CODIGO", DataType.INTEGER));
			columnsValue.add(codigo);
		}
		if (dataCriacao != null) {
			columnsList.add(new Column("TQA_DATA_CRIACAO", DataType.TIMESTAMP));
			columnsValue.add(dataCriacao);
		}
		if (somaVoz != null) {
			columnsList.add(new Column("TQA_SOMA_VOZ", DataType.INTEGER));
			columnsValue.add(somaVoz);
		}
		if (ultimaAfetacao != null) {
			columnsList.add(new Column("TQA_ULTIMA_AFETACAO", DataType.INTEGER));
			columnsValue.add(ultimaAfetacao);
		} else {
			columnsList.add(new Column("TQA_RAIZ", DataType.INTEGER));
			columnsValue.add(raiz);
		}
		/*
		columnsList.add(new Column("TQA_TIPO_REDE", DataType.INTEGER));
		columnsValue.add(101);
		columnsList.add(new Column("TQA_SEVERIDADE", DataType.INTEGER));
		columnsValue.add(4);
		columnsList.add(new Column("TQA_STATUS", DataType.INTEGER));
		columnsValue.add(10);
		columnsList.add(new Column("TQA_LOCALIDADE_CODIGO", DataType.INTEGER));
		columnsValue.add(11381);
		columnsList.add(new Column("TQA_LOCALIDADE_SIGLA", DataType.VARCHAR));
		columnsValue.add("MCZ");
		columnsList.add(new Column("TQA_LOCALIDADE_NOME", DataType.VARCHAR));
		columnsValue.add("MOGI DAS CRUZES");
		columnsList.add(new Column("TQA_AREA_CODIGO", DataType.VARCHAR));
		columnsValue.add("JP");
		columnsList.add(new Column("TQA_AREA_NOME", DataType.VARCHAR));
		columnsValue.add("JD SAO PEDRO");
		columnsList.add(new Column("TQA_CRO_CODIGO", DataType.VARCHAR));
		columnsValue.add("SP");
		columnsList.add(new Column("TQA_CRO_NOME", DataType.VARCHAR));
		columnsValue.add("REGIONAL SÃO PAULO");
		columnsList.add(new Column("TQA_GERENCIA_CODIGO", DataType.VARCHAR));
		columnsValue.add("CB");
		columnsList.add(new Column("TQA_GERENCIA_NOME", DataType.VARCHAR));
		columnsValue.add("CAMPO BELO");
		columnsList.add(new Column("TQA_CRIADOPOR_DOMINIO", DataType.VARCHAR));
		columnsValue.add("VIVO");
		columnsList.add(new Column("TQA_CRIADOPOR_SISTEMA", DataType.INTEGER));
		columnsValue.add(1);
		columnsList.add(new Column("TQA_CRIADOPOR_GRUPO", DataType.INTEGER));
		columnsValue.add(100);
		columnsList.add(new Column("TQA_CRIADOPOR_USUARIO", DataType.INTEGER));
		columnsValue.add(7);
		columnsList.add(new Column("TQA_DATA_APRESENTACAO", DataType.TIMESTAMP));
		columnsValue.add(dataCriacao);
		columnsList.add(new Column("TQA_DATA_PREVISTA", DataType.TIMESTAMP));
		columnsValue.add(dataCriacao);
		columnsList.add(new Column("TQA_DATA_OBJETIVO", DataType.TIMESTAMP));
		columnsValue.add(dataCriacao);
		columnsList.add(new Column("TQA_ALARME_TIPO", DataType.VARCHAR));
		columnsValue.add("ARQUIVOS_R");
		columnsList.add(new Column("TQA_TIPO_FALHA", DataType.VARCHAR));
		columnsValue.add("ANATEL - INTERRUP");
		columnsList.add(new Column("TQA_TIPO_AFETACAO", DataType.VARCHAR));
		columnsValue.add("AFETACAO - STFC");
		columnsList.add(new Column("TQA_SEVERIDADE_MAXIMA", DataType.INTEGER));
		columnsValue.add(4);
		columnsList.add(new Column("TQA_TIPO_PLANTA", DataType.INTEGER));
		columnsValue.add(1);
		columnsList.add(new Column("TQA_HASHCODE", DataType.INTEGER));
		columnsValue.add(codigo);
		columnsList.add(new Column("TQA_TRAMITA_NOC", DataType.INTEGER));
		columnsValue.add(0);
		columnsList.add(new Column("TQA_TRAMITA_CIERRE", DataType.INTEGER));
		columnsValue.add(0);
		*/

		Column[] columns = new Column[columnsList.size()];
		columns = columnsList.toArray(columns);

		DefaultTable table = new DefaultTable(TABELA_TA, columns);

		Object[] values = new Object[columnsValue.size()];
		values = columnsValue.toArray(values);

		table.addRow(values);
		return new DefaultDataSet(table);
	}

	private DefaultDataSet getDataSetTaAfetacao(Integer codigo, Integer ta, Integer voz, Date dataCriacao)
			throws DataSetException {
		List<Column> columnsList = new ArrayList<Column>();
		List<Object> columnsValue = new ArrayList<Object>();
		if (codigo != null) {
			columnsList.add(new Column("AAP_CODIGO", DataType.INTEGER));
			columnsValue.add(codigo);
		}
		if (dataCriacao != null) {
			columnsList.add(new Column("AAP_DATA", DataType.TIMESTAMP));
			columnsValue.add(dataCriacao);
		}
		columnsList.add(new Column("AAP_VOZ", DataType.INTEGER));
		columnsValue.add(voz);
		if (ta != null) {
			columnsList.add(new Column("AAP_TA", DataType.INTEGER));
			columnsValue.add(ta);
		}

		Column[] columns = new Column[columnsList.size()];
		columns = columnsList.toArray(columns);

		DefaultTable table = new DefaultTable(TABELA_TA_AFETACAO, columns);

		Object[] values = new Object[columnsValue.size()];
		values = columnsValue.toArray(values);

		table.addRow(values);
		return new DefaultDataSet(table);
	}

	/*private DefaultDataSet getDataSetMaximaAfetacao(Integer codigo, Integer taRaiz, Integer voz)
			throws DataSetException {
		List<Column> columnsList = new ArrayList<Column>();
		List<Object> columnsValue = new ArrayList<Object>();
		columnsList.add(new Column("SEQUENCIA", DataType.INTEGER));
		columnsValue.add(codigo);
		if (voz != null) {
			columnsList.add(new Column("VOZ", DataType.INTEGER));
			columnsValue.add(voz);
		}
		columnsList.add(new Column("TQA_RAIZ", DataType.INTEGER));
		columnsValue.add(taRaiz);

		Column[] columns = new Column[columnsList.size()];
		columns = columnsList.toArray(columns);

		DefaultTable table = new DefaultTable(TABELA_AFETACAO_MAXIMA, columns);

		Object[] values = new Object[columnsValue.size()];
		values = columnsValue.toArray(values);

		table.addRow(values);
		return new DefaultDataSet(table);
	}*/

	@Given("^Existe conexão com base de dados$")
	public void existe_conexão_com_base_de_dados() throws Throwable {
		Object hbm2dll = sessionFactory.getHibernateProperties().get("hibernate.hbm2ddl.auto");
		System.out.println("HBM2DLL >> " + hbm2dll);

		// TODO implementar validação da base de dados
	}

	@Then("^Limpar registros$")
	public void limpar_registros() throws Throwable {
		final DefaultTable tableTa = new DefaultTable(TABELA_TA);
		final DefaultTable tableTaAfetacao = new DefaultTable(TABELA_TA_AFETACAO);
		final DefaultTable tableAfetacaoMaxima = new DefaultTable(TABELA_AFETACAO_MAXIMA);
		final DefaultTable tableRecalculaAfetacao = new DefaultTable(TABELA_RECALCULA_AFETACAO);


		IDatabaseConnection conn = getConnection();

		DefaultDataSet dataSet = new DefaultDataSet(tableTaAfetacao);
		DatabaseOperation.DELETE_ALL.execute(conn, dataSet);
		dataSet = new DefaultDataSet(tableTa);
		DatabaseOperation.DELETE_ALL.execute(conn, dataSet);
		dataSet = new DefaultDataSet(tableAfetacaoMaxima);
		DatabaseOperation.DELETE_ALL.execute(conn, dataSet);
		dataSet = new DefaultDataSet(tableRecalculaAfetacao);
		DatabaseOperation.DELETE_ALL.execute(conn, dataSet);

		conn.close();
	}

	@Given("^Ta (\\d+) vinculado ao TA null inserido com sucesso$")
	public void ta_vinculado_ao_TA_null_inserido_com_sucesso(Integer ta) throws Throwable {
		ta_vinculado_ao_TA_inserido_com_sucesso(ta, null);
	}

	@Given("^Ta (\\d+) vinculado ao TA (\\d+) inserido com sucesso$")
	public void ta_vinculado_ao_TA_inserido_com_sucesso(Integer ta, Integer taRaiz) throws Throwable {
		RunAfetacaoTest.tasVozAtual.put(ta, 0);
		TA taEntity = new TA();

		DefaultDataSet dataSet = getDataSetTa(ta, new Date(), 0, taRaiz, null);

		IDatabaseConnection conn = getConnection();
		DatabaseOperation.INSERT.execute(conn, dataSet);

		/*dataSet = getDataSetMaximaAfetacao(ta, taRaiz, 0);
		DatabaseOperation.INSERT.execute(conn, dataSet);*/
		conn.close();

		RunAfetacaoTest.tasDePara.put(taEntity.getTqaCodigo(), ta);
	}

	@When("^Inserir afetacao de voz igual a (\\d+) no TA (\\d+)$")
	public void inserir_afetacao_de_voz_igual_a_no_TA(Integer novaVoz, Integer ta) throws Throwable {
		RunAfetacaoTest.tasVozAtual.put(ta, novaVoz);
		Integer atualVozMaxima = RunAfetacaoTest.tasVozMaxima.get(ta);
		if (atualVozMaxima == null || novaVoz > atualVozMaxima) {
			RunAfetacaoTest.tasVozMaxima.put(ta, novaVoz);
		}

		IDatabaseConnection conn = getConnection();
		Integer codigo = getSequenceNextVal(SEQUENCE_TA_AFETACAO);
		DefaultDataSet dataSetTaAfetacao = getDataSetTaAfetacao(codigo, ta, novaVoz, new Date());
		DatabaseOperation.INSERT.execute(conn, dataSetTaAfetacao);

		conn.close();
		//DefaultDataSet dataSetTa = getDataSetTa(ta, null, novaVoz, null, codigo);
		//DatabaseOperation.UPDATE.execute(conn, dataSetTa);
	}

	@When("^Recalcular afetacao$")
	public void recalcular_afetacao() throws Throwable {
		IDatabaseConnection conn = getConnection();
		conn.getConnection().createStatement().execute("{call CORRIGIR_AFETACAO_24H_VERSAO2()}");
		conn.close();
		//conn.getConnection().createStatement().execute("{call ATUALIZAR_SOMA_AFETACOES(1)}");
	}

	@Then("^a afetacao VOZ atual do TA (\\d+) deve ser (\\d+)$")
	public void a_afetacao_VOZ_atual_do_TA_deve_ser(Integer ta, Integer vozDeveSer) throws Throwable {
		IDatabaseConnection conn = getConnection();
		Statement st = conn.getConnection().createStatement();
		ResultSet rs = st.executeQuery("SELECT aap_voz FROM " + TABELA_TA_AFETACAO + " INNER JOIN " + TABELA_TA
				+ " ON aap_codigo = tqa_ultima_afetacao " + " WHERE TQA_CODIGO = " + ta);
		rs.next();
		st = null;
		Integer vozEh = rs.getInt(1);

		rs.close();
		conn.close();

		org.junit.Assert.assertEquals(vozDeveSer, RunAfetacaoTest.tasVozAtual.get(ta));
		org.junit.Assert.assertEquals(vozDeveSer, vozEh);
	}

	@Then("^a maior afetacao VOZ do TA (\\d+) foi (\\d+)$")
	public void a_maior_afetacao_VOZ_do_TA_foi(Integer ta, Integer maiorVoz) throws Throwable {
		IDatabaseConnection conn = getConnection();
		Statement st = conn.getConnection().createStatement();
		ResultSet rs = st.executeQuery("SELECT max(aap_voz) FROM " + TABELA_TA_AFETACAO + " INNER JOIN " + TABELA_TA
				+ " ON aap_ta = tqa_codigo " + " WHERE TQA_CODIGO = " + ta);
		rs.next();
		st = null;
		Integer maiorVozEh = rs.getInt(1);

		rs.close();
		conn.close();

		org.junit.Assert.assertEquals(maiorVoz, RunAfetacaoTest.tasVozMaxima.get(ta));
		org.junit.Assert.assertEquals(maiorVoz, maiorVozEh);
	}

	@Then("^a SOMA dos derivados do TA (\\d+) deve ser (\\d+)$")
	public void a_SOMA_dos_derivados_do_TA_deve_ser(Integer ta, Integer somaVozDeveSer) throws Throwable {
		IDatabaseConnection conn = getConnection();
		Statement st = conn.getConnection().createStatement();
		ResultSet rs = st.executeQuery("SELECT tqa_soma_voz FROM " + TABELA_TA + " WHERE TQA_CODIGO = " + ta);
		rs.next();
		st = null;
		Integer somaVozEh = rs.getInt(1);

		rs.close();
		conn.close();

		org.junit.Assert.assertEquals(somaVozDeveSer, somaVozEh);
	}

	@Then("^a SOMA do MAX dos derivados do TA (\\d+) deve ser (\\d+)$")
	public void a_SOMA_do_MAX_dos_derivados_do_TA_deve_ser(Integer ta, Integer somaMaxVozDeveSer) throws Throwable {
		IDatabaseConnection conn = getConnection();
		Statement st = conn.getConnection().createStatement();
		ResultSet rs = st.executeQuery("SELECT voz FROM " + TABELA_AFETACAO_MAXIMA + " WHERE sequencia = " + ta);
		rs.next();
		st = null;
		Integer somaMaxVozEh = rs.getInt(1);

		rs.close();
		conn.close();

		org.junit.Assert.assertEquals(somaMaxVozDeveSer, somaMaxVozEh);
	}

	@Given("^Mudar raiz do TA (\\d+) para null$")
	public void mudar_raiz_do_TA_para_null(int taX) throws Throwable {
		mudar_raiz_do_TA_para(taX, null);
	}

	@Given("^Mudar raiz do TA (\\d+) para (\\d+)$")
	public void mudar_raiz_do_TA_para(Integer taX, Integer taY) throws Throwable {
		IDatabaseConnection conn = getConnection();
		DefaultDataSet dataSet = getDataSetTa(taX, null, null, taY, null);
		DatabaseOperation.UPDATE.execute(conn, dataSet);

		conn.close();
		/*dataSet = getDataSetMaximaAfetacao(taX, taY, null);
		DatabaseOperation.UPDATE.execute(getConnection(), dataSet);*/
	}

	@Given("^Atualizar afetacao mais antiga do TA (\\d+) para (\\d+)$")
	public void atualizar_afetacao_mais_antiga_do_TA_para(Integer ta, Integer novaVozAtualizada) throws Throwable {
		Integer atualVozMaxima = RunAfetacaoTest.tasVozMaxima.get(ta);
		if (atualVozMaxima == null || novaVozAtualizada > atualVozMaxima) {
			RunAfetacaoTest.tasVozMaxima.put(ta, novaVozAtualizada);
		}
		IDatabaseConnection conn = getConnection();

		Integer codigoAfetacao = getCodigoAfetacaoMaisAntiga(ta);
		DefaultDataSet dataSet = getDataSetTaAfetacao(codigoAfetacao, null, novaVozAtualizada, null);

		DatabaseOperation.UPDATE.execute(conn, dataSet);
		conn.close();
	}

}
