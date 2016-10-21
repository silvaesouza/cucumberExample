package br.com.silvaesouza.cucumbersample.test;

import java.util.Map;

import cucumber.api.PendingException;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

public class AfetacaoSteps {
	
	Map<Integer, String> tas;
	
	@Given("^Ta (\\d+) inserido com sucesso$")
	public void ta_inserido_com_sucesso(int arg1) throws Throwable {
		// TODO EXECUTAR CHAMADA DO INSERT DE TA
		tas.put(arg1, "tqa_codigo");
		
	    throw new PendingException();
	}

	@When("^Inserir afetacao de voz igual a (\\d+) no TA (\\d+)$")
	public void inserir_afetacao_de_voz_igual_a_no_TA(int arg1, int arg2) throws Throwable {
	    // TODO EXECUTAR CHAMADO DO INSERT DE AFETAÇÃO
	    throw new PendingException();
	}

	@When("^Recalcular afetacao$")
	public void recalcular_afetacao() throws Throwable {
		// TODO EXECUTAR CHAMADA DA PROCEDURE QUE RECALCULA
		// create or replace PROCEDURE ATUALIZAR_SOMA_AFETACOES (p_TQA_CODIGO NUMBER) IS
	    throw new PendingException();
	}

	@Then("^a afetacao VOZ atual do TA (\\d+) deve ser (\\d+)$")
	public void a_afetacao_VOZ_atual_do_TA_deve_ser(int arg1, int arg2) throws Throwable {
	    // TODO EXECUTAR SELECT VERIFICAR ULTIMA AFETAÇÃO DO TA
	    throw new PendingException();
	}

	@Then("^a maior afetacao VOZ do TA (\\d+) foi (\\d+)$")
	public void a_maior_afetacao_VOZ_do_TA_foi(int arg1, int arg2) throws Throwable {
	    // TODO EXECUTAR SELECT PARA VERIFICAR MAIOR AFETAÇÃO DO TA
	    throw new PendingException();
	}

	@Then("^a SOMA e MAX do TA (\\d+) devem ser (\\d+) e (\\d+)$")
	public void a_SOMA_e_MAX_do_TA_devem_ser_e(int arg1, int arg2, int arg3) throws Throwable {
	    // TODO EXECUTAR SELECT PARA VERIFICAR MAIOR SOMA E MAX DA ARVORE DO TA
	    throw new PendingException();
	}

	@When("^Inserir afetacao de voz igual (\\d+) no TA (\\d+)$")
	@Given("^Inserir afetacao de voz igual (\\d+) no TA (\\d+)$")
	public void inserir_afetacao_de_voz_igual_no_TA(int arg1, int arg2) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
	    throw new PendingException();
	}

}
