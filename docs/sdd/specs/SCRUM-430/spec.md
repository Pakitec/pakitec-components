# Feature Specification: SCRUM-430

<!-- sdd:section specs.spec-template:start -->
**Issue**: `SCRUM-430`  
**Status**: `READY`  
**Input**: Jira validado pelo refinement gate (`REFINEMENT_GATE: PASS`, hash `f49f3d3875760404c9d4a8ed3fcdb37483b40c046801736e20a9f65be59bbd52`)

## Objetivo

Permitir que consumidores do componente `PakiTextField` definam, por instância, quais botões da `QuillSimpleToolbar` devem estar ocultos, sem precisar reconfigurar toda a toolbar. Isso reduz a complexidade de uso do componente em contextos que exigem menos recursos de edição (por exemplo, campos de observação curta que não precisam de listas, ou campos de descrição que não devem permitir desfazer/refazer).

## Usuarios e Cenarios

### US-001 - Ocultar botões específicos da toolbar (P1)

Como desenvolvedor consumidor do `PakiTextField`, quero informar uma lista de botões que devem ser ocultos na toolbar para que a interface de edição reflita apenas as ações permitidas no contexto de uso.

**Por que P1**: entrega o valor central da issue e resolve a incapacidade atual de suprimir botões individualmente.  
**Teste independente**: renderizar o widget com `hiddenToolbarItems` contendo um ou mais valores e verificar, por meio de teste de widget ou inspeção da toolbar, que os botões listados não estão presentes enquanto os demais permanecem.

**Cenarios de aceite**:

1. `AC-001` — **Dado** um `PakiTextField` renderizado sem a propriedade `hiddenToolbarItems`, **quando** a toolbar é exibida, **então** todos os botões padrão (desfazer, refazer, negrito, itálico, sublinhado, tachado, lista numerada, lista com marcadores) permanecem visíveis.
2. `AC-002` — **Dado** um `PakiTextField` com `hiddenToolbarItems` igual a `[]`, **quando** a toolbar é exibida, **então** nenhum botão é ocultado.
3. `AC-003` — **Dado** um `PakiTextField` com `hiddenToolbarItems` contendo `[bold, italic]`, **quando** a toolbar é exibida, **então** os botões de negrito e itálico são suprimidos e todos os outros botões padrão permanecem visíveis.
4. `AC-004` — **Dado** um `PakiTextField` com `hiddenToolbarItems` contendo duplicatas (por exemplo, `[bold, bold]`) ou botões já ocultos pelo padrão, **quando** a toolbar é construída, **então** não ocorre erro e o efeito é idempotente.
5. `AC-005` — **Dado** um `PakiTextField` com `showToolbar: false`, **quando** o widget é renderizado, **então** a toolbar inteira não é exibida independentemente do valor de `hiddenToolbarItems`.

### US-002 - Demonstrar a propriedade no Dashbook (P2)

Como mantenedor da biblioteca de componentes, quero que o story do `PakiTextField` no Dashbook exponha a propriedade `hiddenToolbarItems` para que desenvolvedores possam visualizar o comportamento de ocultação sem precisar inspecionar o código-fonte.

**Por que P2**: aumenta a descoberta e a adoção correta do componente, mas não altera o comportamento do widget em si.  
**Teste independente**: abrir o story `PakiTextField` no Dashbook e alternar a lista de botões ocultos; a toolbar deve refletir a seleção.

**Cenarios de aceite**:

1. `AC-006` — **Dado** o story `PakiTextField` no `example/main_dashbook.dart`, **quando** o desenvolvedor seleciona botões para ocultar, **então** o exemplo renderizado reflete a configuração escolhida.
2. `AC-007` — **Dado** a atualização do story, **quando** executados `dart format .`, `flutter analyze` e `flutter test`, **então** não há regressões.

## Requisitos funcionais

- `FR-001`: O componente `PakiTextField` deve expor a propriedade `hiddenToolbarItems` do tipo `List<PakiTextFieldToolbarItem>?`.
- `FR-002`: Deve existir um enum `PakiTextFieldToolbarItem` mapeando apenas os botões visíveis hoje na toolbar do `PakiTextField`: desfazer, refazer, negrito, itálico, sublinhado, tachado, lista numerada e lista com marcadores.
- `FR-003`: Quando `hiddenToolbarItems` for `null` ou vazia, nenhum botão adicional deve ser ocultado além dos já ocultos pela configuração padrão do `QuillSimpleToolbarConfig`.
- `FR-004`: Quando `hiddenToolbarItems` contiver valores válidos, os botões correspondentes devem ser suprimidos da toolbar; os demais botões padrão devem permanecer visíveis.
- `FR-005`: A presença de duplicatas na lista ou de botões já ocultos pelo padrão não deve gerar erro, exceção ou comportamento instável.
- `FR-006`: Se `showToolbar` for `false`, a toolbar inteira deve continuar oculta e `hiddenToolbarItems` não deve forçar sua exibição.
- `FR-007`: O story do Dashbook para `PakiTextField` deve demonstrar a propriedade `hiddenToolbarItems` de forma interativa.

## Requisitos nao funcionais

- `NFR-001`: A implementação deve ser compatível com `flutter_quill: ^11.5.0` e não deve exigir alteração de versão da dependência.
- `NFR-002`: As validações mínimas `dart format .`, `flutter analyze` e `flutter test` devem continuar passando sem regressões.
- `NFR-003`: A nova API deve ser estável e reversível: adicionar ou remover `hiddenToolbarItems` não deve quebrar consumidores existentes.
- `NFR-004`: A solução deve seguir o padrão de nomenclatura e estrutura do projeto descrito em `docs/sdd/templates/flutter.md`.

## Entidades e Dados

- `PakiTextFieldToolbarItem` (enum): representa os botões da toolbar que podem ser ocultados. Valores previstos:
  - `undo` (desfazer)
  - `redo` (refazer)
  - `bold` (negrito)
  - `italic` (itálico)
  - `underline` (sublinhado)
  - `strike` (tachado)
  - `orderedList` (lista numerada)
  - `bulletList` (lista com marcadores)
- `hiddenToolbarItems`: atributo opcional do tipo `List<PakiTextFieldToolbarItem>?` no `PakiTextField`. Quando ausente ou vazio, nenhum efeito adicional ocorre. Quando preenchido, indica quais botões devem ser ocultos.
- `showToolbar`: atributo existente do `PakiTextField` que controla a visibilidade da toolbar como um todo. Continua tendo precedência sobre `hiddenToolbarItems`.

## Edge Cases

- Lista `null` ou vazia: nenhum botão é ocultado além dos já ocultos pela configuração padrão.
- Duplicatas na lista: tratadas de forma idempotente, sem erro.
- Botões já ocultos pelo padrão (`QuillSimpleToolbarConfig` com `show* = false`): listá-los em `hiddenToolbarItems` não causa efeito colateral nem erro.
- `showToolbar: false`: a toolbar inteira permanece oculta; `hiddenToolbarItems` é irrelevante.
- Valores inválidos: não se aplicam, pois o enum `PakiTextFieldToolbarItem` restringe os valores aceitos em tempo de compilação.
- Mudança de valor em tempo de execução (`didUpdateWidget`): a toolbar deve refletir o novo valor de `hiddenToolbarItems` sem perder o estado do editor.

## Criterios de sucesso

- `SC-001`: Com `hiddenToolbarItems` ausente, 100% dos botões padrão esperados estão visíveis.
- `SC-002`: Com `hiddenToolbarItems` preenchido com N itens, exatamente N botões correspondentes são ocultados e os demais permanecem visíveis.
- `SC-003`: Com `hiddenToolbarItems` contendo duplicatas, a toolbar é renderizada sem erro e o conjunto de botões ocultos é igual ao conjunto sem duplicatas.
- `SC-004`: Com `showToolbar: false`, a toolbar não é renderizada independentemente de `hiddenToolbarItems`.
- `SC-005`: `dart format .`, `flutter analyze` e `flutter test` passam sem regressões após a implementação.
- `SC-006`: O story do Dashbook para `PakiTextField` permite selecionar e visualizar ao menos uma combinação de botões ocultos.

## Escopo

- Adicionar o enum `PakiTextFieldToolbarItem`.
- Adicionar a propriedade `hiddenToolbarItems: List<PakiTextFieldToolbarItem>?` ao `PakiTextField`.
- Fazer com que a configuração da toolbar reflita os botões ocultos informados.
- Garantir comportamento idempotente para duplicatas e botões já ocultos pelo padrão.
- Atualizar o story do Dashbook (`example/main_dashbook.dart`) para demonstrar a propriedade.
- Garantir que `dart format .`, `flutter analyze` e `flutter test` continuem passando.

## Fora de escopo

- Adicionar novos botões à toolbar do `PakiTextField`.
- Alterar os botões que já estão ocultos pela configuração padrão do `QuillSimpleToolbarConfig`.
- Habilitar ou expor opções de alinhamento de texto (centro, direita, justificado, etc.).
- Alterar a versão da dependência `flutter_quill`.
- Modificar o comportamento das propriedades existentes `showToolbar`, `isEnabled`, `removeHorizontalDiv`, `onPlainTextChanged`, `validator`, `onSaved` ou `willValidate`.
- Criar testes de widget específicos para o `PakiTextField` (não existem hoje); a validação mínima continua sendo `flutter test`.

## Dependencias

- `flutter_quill: ^11.5.0` (já declarado no `pubspec.yaml`).
- `lib/src/widgets/paki_text_field.dart` (já existente).
- `example/main_dashbook.dart` (já existente).
- Padrão de desenvolvimento Flutter em `docs/sdd/templates/flutter.md`.

## Premissas

- O enum `PakiTextFieldToolbarItem` mapeará apenas os botões atualmente visíveis no `PakiTextField`; botões já ocultos pelo padrão não precisam de representação no enum.
- O nome da propriedade permanece `hiddenToolbarItems`, conforme refinement.
- A configuração padrão da toolbar (`QuillSimpleToolbarConfig` com `show* = false` para vários botões) não será alterada; a nova propriedade atua como camada adicional de ocultação sobre os botões visíveis.
- A propriedade `showToolbar` continua tendo precedência sobre `hiddenToolbarItems`.

## Rastreabilidade

- `FR-001`, `FR-002` -> `US-001` -> `AC-001`, `AC-002`, `AC-003` -> `SC-001`, `SC-002`.
- `FR-003`, `FR-004`, `FR-005` -> `US-001` -> `AC-004` -> `SC-003`.
- `FR-006` -> `US-001` -> `AC-005` -> `SC-004`.
- `FR-007` -> `US-002` -> `AC-006` -> `SC-006`.
- `NFR-001`, `NFR-002`, `NFR-003` -> `US-001`, `US-002` -> `AC-007` -> `SC-005`.

## Clarificacoes

Nenhuma marcacao `[NEEDS CLARIFICATION]` permanece nesta spec.

## Gate da Spec

`READY` somente com `checklist.md` aprovado.
<!-- sdd:section specs.spec-template:end -->
