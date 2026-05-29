# Implementation Plan: paki-rich-text-field

**Feature ID**: `TASK-001`  
**Jira Issue**: `SCRUM-148`  
**Spec**: `spec.md`  
**Stack**: `flutter`
**Projeto Jira/GitHub**: pakitec-components

## Contexto

Implementar a historia Jira `SCRUM-148` seguindo o contexto Pakitec do projeto:

- `AGENTS.md`
- `docs/pakitec-project-context.md`
- `docs/pakitec/constitution.md`
- `docs/pakitec/specs/TASK-001-scrum-148-paki-rich-text-field/jira-context.md`

## Abordagem

1. Confirmar que `Projeto` do Jira bate com o repo GitHub carregado na IDE; se nao bater, interromper.
2. Ler historia, criterios de aceite, `Visao do Usuario`, `Prototipo`, `Regras de Negocio`, `Detalhes Tecnicos` e anexos.
3. Mapear arquivos impactados antes de editar codigo.
4. Implementar em passos pequenos, preservando padroes locais.
5. Conferir o comportamento entregue contra `Visao do Usuario` e `Regras de Negocio`.
6. Rodar testes/lints relevantes.
7. Atualizar Jira com progresso, validacoes e pendencias.

## Contexto Jira para Planejamento

### Visao do Usuario

Precisamos criar uma tarefa no Jira para desenvolver um TextField com mais personalidade usando flutter_quill. A ideia é ter um campo melhor organizado, com mais propriedades para textos longos, porque um TextField com várias linhas não resolve. O novo componente precisa seguir o padrão de nomes dos componentes existentes, talvez PakiTextField, e manter o padrão visual dos demais inputs, como bordas.

### Prototipo

- Nenhum prototipo informado.

### Regras de Negocio

O novo componente deve seguir a identidade visual e o padrão de nomenclatura dos componentes Paki já existentes. A solução deve resolver o caso de textos longos e mais estruturados, evitando depender apenas de um TextField com múltiplas linhas. O uso de flutter_quill é a hipótese inicial para fornecer edição rica, mas deve ser confirmado contra compatibilidade, API, tema e impacto no pacote.

### Detalhes Tecnicos

Projeto carregado: pakitec-components Path local analisado: /Volumes/External HD/Projetos/pakitec/pakitec-components Stack inferida: flutter Estrutura observada: - LICENSE - assets - example - lib - web Arquivos relevantes encontrados: - README.md - pubspec.yaml
Flutter/pubspec snapshot: name: pakitec_components description: components from pakitec devs environment:   sdk: ">=2.15.0 <3.0.0"   flutter: ">=1.17.0" dependencies:   flutter:   flutter_localizations:   rive: 0.13.20   http: ^1.0.0   intl: ^0.20.2   flutter_placeholder_textlines: ^1.1.2   flutter_masked_text2: ^0.9.1   dropdown_search: ^5.0.6   flutter_colorpicker: ^1.1.0   pakitec_themes:   cupertino_icons: ^1.0.2 dev_dependencies:   dashbook: ^0.1.17   flutter_test:   flutter_lints: ^2.0.0   uses-material-design: true   assets:
Contexto Pakitec existente: # Pakitec Project Context
Este arquivo foi gerado pelo MCP Pakitec para orientar agentes antes de executar tarefas neste projeto.
## Regra de uso para agentes
Antes de alterar, criar, mover ou remover arquivos, consulte este documento e preserve a estrutura esperada para a stack `flutter`.
Fluxo obrigatório em projetos Pakitec:
1. Leia este arquivo. 2. Leia `docs/pakitec/constitution.md`, se existir. 3. Para feature nova ou alteração com regra de negócio, use uma pasta em `docs/pakitec/specs/`. 4. Se a pasta da feature ainda não existir, gere com a tool MCP `pakitec_bootstrap_feature_workflow`. 5. Compare a tarefa solicitada com a estrutura, convenções e validações abaixo. 6. Execute mudanças apenas dentro dos diretórios adequados para a stack. 7. Ao final, valide a estrutura com a tool MCP `pakitec_validate_project_structure`.
Se este projeto ainda não tiver `AGENTS.md`, `docs/pakitec/constitution.md` e `docs/pakitec/specs/README.md`, inicialize com a tool MCP `pakitec_init`.
## Subagentes Claude / OpenClaude
O `pakitec_init` também prepara subagentes SDD em `.claude/agents/` e documenta o fluxo em `.claude/SDD.md`.
Arquivos esperados:
```text .claude/ ├── SDD.md └── agents/     ├── sdd-orchestrator.md     ├── sdd-constitution.md     ├── sdd-spec-writer.md     ├── sdd-researcher.md     ├── sdd-planner.md     ├── sdd-task-breakdown.md     ├── sdd-implementer.md     └── sdd-qa-reviewer.md ```
Cada subagente é um Markdown com frontmatter YAML no formato Claude/OpenClaude, contendo `name`, `description`, `tools` e `model`.
Remapeamento Pakitec:
- `sdd-orchestrator`: LT Paki, coordena o fluxo completo. - `sdd-constitution`: LT Paki, governa padrões, restrições e critérios de qualidade. - `sdd-spec-writer`: LT Paki, escreve specs e critérios de aceite. - `sdd-researcher`: pesquisa técnica sem escrita. - `sdd-planner`: LT Paki, cria plano técnico e define ownership. - `sdd-task-breakdown`: LT Paki, quebra tarefas e atribui responsáveis. - `sdd-implementer`: J
README snapshot: # Pakitec Components
Pacote de componentes visuais reutilizáveis criado pela equipe da Pakitec, com foco em produtividade, consistência visual e facilidade de integração em projetos Flutter.
> 💡 Este pacote é privado e não está publicado no pub.dev. Para uso interno e por times autorizados.
---
## ✨ Principais recursos
- Conjunto de widgets prontos para uso: botões, campos de entrada, indicadores, diálogos, scaffold, e muito mais. - Padronização visual com suporte ao tema Pakitec (`pakitec_themes`) - Compatível com Flutter Web, Mobile e Desktop - Documentação interativa via [Dashbook](https://pub.dev/packages/dashbook)
---
## 🚀 Começando
### Pré-requisitos
- Flutter SDK 3.10 ou superior - Acesso ao repositório privado da Pakitec - Adicionado como dependência via Git:
```yaml dependencies:   pakitec_components:     git:       url: https://github.com/Pakitec/pakitec-components.git ```
---
## 📦 Estrutura
Este pacote oferece os seguintes componentes:
- `PakiButton` - `PakiNewBadge`
> Todos estão localizados em `lib/src/widgets/`.
---
## 🧪 Demonstração interativa (Dashbook)
Você pode visualizar e testar os componentes individualmente com controle dinâmico de propriedades.
### GitHub Pages
O playbook é publicado automaticamente no GitHub Pages a cada push na branch `master` pelo workflow [`deploy_playbook_pages.yml`](.github/workflows/deploy_playbook_pages.yml).
URL esperada:
```text https://flutter-components.pakitec.com.br/ ```
### Executar localmente:
```bash flutter pub get flutter run -d chrome -t example/main_dashbook.dart ```
---
## 🛠 Exemplo de uso
`dart PakiButton(   text: 'Enviar',   iconData: Icons.send,   onPressed: () => print('Enviado'),   width: 160,   height: 50, ) `
---
## 🎨 Tema escuro e claro
O pacote suporta alternância entre tema escuro e claro usando `Dashbook.dualTheme`. Os componentes se adaptam automaticamente ao tema ativo via `Theme.of(context)`.
---
## 📚 Documentação
- Exemplos práticos no diretório [`ex Leitura tecnica inicial: - A implementacao deve partir do projeto 'pakitec-components' e preservar os padroes locais detectados. - A demanda do usuario deve ser refinada em criterio de aceite antes de iniciar desenvolvimento. - Antes de executar, rodar pakitec_plan na issue criada para gerar TASK local, branch e contexto de implementacao.
Notas tecnicas informadas no prompt: Investigar os componentes de input já existentes no pacote para alinhar nomenclatura, tema, bordas, espaçamento e API pública. Avaliar flutter_quill como base para o editor rico. Implementar o novo componente reaproveitando padrões visuais existentes e expondo propriedades adequadas para textos longos. Adicionar exemplos no catálogo de componentes do projeto e validações/testes conforme o padrão atual. Prompt original resumido: Precisamos criar uma tarefa no Jira para desenvolver um TextField com mais personalidade usando flutter_quill. A ideia é ter um campo melhor organizado, com mais propriedades para textos longos, porque um TextField com várias linhas não resolve. O novo componente precisa seguir o padrão de nomes dos componentes existentes, talvez PakiTextField, e manter o padrão visual dos demais inputs, como bordas.
iremos usar o  https://pub.dev/packages/flutter_quill  , consulte a documentação dele. Vamos criar um componente básico de informações, centralizar, alinhar, negrito, italico, essas coisas, o mais simples possivel, um editor de textos simples mas ainda muito superior ao inputText que usamos para outras coisas

## Areas Impactadas

- `pubspec.yaml`: adicionar `flutter_quill` como dependência do pacote.
- `lib/src/widgets/paki_text_field.dart`: criar o componente `PakiTextField` com editor rico simples.
- `lib/pakitec_components.dart`: exportar o novo componente público.
- `example/main_dashbook.dart`: adicionar story Dashbook para demonstrar uso básico e variações.
- `docs/pakitec/specs/TASK-001-scrum-148-paki-rich-text-field/tasks.md`: registrar progresso SDD.

## Validacoes

- `flutter pub get`
- `flutter analyze`
- `flutter test`
- `pakitec_validate_project_structure` quando houver mudanca estrutural.

## Riscos

- Campo customizado ou anexo pode conter requisito nao refletido na descricao principal.
- Implementar no projeto errado invalida a entrega; conferir o repo antes de planejar.
- Prototipo pode ser opcional, mas quando existir deve guiar telas/fluxos de front ou app.
- Status/transitions do Jira podem variar por projeto.
- Subtasks geradas sao fases SDD e podem precisar de detalhamento adicional durante a implementacao.
