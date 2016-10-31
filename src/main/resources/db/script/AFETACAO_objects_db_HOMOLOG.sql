/*
create or replace PROCEDURE corrigir_afetacao_24h IS
BEGIN
	FOR c IN (
		SELECT att_ta
		FROM tbl_ta_altera_timestamp
		WHERE att_altera_timestamp > TRUNC(SYSDATE - 1,'HH')
	) LOOP
		IF is_soma_afetacao_correta(c.att_ta) = 0 THEN
			atualizar_soma_afetacoes(c.att_ta);
		END IF;
	END LOOP;
END;
*/

create or replace PROCEDURE ATUALIZAR_SOMA_AFETACOES (p_TQA_CODIGO NUMBER) IS
BEGIN
    --
    -- SOMA
    --
    FOR c IN (
        SELECT
            SUM(AAP_VOZ) voz,
            SUM(AAP_CP) cp,
            SUM(AAP_TRANSMISSAO) transmissao,
            SUM(AAP_DETERMINISTICA) deterministica,
            SUM(AAP_DTH) dth,
            SUM(AAP_SPEEDY) speedy,
            SUM(AAP_REDEIP) redeip,
            SUM(AAP_FTTX) fttx,
            SUM(AAP_CLIENTE) cliente,
            SUM(AAP_INTERCONEXAO) interconexao,
            SUM(AAP_SPPAC) sppac,
            SUM(AAP_IPTV) iptv
        FROM tbl_test_ta_afetacao_parcial
        WHERE aap_codigo IN (
            SELECT tqa_ultima_afetacao
            FROM tbl_test_ta
            CONNECT BY NOCYCLE
            PRIOR tqa_codigo = tqa_raiz
            START WITH tqa_codigo = p_TQA_CODIGO
        )
    ) LOOP
        UPDATE tbl_test_ta t SET
            t.tqa_soma_voz = COALESCE(c.VOZ, 0),
            t.tqa_soma_cp = COALESCE(c.CP, 0),
            t.tqa_soma_transmissao = COALESCE(c.TRANSMISSAO, 0),
            t.tqa_soma_deterministica = COALESCE(c.DETERMINISTICA, 0),
            t.tqa_soma_dth = COALESCE(c.DTH, 0),
            t.tqa_soma_speedy = COALESCE(c.SPEEDY, 0),
            t.tqa_soma_redeip = COALESCE(c.REDEIP, 0),
            t.tqa_soma_fttx = COALESCE(c.FTTX, 0),
            t.tqa_soma_cliente = COALESCE(c.CLIENTE, 0),
            t.tqa_soma_interconexao = COALESCE(c.INTERCONEXAO, 0),
            t.tqa_soma_sppac = COALESCE(c.SPPAC, 0),
            t.tqa_soma_iptv = COALESCE(c.IPTV, 0)
        WHERE tqa_codigo = p_TQA_CODIGO;
    END LOOP;
    --
    -- MAX
    --
    FOR c IN (
        WITH tas AS (
              SELECT level, tqa_raiz, tqa_codigo
              FROM tbl_test_ta
              CONNECT BY NOCYCLE
              PRIOR tqa_codigo = tqa_raiz
              START WITH tqa_codigo = p_TQA_CODIGO
        )
        SELECT
              MAX(aap_voz) voz,
              MAX(aap_cp) cp,
              MAX(aap_transmissao) transmissao,
              MAX(aap_deterministica) deterministica,
              MAX(aap_dth) dth,
              MAX(aap_speedy) speedy,
              MAX(aap_redeip) redeip,
              MAX(aap_fttx) fttx,
              MAX(aap_cliente) cliente,
              MAX(aap_interconexao) interconexao,
              MAX(aap_sppac) sppac,
              MAX(aap_iptv) iptv
        FROM tas
        JOIN tbl_test_ta_afetacao_parcial ON aap_ta = tqa_codigo
    ) LOOP
        UPDATE afetacao_test_maxima_ta t SET
            t.voz = COALESCE(c.VOZ, 0),
            t.cp = COALESCE(c.CP, 0),
            t.transmissao = COALESCE(c.TRANSMISSAO, 0),
            t.deterministica = COALESCE(c.DETERMINISTICA, 0),
            t.dth = COALESCE(c.DTH, 0),
            t.speedy = COALESCE(c.SPEEDY, 0),
            t.rede_ip = COALESCE(c.REDEIP, 0),
            t.fttx = COALESCE(c.FTTX, 0),
            t.cliente = COALESCE(c.CLIENTE, 0),
            t.interconexao = COALESCE(c.INTERCONEXAO, 0),
            t.sppac = COALESCE(c.SPPAC, 0),
            t.iptv = COALESCE(c.IPTV, 0)
        WHERE t.sequencia = p_TQA_CODIGO;
    END LOOP;
END;
--------------------------------------------------------------------------------
CREATE TRIGGER tr_cria_afet_max
AFTER INSERT ON tbl_test_ta
FOR EACH ROW
BEGIN
    INSERT INTO afetacao_test_maxima_ta (
        SEQUENCIA,TQA_RAIZ,DT_ULT_AFETACAO,TRANSMISSAO,VOZ,DETERMINISTICA,SPEEDY,CLIENTE,CP,REDE_IP,INTERCONEXAO,SPPAC,DTH,FTTX,IPTV
    ) VALUES (
        :NEW.TQA_CODIGO,:NEW.TQA_RAIZ,:NEW.TQA_DATA_CRIACAO,0,0,0,0,0,0,0,0,0,0,0,0
    );
END;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
CREATE TRIGGER TTS_ULTIMA_AFETACAO_TA
AFTER INSERT
ON TBL_TEST_TA_AFETACAO_PARCIAL
FOR EACH ROW
BEGIN
    UPDATE TBL_TEST_TA SET TQA_ULTIMA_AFETACAO = :NEW.AAP_CODIGO WHERE TQA_CODIGO = :NEW.AAP_TA;
END;
--------------------------------------------------------------------------------
CREATE TRIGGER TTS_TA_AFET_MAX
FOR UPDATE ON TBL_TEST_TA
COMPOUND TRIGGER
  type tas_para_recalcular_type is table of TBL_TEST_TA.TQA_CODIGO%TYPE;
  tas_para_recalcular tas_para_recalcular_type;
before statement IS
begin
    tas_para_recalcular := tas_para_recalcular_type();
end before statement;
AFTER EACH ROW IS
BEGIN
    if (:old.TQA_RAIZ is null AND :new.TQA_RAIZ is not null) OR (:old.TQA_RAIZ is not null AND :new.TQA_RAIZ is null) OR (:old.TQA_RAIZ <> :new.TQA_RAIZ) then
        if :old.TQA_RAIZ is not null then
            tas_para_recalcular.extend(1);
            tas_para_recalcular(tas_para_recalcular.count()) := :old.TQA_RAIZ;
        end if;
        if :new.TQA_RAIZ is not null then
            tas_para_recalcular.extend(1);
            tas_para_recalcular(tas_para_recalcular.count()) := :new.TQA_RAIZ;
        end if;
    end if;
END AFTER EACH ROW;
AFTER STATEMENT IS
BEGIN
    if tas_para_recalcular.count() > 0
        THEN
            for v_it in tas_para_recalcular.first .. tas_para_recalcular.last
            loop
                ATUALIZAR_AFET_MAX_TA(tas_para_recalcular(v_it));
                ATUALIZAR_SOMA_AFETACOES(tas_para_recalcular(v_it));
            end loop;
    end if;
END AFTER STATEMENT;
END TTS_TA_AFET_MAX;
--------------------------------------------------------------------------------
CREATE OR REPLACE type soma_afetacao_type
AS
  object
  (
    soma_transmissao    NUMBER,
    soma_voz            NUMBER,
    soma_deterministica NUMBER,
    soma_speedy         NUMBER,
    soma_cliente        NUMBER,
    soma_cp             NUMBER,
    soma_redeip         NUMBER,
    soma_interconexao   NUMBER,
    soma_sppac          NUMBER,
    soma_dth            NUMBER,
    soma_fttx           NUMBER,
    soma_iptv           NUMBER);
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION get_maxima_afetacao(
    p_TQA_CODIGO NUMBER)
  RETURN soma_afetacao_type
IS
  soma soma_afetacao_type := soma_afetacao_type(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
BEGIN
WITH afetacao_maxima_individual AS
  (SELECT MAX(tqa_codigo) sequencia,
    MAX(tqa_raiz) raiz,
    MAX(AAP_VOZ) voz,
    MAX(AAP_CP) cp,
    MAX(AAP_TRANSMISSAO) transmissao,
    MAX(AAP_DETERMINISTICA) deterministica,
    MAX(AAP_DTH) dth,
    MAX(AAP_SPEEDY) speedy,
    MAX(AAP_REDEIP) redeip,
    MAX(AAP_FTTX) fttx,
    MAX(AAP_CLIENTE) cliente,
    MAX(AAP_INTERCONEXAO) interconexao,
    MAX(AAP_SPPAC) sppac,
    MAX(AAP_IPTV) iptv
  FROM tbl_test_ta_afetacao_parcial
  INNER JOIN tbl_test_ta
  ON (aap_ta = tqa_codigo)
  GROUP BY aap_ta
  )
SELECT SUM(TRANSMISSAO) soma_transmissao,
  SUM(VOZ) soma_voz,
  SUM(DETERMINISTICA) soma_deterministica,
  SUM(SPEEDY) soma_speedy,
  SUM(CLIENTE) soma_cliente,
  SUM(CP) soma_cp,
  SUM(REDEIP) soma_redeip,
  SUM(INTERCONEXAO) soma_interconexao,
  SUM(SPPAC) soma_sppac,
  SUM(DTH) soma_dth,
  SUM(FTTX) soma_fttx,
  SUM(IPTV) soma_iptv
INTO soma.soma_transmissao,
  soma.soma_voz,
  soma.soma_deterministica,
  soma.soma_speedy,
  soma.soma_cliente,
  soma.soma_cp,
  soma.soma_redeip,
  soma.soma_interconexao,
  soma.soma_sppac,
  soma.soma_dth,
  soma.soma_fttx,
  soma.soma_iptv
FROM afetacao_maxima_individual
  CONNECT BY NOCYCLE PRIOR sequencia = raiz
  START WITH sequencia               = p_TQA_CODIGO;
RETURN soma;
END;
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION GET_RAIZ_TA(
    p_sequencia IN NUMBER)
  RETURN NUMBER
AS
  r_raiz NUMBER;
BEGIN
  SELECT tqa_raiz INTO r_raiz FROM tbl_test_ta WHERE tqa_codigo = p_sequencia;
  RETURN r_raiz;
END GET_RAIZ_TA;
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ATUALIZAR_AFET_MAX_TA(
    p_sequencia NUMBER)
AS
  soma soma_afetacao_type:= get_maxima_afetacao(p_sequencia);
  raiz NUMBER;
BEGIN
  UPDATE AFETACAO_TEST_MAXIMA_TA
  SET transmissao  = soma.soma_transmissao,
    voz            = soma.soma_voz,
    deterministica = soma.soma_deterministica,
    speedy         = soma.soma_speedy,
    cliente        = soma.soma_cliente,
    cp             = soma.soma_cp,
    rede_ip        = soma.soma_redeip,
    interconexao   = soma.soma_interconexao,
    sppac          = soma.soma_sppac,
    dth            = soma.soma_dth,
    fttx           = soma.soma_fttx,
    iptv           = soma.soma_iptv
  WHERE sequencia  = p_sequencia;
  raiz            := get_raiz_ta(p_sequencia);
  IF raiz         IS NOT NULL THEN
    ATUALIZAR_AFET_MAX_TA(raiz);
    ATUALIZAR_SOMA_AFETACOES(raiz);
  END IF;
END ATUALIZAR_AFET_MAX_TA;
--------------------------------------------------------------------------------
ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';
CREATE TRIGGER TTS_TA_AFET_PARCIAL_MAX FOR INSERT OR
  UPDATE ON TBL_TEST_TA_AFETACAO_PARCIAL COMPOUND TRIGGER type tas_para_recalcular_type IS TABLE OF TBL_TEST_TA.TQA_CODIGO%TYPE;
  tas_para_recalcular tas_para_recalcular_type;
  before STATEMENT
IS
BEGIN
  tas_para_recalcular := tas_para_recalcular_type();
END before STATEMENT;
AFTER EACH ROW
IS
BEGIN
  tas_para_recalcular.extend(1);
  tas_para_recalcular(tas_para_recalcular.count()) := :NEW.AAP_TA;
END AFTER EACH ROW;
AFTER STATEMENT
IS
BEGIN
  FOR v_it IN tas_para_recalcular.first .. tas_para_recalcular.last
  LOOP
    ATUALIZAR_AFET_MAX_TA(tas_para_recalcular(v_it));
  END LOOP;
END AFTER STATEMENT;
END TTS_TA_AFET_PARCIAL_MAX;
--------------------------------------------------------------------------------