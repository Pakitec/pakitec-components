# Tarefas SCRUM-430

<!-- sdd:section specs.tasks-template:start -->
## Formato

`TASK-ID [P?] [US-ID] Descricao com path exato`

`[P]` significa execucao paralela segura: arquivos diferentes e nenhuma dependencia pendente.

## Fase 1 - Setup/Fundacao

Nao ha setup ou fundacao necessaria para esta issue. Nao serao adicionadas dependencias, novos diretorios ou arquivos base. A implementacao inicia diretamente na jornada US-001.

## Fase 2 - US-001 (P1)

**Objetivo**: permitir que consumidores do `PakiTextField` ocultem botoes especificos da toolbar via propriedade `hiddenToolbarItems`.  
**Teste independente**: renderizar o widget com `hiddenToolbarItems` preenchido e verificar, manualmente ou por inspecao da toolbar, que os botoes listados sao suprimidos enquanto os demais permanecem.

### Implementacao

- [ ] `TASK-001 [US-001] Declarar enum `PakiTextFieldToolbarItem` e propriedade `hiddenToolbarItems` em `lib/src/widgets/paki_text_field.dart``
- [ ] `TASK-002 [US-001] Aplicar mapeamento de `hiddenToolbarItems` para flags do `QuillSimpleToolbarConfig` em `lib/src/widgets/paki_text_field.dart``

**Checkpoint**: US-001 funciona e pode ser demonstrada isoladamente (widget compila, botoes ocultam conforme a lista, e comandos `dart format .` e `flutter analyze` passam para o arquivo alterado).

## Fase 3 - US-002 (P2)

**Objetivo**: demonstrar a propriedade `hiddenToolbarItems` no story do Dashbook para facilitar descoberta e validacao visual.  
**Teste independente**: abrir o story `PakiTextField` no Dashbook e alternar a selecao de botoes ocultos; a toolbar renderizada deve refletir a escolha.

### Implementacao

- [ ] `TASK-003 [US-002] Adicionar story interativo com custom property de multipla selecao em `example/main_dashbook.dart``

**Checkpoint**: US-002 funciona e pode ser demonstrada isoladamente (story exibe a propriedade customizada e reflete as escolhas na toolbar).

## Fase final - Polish e validacao

- [ ] `TASK-004 [US-001, US-002] Executar `dart format .`, `flutter analyze` e `flutter test` e confirmar ausencia de regressoes`
- [ ] Confirmar estrutura, documentacao e ausencia de overengineering.

## Contrato de cada tarefa

### TASK-001

- **Tipo**: implementation
- **Ownership**: `sdd-implementer`
- **Requisitos**: `FR-001`, `FR-002`
- **Criterios**: `AC-001`, `AC-002`
- **Dependencias**: nenhuma
- **Arquivos provaveis**: `lib/src/widgets/paki_text_field.dart`
- **Objetivo**: declarar o enum publico `PakiTextFieldToolbarItem` com os valores `undo`, `redo`, `bold`, `italic`, `underline`, `strike`, `orderedList`, `bulletList`; adicionar a propriedade final opcional `hiddenToolbarItems: List<PakiTextFieldToolbarItem>?` ao `PakiTextField` e ao seu construtor.
- **Validacao**:
  - `flutter analyze` nao reporta erros no arquivo.
  - O enum e a propriedade estao acessiveis pelo export publico de `pakitec_components.dart`.
  - Construtor continua aceitando instancias sem `hiddenToolbarItems` (retrocompativel).
- **Subtarefa Jira**: pendente / a ser criada para BUILD
- **Estado**: pending

### TASK-002

- **Tipo**: implementation
- **Ownership**: `sdd-implementer`
- **Requisitos**: `FR-003`, `FR-004`, `FR-005`, `FR-006`
- **Criterios**: `AC-003`, `AC-004`, `AC-005`
- **Dependencias**: `TASK-001`
- **Arquivos provaveis**: `lib/src/widgets/paki_text_field.dart`
- **Objetivo**: no metodo `build` do `_PakiTextFieldState`, converter `hiddenToolbarItems` em `Set<PakiTextFieldToolbarItem>` e mapear cada valor para a flag correspondente do `QuillSimpleToolbarConfig` (`showUndo`, `showRedo`, `showBoldButton`, `showItalicButton`, `showUnderLineButton`, `showStrikeThrough`, `showListNumbers`, `showListBullets`), mantendo `showToolbar` como guarda principal. Remover `const` da configuracao da toolbar porque ela passa a depender de valor em runtime.
- **Validacao**:
  - `hiddenToolbarItems` vazio ou `null`: todos os botoes padrao visiveis (`AC-001`, `AC-002`).
  - `hiddenToolbarItems = [bold, italic]`: negrito e italico ocultos, demais visiveis (`AC-003`).
  - `hiddenToolbarItems` com duplicatas: sem erro e efeito idempotente (`AC-004`).
  - `showToolbar: false`: toolbar inteira oculta (`AC-005`).
  - `flutter analyze` passa.
- **Subtarefa Jira**: pendente / a ser criada para BUILD
- **Estado**: pending

### TASK-003

- **Tipo**: implementation
- **Ownership**: `sdd-implementer`
- **Requisitos**: `FR-007`
- **Criterios**: `AC-006`, `AC-007`
- **Dependencias**: `TASK-001` (pelo contrato do enum; pode ser iniciada em paralelo desde que o contrato esteja estabilizado, mas a compilacao so e possivel apos a declaracao do enum)
- **Arquivos provaveis**: `example/main_dashbook.dart`
- **Objetivo**: no story `PakiTextField`, criar uma propriedade customizada `Property<List<PakiTextFieldToolbarItem>>.withBuilder` que renderize um checkbox para cada valor do enum. Passar o valor retornado para `hiddenToolbarItems` do `PakiTextField` e atualizar a string do exemplo gerado.
- **Validacao**:
  - Marcar/desmarcar valores no story reflete imediatamente na toolbar (`AC-006`).
  - `flutter analyze` e `flutter test` continuam passando (`AC-007`).
  - O exemplo gerado exibe a propriedade `hiddenToolbarItems` de forma legivel.
- **Subtarefa Jira**: pendente / a ser criada para BUILD
- **Estado**: pending

### TASK-004

- **Tipo**: polish
- **Ownership**: `sdd-implementer`
- **Requisitos**: `NFR-001`, `NFR-002`, `NFR-003`, `NFR-004`
- **Criterios**: `AC-007`, `SC-005`
- **Dependencias**: `TASK-002`, `TASK-003`
- **Arquivos provaveis**: `lib/src/widgets/paki_text_field.dart`, `example/main_dashbook.dart`
- **Objetivo**: executar os comandos de validacao minimos da constitucao e confirmar que nao ha regressoes de formato, analise estatica ou testes.
- **Validacao**:
  - `dart format .` termina sem alteracoes pendentes.
  - `flutter analyze` retorna sem erros.
  - `flutter test` executa sem falhas.
  - Nao ha novos warnings introduzidos pelas alteracoes.
- **Subtarefa Jira**: pendente / a ser criada para BUILD
- **Estado**: pending

Cada tarefa e pequena o suficiente para execucao sem redesenhar o plano. Nenhuma tarefa esconde decisao de produto.
<!-- sdd:section specs.tasks-template:end -->
