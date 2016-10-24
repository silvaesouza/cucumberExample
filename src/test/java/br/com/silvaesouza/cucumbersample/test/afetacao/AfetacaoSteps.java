package br.com.silvaesouza.cucumbersample.test.afetacao;

import br.com.silvaesouza.cucumbersample.test.RunAfetacaoTest;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

public class AfetacaoSteps {
	
	/*@Before("@afetacao")
	public void setup() {
		//tas = new HashMap<Integer, Integer>();
		System.out.println("chamou afetacao");
		
		if(!dunit) {
            Runtime.getRuntime().addShutdownHook(new Thread() {
                public void run() {
                    System.out.println("snake!");
                }
            });
            System.out.println("badger");
            dunit = true;
        }
	}
	
	@After("@afetacao")
	public void finalize() {
		Logger.getAnonymousLogger().log(Level.ALL, tas.toString());
		
		System.out.println(tas.toString());
	}*/
	
	@Given("^Ta (\\d+) inserido com sucesso$")
	public void ta_inserido_com_sucesso(int ta) throws Throwable {
		// TODO EXECUTAR CHAMADA DO INSERT DE TA
		RunAfetacaoTest.tasVozAtual.put(ta, 0);
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
		// create or replace PROCEDURE ATUALIZAR_SOMA_AFETACOES (p_TQA_CODIGO NUMBER) IS
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
		// TODO UPDATE RAIZ para outro TA ou para NULL
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
