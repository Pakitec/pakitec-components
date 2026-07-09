---
description: Especificar e planejar uma issue Jira com agentes SDD, sem implementar codigo.
argument-hint: <ISSUE-KEY>
allowed-tools: Read, Glob, Grep, Bash, Write, Edit, Agent, mcp__pakitec-cloud-mcp__jira_get_workspace_binding, mcp__pakitec-cloud-mcp__jira_list_profiles, mcp__pakitec-cloud-mcp__jira_bind_workspace, mcp__pakitec-cloud-mcp__jira_get_issue, mcp__pakitec-cloud-mcp__jira_list_attachments, mcp__pakitec-cloud-mcp__jira_read_attachment, mcp__pakitec-cloud-mcp__jira_create_subtask, mcp__pakitec-cloud-mcp__jira_edit_task, mcp__pakitec-cloud-mcp__jira_record_sdd_event, jira_get_workspace_binding, jira_list_profiles, jira_bind_workspace, jira_get_issue, jira_list_attachments, jira_read_attachment, jira_create_subtask, jira_edit_task, jira_record_sdd_event
---

<!-- sdd:section command.sdd-plan:start -->
Voce esta executando `/sdd-plan` para planejar uma issue Jira. Entrada: `$ARGUMENTS`.

Regras obrigatorias:

1. Extraia exatamente uma chave no formato `PROJ-123`. Se estiver ausente ou ambigua, pergunte antes de continuar.
2. Execute o `JIRA_GATE` antes de criar ou alterar `docs/sdd/specs`: chame `jira_get_workspace_binding`. Se nao houver vinculo, liste perfis, pergunte qual perfil/projeto usar, vincule e valide novamente. Sem contexto Jira valido, encerre sem gerar planejamento local.
3. Leia a issue, recuse projeto divergente e calcule um hash normalizado. Antes de qualquer analise, chame `jira_record_sdd_event` no pai com `eventKey: <ISSUE>/plan/<hash12>/started`, `eventType: PLAN_STARTED`, `targetStatus: inProgress` e o proximo passo. Falha deste checkpoint bloqueia o comando.
4. Consulte anexos. Nesta fase, leia os relevantes diretamente do Jira apenas para avaliacao; nao crie diretorio, asset, spec, workflow ou subtarefa.
5. Leia `.claude/agents/sdd-refinement-reviewer.md` e delegue usando exatamente `subagent_type: "sdd-refinement-reviewer"`. Nunca use `code`, `developer` ou agente generico.
6. Se o veredito for `BLOCKED`, registre `PLAN_BLOCKED` no pai com a mesma revisao, blockers e proximo passo; pare antes de qualquer escrita local ou subtarefa.
6. Para refinar, colete respostas do usuario e mostre um patch Jira proposto. Somente apos confirmacao explicita use `jira_edit_task`; depois releia a issue e repita o `REFINEMENT_GATE` completo. Resposta em chat sem persistencia no Jira nao libera o planejamento.
7. O gate so passa com zero blockers, zero `NEEDS CLARIFICATION`, criterios verificaveis e anexos obrigatorios acessiveis. Warnings aceitos devem virar premissas explicitas e reversiveis.
8. Somente apos `REFINEMENT_GATE: PASS`, leia os padroes e crie/retome a pasta. Inicialize ou migre `workflow.json` schema v2 com `runId`, `planRevision`, `attempts`, `eventLedger` e `pendingJiraEvents`.
9. Execute `ATTACHMENT_INGEST`: baixe todos os anexos listados para `assets/`. Use `<attachmentId>-<nome-saneado>`, removendo diretorios, controles e caracteres fora de `[A-Za-z0-9._-]`; nunca sobrescreva IDs diferentes.
10. Grave texto em UTF-8 e decodifique binarios Base64 sem imprimir conteudo em logs. Calcule SHA-256 e gere `assets/manifest.json` com ID, nome original, path relativo, MIME, tamanhos, hash, status e erro seguro. Nunca execute anexos.
11. Antes dos agentes, delegue exatamente `sdd-jira-coordinator` para criar/reconciliar `[SDD][SPEC] Specification`, `[SDD][RESEARCH] Technical Research` e `[SDD][PLAN] Technical Plan`.
12. Leia `sdd-orchestrator.md` e delegue exatamente `sdd-orchestrator` em modo PLAN. Para cada agente, o orquestrador deve transicionar/comentar a subtarefa com `TASK_STARTED` antes da chamada e `TASK_COMPLETED` somente após artefato/check aprovado.
13. A sequencia exata e `sdd-spec-writer`, `sdd-researcher`, `sdd-planner`; depois `sdd-jira-coordinator` reconcilia as `TASK-*`. Spec com `NEEDS CLARIFICATION` registra falha e volta ao refinement.
14. Nao edite codigo, nao crie branch e nao invoque implementador ou QA neste comando.
15. Grave `phase: "READY_TO_BUILD"` somente com refinement PASS, checklist PASS, documentos completos, hashes consistentes e subtarefas reconciliadas.

Protocolo fail-fast: nao use `run_in_background` ao delegar agentes que precisam de Jira MCP. Timeout, rede, `429` ou `5xx` permitem uma unica repeticao com o mesmo agente e `eventKey`. Tool MCP ausente, `Agent type not found`, permissao, input invalido, artefato ausente, validacao FAIL ou segunda falha registram `TASK_FAILED`/`PLAN_BLOCKED`, adicionam `pendingJiraEvents` se o Jira estiver temporariamente indisponivel e interrompem. Nunca continue parcialmente nem implemente como fallback.

Ao final, resuma documentos, decisoes, riscos, subtarefas e bloqueios. Quando estiver pronto, indique `/sdd-build <ISSUE-KEY>`.
<!-- sdd:section command.sdd-plan:end -->
