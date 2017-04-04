#language: pt
@afetacao
Funcionalidade: Afetacao
  -Vincular/Desvincular TA uns aos outros
  -Efetuar cálculos de Soma de afetação levam em consideração um TA raiz e seus derivados
  -Efetuar cálculos de Máxima afetação levam em consideração um TA raiz e seus derivados
  -Os cálculos de afetação levam em consideração apenas VOZ
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
      |  1 | null |       49 |       49 |          49 |
    # |  2 |    1 |       10 |       10 |          10 |
    # |  3 |    1 |       20 |       20 |          20 |
    # |  4 |    2 |       10 |       10 |          10 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
    # |  4 |            10 |               10 |
    # |  3 |            20 |               20 |
    # |  2 |            20 |               20 |
      |  1 |            49 |               49 |

  Esquema do Cenário: Inserir nova afetacao
    Dado Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  1 |        0 |        0 |          49 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |             0 |               49 |

  Esquema do Cenário: Inserir nova afetacao
    Dado Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  1 |       49 |       49 |          49 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |            49 |               49 |

  Esquema do Cenário: Inserir nova afetacao
    Dado Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  1 |        0 |        0 |          49 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |             0 |               49 |

  Esquema do Cenário: Inserir nova afetacao
    Dado Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  1 |       20 |       20 |          49 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |            20 |               49 |

  Esquema do Cenário: Inserir nova afetacao
    Dado Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  1 |       30 |       30 |          49 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |            30 |               49 |

  Esquema do Cenário: Inserir nova afetacao
    Dado Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  1 |        0 |        0 |          49 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |             0 |               49 |

  Esquema do Cenário: Inserir nova afetacao
    Dado Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  1 |       30 |       30 |          49 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |            30 |               49 |

  Esquema do Cenário: Inserir nova afetacao
    Dado Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  1 |        0 |        0 |          49 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |             0 |               49 |

  Esquema do Cenário: Inserir nova afetacao
    Dado Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  1 |       30 |       30 |          49 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |            30 |               49 |

  Esquema do Cenário: Inserir nova afetacao
    Dado Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  1 |        0 |        0 |          49 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |             0 |               49 |

  Esquema do Cenário: Inserir novo TA
    Dado Ta <ta> vinculado ao TA <raiz> inserido com sucesso
    Quando Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | raiz | afetacao | vozAtual | vozMaxAtual |
      |  2 | null |       60 |       60 |          60 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |             0 |               49 |
      |  2 |            60 |               60 |

  Esquema do Cenário: Alterar TA Raiz
    Dado Mudar raiz do TA <ta> para <raiz>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | raiz | vozAtual | vozMaxAtual |
      |  2 |    1 |       60 |          60 |

  Esquema do Cenário: Inserir nova afetacao
    Dado Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  2 |        0 |        0 |          60 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |             0 |              109 |
      |  2 |             0 |               60 |

  Esquema do Cenário: Inserir novo TA
    Dado Ta <ta> vinculado ao TA <raiz> inserido com sucesso
    Quando Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | raiz | afetacao | vozAtual | vozMaxAtual |
      |  3 | null |     1217 |     1217 |        1217 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |             0 |              109 |
      |  2 |             0 |               60 |
      |  3 |          1217 |             1217 |

  Esquema do Cenário: Inserir nova afetacao
    Dado Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  3 |        1 |        1 |        1217 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |             0 |              109 |
      |  2 |             0 |               60 |
      |  3 |             1 |             1217 |

  Esquema do Cenário: Inserir nova afetacao
    Dado Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  3 |       48 |       48 |        1217 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |             0 |              109 |
      |  2 |             0 |               60 |
      |  3 |            48 |             1217 |

  Esquema do Cenário: Inserir nova afetacao
    Dado Inserir afetacao de voz igual a <afetacao> no TA <ta>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | afetacao | vozAtual | vozMaxAtual |
      |  3 |        0 |        0 |        1217 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |             0 |              109 |
      |  2 |             0 |               60 |
      |  3 |             0 |             1217 |

  Esquema do Cenário: Alterar TA Raiz
    Dado Mudar raiz do TA <ta> para <raiz>
    Então a afetacao VOZ atual do TA <ta> deve ser <vozAtual>
    E a maior afetacao VOZ do TA <ta> foi <vozMaxAtual>

    Exemplos:
      | ta | raiz | vozAtual | vozMaxAtual |
      |  3 |    1 |        0 |        1217 |

  Cenário: Calcular Arvore
    Dado Recalcular afetacao

  Esquema do Cenário: Validar Arvore
    Então a SOMA dos derivados do TA <ta> deve ser <somaDerivados>
    Então a SOMA do MAX dos derivados do TA <ta> deve ser <somaMaxDerivados>

    Exemplos:
      | ta | somaDerivados | somaMaxDerivados |
      |  1 |             0 |             1326 |
      |  2 |             0 |               60 |
      |  3 |             0 |             1217 |
