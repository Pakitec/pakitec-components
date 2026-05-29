# SDD Workflow Pakitec

Projeto: pakitec-components

Este projeto usa agentes Claude em `.claude/agents` para executar SDD - Specification Driven Development - no formato Pakitec.

## Remapeamento do prompt SDD original

| Prompt original | Agente Claude gerado | Remapeamento Pakitec |
| --- | --- | --- |
| `sdd-orchestrator` | `sdd-orchestrator` | LT Paki coordena o fluxo completo. |
| `sdd-constitution` | `sdd-constitution` | LT Paki governa padroes e restricoes reutilizaveis. |
| `sdd-spec-writer` | `sdd-spec-writer` | LT Paki transforma demanda em spec e criterios de aceite. |
| `sdd-researcher` | `sdd-researcher` | Investigacao tecnica sem escrita antes do plano. |
| `sdd-planner` | `sdd-planner` | LT Paki define design tecnico e ownership. |
| `sdd-task-breakdown` | `sdd-task-breakdown` | LT Paki quebra tarefas e atribui Joe/Tatu/Amora. |
| `sdd-implementer` | `sdd-implementer` | Usado como Joe para frontend/Flutter/web/UI e Tatu para backend/Node/APIs/dados. |
| `sdd-qa-reviewer` | `sdd-qa-reviewer` | Amora valida com verdict PASS, FAIL ou PARTIAL. |

## Agentes

1. `sdd-orchestrator`
   - Conduz o fluxo completo e atua como LT Paki.
   - Decide quando acionar constitution, spec, research, plan, tasks, implementer e QA.

2. `sdd-constitution`
   - Mantem principios, padroes tecnicos, seguranca e criterios de qualidade.

3. `sdd-spec-writer`
   - Cria especificacoes, escopo, fora de escopo e criterios de aceite.

4. `sdd-researcher`
   - Pesquisa codigo, padroes, dependencias, riscos e integracoes sem editar.

5. `sdd-planner`
   - Converte spec e pesquisa em plano tecnico incremental.

6. `sdd-task-breakdown`
   - Quebra plano em tarefas pequenas, verificaveis e atribuidas.

7. `sdd-implementer`
   - Implementa tarefas aprovadas.
   - Atua como Joe quando a tarefa for frontend/Flutter/web/UI.
   - Atua como Tatu quando a tarefa for backend/Node/APIs/dados/integracoes.

8. `sdd-qa-reviewer`
   - Atua como Amora.
   - Verifica criterios de aceite, testes, build, lint, seguranca e regressao.
   - Retorna verdict: PASS, FAIL ou PARTIAL.

## Fases

1. Spec
   - Entender pedido.
   - Criar requisitos funcionais e nao funcionais.
   - Definir escopo, fora de escopo e criterios de aceite.

2. Design
   - Mapear codigo impactado.
   - Definir abordagem tecnica.
   - Planejar testes e identificar riscos.

3. Tasks
   - Quebrar o trabalho em tarefas pequenas.
   - Definir ownership de cada tarefa.

4. Implementation
   - Implementar uma tarefa por vez.
   - Manter escopo controlado.
   - Preservar mudancas existentes que nao sejam do agente.

5. Verification
   - Rodar testes/build/lint quando disponiveis.
   - Validar criterios de aceite e regras de negocio.

6. Review
   - Revisar qualidade, simplicidade, aderencia ao escopo e evidencias.

## Regras

- Nunca implementar antes de ter criterios de aceite para trabalho nao trivial.
- Nunca alterar codigo sem ler os arquivos relevantes.
- Nunca expandir escopo sem aprovacao.
- Preferir mudancas pequenas e rastreaveis.
- Toda implementacao nao trivial precisa de verificacao independente.
- O verificador deve retornar PASS, FAIL ou PARTIAL.
- Em caso de FAIL, corrigir e verificar novamente.
- No `pakitec_build`, nao pedir confirmacao entre fases; avance automaticamente salvo bloqueio real.

## Como usar

Para uma nova feature:

> Use o fluxo SDD Pakitec para implementar: <descricao da feature>

Para bugfix:

> Use SDD Pakitec para diagnosticar e corrigir: <descricao do bug>

Para apenas planejar:

> Use SDD Pakitec ate a fase de Tasks, sem implementar.
