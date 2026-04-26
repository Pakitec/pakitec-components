
# Pakitec Components

Pacote de componentes visuais reutilizáveis criado pela equipe da Pakitec, com foco em produtividade, consistência visual e facilidade de integração em projetos Flutter.

> 💡 Este pacote é privado e não está publicado no pub.dev. Para uso interno e por times autorizados.

---

## ✨ Principais recursos

- Conjunto de widgets prontos para uso: botões, campos de entrada, indicadores, diálogos, scaffold, e muito mais.
- Padronização visual com suporte ao tema Pakitec (`pakitec_themes`)
- Compatível com Flutter Web, Mobile e Desktop
- Documentação interativa via [Dashbook](https://pub.dev/packages/dashbook)

---

## 🚀 Começando

### Pré-requisitos

- Flutter SDK 3.10 ou superior
- Acesso ao repositório privado da Pakitec
- Adicionado como dependência via Git:

```yaml
dependencies:
  pakitec_components:
    git:
      url: https://github.com/Pakitec/pakitec-components.git
```

---

## 📦 Estrutura

Este pacote oferece os seguintes componentes:

- `PakiButton`
- `PakiNewBadge`


> Todos estão localizados em `lib/src/widgets/`.

---

## 🧪 Demonstração interativa (Dashbook)

Você pode visualizar e testar os componentes individualmente com controle dinâmico de propriedades.

### GitHub Pages

O playbook é publicado automaticamente no GitHub Pages a cada push na branch `master` pelo workflow [`deploy_playbook_pages.yml`](.github/workflows/deploy_playbook_pages.yml).

URL esperada:

```text
https://flutter-components.pakitec.com.br/
```

### Executar localmente:

```bash
flutter pub get
flutter run -d chrome -t example/main_dashbook.dart
```

---

## 🛠 Exemplo de uso

`dart
PakiButton(
  text: 'Enviar',
  iconData: Icons.send,
  onPressed: () => print('Enviado'),
  width: 160,
  height: 50,
)
`

---

## 🎨 Tema escuro e claro

O pacote suporta alternância entre tema escuro e claro usando `Dashbook.dualTheme`. Os componentes se adaptam automaticamente ao tema ativo via `Theme.of(context)`.

---

## 📚 Documentação

- Exemplos práticos no diretório [`example/`](example/)
- Cada componente pode ser testado e copiado diretamente da interface do Dashbook
- É possível exibir o código gerado e copiá-lo para uso

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Para colaborar:

1. Crie uma branch com sua feature/fix
2. Mantenha o padrão de código e organização
3. Faça um PR com uma descrição clara

---

## 🧾 Licença

Este pacote é de uso interno da **Pakitec Tecnologia** e está licenciado apenas para projetos autorizados.

---
