create or replace PROCEDURE ATUALIZAR_SOMA_AFETACOES (p_TQA_CODIGO NUMBER) IS
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
    --IS
    -- SOMA
    --
    FOR c IN (
        select lpad(' ',2*(level-1)) || to_char(tqa_codigo) s 
             , tqa_codigo codigo
             , tqa_soma_voz
             , tqa_soma_speedy
             , (SELECT
                    NVL(SUM(AAP_VOZ), 0)            --1
                    ||';'||
                    NVL(SUM(AAP_CP), 0)             --2
                    ||';'||
                    NVL(SUM(AAP_TRANSMISSAO), 0)    --3
                    ||';'||
                    NVL(SUM(AAP_DETERMINISTICA), 0) --4
                    ||';'||
                    NVL(SUM(AAP_DTH), 0)            --5
                    ||';'||
                    NVL(SUM(AAP_SPEEDY), 0)         --6
                    ||';'||
                    NVL(SUM(AAP_REDEIP), 0)         --7
                    ||';'||
                    NVL(SUM(AAP_FTTX), 0)           --8
                    ||';'||
                    NVL(SUM(AAP_CLIENTE), 0)        --9
                    ||';'||
                    NVL(SUM(AAP_INTERCONEXAO), 0)   --10
                    ||';'||
                    NVL(SUM(AAP_SPPAC), 0)          --11
                    ||';'||
                    NVL(SUM(AAP_IPTV), 0)           --12
                FROM tbl_test_ta_afetacao_parcial
                WHERE aap_codigo IN (
                    SELECT tqa_ultima_afetacao
                    FROM tbl_test_ta taInner
                    CONNECT BY NOCYCLE
                    PRIOR tqa_codigo = tqa_raiz
                    START WITH taInner.tqa_codigo = taAll.tqa_codigo
                )) soma_todos
          from tbl_test_ta taAll
          start with tqa_codigo = p_TQA_CODIGO
          connect by nocycle prior tqa_raiz = tqa_codigo
    ) LOOP
        UPDATE tbl_test_ta t SET
            t.tqa_soma_voz            = REGEXP_SUBSTR(c.soma_todos, '[^;]+', 1, 1),  --1
            t.tqa_soma_cp             = REGEXP_SUBSTR(c.soma_todos, '[^;]+', 1, 2),  --2
            t.tqa_soma_transmissao    = REGEXP_SUBSTR(c.soma_todos, '[^;]+', 1, 3),  --3
            t.tqa_soma_deterministica = REGEXP_SUBSTR(c.soma_todos, '[^;]+', 1, 4),  --4
            t.tqa_soma_dth            = REGEXP_SUBSTR(c.soma_todos, '[^;]+', 1, 5),  --5
            t.tqa_soma_speedy         = REGEXP_SUBSTR(c.soma_todos, '[^;]+', 1, 6),  --6
            t.tqa_soma_redeip         = REGEXP_SUBSTR(c.soma_todos, '[^;]+', 1, 7),  --7
            t.tqa_soma_fttx           = REGEXP_SUBSTR(c.soma_todos, '[^;]+', 1, 8),  --8
            t.tqa_soma_cliente        = REGEXP_SUBSTR(c.soma_todos, '[^;]+', 1, 9),  --9
            t.tqa_soma_interconexao   = REGEXP_SUBSTR(c.soma_todos, '[^;]+', 1, 10), --10
            t.tqa_soma_sppac          = REGEXP_SUBSTR(c.soma_todos, '[^;]+', 1, 11), --11
            t.tqa_soma_iptv           = REGEXP_SUBSTR(c.soma_todos, '[^;]+', 1, 12)  --12
        WHERE tqa_codigo = c.codigo;
    END LOOP;
    --
    -- MAX
    --
    FOR c IN (
        select TQA_CODIGO
          from tbl_TEST_ta CONNECT BY NOCYCLE
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
                  FROM tbl_test_ta taInner
                  INNER JOIN tbl_test_ta_afetacao_parcial taAfet ON taAfet.aap_ta = taInner.tqa_codigo
                  where taInner.tqa_codigo in (taOuter.tqa_codigo)
                ) allMax
          FROM tbl_test_ta taOuter
          CONNECT BY NOCYCLE
          PRIOR tqa_codigo = tqa_raiz
          START WITH tqa_codigo = p_TQA_CODIGO
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
        
        UPDATE afetacao_test_maxima_ta t SET
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
        WHERE t.sequencia = p_TQA_CODIGO;
    END LOOP;
END;