#language: pt

@afetacao
Funcionalidade: Afetacao
  -Vincular/Desvincular TA uns aos outros
  -Efetuar calculos de Soma de afetacao levEo em consideracao um TA raiz e seus derivados
  -Efetuar calculos de Máxima afetacao levEo em consideracao um TA raiz e seus derivados
  -Os calculos de afetacao levam em consideracao apenas VOZ
  -SOMA = Soma da afetação atual do TA + Derivados 
  -MAX  = Soma da maior de todas as afetações do TA e maior de todas de cada derivado

  Cenário: Validar base e limpar dados
    Dado Existe conexão com base de dados
    Então Limpar registros

  Esquema do Cenário: Inserir novo TA
    Dado Ta <ta> vinculado ao TA <raiz> inserido com sucesso
    Quando Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos: 
      | ta | raiz | afetacao | vozAtual | vozMaxAtual |
      |  1 | null |        5 |        5 |           5 |
      |  2 |    1 |       10 |       10 |          10 |
      |  3 |    1 |       20 |       20 |          20 |
      |  4 |    2 |       10 |       10 |          10 |

	Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos: 
      | ta | somaDerivados | somaMaxDerivados |
      |  4 |            10 |               10 |
      |  3 |            20 |               20 |
      |  2 |            20 |               20 |
      |  1 |            45 |               45 |

  Esquema do Cenário: Inserir nova afetacao
    Dado Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos: 
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  3 |       30 |       30 |          30 |
      |  4 |       40 |       40 |          40 |
      |  4 |       20 |       20 |          40 |
      |  4 |       20 |       20 |          40 |
      |  2 |       20 |       20 |          20 |
      
  Cenário: Calcular Arvore Novamente
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore Novamente
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos: 
      | ta | raiz | vozAtual | vozMaxAtual | somaDerivados | somaMaxDerivados |
      |  4 |    2 |       20 |          40 |            20 |               40 |
      |  3 |    1 |       30 |          30 |            30 |               30 |
      |  2 |    1 |       20 |          20 |            40 |               60 |
      |  1 | null |        5 |           5 |            75 |               95 |

  Esquema do Cenário: Atualizar afetacao mais antiga
    Dado Atualizar afetacao mais antiga do TA <ta> para <afetacao>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos: 
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  2 |       50 |       20 |          50 |
      
  Cenário: Calcular Arvore apos alterar afetacao mais antiga
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore apos alterar afetacao mais antiga
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos: 
      | ta | raiz | vozAtual | vozMaxAtual | somaDerivados | somaMaxDerivados |
      |  4 |    2 |       20 |          40 |            20 |               40 |
      |  3 |    1 |       30 |          30 |            30 |               30 |
      |  2 |    1 |       20 |          50 |            40 |               90 |
      |  1 | null |        5 |           5 |            75 |              125 |

  Esquema do Cenário: Alterar TA Raiz
    Dado Mudar raiz do TA <ta> para <raiz>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos: 
      | ta | raiz | vozAtual | vozMaxAtual |
      |  2 | null |       20 |          50 |

  Cenário: Calcular Arvore apos alterar remover elemento da arvore
    Dado Recalcular afetacao
  
  Esquema do Cenário: Validar Arvore apos alterar remover elemento da arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos: 
      | ta | raiz | vozAtual | vozMaxAtual | somaDerivados | somaMaxDerivados |
      |  4 |    2 |       20 |          40 |            20 |               40 |
      |  3 |    1 |       30 |          30 |            30 |               30 |
      |  2 | null |       20 |          50 |            40 |               90 |
      |  1 | null |        5 |           5 |            35 |               65 |

  Esquema do Cenário: Alterar TA Raiz
    Dado Mudar raiz do TA <ta> para <raiz>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos: 
      | ta | raiz | vozAtual | vozMaxAtual |
      |  2 |    1 |       20 |          50 |
      |  3 |    4 |       30 |          30 |

  Cenário: Calcular Arvore apos voltar elemento e alterar outro
    Dado Recalcular afetacao
  
  Esquema do Cenário: Validar Arvore apos voltar elemento e alterar outro
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos: 
      | ta | raiz | vozAtual | vozMaxAtual | somaDerivados | somaMaxDerivados |
      |  4 |    2 |       20 |          40 |            50 |               70 |
      |  3 |    4 |       30 |          30 |            30 |               30 |
      |  2 |    1 |       20 |          50 |            70 |              120 |
      |  1 | null |        5 |           5 |            75 |              125 |

  Esquema do Cenário: Inserir novo TA
    Dado Ta <ta> vinculado ao TA <raiz> inserido com sucesso
    Quando Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos: 
      | ta | raiz | afetacao | vozAtual | vozMaxAtual |
      |  5 |    3 |       20 |       20 |          20 |

  Cenário: Calcular Arvore apos inserir novo TA
    Dado Recalcular afetacao
  
  Esquema do Cenário: Validar Arvore apos inserir novo TA
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos: 
      | ta | raiz | vozAtual | vozMaxAtual | somaDerivados | somaMaxDerivados |
      |  5 |    3 |       20 |          20 |            20 |               20 |
      |  4 |    2 |       20 |          40 |            70 |               90 |
      |  3 |    4 |       30 |          30 |            50 |               50 |
      |  2 |    1 |       20 |          50 |            90 |              140 |
      |  1 | null |        5 |           5 |            95 |              145 |

  Esquema do Cenário: Alterar TA Raiz
    Dado Mudar raiz do TA <ta> para <raiz>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos: 
      | ta | raiz | vozAtual | vozMaxAtual |
      |  5 |    2 |       20 |          20 |

  Cenário: Calcular Arvore apos alterar elemento de lugar
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore apos alterar elemento de lugar
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos: 
      | ta | raiz | vozAtual | vozMaxAtual | somaDerivados | somaMaxDerivados |
      |  5 |    2 |       20 |          20 |            20 |               20 |
      |  4 |    2 |       20 |          40 |            50 |               70 |
      |  3 |    4 |       30 |          30 |            30 |               30 |
      |  2 |    1 |       20 |          50 |            90 |              140 |
      |  1 | null |        5 |           5 |            95 |              145 |
