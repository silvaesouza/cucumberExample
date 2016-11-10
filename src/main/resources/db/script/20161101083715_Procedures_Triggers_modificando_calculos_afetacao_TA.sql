--// Armazenamento de maxima de afetacao computada para TA
-- Migration SQL that makes the change goes here.
-------------------------------------------------------------------------------
CREATE TABLE TBL_TA_RECALCULA_AFETACAO (
    TA_CODIGO NUMBER,
    DATA_CRIACAO DATE
);
-------------------------------------------------------------------------------
create or replace PROCEDURE CORRIGIR_AFETACAO_24H_VERSAO2 IS
BEGIN
    FOR c IN (
        SELECT distinct TA_CODIGO
        FROM TBL_TA_RECALCULA_AFETACAO
        WHERE DATA_CRIACAO > TRUNC(SYSDATE - 1,'HH')
    ) LOOP
        ATUALIZA_SOMAEMAXIMA_AFETACOES(c.TA_CODIGO);
    END LOOP;
END;
/
BEGIN    
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"JOB_RECALCULAR_AFETACAO"',
            schedule_name => '"A_CADA_2_MINUTOS"',
            job_type => 'PLSQL_BLOCK',
            job_action => 'BEGIN CORRIGIR_AFETACAO_24H_VERSAO2; END;',
            number_of_arguments => 0,
            enabled => FALSE,
            auto_drop => FALSE,
               
            comments => 'Recalculo de Maximas e Afetacoes'); 
 
    DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => '"JOB_RECALCULAR_AFETACAO"', 
             attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_OFF);
      
  
    
    DBMS_SCHEDULER.enable(
             name => '"JOB_RECALCULAR_AFETACAO"');
END;
/
-------------------------------------------------------------------------------
create or replace PROCEDURE ATUALIZA_SOMAEMAXIMA_AFETACOES (p_TQA_CODIGO NUMBER) IS
l_voz NUMBER;
l_cp NUMBER;
l_deterministica NUMBER;
l_transmissao NUMBER;
l_dth NUMBER;
l_speedy NUMBER;
l_redeip NUMBER;
l_fttx NUMBER;
l_cliente NUMBER;
l_interconexao NUMBER;
l_sppac NUMBER;
l_iptv NUMBER;
BEGIN
    --
    -- SOMA
    --
    FOR c IN (
        select lpad(' ',2*(level-1)) || to_char(tqa_codigo) s 
             , tqa_codigo codigo
          from tbl_ta taAll
          start with tqa_codigo = p_TQA_CODIGO
          connect by nocycle prior tqa_raiz = tqa_codigo
    ) LOOP
        SELECT
          NVL(SUM(AAP_VOZ), 0)            voz,            --1
          NVL(SUM(AAP_CP), 0)             cp,             --2
          NVL(SUM(AAP_TRANSMISSAO), 0)    transmissao,    --3
          NVL(SUM(AAP_DETERMINISTICA), 0) deterministica, --4
          NVL(SUM(AAP_DTH), 0)            dth,            --5
          NVL(SUM(AAP_SPEEDY), 0)         speedy,         --6
          NVL(SUM(AAP_REDEIP), 0)         redeip,         --7
          NVL(SUM(AAP_FTTX), 0)           fttx,           --8
          NVL(SUM(AAP_CLIENTE), 0)        cliente,        --9
          NVL(SUM(AAP_INTERCONEXAO), 0)   interconexao,   --10
          NVL(SUM(AAP_SPPAC), 0)          sppac,          --11
          NVL(SUM(AAP_IPTV), 0)           iptv            --12
       INTO l_voz            --1
          , l_cp             --2
          , l_transmissao    --3
          , l_deterministica --4
          , l_dth            --5
          , l_speedy         --6
          , l_redeip         --7
          , l_fttx           --8
          , l_cliente        --9
          , l_interconexao   --10
          , l_sppac          --11
          , l_iptv           --12
      FROM tbl_ta_afetacao_parcial
      WHERE aap_codigo IN (
          SELECT tqa_ultima_afetacao
          FROM tbl_ta taInner
          CONNECT BY NOCYCLE
          PRIOR tqa_codigo = tqa_raiz
          START WITH taInner.tqa_codigo = c.codigo);
    
        UPDATE tbl_ta t SET
            t.tqa_soma_voz            = l_voz,             --1
            t.tqa_soma_cp             = l_cp,              --2
            t.tqa_soma_transmissao    = l_transmissao,     --3
            t.tqa_soma_deterministica = l_deterministica,  --4
            t.tqa_soma_dth            = l_dth,             --5
            t.tqa_soma_speedy         = l_speedy,          --6
            t.tqa_soma_redeip         = l_redeip,          --7
            t.tqa_soma_fttx           = l_fttx,            --8
            t.tqa_soma_cliente        = l_cliente,         --9
            t.tqa_soma_interconexao   = l_interconexao,    --10
            t.tqa_soma_sppac          = l_sppac,           --11
            t.tqa_soma_iptv           = l_iptv             --12
        WHERE tqa_codigo = c.codigo;
    END LOOP;
    --
    -- MAX
    --
    FOR c IN (
        select TQA_CODIGO
          from tbl_ta CONNECT BY NOCYCLE
         PRIOR tqa_raiz = tqa_codigo
         START WITH tqa_codigo = p_TQA_CODIGO
    ) LOOP
    WITH sumOfMax as (
          SELECT tqa_codigo taCodigo, 
                (SELECT
                        NVL(MAX(AAP_VOZ), 0)            --1
                        ||';'||
                        NVL(MAX(AAP_CP), 0)             --2
                        ||';'||
                        NVL(MAX(AAP_TRANSMISSAO), 0)    --3
                        ||';'||
                        NVL(MAX(AAP_DETERMINISTICA), 0) --4
                        ||';'||
                        NVL(MAX(AAP_DTH), 0)            --5
                        ||';'||
                        NVL(MAX(AAP_SPEEDY), 0)         --6
                        ||';'||
                        NVL(MAX(AAP_REDEIP), 0)         --7
                        ||';'||
                        NVL(MAX(AAP_FTTX), 0)           --8
                        ||';'||
                        NVL(MAX(AAP_CLIENTE), 0)        --9
                        ||';'||
                        NVL(MAX(AAP_INTERCONEXAO), 0)   --10
                        ||';'||
                        NVL(MAX(AAP_SPPAC), 0)          --11
                        ||';'||
                        NVL(MAX(AAP_IPTV), 0)           --12
                  FROM tbl_ta taInner
                  INNER JOIN tbl_ta_afetacao_parcial taAfet ON taAfet.aap_ta = taInner.tqa_codigo
                  where taInner.tqa_codigo in (taOuter.tqa_codigo)
                ) allMax
          FROM tbl_ta taOuter
          CONNECT BY NOCYCLE
          PRIOR tqa_codigo = tqa_raiz
          START WITH tqa_codigo = c.TQA_CODIGO
        ) 
        select SUM(REGEXP_SUBSTR(sm.allMax, '[^;]+', 1, 1)) voz            --1
             , SUM(REGEXP_SUBSTR(sm.allMax, '[^;]+', 1, 2)) cp             --2
             , SUM(REGEXP_SUBSTR(sm.allMax, '[^;]+', 1, 3)) transmissao    --3
             , SUM(REGEXP_SUBSTR(sm.allMax, '[^;]+', 1, 4)) deterministica --4
             , SUM(REGEXP_SUBSTR(sm.allMax, '[^;]+', 1, 5)) dth            --5
             , SUM(REGEXP_SUBSTR(sm.allMax, '[^;]+', 1, 6)) speedy         --6
             , SUM(REGEXP_SUBSTR(sm.allMax, '[^;]+', 1, 7)) redeip         --7
             , SUM(REGEXP_SUBSTR(sm.allMax, '[^;]+', 1, 8)) fttx           --8
             , SUM(REGEXP_SUBSTR(sm.allMax, '[^;]+', 1, 9)) cliente        --9
             , SUM(REGEXP_SUBSTR(sm.allMax, '[^;]+', 1, 10)) interconexao  --10
             , SUM(REGEXP_SUBSTR(sm.allMax, '[^;]+', 1, 11)) sppac         --11
             , SUM(REGEXP_SUBSTR(sm.allMax, '[^;]+', 1, 12)) iptv          --12
             INTO l_voz            --1
                , l_cp             --2
                , l_transmissao    --3
                , l_deterministica --4
                , l_dth            --5
                , l_speedy         --6
                , l_redeip         --7
                , l_fttx           --8
                , l_cliente        --9
                , l_interconexao   --10
                , l_sppac          --11
                , l_iptv           --12
        from sumOfMax sm;
        
        UPDATE afetacao_maxima_ta t SET
            t.voz            = COALESCE(l_voz, 0),            --1
            t.cp             = COALESCE(l_cp, 0),             --2
            t.transmissao    = COALESCE(l_transmissao, 0),    --3
            t.deterministica = COALESCE(l_deterministica, 0), --4
            t.dth            = COALESCE(l_dth, 0),            --5
            t.speedy         = COALESCE(l_speedy, 0),         --6
            t.rede_ip        = COALESCE(l_redeip, 0),         --7
            t.fttx           = COALESCE(l_fttx, 0),           --8
            t.cliente        = COALESCE(l_cliente, 0),        --9
            t.interconexao   = COALESCE(l_interconexao, 0),   --10
            t.sppac          = COALESCE(l_sppac, 0),          --11
            t.iptv           = COALESCE(l_iptv, 0)            --12
        WHERE t.sequencia = c.TQA_CODIGO;
    END LOOP;
    DELETE FROM TBL_TA_RECALCULA_AFETACAO WHERE ta_codigo = p_TQA_CODIGO; 
END;
/
-------------------------------------------------------------------------------
ALTER TRIGGER TTS_TA_NOVO_AFET_MAX DISABLE;
ALTER TRIGGER TTS_TA_AFET_MAX DISABLE;
ALTER TRIGGER TTS_TA_AFET_PARCIAL_MAX DISABLE;
-------------------------------------------------------------------------------
create or replace TRIGGER TTS_TA_AFET_RECALCULAR
FOR INSERT OR UPDATE ON TBL_TA
COMPOUND TRIGGER
  type tas_para_recalcular_type is table of TBL_TA.TQA_CODIGO%TYPE;
  tas_para_recalcular tas_para_recalcular_type;
before statement IS
begin
    tas_para_recalcular := tas_para_recalcular_type();
end before statement;
AFTER EACH ROW IS
BEGIN
    if (INSERTING AND :new.TQA_RAIZ is not null) THEN
        INSERT INTO TBL_TA_RECALCULA_AFETACAO (TA_CODIGO, DATA_CRIACAO) VALUES (:NEW.TQA_CODIGO, SYSDATE);
    END IF;
    if (:old.TQA_RAIZ <> :new.TQA_RAIZ) then
        INSERT INTO TBL_TA_RECALCULA_AFETACAO (TA_CODIGO, DATA_CRIACAO) VALUES (:OLD.TQA_CODIGO, SYSDATE);
        INSERT INTO TBL_TA_RECALCULA_AFETACAO (TA_CODIGO, DATA_CRIACAO) VALUES (:OLD.TQA_RAIZ, SYSDATE);
    end if;
    if (:old.TQA_RAIZ is not null and :new.TQA_RAIZ is null and UPDATING) then
        INSERT INTO TBL_TA_RECALCULA_AFETACAO (TA_CODIGO, DATA_CRIACAO) VALUES (:OLD.TQA_CODIGO, SYSDATE);
        INSERT INTO TBL_TA_RECALCULA_AFETACAO (TA_CODIGO, DATA_CRIACAO) VALUES (:OLD.TQA_RAIZ, SYSDATE);
    end if;
    if (:old.TQA_RAIZ is null and :new.TQA_RAIZ is not null and UPDATING) then
        INSERT INTO TBL_TA_RECALCULA_AFETACAO (TA_CODIGO, DATA_CRIACAO) VALUES (:NEW.TQA_CODIGO, SYSDATE);
    end if;
END AFTER EACH ROW;
END TTS_TA_AFET_RECALCULAR;
/
-------------------------------------------------------------------------------
create or replace TRIGGER TTS_TA_AFET_PARCIAL_RECALCULAR FOR INSERT OR
  UPDATE ON TBL_TA_AFETACAO_PARCIAL COMPOUND TRIGGER type tas_para_recalcular_type IS TABLE OF TBL_TA.TQA_CODIGO%TYPE;
  tas_para_recalcular tas_para_recalcular_type;
  before STATEMENT
IS
BEGIN
  tas_para_recalcular := tas_para_recalcular_type();
END before STATEMENT;
AFTER EACH ROW
IS
BEGIN
  INSERT INTO TBL_TA_RECALCULA_AFETACAO (TA_CODIGO, DATA_CRIACAO) VALUES (:NEW.AAP_TA, SYSDATE);
END AFTER EACH ROW;
END TTS_TA_AFET_PARCIAL_RECALCULAR;
/
-------------------------------------------------------------------------------

--//@UNDO
-- SQL to undo the change goes here.

DROP PROCEDURE CORRIGIR_AFETACAO_24H_VERSAO2;

DROP TABLE TBL_TA_RECALCULA_AFETACAO;

DROP PROCEDURE ATUALIZA_SOMAEMAXIMA_AFETACOES;

-------------------------------------------------------------------------------
ALTER TRIGGER TTS_TA_NOVO_AFET_MAX ENABLE;
ALTER TRIGGER TTS_TA_AFET_MAX ENABLE;
ALTER TRIGGER TTS_TA_AFET_PARCIAL_MAX ENABLE;
-------------------------------------------------------------------------------

DROP TRIGGER TTS_TA_AFET_RECALCULAR;

DROP TRIGGER TTS_TA_AFET_PARCIAL_RECALCULAR;

BEGIN
    DBMS_SCHEDULER.DROP_JOB(job_name => '"JOB_RECALCULAR_AFETACAO"',
                               defer => false,
                               force => false);
END;
/