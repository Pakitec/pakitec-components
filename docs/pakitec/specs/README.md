# Pakitec Specs

Esta pasta guarda especificações, planos e tarefas por feature.

Antes de criar ou implementar uma feature, leia:

- `AGENTS.md`
- `docs/pakitec-project-context.md`
- `docs/pakitec/constitution.md`

Fluxo recomendado:

1. Crie uma pasta por feature com `pakitec_bootstrap_feature_workflow`.
2. Preencha `spec.md` com o problema, histórias de usuário e critérios de sucesso.
3. Preencha `plan.md` com arquitetura, arquivos impactados e validações.
4. Registre decisões técnicas em `research.md`.
5. Quebre o plano em `tasks.md`, mantendo IDs, paths e checkpoints.
6. Use `checklist.md` para revisar clareza, escopo, testes e aderência ao padrão Pakitec antes de implementar.

Estrutura esperada:

```text
docs/pakitec/specs/
└── 001-nome-da-feature/
    ├── spec.md
    ├── plan.md
    ├── research.md
    ├── tasks.md
    └── checklist.md
```

## Quando Criar Uma Spec

Crie uma spec para:

- feature nova;
- mudança com regra de negócio;
- alteração que envolve múltiplos arquivos ou módulos;
- integração externa;
- mudança de dados, permissão, assinatura, cobrança ou autenticação;
- UI relevante para fluxo de usuário.

Uma correção pequena e isolada pode ser feita sem spec dedicada, desde que siga `AGENTS.md` e o contexto Pakitec.
