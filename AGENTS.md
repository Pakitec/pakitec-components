<!-- pakitec-sdd:start -->
## Instrumentação SDD

Antes de planejar, implementar, revisar ou criar arquivos:

1. Leia `docs/constitution.md` e todos os templates obrigatórios referenciados por ela em `docs/sdd/templates/`.
2. Para features novas ou mudanças com regra de negócio, use uma spec em `docs/sdd/specs/<ISSUE-KEY>/`. Se ainda não existir issue refinada, comece por `/sdd-task` e depois execute `/sdd-plan ISSUE-KEY`.
3. Preserve as regras específicas do projeto escritas fora deste bloco; elas prevalecem quando forem mais restritivas.
4. Atualize `docs/constitution.md` quando uma decisão arquitetural aprovada mudar.
5. Use os subagentes em `.claude/agents/` quando estiverem disponíveis: `sdd-orchestrator`, `sdd-refinement-reviewer`, `sdd-spec-writer`, `sdd-researcher`, `sdd-planner`, `sdd-jira-coordinator`, `sdd-implementer` e `sdd-qa-reviewer`.

O fluxo operacional exige `JIRA_GATE`: sem workspace vinculado a um perfil e projeto Jira válidos, não execute nem produza artefatos de `/sdd-task`, `/sdd-plan` ou `/sdd-build`.
<!-- pakitec-sdd:end -->
