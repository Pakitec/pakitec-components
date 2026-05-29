# pakitec-components Constitution

Este documento define os princípios de execução para agentes e pessoas trabalhando neste projeto.

## Princípios

### 1. Padrão Pakitec Primeiro

Toda mudança deve respeitar o template Pakitec da stack `flutter`, incluindo diretórios, arquivos obrigatórios, convenções e regras de validação.

### 2. Especificação Antes da Implementação

Features relevantes devem começar com uma especificação em `docs/pakitec/specs/`, contendo problema, usuários, histórias, requisitos, critérios de aceite, riscos e fora de escopo.

Use a tool MCP `pakitec_bootstrap_feature_workflow` para criar a estrutura inicial da feature.

### 3. Plano Técnico Verificável

Antes de editar código, registre a abordagem técnica, arquivos impactados, dependências, testes e comandos de validação esperados.

O plano deve deixar claro quais arquivos serão criados ou alterados e como a entrega será validada.

### 4. Entrega Incremental

Divida tarefas por histórias de usuário independentes sempre que possível. Cada história deve ter um checkpoint verificável e não deve quebrar histórias já entregues.

### 5. UI Consistente

Em projetos Flutter, use sempre componentes do pacote `pakiComponents` quando existir componente equivalente. Só crie componente customizado quando houver lacuna real e documente a razão no plano.

### 6. Segurança e Configuração

Credenciais, chaves de API e configurações sensíveis devem ficar fora do código versionado. Documente variáveis esperadas e use mecanismos seguros da stack.

## Governança

- Use `pakitec_init` para inicializar estes documentos em projetos novos ou legados.
- Atualize esta constituição quando uma regra organizacional mudar.
- Mudanças de arquitetura devem referenciar a regra ou tradeoff relevante em `plan.md`.
- Ao final de mudanças estruturais, rode `pakitec_validate_project_structure`.

**Versão**: 1.0.0 | **Criado em**: 2026-05-29
