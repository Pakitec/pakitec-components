---
description: Executar um planejamento SDD aprovado, sincronizando subtarefas Jira e QA.
argument-hint: <ISSUE-KEY>
allowed-tools: Read, Glob, Grep, Bash, Write, Edit, Agent, mcp__pakitec-cloud-mcp__jira_get_workspace_binding, mcp__pakitec-cloud-mcp__jira_list_profiles, mcp__pakitec-cloud-mcp__jira_bind_workspace, mcp__pakitec-cloud-mcp__jira_get_issue, mcp__pakitec-cloud-mcp__jira_list_attachments, mcp__pakitec-cloud-mcp__jira_edit_task, mcp__pakitec-cloud-mcp__jira_record_sdd_event, jira_get_workspace_binding, jira_list_profiles, jira_bind_workspace, jira_get_issue, jira_list_attachments, jira_edit_task, jira_record_sdd_event
---

<!-- sdd:section command.sdd-build:start -->
Voce esta executando `/sdd-build` para implementar uma issue Jira planejada. Entrada: `$ARGUMENTS`.

Regras obrigatorias:

1. Extraia exatamente uma chave `PROJ-123` e execute o `JIRA_GATE` antes de ler ou alterar o workflow: resolva o vinculo; se ausente, permita escolha assistida, vincule e valide novamente. Sem Jira valido, encerre sem executar codigo.
2. Leia a issue, confirme o projeto vinculado e somente entao abra constituicao e `docs/sdd/specs/<ISSUE-KEY>/workflow.json`.
3. Recuse a execucao quando o workflow nao existir, nao registrar `refinement.verdict: "PASS"`, nao possuir checklist aprovado, contiver `NEEDS CLARIFICATION`, estiver `BLOCKED` ou nunca tiver atingido `READY_TO_BUILD`; indique `/sdd-plan <ISSUE-KEY>`.
4. Migre workflow v1 para v2 preservando dados. Antes de trabalhar, descarregue todos os `pendingJiraEvents`; falha impede retomada.
5. Valide anexos e hashes. Mudanca material exige novo `/sdd-plan`.
6. Capture `buildStartedAt` em ISO-8601 com timezone no momento de inicio real do build, persista no `workflow.json` e registre `PHASE_STARTED` no pai com eventKey `<ISSUE>/<runId>/r<revision>/build/started`, `targetStatus: inProgress` e o horario de inicio no resumo.
7. Delegue exatamente `sdd-orchestrator` em modo BUILD. Para cada `TASK-*`, use exclusivamente `subagent_type: "sdd-implementer"`; nunca `code` ou fallback direto.
8. Antes do agente, capture e persista `startedAt` na entrada da tarefa e registre `TASK_STARTED` na subtarefa com `targetStatus: inProgress`. Depois, capture `finishedAt`, observacao final e status; registre `TASK_COMPLETED` com arquivos e validacoes e `targetStatus: done` apenas quando tudo passar.
9. Depois de cada retorno, consolide evidencias no `workflow.json`, incluindo horarios explicitos por tarefa. Se o agente criou worktree isolado, integre/mergeie as alteracoes aprovadas na branch de trabalho atual antes de marcar a tarefa como concluida. Nao repita tarefa concluida; bloqueios reais devem ser registrados na subtarefa correspondente.
10. Em qualquer erro, capture `buildFinishedAt` em ISO-8601 com timezone, registre `TASK_BLOCKED` ou `TASK_FAILED` na subtarefa e `BUILD_BLOCKED` no pai; mantenha a subtarefa aberta e pare imediatamente. O comentario final do `BUILD_BLOCKED` deve informar `Inicio do build: <buildStartedAt>` e `Fim do build: <buildFinishedAt>`.
11. Para QA, capture `qa.startedAt`, registre `QA_STARTED` na subtarefa e no pai, usando `codeReview` no pai quando disponivel; delegue exclusivamente `sdd-qa-reviewer`. Ao terminar, persista `qa.finishedAt`, status e observacao.
12. `QA_FAILED` mantem cards abertos e bloqueia. Somente `QA_PASSED` conclui a subtask. Antes de `BUILD_COMPLETED`, confirme que todas as alteracoes dos worktrees dos agentes foram mergeadas na branch de trabalho atual e remova os worktrees temporarios criados para o build. Se algum worktree tiver alteracao nao consolidada, registre `BUILD_BLOCKED` e pare. Depois capture `buildFinishedAt` em ISO-8601 com timezone e persista no `workflow.json`.
13. Registre o ultimo evento do pai como `BUILD_COMPLETED`, com `targetStatus: done`, `Inicio do build: <buildStartedAt>` e `Fim do build: <buildFinishedAt>`. Inclua `report` com `runId`, `planRevision`, os dois horarios do build, uma linha para cada `TASK-*` e uma linha de QA, usando os `startedAt`/`finishedAt` persistidos, observacoes curtas, status final, validacoes executadas e observacoes gerais. A tool salva o dashboard PNG em `docs/sdd/specs/<ISSUE-KEY>/report/` e publica no Jira somente o resumo textual com tempos, tarefas, QA, validacoes e path local da imagem; falha do relatorio retorna aviso, mas nao reverte nem bloqueia o build concluido. Nao envie `report` em `BUILD_BLOCKED`.

Retry: nao use `run_in_background` ao delegar agentes que precisam de Jira MCP. Somente timeout, rede, `429` ou `5xx`, uma vez, com mesmo agente/eventKey. Tool MCP ausente, erro de tipo de agente, permissao, input, artefato, teste ou validacao e definitivo. Falha Jira obrigatoria entra em `pendingJiraEvents` somente quando for temporaria; ausencia de tool MCP retorna `BLOCKED:MCP_UNAVAILABLE` e interrompe. Nenhuma fase avanca sem comentario/transicao confirmados.

Nao altere escopo aprovado durante o build. Ao final, informe tarefas executadas, arquivos, comandos, evidencias, estados Jira, path local do dashboard ou seu aviso nao bloqueante, pendencias, worktrees removidos, `buildStartedAt` e `buildFinishedAt`.
<!-- sdd:section command.sdd-build:end -->
