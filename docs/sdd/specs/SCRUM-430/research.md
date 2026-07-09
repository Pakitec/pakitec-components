# Pesquisa tecnica SCRUM-430

<!-- sdd:section specs.research-template:start -->

## Arquivos e simbolos relevantes

- `/Volumes/External HD/Projetos/pakitec/pakitec-components/lib/src/widgets/paki_text_field.dart`
  - `PakiTextField` (StatefulWidget)
  - `_PakiTextFieldState`
  - Propriedades existentes: `name`, `controller`, `isEnabled`, `showToolbar`, `removeHorizontalDiv`, `hint`, `minHeight`, `maxHeight`, `padding`, `onPlainTextChanged`, `validator`, `onSaved`, `willValidate`
  - Getters: `isEnabled`, `showToolbar`, `removeHorizontalDiv`, `willValidate`
  - Usa `QuillSimpleToolbar` e `QuillEditor.basic`
- `/Volumes/External HD/Projetos/pakitec/pakitec-components/lib/pakitec_components.dart`
  - Exporta `src/widgets/paki_text_field.dart`; qualquer enum adicionado ao mesmo arquivo sera exportado automaticamente. Se criado em arquivo separado, precisara de export adicional aqui.
- `/Volumes/External HD/Projetos/pakitec/pakitec-components/example/main_dashbook.dart`
  - Story `PakiTextField` (linhas 464-486) usa `ctx.textProperty` para `hint`.
  - Importa `package:pakitec_components/pakitec_components.dart` e `package:pakitec_components/src/widgets/...`.
- `/Volumes/External HD/Projetos/pakitec/pakitec-components/pubspec.yaml`
  - `flutter_quill: ^11.5.0` (locked em 11.5.0 no pubspec.lock).
- Cache da dependencia instalada:
  - `/Users/leonardo/.pub-cache/hosted/pub.dev/flutter_quill-11.5.0/lib/src/toolbar/config/simple_toolbar_config.dart` — define `QuillSimpleToolbarConfig` e todas as flags `show*`.
  - `/Users/leonardo/.pub-cache/hosted/pub.dev/flutter_quill-11.5.0/lib/src/toolbar/simple_toolbar.dart` — `QuillSimpleToolbar` consome as flags `show*` em `if (config.showX)` para renderizar cada botao.
- `/Volumes/External HD/Projetos/pakitec/pakitec-components/analysis_options.yaml`
  - Usa `package:flutter_lints/flutter.yaml` com `prefer_single_quotes`, `prefer_relative_imports`, `avoid_relative_lib_imports`, `library_private_types_in_public_api`.

## Arquitetura e padroes existentes

- O widget `PakiTextField` segue o padrao Flutter de `StatefulWidget` + `State` ja existente no projeto.
- A toolbar e condicionalmente renderizada por `if (showToolbar && isEnabled)`.
- A configuracao da toolbar e feita via `QuillSimpleToolbarConfig`, hoje com valores explicitamente desligados para recursos nao usados (`showHeaderStyle: false`, `showCodeBlock: false`, `showColorButton: false`, etc.).
- Os recursos habilitados hoje (default `true` no `QuillSimpleToolbarConfig`) e visiveis no `PakiTextField` sao: desfazer, refazer, negrito, italico, sublinhado, tachado, lista numerada e lista com marcadores.
- Nao ha Controller/Service/Model envolvido; e um widget puro de apresentacao. Portanto, nao e necessario redesenhar arquitetura.
- O enum `PakiTextFieldToolbarItem` pode ser declarado no mesmo arquivo `paki_text_field.dart` (mais simples e alinhado ao projeto, que nao separa enums pequenos) ou em arquivo proprio. Declarar no mesmo arquivo mantem a mudanca local e ja e exportado por `pakitec_components.dart`, sem risco de esquecer o export.

## API do flutter_quill

- `QuillSimpleToolbar` e `StatelessWidget` que recebe `controller` e `config` (tipo `QuillSimpleToolbarConfig`).
- `QuillSimpleToolbarConfig` contem flags booleanas `show*` com defaults. Relevantes para esta task:
  - `showUndo` (default `true`) -> botao desfazer
  - `showRedo` (default `true`) -> botao refazer
  - `showBoldButton` (default `true`) -> negrito
  - `showItalicButton` (default `true`) -> italico
  - `showUnderLineButton` (default `true`) -> sublinhado
  - `showStrikeThrough` (default `true`) -> tachado
  - `showListNumbers` (default `true`) -> lista numerada
  - `showListBullets` (default `true`) -> lista com marcadores
- O build de `QuillSimpleToolbar` agrupa botoes em secoes e so renderiza cada botao quando a flag correspondente e `true`. Mudar a flag para `false` remove o botao da toolbar sem alterar o editor.
- O `PakiTextField` ja define `showHeaderStyle: false`, `showCodeBlock: false`, etc. A nova propriedade `hiddenToolbarItems` atuara como camada adicional sobre as flags ja desligadas, desligando ainda mais as flags listadas acima.

## Enum PakiTextFieldToolbarItem e mapeamento para flags

- Opcoes de design consideradas:
  1. Declarar o enum no mesmo arquivo `paki_text_field.dart`.
  2. Declarar o enum em arquivo separado, por exemplo `lib/src/widgets/paki_text_field_toolbar_item.dart`, e exporta-lo.
- Recomendacao: declarar no mesmo arquivo `paki_text_field.dart`, pois o enum e pequeno, exclusivo do widget, e o projeto nao tem padrao de separar enums. Isso evita novo arquivo e novo export. A visibilidade/public API continua sendo controlada pelo export de `paki_text_field.dart` em `pakitec_components.dart`.

Mapeamento exato de cada valor do enum para a flag `show*` do `QuillSimpleToolbarConfig`:

| Enum `PakiTextFieldToolbarItem` | Flag `QuillSimpleToolbarConfig` | Botao |
|---|---|---|
| `undo` | `showUndo` | Desfazer |
| `redo` | `showRedo` | Refazer |
| `bold` | `showBoldButton` | Negrito |
| `italic` | `showItalicButton` | Italico |
| `underline` | `showUnderLineButton` | Sublinhado |
| `strike` | `showStrikeThrough` | Tachado |
| `orderedList` | `showListNumbers` | Lista numerada |
| `bulletList` | `showListBullets` | Lista com marcadores |

## Testes e comandos atuais

- Nao existe diretorio `test/` nem arquivo de teste de widget para `PakiTextField` no projeto. Confirmado via `find` na raiz.
- Comandos de validacao minimos (constitution e spec):
  - `dart format .`
  - `flutter analyze`
  - `flutter test` (vai executar sem testes ou com testes existentes; nao deve falhar por regressao)
- CI existente em `/Volumes/External HD/Projetos/pakitec/pakitec-components/.github/workflows/`:
  - `deploy_playbook_pages.yml`: dispara em push para `master`, executa `flutter pub get` e `flutter build web --target example/main_dashbook.dart --base-href /`.
  - `version_tag.yml`: dispara em push para `master`, le a versao do `pubspec.yaml` e cria tag.
  - Nenhum workflow executa `flutter test` ou `flutter analyze` automaticamente hoje. A validacao e manual/local conforme a spec.

## Story do Dashbook

- `example/main_dashbook.dart` usa a API `DashbookContext` com `textProperty`, `boolProperty`, `numberProperty`, `listProperty`, `optionsProperty`, etc.
- O Dashbook `0.1.17` nao possui propriedade nativa de multipla selecao (checkbox list). Para demonstrar `hiddenToolbarItems` interativamente, recomenda-se criar uma propriedade customizada estendendo `Property<List<PakiTextFieldToolbarItem>>` (ou usar `Property.withBuilder`) que renderize checkboxes para cada valor do enum.
- Alternativa mais simples: usar `listProperty` com um tipo que represente combinacoes pre-definidas (por exemplo, `none`, `boldOnly`, `boldItalic`, `all`), mas isso limita a demonstracao. A spec pede que o desenvolvedor "selecione botões para ocultar", o que sugere multipla escolha real.
- Portanto, a abordagem correta no story e uma custom property com checkboxes, retornando `List<PakiTextFieldToolbarItem>`, e passando para `hiddenToolbarItems` do `PakiTextField`.

## Alternativas consideradas

- Receber `List<String>` em vez de enum:
  - Perde type safety, permite valores invalidos em tempo de execucao, exige validacao manual e nao aproveita autocompletar do IDE.
  - Rejeitada; o enum e preferido conforme a spec.
- Expor `QuillSimpleToolbarConfig` diretamente como parametro do `PakiTextField`:
  - Da controle total, mas aumenta a superficie de API, expoe dependencia interna e forca o consumidor a conhecer todas as flags do `flutter_quill`.
  - Vai contra o objetivo da spec de simplificar o uso.
  - Rejeitada.
- Usar `Set<PakiTextFieldToolbarItem>` em vez de `List<PakiTextFieldToolbarItem>?`:
  - Semanticamente mais correto para evitar duplicatas, mas a spec define explicitamente `List<PakiTextFieldToolbarItem>?`.
  - A implementacao pode converter internamente para `Set` para tratar duplicatas de forma idempotente.

## Riscos tecnicos

- **Quebra de API publica**: baixo. A nova propriedade e opcional (`List<PakiTextFieldToolbarItem>?`). Codigos existentes continuam compilando sem alteracao. O enum precisa ser exportado em `pakitec_components.dart` (automatico se no mesmo arquivo do widget).
- **Compatibilidade com `flutter_quill: ^11.5.0`**: confirmada. As flags `show*` listadas existem na versao 11.5.0 do cache local.
- **Comportamento com `didUpdateWidget`**: a toolbar e reconstruida quando o `PakiTextField` reconstruir com novo `hiddenToolbarItems`. O `QuillSimpleToolbar` e `StatelessWidget`, portanto depende do pai. O `didUpdateWidget` atual so trata mudanca de `controller`; nao e necessario codigo adicional para `hiddenToolbarItems`, mas o estado do editor (`QuillEditor`) e preservado pelo `QuillController` externo.
- **Performance**: impacto minimo. Conversao de lista para set e mapeamento para flags ocorre apenas durante o build.
- **Idempotencia**: duplicatas e botoes ja ocultos pelo padrao podem ser tratados com `hiddenToolbarItems?.toSet() ?? {}` e `Set` lookup; nao gera erro.
- **Const `QuillSimpleToolbarConfig`**: atualmente a configuracao e `const`. Ao depender de `hiddenToolbarItems` (valor em runtime), o `QuillSimpleToolbarConfig` dentro do `build` nao podera mais ser `const`. Isso e aceitavel e nao altera semantica.
- **Lint `library_private_types_in_public_api`**: ativado no `analysis_options.yaml`. O tipo `List<PakiTextFieldToolbarItem>?` e publico, portanto o enum deve ser publico. Nao ha problema. O tipo `_PakiTextFieldState` ja e privado.

## Lacunas

- Nenhuma lacuna tecnica bloqueia o planejamento. Todos os mapeamentos de flags foram verificados na fonte da versao 11.5.0 do `flutter_quill`.
- Consideracao para o planner: o story do Dashbook precisara de uma custom property para multipla selecao, pois o Dashbook 0.1.17 nao fornece esse controle nativamente. A custom property deve ser leve e local ao story.

<!-- sdd:section specs.research-template:end -->
