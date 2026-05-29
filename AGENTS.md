# Agent Instructions

<!-- pakitec-mcp:start -->
## Instruções Pakitec MCP

Antes de alterar código, estrutura, dependências ou documentação técnica neste projeto:

1. Leia `docs/pakitec-project-context.md`.
2. Leia `docs/pakitec/constitution.md`, se existir.
3. Para features novas ou mudanças com regra de negócio, use ou crie uma spec em `docs/pakitec/specs/` com a tool MCP `pakitec_bootstrap_feature_workflow`.
4. Siga a estrutura, convenções e regras de validação da stack descritas no contexto Pakitec.
5. Em projetos Flutter, use componentes do pacote `pakiComponents` sempre que existir componente equivalente.
6. Depois de mudanças estruturais, valide com a tool MCP `pakitec_validate_project_structure`.

## Subagentes Claude / OpenClaude

Quando este projeto tiver `.claude/agents/`, use os subagentes SDD gerados pelo `pakitec_init`:

- `sdd-orchestrator`: conduz o fluxo completo e atua como LT Paki.
- `sdd-constitution`: revisa princípios, padrões, restrições e critérios de qualidade.
- `sdd-spec-writer`: cria ou revisa especificação e critérios de aceite.
- `sdd-researcher`: pesquisa código, dependências, padrões e riscos sem editar arquivos.
- `sdd-planner`: transforma spec e pesquisa em plano técnico.
- `sdd-task-breakdown`: quebra o plano em tarefas pequenas e atribuíveis.
- `sdd-implementer`: implementa tarefas aprovadas; atua como Joe em frontend/Flutter/web/UI e como Tatu em backend/Node/APIs/dados.
- `sdd-qa-reviewer`: atua como Amora, valida a entrega e retorna `PASS`, `FAIL` ou `PARTIAL`.

Leia `.claude/SDD.md` para o mapa completo do fluxo SDD Pakitec. Se os subagentes forem criados durante a sessão atual, reinicie a sessão do Claude/OpenClaude para carregá-los.

Se a estrutura Pakitec ainda não existir neste projeto, execute primeiro a tool MCP `pakitec_init`.
<!-- pakitec-mcp:end -->

