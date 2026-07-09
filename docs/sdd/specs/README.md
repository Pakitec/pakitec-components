# Especificacoes SDD

<!-- sdd:section specs.workflow-contract:start -->
Cada issue usa um diretorio `docs/sdd/specs/<ISSUE-KEY>/` com:

```text
issue.md
spec.md
checklist.md
research.md
plan.md
tasks.md
qa.md
workflow.json
assets/
  manifest.json
  <attachmentId>-<nome-saneado>
```

Antes do refinement PASS, esta pasta da issue nao deve ser criada. Depois do gate, copie os arquivos Markdown de `_templates/`. Conteudo existente sempre deve ser preservado e atualizado incrementalmente.

## Gate Jira

Nenhum diretorio de issue, `workflow.json`, planejamento ou build pode ser iniciado sem `jira_get_workspace_binding` validado e a issue confirmada no projeto vinculado. O `sdd_init` pode instalar estes templates sem Jira; `/sdd-task`, `/sdd-plan` e `/sdd-build` nao podem operar sem ele.

## Workflow

`workflow.json` e o checkpoint retomavel e deve ser JSON valido:

```json
{
  "schemaVersion": 2,
  "issueKey": "PROJ-123",
  "runId": "uuid",
  "planRevision": 1,
  "workspacePath": "/caminho/absoluto",
  "phase": "SPEC",
  "lastStablePhase": "SPEC",
  "buildStartedAt": "ISO-8601",
  "buildFinishedAt": "ISO-8601",
  "jira": { "profileId": "perfil", "projectKey": "PROJ" },
  "refinement": { "verdict": "PASS", "issueHash": "sha256", "checkedAt": "ISO-8601", "warnings": [] },
  "hashes": { "issue": "sha256", "assetsManifest": "sha256", "spec": "sha256", "checklist": "sha256", "research": "sha256", "plan": "sha256", "tasks": "sha256" },
  "subtasks": { "TASK-001": { "issueKey": "PROJ-124", "status": "pending", "owner": "sdd-implementer", "startedAt": null, "finishedAt": null, "observation": null } },
  "qa": { "issueKey": "PROJ-125", "status": "pending", "startedAt": null, "finishedAt": null, "observation": null },
  "attempts": { "TASK-001": 1 },
  "eventLedger": { "event-key": { "issueKey": "PROJ-124", "eventType": "TASK_STARTED", "commentId": "10000", "recordedAt": "ISO-8601" } },
  "pendingJiraEvents": [],
  "blockers": [],
  "validations": [],
  "updatedAt": "ISO-8601"
}
```

Fases permitidas: `SPEC`, `RESEARCH`, `PLAN`, `JIRA_SYNC`, `BLOCKED`, `READY_TO_BUILD`, `BUILD`, `QA`, `DONE`.

Somente o `sdd-orchestrator` escreve `workflow.json`. Workflows v1 sao migrados para v2 preservando dados. Antes de retomar, envie `pendingJiraEvents`; falha bloqueia. Nenhuma fase avanca sem evento Jira confirmado no `eventLedger`. O refinement PASS deve corresponder ao hash atual da issue.

Durante BUILD, `buildStartedAt`, `buildFinishedAt`, `subtasks.*.startedAt`, `subtasks.*.finishedAt`, `subtasks.*.observation` e os campos equivalentes de `qa` sao a fonte dos horarios do relatorio. Registre-os em ISO-8601 com timezone no momento real de cada transicao; nao derive esses valores posteriormente dos comentarios Jira.

## Protocolo de progresso

- Pai: `PLAN_STARTED`, `PLAN_BLOCKED`, inicio do build, `QA_STARTED`, `BUILD_BLOCKED` e `BUILD_COMPLETED`.
- Subtask: evento de inicio antes do agente; bloqueio/falha imediato; conclusao somente depois de validacao.
- `eventKey` usa issue, `runId`, revisao, tarefa, tentativa e evento. Reutilize a mesma chave em retry.
- Somente rede, timeout, 429 e 5xx permitem uma repeticao. Configuracao, permissao, agente inexistente, artefato ou validacao bloqueiam imediatamente.
- Comentarios incluem paths relativos, validacoes resumidas, blockers e proximo passo; nunca logs brutos, diff, Base64 ou segredos.
- O ultimo `BUILD_COMPLETED` inclui `report` estruturado. O MCP renderiza PNG 4K, divide tabelas longas em paginas e salva a imagem em `docs/sdd/specs/<ISSUE-KEY>/report/`. O Jira recebe somente resumo textual com tempos, tarefas, QA, validacoes e path local da imagem. Falha da imagem local gera aviso nao bloqueante. `BUILD_BLOCKED` nunca inclui relatorio.

## Fluxo Spec Kit

1. Avalie Jira e anexos sem criar arquivos.
2. Bloqueie e refine a historia enquanto houver `NEEDS CLARIFICATION`.
3. Persista as respostas no Jira e repita toda a avaliacao.
4. Somente com refinement PASS crie issue snapshot, assets, spec e checklist.
5. Spec descreve comportamento e valor; research/plan descrevem tecnologia.
6. Checklist reprovado volta para spec ou refinement, conforme a origem do gap.
7. Tasks sao organizadas por jornada independente e checkpoints.

## Manifesto de assets

`assets/manifest.json` registra todos os anexos retornados pelo Jira, inclusive falhas:

```json
{
  "schemaVersion": 1,
  "issueKey": "PROJ-123",
  "capturedAt": "ISO-8601",
  "attachments": [
    {
      "attachmentId": "10001",
      "originalName": "contrato.pdf",
      "localPath": "assets/10001-contrato.pdf",
      "mimeType": "application/pdf",
      "jiraSize": 12345,
      "localSize": 12345,
      "sha256": "hex",
      "status": "downloaded",
      "error": null
    }
  ]
}
```

Use sempre o ID como prefixo, nunca confie no nome como caminho e nao execute anexos. `status` pode ser `downloaded`, `skipped` ou `failed`. Anexo necessario com status diferente de `downloaded` bloqueia o planejamento.

## Rastreabilidade

- Requisitos funcionais: `FR-001`.
- Requisitos nao funcionais: `NFR-001`.
- Criterios/cenarios de aceite: `AC-001`.
- Tarefas executaveis: `TASK-001`.
- Subtarefas Jira: `[SDD][TASK-001] Titulo`.

Cada tarefa referencia requisitos e criterios. Cada evidencia de QA referencia criterios e comandos executados.
<!-- sdd:section specs.workflow-contract:end -->
