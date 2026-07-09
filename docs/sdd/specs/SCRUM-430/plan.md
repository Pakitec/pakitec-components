# Plano técnico SCRUM-430

<!-- sdd:section specs.plan-template:start -->
## Resumo executivo

Adicionar a propriedade `hiddenToolbarItems` ao widget `PakiTextField` para que consumidores possam ocultar botões específicos da `QuillSimpleToolbar` por instância. A mudança introduz o enum `PakiTextFieldToolbarItem` (valores: `undo`, `redo`, `bold`, `italic`, `underline`, `strike`, `orderedList`, `bulletList`), mapeia cada valor para a flag correspondente do `QuillSimpleToolbarConfig` e atualiza o story do `PakiTextField` no Dashbook com uma propriedade customizada de múltipla seleção. Nenhuma dependência nova é necessária e nenhum arquivo extra será criado.

## Constitution Check

- `docs/sdd/templates/flutter.md` e `docs/constitution.md` lidos e seguidos.
- Arquitetura existente preservada: `PakiTextField` continua como `StatefulWidget` puro de apresentação, sem Controller/Service/Model.
- Padrão de nomenclatura do projeto mantido (`PakiTextFieldToolbarItem` em `UpperCamelCase`, propriedade em `lowerCamelCase`).
- Validação mínima da constituição será aplicada: `dart format .`, `flutter analyze` e `flutter test`.
- Desvio justificado: o enum será declarado no mesmo arquivo `lib/src/widgets/paki_text_field.dart`. Isso evita arquivo adicional e export manual, e está alinhado ao fato de `pakitec_components.dart` já exportar o widget. O enum é pequeno, exclusivo do widget e segue o padrão do projeto de não separar enums triviais.

## Contexto técnico

- Runtime/stack: Flutter/Dart, pacote `pakitec_components` (SDK `>=3.10.0 <4.0.0`, Flutter `>=3.38.0`).
- Dependências relevantes: `flutter_quill: ^11.5.0` (já no `pubspec.yaml`), `dashbook: ^0.1.17` (dev dependency, usado no exemplo).
- Dados/storage: nenhum. A feature é puramente de configuração visual do widget.
- Auth/permissoes: nenhum.
- Plataformas: multiplataforma Flutter (mobile/web/desktop), sem restrições específicas.
- Restrições:
  - A `QuillSimpleToolbarConfig` atual é `const`; ao depender de `hiddenToolbarItems` em runtime, a configuração no `build` não poderá mais ser `const`. Isso não altera semântica e é aceitável.
  - O Dashbook `0.1.17` não possui propriedade nativa de múltipla seleção; o story precisará de uma `Property<List<PakiTextFieldToolbarItem>>.withBuilder` local.
  - Não existem testes de widget para `PakiTextField` hoje; a validação continua sendo `dart format .`, `flutter analyze` e `flutter test`.

## Arquitetura e abordagem

### Arquivos a alterar

- `lib/src/widgets/paki_text_field.dart`: declarar o enum `PakiTextFieldToolbarItem`, adicionar a propriedade `hiddenToolbarItems`, converter a lista para `Set` no `build` e mapear cada valor para a flag `show*` do `QuillSimpleToolbarConfig`.
- `example/main_dashbook.dart`: adicionar uma propriedade customizada que renderize checkboxes para cada valor do enum e passe a lista resultante para o `PakiTextField` do story.

### Arquivos a criar

- Nenhum. O enum será declarado no mesmo arquivo do widget para minimizar a superfície de mudança.

## Contratos e dados

### Enum `PakiTextFieldToolbarItem`

Valores e mapeamento para as flags de `QuillSimpleToolbarConfig`:

| Enum `PakiTextFieldToolbarItem` | Flag `QuillSimpleToolbarConfig` | Botão |
|---|---|---|
| `undo` | `showUndo` | Desfazer |
| `redo` | `showRedo` | Refazer |
| `bold` | `showBoldButton` | Negrito |
| `italic` | `showItalicButton` | Itálico |
| `underline` | `showUnderLineButton` | Sublinhado |
| `strike` | `showStrikeThrough` | Tachado |
| `orderedList` | `showListNumbers` | Lista numerada |
| `bulletList` | `showListBullets` | Lista com marcadores |

### Propriedade do widget

- `final List<PakiTextFieldToolbarItem>? hiddenToolbarItems;`
- Adicionada ao construtor de `PakiTextField` como parâmetro opcional.
- Quando `null` ou vazia, nenhum botão adicional é ocultado além dos já desligados pela configuração padrão.
- Quando preenchida, cada item da lista desliga a flag correspondente.
- Duplicatas e itens já ocultos pelo padrão são tratados de forma idempotente via conversão para `Set`.

## Segurança e privacidade

- Nenhum dado sensível, autenticação, autorização, criptografia ou persistência está envolvido.
- A propriedade afeta apenas a renderização visual da toolbar.

## Observabilidade

- `dart format .`: garante formatação consistente.
- `flutter analyze`: detecta erros de tipo, imports e lints.
- `flutter test`: executa a suíte existente (hoje sem testes de widget para `PakiTextField`) e confirma ausência de regressões.
- Verificação manual no story do Dashbook: selecionar e desmarcar botões para ocultar e confirmar que a toolbar reflete a seleção.

## Etapas de implementação

1. No arquivo `lib/src/widgets/paki_text_field.dart`:
   1. Declarar o enum `PakiTextFieldToolbarItem` com os oito valores documentados.
   2. Adicionar `hiddenToolbarItems` como propriedade final opcional no `PakiTextField` e no seu construtor.
   3. No `build`, converter `hiddenToolbarItems` para `Set<PakiTextFieldToolbarItem>`.
   4. Remover `const` do `QuillSimpleToolbarConfig` e atribuir cada flag `show*` como `!hiddenSet.contains(PakiTextFieldToolbarItem.x)` sobrepondo os defaults `true` do `flutter_quill`.
2. No arquivo `example/main_dashbook.dart`:
   1. Criar uma `Property<List<PakiTextFieldToolbarItem>>.withBuilder` local no story `PakiTextField`.
   2. Renderizar uma lista de checkboxes, uma para cada valor do enum.
   3. Passar o valor retornado para `hiddenToolbarItems` do `PakiTextField` e atualizar o exemplo de código gerado.
3. Executar `dart format .`, `flutter analyze` e `flutter test`.
4. Abrir o Dashbook e validar interativamente o story `PakiTextField`.

## Estratégia de testes

- `dart format .`: deve terminar sem alterações pendentes.
- `flutter analyze`: deve retornar sem erros e sem warnings que bloqueiem a análise.
- `flutter test`: deve passar sem regressões (a suíte pode estar vazia, mas o comando não deve falhar).
- Teste manual no Dashbook: abrir o story `PakiTextField`, marcar `bold` e `italic` na propriedade customizada e verificar que os botões correspondentes desaparecem da toolbar enquanto os demais permanecem.
- Teste manual de edge cases:
  - `hiddenToolbarItems = null` ou `[]`: todos os botões padrão visíveis.
  - `hiddenToolbarItems` com duplicatas: renderização sem erro e conjunto de botões ocultos idempotente.
  - `showToolbar: false`: toolbar inteira oculta independentemente de `hiddenToolbarItems`.

## Rollout e rollback

- Rollout: a alteração é retrocompatível. Após merge na branch principal, o `PakiTextField` ganha a nova API opcional. Não é necessário bump de versão da dependência `flutter_quill`, mas pode ser necessário bump da versão do pacote `pakitec_components` conforme processo interno de release.
- Rollback: reverter os commits que alteraram `lib/src/widgets/paki_text_field.dart` e `example/main_dashbook.dart` restaura o comportamento anterior sem impactar consumidores (a nova propriedade era opcional).

## Riscos e mitigações

| Risco | Impacto | Mitigação |
|---|---|---|
| Perda de `const` na `QuillSimpleToolbarConfig` | Baixo — pode gerar rebuild levemente maior, mas sem mudança semântica | Aceitável; configuração permanece imutável por build |
| Custom property do Dashbook mal implementada | Médio — story pode não refletir a seleção | Reutilizar `Property.withBuilder` e testar manualmente todos os valores |
| API pública aumenta com novo enum | Baixo — enum é exportado automaticamente pelo widget | Manter enum no mesmo arquivo para não esquecer export; documentar valores |
| Quebra de compatibilidade com `flutter_quill` 11.5.0 | Baixo — flags verificadas no cache local | Validar com `flutter analyze` e `flutter test`; não alterar versão da dependência |
| `library_private_types_in_public_api` ativado | Baixo — o enum deve ser público | Declarar enum como `public` (sem prefixo `_`) |

## Complexity Tracking

| Desvio | Necessidade | Alternativa simples rejeitada |
|---|---|---|
| N/A | N/A | N/A |

A solução adotada é a mais simples possível: enum no mesmo arquivo do widget e mapeamento direto para flags já existentes do `QuillSimpleToolbarConfig`. Não há desvio da solução mínima.

## Gate de execução

`READY_TO_BUILD` somente quando:

- `plan.md` e `tasks.md` estiverem aprovados e consistentes com `spec.md` e `research.md`.
- Nenhuma dúvida de produto permanecer sem resposta.
- Os arquivos de origem (`lib/src/widgets/paki_text_field.dart`, `example/main_dashbook.dart`) forem acessíveis e a dependência `flutter_quill: ^11.5.0` estiver resolvida no ambiente.
- (Observação) A constituição do projeto indica que o workspace ainda não possui vínculo Jira, portanto os comandos `/sdd-task`, `/sdd-plan` e `/sdd-build` permanecem bloqueados até a vinculação. O presente plano pode ser executado manualmente pelos agentes SDD.
<!-- sdd:section specs.plan-template:end -->
