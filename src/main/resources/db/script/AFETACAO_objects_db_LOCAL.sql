CREATE TABLE TBL_TA_RECALCULA_AFETACAO (
  TA_CODIGO NUMBER,
  DATA_CRIACAO DATE
);--OK
--------------------------------------------------------------------------------
CREATE TABLE "AFETACAO_MAXIMA_TA"
  (
    "SEQUENCIA"       NUMBER(10,0) NOT NULL ENABLE,
    "TQA_RAIZ"        NUMBER(10,0),
    "TRANSMISSAO"     NUMBER,
    "VOZ"             NUMBER,
    "DETERMINISTICA"  NUMBER,
    "SPEEDY"          NUMBER,
    "CLIENTE"         NUMBER,
    "CP"              NUMBER,
    "REDE_IP"         NUMBER,
    "INTERCONEXAO"    NUMBER,
    "SPPAC"           NUMBER,
    "DTH"             NUMBER,
    "FTTX"            NUMBER,
    "IPTV"            NUMBER,
    "DT_ULT_AFETACAO" TIMESTAMP (6),
    PRIMARY KEY ("SEQUENCIA")
  );
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ATUALIZA_SOMAEMAXIMA_AFETACOES (p_TQA_CODIGO NUMBER) IS
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

        UPDATE AFETACAO_MAXIMA_TA t SET
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
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ADD_TA_RECALCULO_DE_AFETACAO ( l_codigo IN NUMBER, l_date IN TIMESTAMP)
IS
BEGIN
    MERGE INTO TBL_TA_RECALCULA_AFETACAO target USING (
      SELECT l_codigo codigo FROM dual
    ) origin
    ON (target.TA_CODIGO = origin.codigo)
    WHEN NOT MATCHED THEN
      INSERT (TA_CODIGO, DATA_CRIACAO) VALUES (l_codigo, l_date);
END;
--------------------------------------------------------------------------------
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
        ADD_TA_RECALCULO_DE_AFETACAO(:NEW.TQA_CODIGO, sysdate);
    END IF;
    if (:old.TQA_RAIZ <> :new.TQA_RAIZ) then
        ADD_TA_RECALCULO_DE_AFETACAO(:old.TQA_CODIGO, sysdate);
        ADD_TA_RECALCULO_DE_AFETACAO(:old.TQA_RAIZ, sysdate);
    end if;
    if (:old.TQA_RAIZ is not null and :new.TQA_RAIZ is null and UPDATING) then
        ADD_TA_RECALCULO_DE_AFETACAO(:old.TQA_RAIZ, sysdate);
    end if;
    if (:old.TQA_RAIZ is null and :new.TQA_RAIZ is not null and UPDATING) then
        ADD_TA_RECALCULO_DE_AFETACAO(:new.TQA_RAIZ, sysdate);
    end if;
END AFTER EACH ROW;
END TTS_TA_AFET_RECALCULAR;
--------------------------------------------------------------------------------
create or replace TRIGGER TTS_TA_AFET_PARCIAL_RECALCULAR FOR INSERT OR
  UPDATE ON TBL_TA_AFETACAO_PARCIAL COMPOUND TRIGGER type tas_para_recalcular_type IS TABLE OF TBL_TA.TQA_CODIGO%TYPE;
  tas_para_recalcular tas_para_recalcular_type;
AFTER EACH ROW
IS
BEGIN
  ADD_TA_RECALCULO_DE_AFETACAO(:new.AAP_TA, sysdate);
END AFTER EACH ROW;
END TTS_TA_AFET_PARCIAL_RECALCULAR;
--------------------------------------------------------------------------------
--- necessário para ambiente local
--------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------
CREATE SEQUENCE SEQ_TA_AFETACAO_PARCIAL
 START WITH     1000
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
--------------------------------------------------------------------------------
CREATE UNIQUE INDEX "AFETACAO_MAXIMA_TA_PK_IDX" ON "AFETACAO_MAXIMA_TA" ("SEQUENCIA");
CREATE INDEX "AFETACAO_MAXIMA_TA_RAIZ_IDX" ON "AFETACAO_MAXIMA_TA" ("TQA_RAIZ");
--------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER tr_cria_afet_max
AFTER INSERT ON TBL_TA
FOR EACH ROW
BEGIN
    INSERT INTO afetacao_maxima_ta (
        SEQUENCIA,TQA_RAIZ,DT_ULT_AFETACAO,TRANSMISSAO,VOZ,DETERMINISTICA,SPEEDY,CLIENTE,CP,REDE_IP,INTERCONEXAO,SPPAC,DTH,FTTX,IPTV
    ) VALUES (
        :NEW.TQA_CODIGO,:NEW.TQA_RAIZ,:NEW.TQA_DATA_CRIACAO,0,0,0,0,0,0,0,0,0,0,0,0
    );
END;
--------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TTS_ULTIMA_AFETACAO_TA
AFTER INSERT
ON TBL_TA_AFETACAO_PARCIAL
FOR EACH ROW
BEGIN
    UPDATE TBL_TA SET TQA_ULTIMA_AFETACAO = :NEW.AAP_CODIGO WHERE TQA_CODIGO = :NEW.AAP_TA;
END;
--------------------------------------------------------------------------------
