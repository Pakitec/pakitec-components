# Pakitec Project Context

Este arquivo foi gerado pelo MCP Pakitec para orientar agentes antes de executar tarefas neste projeto.

## Regra de uso para agentes

Antes de alterar, criar, mover ou remover arquivos, consulte este documento e preserve a estrutura esperada para a stack `flutter`.

Fluxo obrigatório em projetos Pakitec:

1. Leia este arquivo.
2. Leia `docs/pakitec/constitution.md`, se existir.
3. Para feature nova ou alteração com regra de negócio, use uma pasta em `docs/pakitec/specs/`.
4. Se a pasta da feature ainda não existir, gere com a tool MCP `pakitec_bootstrap_feature_workflow`.
5. Compare a tarefa solicitada com a estrutura, convenções e validações abaixo.
6. Execute mudanças apenas dentro dos diretórios adequados para a stack.
7. Ao final, valide a estrutura com a tool MCP `pakitec_validate_project_structure`.

Se este projeto ainda não tiver `AGENTS.md`, `docs/pakitec/constitution.md` e `docs/pakitec/specs/README.md`, inicialize com a tool MCP `pakitec_init`.

## Subagentes Claude / OpenClaude

O `pakitec_init` também prepara subagentes SDD em `.claude/agents/` e documenta o fluxo em `.claude/SDD.md`.

Arquivos esperados:

```text
.claude/
├── SDD.md
└── agents/
    ├── sdd-orchestrator.md
    ├── sdd-constitution.md
    ├── sdd-spec-writer.md
    ├── sdd-researcher.md
    ├── sdd-planner.md
    ├── sdd-task-breakdown.md
    ├── sdd-implementer.md
    └── sdd-qa-reviewer.md
```

Cada subagente é um Markdown com frontmatter YAML no formato Claude/OpenClaude, contendo `name`, `description`, `tools` e `model`.

Remapeamento Pakitec:

- `sdd-orchestrator`: LT Paki, coordena o fluxo completo.
- `sdd-constitution`: LT Paki, governa padrões, restrições e critérios de qualidade.
- `sdd-spec-writer`: LT Paki, escreve specs e critérios de aceite.
- `sdd-researcher`: pesquisa técnica sem escrita.
- `sdd-planner`: LT Paki, cria plano técnico e define ownership.
- `sdd-task-breakdown`: LT Paki, quebra tarefas e atribui responsáveis.
- `sdd-implementer`: Joe para frontend/Flutter/web/UI ou Tatu para backend/Node/APIs/dados, conforme ownership.
- `sdd-qa-reviewer`: Amora, valida com verdict `PASS`, `FAIL` ou `PARTIAL`.

Se os subagentes forem criados diretamente no disco durante a sessão atual, reinicie a sessão do Claude/OpenClaude para carregá-los.

## Fluxo de Feature

Use este fluxo para mudanças relevantes:

1. `spec.md`: descreva objetivo, usuários, histórias, requisitos, critérios de sucesso e fora de escopo.
2. `plan.md`: defina abordagem técnica, arquivos impactados, dependências, riscos e validações.
3. `research.md`: registre decisões que dependem de bibliotecas, APIs, plataforma ou tradeoffs.
4. `tasks.md`: quebre em tarefas com IDs, paths reais e checkpoints por história.
5. `checklist.md`: revise clareza, aderência ao padrão Pakitec e testes antes de implementar.

Mudanças pequenas, como correções pontuais sem regra de negócio nova, podem dispensar uma spec dedicada, mas ainda devem seguir este contexto.

## Template

- Stack: `flutter`
- Nome: Pakitec Flutter App Template
- Repositório-base: Pakitec/pakitec-template_app_flutter
- Branch-base: `master`
- URL: https://github.com/Pakitec/pakitec-template_app_flutter

## Diretórios obrigatórios

- `android`
- `ios`
- `lib`
- `assets`
- `test`

## Arquivos obrigatórios

- `pubspec.yaml`
- `analysis_options.yaml`
- `README.md`
- `lib/main.dart`

## Diretórios recomendados

- `lib/models`
- `lib/screens`
- `assets/images`
- `assets/animations`

## Arquivos opcionais

- `lib/firebase_options.dart`
- `pubspec.lock`
- `.metadata`

## Convenções

```json
{
  "runtime": "flutter",
  "packageManager": "flutter pub",
  "entrypoint": "lib/main.dart",
  "localization": {
    "required": false,
    "file": "l10n.yaml"
  },
  "notes": [
    "Base project uses Firebase, notifications, scoped_model, and Pakitec shared packages.",
    "New generated projects should treat Firebase credentials as project-specific material.",
    "Flutter UI must always use components from the pakiComponents package when an equivalent component exists."
  ]
}
```

## Regras Específicas da Stack

- Preserve os diretórios e arquivos obrigatórios listados abaixo.
- Não crie pastas de código fora da área esperada pela stack.
- Documente qualquer exceção no `plan.md` da feature.
- Em Flutter, use sempre `pakiComponents` quando existir componente equivalente antes de criar UI customizada.

## Regras de validação

### Campos em arquivos

- Flutter package name must use snake_case.
- pubspec.yaml must declare Flutter SDK dependency.
- pubspec.yaml must keep uses-material-design enabled.

### Caminhos obrigatórios

- Flutter projects must keep Dart source files inside lib/.

### Caminhos proibidos

- Flutter source folders must not exist at the repository root; keep them inside lib/.

### Nomes de arquivos e diretórios

- Flutter directories inside lib/ must use snake_case.
- Flutter Dart files inside lib/ must use snake_case.
