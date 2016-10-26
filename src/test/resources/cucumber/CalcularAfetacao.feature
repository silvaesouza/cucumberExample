@afetacao
Feature: Afetacao
  -Vincular/Desvincular TA uns aos outros
  -Efetuar calculos de Soma de afetacao levando em consideracao um TA raiz e seus derivados
  -Efetuar calculos de Máxima afetacao levando em consideracao um TA raiz e seus derivados
  -Os calculos de afetacao levam em consideracao apenas VOZ
  -SOMA = Soma da afetação atual do TA + Derivados 
  -MAX  = Soma da maior de todas as afetações do TA + derivados

  Scenario: Validar base e limpar dados
    Given Existe conexão com base de dados
    Then Limpar registros

  Scenario: Inserir registro inicial do TA 1 Raiz com afetacao 5
    Given Ta 1 inserido com sucesso
    When Inserir afetacao de voz igual a 5 no TA 1
    And Recalcular afetacao
    Then a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA dos derivados do TA 1 deve ser 5
    And a SOMA do MAX dos derivados do TA 1 deve ser 5

  Scenario: Inserir novo TA Derivado 2 vinculado ao TA 1 com afetacao 10
    Given Ta 2 vinculado ao TA 1 inserido com sucesso
    When Inserir afetacao de voz igual a 10 no TA 2
    And Recalcular afetacao
    Then a afetacao VOZ atual do TA 2 deve ser 10
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 2 foi 10
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA dos derivados do TA 2 deve ser 10
    And a SOMA do MAX dos derivados do TA 2 deve ser 10
    And a SOMA dos derivados do TA 1 deve ser 15
    And a SOMA do MAX dos derivados do TA 1 deve ser 15

  Scenario: Inserir novo TA Derivado 3 vinculado ao TA 1 com afetacao 20
    Given Ta 3 vinculado ao TA 1 inserido com sucesso
    When Inserir afetacao de voz igual a 20 no TA 3
    And Recalcular afetacao
    Then a afetacao VOZ atual do TA 3 deve ser 20
    And a afetacao VOZ atual do TA 2 deve ser 10
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 3 foi 20
    And a maior afetacao VOZ do TA 2 foi 10
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA dos derivados do TA 3 deve ser 20
    And a SOMA do MAX dos derivados do TA 3 deve ser 20
    And a SOMA dos derivados do TA 2 deve ser 10
    And a SOMA do MAX dos derivados do TA 2 deve ser 10
    And a SOMA dos derivados do TA 1 deve ser 35
    And a SOMA do MAX dos derivados do TA 1 deve ser 35

  Scenario: Inserir novo TA Derivado 4 vinculado ao TA 2 com afetacao 10
    Given Ta 4 vinculado ao TA 2 inserido com sucesso
    When Inserir afetacao de voz igual a 10 no TA 4
    And Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 10
    And a afetacao VOZ atual do TA 3 deve ser 20
    And a afetacao VOZ atual do TA 2 deve ser 10
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 4 foi 10
    And a maior afetacao VOZ do TA 3 foi 20
    And a maior afetacao VOZ do TA 2 foi 10
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA dos derivados do TA 4 deve ser 10
    And a SOMA do MAX dos derivados do TA 4 deve ser 10
    And a SOMA dos derivados do TA 3 deve ser 20
    And a SOMA do MAX dos derivados do TA 3 deve ser 20
    And a SOMA dos derivados do TA 1 deve ser 20
    And a SOMA do MAX dos derivados do TA 1 deve ser 20
    And a SOMA dos derivados do TA 1 deve ser 45
    And a SOMA do MAX dos derivados do TA 1 deve ser 45

  Scenario: Inserir nova afetacao no TA Derivado 3 com afetacao 30
    Given Inserir afetacao de voz igual a 30 no TA 3
    When Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 10
    And a afetacao VOZ atual do TA 3 deve ser 30
    And a afetacao VOZ atual do TA 2 deve ser 10
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 4 foi 10
    And a maior afetacao VOZ do TA 3 foi 30
    And a maior afetacao VOZ do TA 2 foi 10
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA dos derivados do TA 4 deve ser 10
    And a SOMA do MAX dos derivados do TA 4 deve ser 10
    And a SOMA dos derivados do TA 3 deve ser 30
    And a SOMA do MAX dos derivados do TA 3 deve ser 30
    And a SOMA dos derivados do TA 2 deve ser 20
    And a SOMA do MAX dos derivados do TA 2 deve ser 20
    And a SOMA dos derivados do TA 1 deve ser 55
    And a SOMA do MAX dos derivados do TA 1 deve ser 55

  Scenario: Inserir nova afetacao no TA Derivado 4 com afetacao 40
    Given Inserir afetacao de voz igual a 40 no TA 4
    When Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 40
    And a afetacao VOZ atual do TA 3 deve ser 30
    And a afetacao VOZ atual do TA 2 deve ser 10
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 4 foi 40
    And a maior afetacao VOZ do TA 3 foi 30
    And a maior afetacao VOZ do TA 2 foi 10
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA dos derivados do TA 4 deve ser 40
    And a SOMA do MAX dos derivados do TA 4 deve ser 40
    And a SOMA dos derivados do TA 3 deve ser 30
    And a SOMA do MAX dos derivados do TA 3 deve ser 30
    And a SOMA dos derivados do TA 2 deve ser 50
    And a SOMA do MAX dos derivados do TA 2 deve ser 50
    And a SOMA dos derivados do TA 1 deve ser 85
    And a SOMA do MAX dos derivados do TA 1 deve ser 85

  Scenario: Inserir nova afetacao no TA Derivado 4 com afetacao 20
    Given Inserir afetacao de voz igual a 20 no TA 4
    When Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 20
    And a afetacao VOZ atual do TA 3 deve ser 30
    And a afetacao VOZ atual do TA 2 deve ser 10
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 4 foi 40
    And a maior afetacao VOZ do TA 3 foi 30
    And a maior afetacao VOZ do TA 2 foi 10
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA dos derivados do TA 4 deve ser 20
    And a SOMA do MAX dos derivados do TA 4 deve ser 40
    And a SOMA dos derivados do TA 3 deve ser 30
    And a SOMA do MAX dos derivados do TA 3 deve ser 30
    And a SOMA dos derivados do TA 2 deve ser 30
    And a SOMA do MAX dos derivados do TA 2 deve ser 50
    And a SOMA dos derivados do TA 1 deve ser 65
    And a SOMA do MAX dos derivados do TA 1 deve ser 85

  Scenario: Inserir nova afetacao no TA Derivado 2 com afetacao 20
    Given Inserir afetacao de voz igual a 20 no TA 2
    When Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 20
    And a afetacao VOZ atual do TA 3 deve ser 30
    And a afetacao VOZ atual do TA 2 deve ser 20
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 4 foi 40
    And a maior afetacao VOZ do TA 3 foi 30
    And a maior afetacao VOZ do TA 2 foi 20
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA dos derivados do TA 4 deve ser 20
    And a SOMA do MAX dos derivados do TA 4 deve ser 40
    And a SOMA dos derivados do TA 3 deve ser 30
    And a SOMA do MAX dos derivados do TA 3 deve ser 30
    And a SOMA dos derivados do TA 2 deve ser 40
    And a SOMA do MAX dos derivados do TA 2 deve ser 60
    And a SOMA dos derivados do TA 1 deve ser 75
    And a SOMA do MAX dos derivados do TA 1 deve ser 95

  Scenario: Atualizar afetacao mais antiga do TA Derivado 2 com afetacao 50
    Given Atualizar afetacao mais antiga do TA 2 para 50
    When Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 20
    And a afetacao VOZ atual do TA 3 deve ser 30
    And a afetacao VOZ atual do TA 2 deve ser 20
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 4 foi 40
    And a maior afetacao VOZ do TA 3 foi 30
    And a maior afetacao VOZ do TA 2 foi 50
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA dos derivados do TA 4 deve ser 20
    And a SOMA do MAX dos derivados do TA 4 deve ser 40
    And a SOMA dos derivados do TA 3 deve ser 30
    And a SOMA do MAX dos derivados do TA 3 deve ser 30
    And a SOMA dos derivados do TA 2 deve ser 40
    And a SOMA do MAX dos derivados do TA 2 deve ser 90
    And a SOMA dos derivados do TA 1 deve ser 75
    And a SOMA do MAX dos derivados do TA 1 deve ser 125

  Scenario: Alterar TA Derivado 2 para raiz propria
    Given Mudar raiz do TA 2 para null
    When Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 20
    And a afetacao VOZ atual do TA 3 deve ser 30
    And a afetacao VOZ atual do TA 2 deve ser 20
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 4 foi 40
    And a maior afetacao VOZ do TA 3 foi 30
    And a maior afetacao VOZ do TA 2 foi 50
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA dos derivados do TA 4 deve ser 20
    And a SOMA do MAX dos derivados do TA 4 deve ser 40
    And a SOMA dos derivados do TA 3 deve ser 30
    And a SOMA do MAX dos derivados do TA 3 deve ser 30
    And a SOMA dos derivados do TA 2 deve ser 40
    And a SOMA do MAX dos derivados do TA 2 deve ser 90
    And a SOMA dos derivados do TA 1 deve ser 35
    And a SOMA do MAX dos derivados do TA 1 deve ser 35

  Scenario: Alterar TA Raiz 2 tornando derivado do TA Raiz 1
    Given Mudar raiz do TA 2 para 1
    When Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 20
    And a afetacao VOZ atual do TA 3 deve ser 30
    And a afetacao VOZ atual do TA 2 deve ser 20
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 4 foi 40
    And a maior afetacao VOZ do TA 3 foi 30
    And a maior afetacao VOZ do TA 2 foi 50
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA dos derivados do TA 4 deve ser 20
    And a SOMA do MAX dos derivados do TA 4 deve ser 40
    And a SOMA dos derivados do TA 3 deve ser 30
    And a SOMA do MAX dos derivados do TA 3 deve ser 30
    And a SOMA dos derivados do TA 2 deve ser 40
    And a SOMA do MAX dos derivados do TA 2 deve ser 90
    And a SOMA dos derivados do TA 1 deve ser 75
    And a SOMA do MAX dos derivados do TA 1 deve ser 125

  Scenario: Alterar TA Raiz 3 tornando derivado do TA Raiz 4
    Given Mudar raiz do TA 3 para 4
    When Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 20
    And a afetacao VOZ atual do TA 3 deve ser 30
    And a afetacao VOZ atual do TA 2 deve ser 20
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 4 foi 40
    And a maior afetacao VOZ do TA 3 foi 30
    And a maior afetacao VOZ do TA 2 foi 50
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA dos derivados do TA 4 deve ser 50
    And a SOMA do MAX dos derivados do TA 4 deve ser 70
    And a SOMA dos derivados do TA 3 deve ser 30
    And a SOMA do MAX dos derivados do TA 3 deve ser 30
    And a SOMA dos derivados do TA 2 deve ser 70
    And a SOMA do MAX dos derivados do TA 2 deve ser 120
    And a SOMA dos derivados do TA 1 deve ser 75
    And a SOMA do MAX dos derivados do TA 1 deve ser 125

  Scenario: Inserir novo TA Derivado 5 vinculado ao TA 3 com afetacao 20
    Given Ta 5 vinculado ao TA 3 inserido com sucesso
    When Inserir afetacao de voz igual a 20 no TA 5
    And Recalcular afetacao
    Then a afetacao VOZ atual do TA 5 deve ser 20
    Then a afetacao VOZ atual do TA 4 deve ser 20
    And a afetacao VOZ atual do TA 3 deve ser 30
    And a afetacao VOZ atual do TA 2 deve ser 20
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 5 foi 20
    And a maior afetacao VOZ do TA 4 foi 40
    And a maior afetacao VOZ do TA 3 foi 30
    And a maior afetacao VOZ do TA 2 foi 50
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA dos derivados do TA 5 deve ser 20
    And a SOMA do MAX dos derivados do TA 5 deve ser 20
    And a SOMA dos derivados do TA 4 deve ser 70
    And a SOMA do MAX dos derivados do TA 4 deve ser 90
    And a SOMA dos derivados do TA 3 deve ser 50
    And a SOMA do MAX dos derivados do TA 3 deve ser 50
    And a SOMA dos derivados do TA 2 deve ser 90
    And a SOMA do MAX dos derivados do TA 2 deve ser 140
    And a SOMA dos derivados do TA 1 deve ser 95
    And a SOMA do MAX dos derivados do TA 1 deve ser 145

  Scenario: Alterar TA Raiz 5 tornando derivado do TA Raiz 2
    Given Mudar raiz do TA 5 para 2
    When Recalcular afetacao
    Then a afetacao VOZ atual do TA 5 deve ser 20
    Then a afetacao VOZ atual do TA 4 deve ser 20
    And a afetacao VOZ atual do TA 3 deve ser 30
    And a afetacao VOZ atual do TA 2 deve ser 20
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 5 foi 20
    And a maior afetacao VOZ do TA 4 foi 40
    And a maior afetacao VOZ do TA 3 foi 30
    And a maior afetacao VOZ do TA 2 foi 50
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA dos derivados do TA 5 deve ser 20
    And a SOMA do MAX dos derivados do TA 5 deve ser 20
    And a SOMA dos derivados do TA 4 deve ser 50
    And a SOMA do MAX dos derivados do TA 4 deve ser 70
    And a SOMA dos derivados do TA 3 deve ser 30
    And a SOMA do MAX dos derivados do TA 3 deve ser 30
    And a SOMA dos derivados do TA 2 deve ser 90
    And a SOMA do MAX dos derivados do TA 2 deve ser 140
    And a SOMA dos derivados do TA 1 deve ser 95
    And a SOMA do MAX dos derivados do TA 1 deve ser 145
