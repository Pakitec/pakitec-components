# Padrão de desenvolvimento Flutter

<!-- sdd:section flutter.principles:start -->
## Princípios

- Mantenha a estrutura simples, previsível e compatível com Flutter.
- Organize o fluxo principal como `Screen -> Controller -> Service -> Model`.
- Use `ChangeNotifier` com `provider` para estado compartilhado e observável.
- Não introduza outros gerenciadores de estado sem aprovação explícita.
- Screens cuidam da UI e do estado visual local.
- Controllers mantêm estado observável e ações da aplicação.
- Services encapsulam API, storage, device e integrações de plataforma.
- Models representam dados e conceitos de domínio.
- Prefira widgets pequenos e reutilizáveis a screens extensas.
<!-- sdd:section flutter.principles:end -->

<!-- sdd:section flutter.layout:start -->
## Estrutura de diretórios

```text
lib/
  main.dart
  app/
    app.dart
    app_theme.dart
    app_routes.dart
    app_bootstrap.dart
  core/
    constants/
    errors/
    network/
    storage/
    utils/
    widgets/
  controllers/
    session/
  models/
  services/
  screens/
    <flow>/
      <flow>_screen.dart
      widgets/
```

Respeite a estrutura equivalente já existente. Não mova código apenas para
forçar esta árvore; aplique-a ao criar ou reorganizar código aprovado. Crie
`lib/repositories/` apenas quando houver coordenação relevante entre múltiplos
services, cache ou fontes de dados.
<!-- sdd:section flutter.layout:end -->

<!-- sdd:section flutter.responsibilities:start -->
## Responsabilidades

### `lib/main.dart`

Somente inicializa bindings, executa bootstrap e chama `runApp`. Não coloque UI,
rotas, regra de negócio ou construção extensa de dependências aqui.

### `lib/app`

Contém `MaterialApp`, tema, rotas e wiring/bootstrap global.

### `lib/core`

Infraestrutura genérica: constantes, falhas base, API client, storage,
validators, formatters e widgets verdadeiramente compartilhados. Widgets de um
fluxo pertencem ao `widgets/` local desse fluxo.

### `lib/controllers`

Controllers estendem `ChangeNotifier`, coordenam ações da aplicação e expõem
estado observável para a UI. Podem consumir services e repositories, mas não
exibem widgets, dialogs ou snackbars e não executam navegação.

### `lib/models`

Models são objetos Dart que representam dados e conceitos de domínio. Prefira
objetos imutáveis; `fromJson`, `toJson`, `toMap` e `copyWith` podem ficar no
model. Models não estendem `ChangeNotifier`, não acessam `BuildContext` e não
executam chamadas externas.

### `lib/services`

Integrações externas e operações de baixo nível: HTTP, storage, localização,
notificações, permissões e plugins. Services convertem respostas em objetos
de `lib/models` e não contêm lógica de UI.

### `lib/repositories`

Camada opcional. Use repositories somente quando um fluxo precisar coordenar
múltiplos services, cache e persistência ou esconder uma estratégia de fonte de
dados. Não crie repository como passagem direta para um único service.

### `lib/screens`

Screens renderizam UI, observam Controllers e encaminham ações do usuário.
Estado visual efêmero pode permanecer na screen com `setState`; requests e
ações da aplicação devem ser delegados a Controllers ou services apropriados.
<!-- sdd:section flutter.responsibilities:end -->

<!-- sdd:section flutter.state:start -->
## Estado

Declare `provider` nas dependências do `pubspec.yaml`. Controllers observáveis
estendem `ChangeNotifier` e chamam `notifyListeners()` após mudanças relevantes.
Use `ChangeNotifierProvider` para disponibilizá-los e `context.watch`,
`context.select` ou `Consumer` para observar mudanças. Use `context.read` para
executar ações sem reconstruir o widget.

### Sessão global única

Use uma única instância de `UserSession` durante a execução da aplicação. Ela
concentra usuário autenticado, token, permissões, restauração da sessão e logout.
Crie essa instância antes de `runApp` e disponibilize-a com
`ChangeNotifierProvider<UserSession>` acima do `MaterialApp`.

As regras e operações de sessão permanecem em
`lib/controllers/session/user_session.dart`. O `main.dart` contém somente
inicialização, wrapper e wiring global.

```dart
// lib/controllers/session/user_session.dart
import 'package:flutter/foundation.dart';

import '../../models/user_model.dart';
import '../../services/auth_service.dart';

class UserSession extends ChangeNotifier {
  UserSession(this.authService);

  final AuthService authService;
  UserModel? user;
  String? accessToken;

  bool get isLoggedIn => user != null && accessToken != null;

  Future<void> restoreSession() async {
    final restored = await authService.restoreSession();
    user = restored?.user;
    accessToken = restored?.accessToken;
    notifyListeners();
  }

  Future<void> signOut() async {
    await authService.signOut();
    user = null;
    accessToken = null;
    notifyListeners();
  }
}
```

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/session/user_session.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userSession = UserSession(AuthService());
  await userSession.restoreSession();

  runApp(MyApp(userSession: userSession));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.userSession});

  final UserSession userSession;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserSession>.value(
      value: userSession,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserSession>(
      builder: (context, session, child) {
        return MaterialApp(
          home: session.isLoggedIn
              ? const HomeScreen()
              : const LoginScreen(),
        );
      },
    );
  }
}
```

Use `Consumer<UserSession>` ou `context.watch<UserSession>()` na raiz somente
quando `MaterialApp`, home, rotas ou tema precisarem reagir à sessão. Em outros
pontos, use `context.read<UserSession>()` para executar ações e
`context.select<UserSession, T>()` para observar apenas o campo necessário.

Nunca crie outra instância de `UserSession` em screens, widgets ou Controllers
de fluxo. Controllers que dependem da sessão recebem a instância existente pelo
construtor:

```dart
class StudentController extends ChangeNotifier {
  StudentController(this.session, this.service);

  final UserSession session;
  final StudentService service;
}

ChangeNotifierProvider<StudentController>(
  create: (context) => StudentController(
    context.read<UserSession>(),
    StudentService(),
  ),
  child: const StudentsScreen(),
);
```

`UserSession` é global e única durante o ciclo da aplicação. Controllers de
fluxo são criados no limite da rota ou screen e recebem essa sessão quando
necessário. Sessão global única não significa limitar o usuário a um único
dispositivo.

Use `setState` apenas para estado visual efêmero, como tab selecionada,
visibilidade de senha, expansão de painel ou animação local.

```dart
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class LoginController extends ChangeNotifier {
  LoginController(this.service);

  final LoginService service;
  bool isLoading = false;
  String? errorMessage;

  Future<void> submit() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      await service.signIn();
    } catch (_) {
      errorMessage = 'Não foi possível entrar.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

ChangeNotifierProvider<LoginController>(
  create: (_) => LoginController(loginService),
  child: const LoginScreen(),
);

Consumer<LoginController>(
  builder: (context, controller, child) {
    return LoginButton(
      isLoading: controller.isLoading,
      onPressed: controller.submit,
    );
  },
);
```

Estado que afeta fluxo, carregamento ou ações da aplicação pertence ao
Controller. Models permanecem independentes da UI e do mecanismo de estado.
<!-- sdd:section flutter.state:end -->

<!-- sdd:section flutter.naming:start -->
## Nomenclatura

- Screens: `*_screen.dart`
- Controllers: `*_controller.dart`
- Sessão global: `user_session.dart`
- Models: `*_model.dart`
- Services: `*_service.dart`
- Repositories opcionais: `*_repository.dart`
- Widgets: nome descritivo e escopo local quando não forem compartilhados
<!-- sdd:section flutter.naming:end -->

<!-- sdd:section flutter.new-screen:start -->
## Nova screen

1. Crie a screen em `lib/screens/<flow>/`.
2. Coloque widgets locais em `lib/screens/<flow>/widgets/`.
3. Crie ou atualize Models em `lib/models/` para dados e conceitos de domínio.
4. Adicione integrações externas em `lib/services/`.
5. Crie um `*Controller` em `lib/controllers/` quando houver ações ou estado
   observável.
6. Exponha o Controller com `ChangeNotifierProvider` no limite da rota ou
   screen.
7. Mantenha em `setState` somente o estado visual e local da screen.
8. Registre a rota no mecanismo já usado pelo projeto.
<!-- sdd:section flutter.new-screen:end -->

<!-- sdd:section flutter.agent:start -->
## Regras para agentes

- Leia este padrão antes de criar arquivos Flutter.
- Preserve a organização existente salvo solicitação explícita de migração.
- Garanta que `provider` esteja declarado no `pubspec.yaml`.
- Nunca instancie `UserSession` fora do bootstrap global da aplicação.
- Não adicione Riverpod, Bloc, GetX, MobX ou Redux sem aprovação.
- Não crie árvores feature-first `data/presentation/domain` neste padrão.
- Não crie repositories sem coordenação real entre fontes de dados.
- Mantenha `main.dart` pequeno.
- Reutilize os componentes corporativos existentes antes de criar equivalentes.
- Execute `dart format` após alterações Dart.
- Execute `flutter analyze` quando comportamento ou arquitetura mudar.
- Execute os testes Flutter relevantes antes de concluir.
<!-- sdd:section flutter.agent:end -->
