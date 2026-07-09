# Snapshot da issue SCRUM-430

<!-- sdd:section specs.issue-template:start -->
- Jira: `SCRUM-430`
- Projeto: `SCRUM`
- Status no momento do planejamento: `Em andamento`
- Capturado em: `2026-07-09T16:26:00-03:00`
- Hash normalizado: `f49f3d3875760404c9d4a8ed3fcdb37483b40c046801736e20a9f65be59bbd52`

## Resumo

Adicionar propriedade `hiddenToolbarItems` ao `PakiTextField` para ocultar botões da toolbar.

## Descricao

O componente `PakiTextField` (`lib/src/widgets/paki_text_field.dart`) usa `flutter_quill` e exibe uma `QuillSimpleToolbar` com os botões padrão visíveis hoje: desfazer, refazer, negrito, itálico, sublinhado, tachado, lista numerada e lista com marcadores.

Não é possível suprimir botões específicos por instância do componente. Consumidores do componente precisam ocultar itens da toolbar de acordo com o contexto de uso.

Nova propriedade `hiddenToolbarItems` que receba uma lista de botões a ocultar. Quando a propriedade for `null` ou vazia, nenhum botão é oculto. Quando informada, apenas os botões listados são suprimidos, mantendo os demais visíveis.

## Criterios e campos personalizados

### Critérios de aceite

1. Dado que um `PakiTextField` é renderizado sem `hiddenToolbarItems`, quando a toolbar é exibida, então todos os botões padrão permanecem visíveis.
2. Dado que `hiddenToolbarItems` é uma lista vazia, quando a toolbar é exibida, então nenhum botão é ocultado.
3. Dado que `hiddenToolbarItems` contém valores válidos de botões visíveis, quando a toolbar é exibida, então apenas esses botões são suprimidos.
4. Dado que a lista contém duplicatas ou botões já ocultos pelo padrão, quando a toolbar é construída, então não ocorre erro e o efeito é idempotente.
5. Dado que a implementação é concluída, quando executados `dart format .`, `flutter analyze` e `flutter test`, então todos passam sem regressões.

### Campos personalizados preenchidos

- `Projeto`: `pakitec-components`
- `Regras de negócio`: Por padrão todos os botões da toolbar do PakiTextField são visíveis. A ocultação só ocorre quando `hiddenToolbarItems` for explicitamente informado.
- `Detalhes técnicos`: Widget `lib/src/widgets/paki_text_field.dart`, story `example/main_dashbook.dart`, dependência `flutter_quill: ^11.5.0`, validação `dart format .`, `flutter analyze`, `flutter test`.

## Anexos relevantes

Nenhum anexo na issue.

## Subtarefas existentes

- `SCRUM-431` — `[SDD][SPEC] Specification` — Em andamento
- `SCRUM-432` — `[SDD][RESEARCH] Technical Research` — A fazer
- `SCRUM-433` — `[SDD][PLAN] Technical Plan` — A fazer

## Decisões pendentes / premissas

- Nome final da propriedade: `hiddenToolbarItems`.
- Enum apenas com botões visíveis hoje no `PakiTextField`.
- Alinhamentos de texto (centro, direita, etc.) não estão habilitados na configuração padrão atual, portanto não fazem parte desta task.

Este arquivo é um snapshot para rastreabilidade. A issue Jira continua sendo a fonte da demanda.
<!-- sdd:section specs.issue-template:end -->
