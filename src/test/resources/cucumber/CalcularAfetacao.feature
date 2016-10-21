Feature: Afetacao
  Vincular/Desvincular TA uns aos outros
  Efetuar calculos de Soma de afetacao levando em consideracao um TA raiz e seus derivados
  Efetuar calculos de Máxima afetacao levando em consideracao um TA raiz e seus derivados
  Os calculos de afetacao levam em consideracao apenas VOZ
  SOMA = Soma da afetação atual do TA + Derivados 
  MAX  = Soma da maior de todas as afetações do TA + derivados

  #INSERIR NOVOS TAS E AFETAÇOES
  Scenario: Inserir registro inicial do TA 1 Raiz com afetacao 5
    Given Ta 1 inserido com sucesso
    When Inserir afetacao de voz igual a 5 no TA 1
    And Recalcular afetacao
    Then a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA e MAX do TA 1 devem ser 5 e 5

  Scenario: Inserir novo TA Derivado 2 vinculado ao TA 1 com afetacao 10
    Given Ta 2 inserido com sucesso
    When Inserir afetacao de voz igual a 10 no TA 2
    And Recalcular afetacao
    Then a afetacao VOZ atual do TA 2 deve ser 10
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 2 foi 10
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA e MAX do TA 2 devem ser 10 e 10
    And a SOMA e MAX do TA 1 devem ser 15 e 15

  Scenario: Inserir novo TA Derivado 3 vinculado ao TA 1 com afetacao 20
    Given Ta 3 inserido com sucesso
    When Inserir afetacao de voz igual a 20 no TA 3
    And Recalcular afetacao
    Then a afetacao VOZ atual do TA 3 deve ser 20
    And a afetacao VOZ atual do TA 2 deve ser 10
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 3 foi 20
    And a maior afetacao VOZ do TA 2 foi 10
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA e MAX do TA 3 devem ser 20 e 20
    And a SOMA e MAX do TA 2 devem ser 10 e 10
    And a SOMA e MAX do TA 1 devem ser 35 e 35

  Scenario: Inserir novo TA Derivado 4 vinculado ao TA 2 com afetacao 10
    Given Ta 4 inserido com sucesso
    When Inserir afetacao de voz igual 10 no TA 4
    And Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 10
    And a afetacao VOZ atual do TA 3 deve ser 20
    And a afetacao VOZ atual do TA 2 deve ser 10
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 4 foi 10
    And a maior afetacao VOZ do TA 3 foi 20
    And a maior afetacao VOZ do TA 2 foi 10
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA e MAX do TA 4 devem ser 10 e 10
    And a SOMA e MAX do TA 3 devem ser 20 e 20
    And a SOMA e MAX do TA 2 devem ser 20 e 20
    And a SOMA e MAX do TA 1 devem ser 45 e 45

  #INSERIR NOVAS AFETAÇÕES EM TA EXISTENTES
  Scenario: Inserir nova afetacao no TA Derivado 3 com afetacao 30
    Given Inserir afetacao de voz igual 20 no TA 3
    When Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 10
    And a afetacao VOZ atual do TA 3 deve ser 30
    And a afetacao VOZ atual do TA 2 deve ser 10
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 4 foi 10
    And a maior afetacao VOZ do TA 3 foi 30
    And a maior afetacao VOZ do TA 2 foi 10
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA e MAX do TA 4 devem ser 10 e 10
    And a SOMA e MAX do TA 3 devem ser 30 e 30
    And a SOMA e MAX do TA 2 devem ser 20 e 20
    And a SOMA e MAX do TA 1 devem ser 55 e 55

  Scenario: Inserir nova afetacao no TA Derivado 4 com afetacao 40
    Given Inserir afetacao de voz igual 40 no TA 4
    When Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 40
    And a afetacao VOZ atual do TA 3 deve ser 30
    And a afetacao VOZ atual do TA 2 deve ser 10
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 4 foi 40
    And a maior afetacao VOZ do TA 3 foi 30
    And a maior afetacao VOZ do TA 2 foi 10
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA e MAX do TA 4 devem ser 40 e 40
    And a SOMA e MAX do TA 3 devem ser 30 e 30
    And a SOMA e MAX do TA 2 devem ser 50 e 50
    And a SOMA e MAX do TA 1 devem ser 85 e 85

  Scenario: Inserir nova afetacao no TA Derivado 4 com afetacao 20
    Given Inserir afetacao de voz igual 20 no TA 4
    When Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 20
    And a afetacao VOZ atual do TA 3 deve ser 30
    And a afetacao VOZ atual do TA 2 deve ser 10
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 4 foi 40
    And a maior afetacao VOZ do TA 3 foi 30
    And a maior afetacao VOZ do TA 2 foi 10
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA e MAX do TA 4 devem ser 20 e 40
    And a SOMA e MAX do TA 3 devem ser 30 e 30
    And a SOMA e MAX do TA 2 devem ser 30 e 50
    And a SOMA e MAX do TA 1 devem ser 65 e 85

  Scenario: Inserir nova afetacao no TA Derivado 2 com afetacao 20
    Given Inserir afetacao de voz igual 20 no TA 2
    When Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 20
    And a afetacao VOZ atual do TA 3 deve ser 30
    And a afetacao VOZ atual do TA 2 deve ser 20
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 4 foi 40
    And a maior afetacao VOZ do TA 3 foi 30
    And a maior afetacao VOZ do TA 2 foi 20
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA e MAX do TA 4 devem ser 20 e 40
    And a SOMA e MAX do TA 3 devem ser 30 e 30
    And a SOMA e MAX do TA 2 devem ser 40 e 60
    And a SOMA e MAX do TA 1 devem ser 75 e 95

  #ATUALIZAR UMA AFETAÇÃO EXISTENTE DESDE QUE NÃO SEJA A ULTIMA
  Scenario: Atualizar afetacao mais antiga do TA Derivado 2 com afetacao 50
    Given Inserir afetacao de voz igual 20 no TA 2
    When Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 20
    And a afetacao VOZ atual do TA 3 deve ser 30
    And a afetacao VOZ atual do TA 2 deve ser 20
    And a afetacao VOZ atual do TA 1 deve ser 5
    And a maior afetacao VOZ do TA 4 foi 40
    And a maior afetacao VOZ do TA 3 foi 30
    And a maior afetacao VOZ do TA 2 foi 50
    And a maior afetacao VOZ do TA 1 foi 5
    And a SOMA e MAX do TA 4 devem ser 20 e 40
    And a SOMA e MAX do TA 3 devem ser 30 e 30
    And a SOMA e MAX do TA 2 devem ser 40 e 90
    And a SOMA e MAX do TA 1 devem ser 75 e 125

  #MUDANDO UM NÓ DA ARVORE E RECALCULAR
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
    And a SOMA e MAX do TA 4 devem ser 20 e 40
    And a SOMA e MAX do TA 3 devem ser 30 e 30
    And a SOMA e MAX do TA 2 devem ser 40 e 90
    And a SOMA e MAX do TA 1 devem ser 35 e 35


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
    And a SOMA e MAX do TA 4 devem ser 20 e 40
    And a SOMA e MAX do TA 3 devem ser 30 e 30
    And a SOMA e MAX do TA 2 devem ser 40 e 90
    And a SOMA e MAX do TA 1 devem ser 75 e 125
  
  Scenario: Alterar TA Raiz 3 tornando derivado do TA Raiz 4
    Given Mudar raiz do TA 3 para 4
    When Recalcular afetacao
    Then a afetacao VOZ atual do TA 4 deve ser 20 ??
    And a afetacao VOZ atual do TA 3 deve ser 30 ??
    And a afetacao VOZ atual do TA 2 deve ser 20 ??
    And a afetacao VOZ atual do TA 1 deve ser 5 ??
    And a maior afetacao VOZ do TA 4 foi 40 ??
    And a maior afetacao VOZ do TA 3 foi 30 ??
    And a maior afetacao VOZ do TA 2 foi 50 ??
    And a maior afetacao VOZ do TA 1 foi 5 ??
    And a SOMA e MAX do TA 4 devem ser 20 e 40 ??
    And a SOMA e MAX do TA 3 devem ser 30 e 30 ??
    And a SOMA e MAX do TA 2 devem ser 40 e 90 ??
    And a SOMA e MAX do TA 1 devem ser 75 e 125 ??
    

