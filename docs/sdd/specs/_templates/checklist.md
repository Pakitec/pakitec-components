# Checklist de Qualidade ISSUE-KEY

<!-- sdd:section specs.checklist-template:start -->
## Refinement Gate

- [ ] Jira e projeto foram validados.
- [ ] `REFINEMENT_GATE: PASS` corresponde ao hash atual da issue.
- [ ] Nao existem blockers ou `NEEDS CLARIFICATION`.
- [ ] Anexos obrigatorios estao acessiveis e coerentes.

## Specification Quality

- [ ] Problema, atores, objetivo e valor estao claros.
- [ ] Spec descreve o que/por que, sem detalhes de implementacao.
- [ ] Jornadas `US-*` estao priorizadas e entregam valor independente.
- [ ] Cada jornada possui teste independente.
- [ ] Cenarios usam Dado/Quando/Entao ou equivalente observavel.
- [ ] `FR-*` sao especificos, testaveis e sem ambiguidade.
- [ ] `NFR-*` relevantes sao mensuraveis.
- [ ] Entidades, dados e integracoes relevantes foram definidos.
- [ ] Edge cases e estados de erro foram considerados.
- [ ] Criterios `SC-*` sao mensuraveis e independentes de tecnologia.
- [ ] Fora de escopo, dependencias e premissas estao explicitos.
- [ ] Nao existem placeholders vagos ou contradicoes.

## Planning Quality

- [ ] Constitution Check foi aprovado.
- [ ] Plano referencia paths reais e justifica dependencias/desvios.
- [ ] Seguranca, privacidade, observabilidade, rollout e rollback foram avaliados.
- [ ] Tarefas possuem IDs estaveis, ownership, paths e validacao.
- [ ] Tarefas `[P]` nao compartilham arquivos ou dependencias.
- [ ] Cada jornada termina em checkpoint independente.

Qualquer item obrigatorio desmarcado impede `READY_TO_BUILD`.
<!-- sdd:section specs.checklist-template:end -->
