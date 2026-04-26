import 'package:flutter/material.dart';
import 'package:dashbook/dashbook.dart';
import 'package:pakitec_components/pakitec_components.dart';
import 'package:pakitec_components/src/widgets/button.dart';
import 'package:pakitec_components/src/widgets/checkbox.dart';
import 'package:pakitec_components/src/widgets/color_picker.dart';
import 'package:pakitec_components/src/widgets/combo_field.dart';
import 'package:pakitec_components/src/widgets/compass_indicator.dart';
import 'package:pakitec_components/src/widgets/container.dart';
import 'package:pakitec_components/src/widgets/dialogs.dart';
import 'package:pakitec_components/src/widgets/divider.dart';
import 'package:pakitec_components/src/widgets/edit_list_view.dart';
import 'package:pakitec_components/src/widgets/floating_button.dart';
import 'package:pakitec_components/src/widgets/image_background.dart';
import 'package:pakitec_components/src/widgets/indicator.dart';
import 'package:pakitec_components/src/widgets/input_calendar.dart';
import 'package:pakitec_components/src/widgets/input_field.dart';
import 'package:pakitec_components/src/widgets/input_zip_code.dart';
import 'package:pakitec_components/src/widgets/print_button.dart';
import 'package:pakitec_components/src/widgets/scaffold.dart';
import 'package:pakitec_components/src/widgets/skeleton_indicator.dart';
import 'package:pakitec_components/src/widgets/new_badge.dart';

import 'generate_component.dart';

class IconChoice {
  final String name;
  final IconData icon;

  const IconChoice(this.name, this.icon);

  @override
  String toString() => name;
}

void _noop() {}

void main() {
  final dashbook = Dashbook.dualTheme(
    light: ThemeData.light(),
    dark: ThemeData.dark(),
    title: 'Componentes Pakitec',
  );

  dashbook.storiesOf('PakiButton').add('Example', (ctx) {
    final text = ctx.textProperty('Texto', 'Clique aqui');
    final selectedIcon = ctx.listProperty<IconChoice>(
      'Ícone',
      const IconChoice('Add', Icons.add),
      const [
        IconChoice('Add', Icons.add),
        IconChoice('Check', Icons.check),
        IconChoice('Close', Icons.close),
        IconChoice('Star', Icons.star),
      ],
    );

    final largura = ctx.numberProperty('Largura', 150);
    final altura = ctx.numberProperty('Altura', 50);

    final example = '''
        PakiButton(
          text: '$text',
          iconData: Icons.${selectedIcon.name.toLowerCase()},
          onPressed: () {},
          width: $largura,
          height: $altura,
        )
        ''';

    return GenerateComponent(
        example: example,
        component: PakiButton(
          text: text,
          iconData: selectedIcon.icon,
          onPressed: () => print('Botão pressionado'),
          width: largura,
          height: altura,
        ));
  });

  dashbook.storiesOf('PakiCheckbox').add('Example', (ctx) {
    final labelText = ctx.textProperty('Label', 'I accept the terms');
    final isChecked = ctx.boolProperty('Checked', false);

    final example = '''
        PakiCheckbox(
          label: '$labelText',
          selectedValue: $isChecked,
          onChanged: (value) {},
        )
        ''';

    return GenerateComponent(
      example: example,
      component: PakiCheckbox(
        label: labelText,
        selectedValue: isChecked,
        onChanged: (value) => print('Checkbox changed: \$value'),
      ),
    );
  });

  dashbook.storiesOf('PakiComboField').add('Example', (ctx) {
    final labelText = ctx.textProperty('Label', 'Select an option');
    final showSearch = ctx.boolProperty('Show Search Box', true);
    final removeDivider = ctx.boolProperty('Remove Horizontal Divider', false);
    final selected = ctx.listProperty<String>(
      'Selected Value',
      'Option 1',
      ['Option 1', 'Option 2', 'Option 3'],
    );

    final example = '''
        PakiComboField(
          label: '$labelText',
          list: ['Option 1', 'Option 2', 'Option 3'],
          onSelect: (value) {},
          selectedValue: '$selected',
          showSearchBox: $showSearch,
          removeHorizontalDiv: $removeDivider,
        )
        ''';

    return GenerateComponent(
      example: example,
      component: PakiComboField(
        label: labelText,
        list: ['Option 1', 'Option 2', 'Option 3'],
        selectedValue: selected,
        showSearchBox: showSearch,
        removeHorizontalDiv: removeDivider,
        onSelect: (value) => print('Selected value: \$value'),
      ),
    );
  });

  dashbook.storiesOf('PakiColorPicker').add('Example', (ctx) {
    final initialColor = ctx.textProperty('Cor inicial', '#FF0000');
    final controller = TextEditingController(text: initialColor);

    final example = '''
        PakiColorPicker(
          controller: TextEditingController(text: '$initialColor'),
          currentColor: '$initialColor',
          onChanged: (value) {},
        )
        ''';

    return GenerateComponent(
      example: example,
      component: PakiColorPicker(
        controller: controller,
        currentColor: initialColor,
        onChanged: (value) => print('Cor selecionada: \\$value'),
      ),
    );
  });

  dashbook.storiesOf('PakiNewBadge').add('Example', (ctx) {
    final tooltipText = ctx.textProperty('Tooltip', 'Novo recurso disponível');
    final badgeExpired = ctx.boolProperty('Badge expirado', false);
    final showUntil = badgeExpired
        ? DateTime.now().subtract(const Duration(days: 1))
        : DateTime.now().add(const Duration(days: 1));
    final example = '''
        PakiNewBadge(
          tooltip: '$tooltipText',
          showUntil: DateTime.now().add(const Duration(days: 1)),
          child: const PakiButton(
            text: 'Ação',
            iconData: Icons.new_releases,
            onPressed: null,
          ),
        )
        ''';

    return GenerateComponent(
      example: example,
      component: PakiNewBadge(
        tooltip: tooltipText,
        showUntil: showUntil,
        child: PakiButton(
          text: 'Ação',
          iconData: Icons.new_releases,
          onPressed: () {},
        ),
      ),
    );
  });

  dashbook.storiesOf('PakiCompassIndicator').add('Example', (ctx) {
    const example = '''
        PakiCompassIndicator()
        ''';

    return const GenerateComponent(
      example: example,
      component: Center(child: PakiCompassIndicator()),
    );
  });

  dashbook.storiesOf('PakiContainer').add('Example', (ctx) {
    final ignoreMaxWidth = ctx.boolProperty('Ignorar largura máxima', false);
    final withDecoration = ctx.boolProperty('Com decoração', true);

    final example = '''
        PakiContainer(
          ignoreMaxWidth: $ignoreMaxWidth,
          withDecoration: $withDecoration,
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Conteúdo dentro do container'),
          ),
        )
        ''';

    return GenerateComponent(
      example: example,
      component: PakiContainer(
        ignoreMaxWidth: ignoreMaxWidth,
        withDecoration: withDecoration,
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Conteúdo dentro do container'),
        ),
      ),
    );
  });

  dashbook.storiesOf('PakiDialogs').add('Example', (ctx) {
    final message = ctx.textProperty('Mensagem', 'Deseja confirmar esta ação?');

    final example = '''
        pakiShowQuestionYesNo(
          context: context,
          message: '$message',
          onConfirm: () {},
          onCancel: () {},
        );
        ''';

    return GenerateComponent(
      example: example,
      component: Builder(
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => pakiShowQuestionYesNo(
                context: context,
                message: message,
                onConfirm: () => Navigator.of(context).pop(),
                onCancel: () => Navigator.of(context).pop(),
              ),
              child: const Text('Mostrar diálogo de confirmação'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => pakiShowGlobalModal(
                context: context,
                title: 'Aviso',
                message: 'Modal com contador regressivo',
                color: Colors.orange,
                secondsToClose: 5,
              ),
              child: const Text('Mostrar modal global'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => pakiShowSnackBar(
                context: context,
                content: const Text('Mensagem de exemplo'),
                color: Colors.green,
              ),
              child: const Text('Mostrar snackbar'),
            ),
          ],
        ),
      ),
    );
  });

  dashbook.storiesOf('PakiDivider').add('Example', (ctx) {
    final verticalWidth = ctx.numberProperty('Largura do divisor vertical', 20);
    final horizontalHeight =
        ctx.numberProperty('Altura do divisor horizontal', 20);

    final example = '''
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Acima do divisor horizontal'),
            PakiHorizontalDiv(height: $horizontalHeight),
            Text('Abaixo do divisor horizontal'),
          ],
        )
        ''';

    return GenerateComponent(
      example: example,
      component: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Acima do divisor horizontal'),
          PakiHorizontalDiv(height: horizontalHeight.toDouble()),
          const Text('Abaixo do divisor horizontal'),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Esquerda'),
              PakiVerticalDiv(width: verticalWidth.toDouble()),
              const Text('Direita'),
            ],
          ),
        ],
      ),
    );
  });

  dashbook.storiesOf('PakiEditListView').add('Example', (ctx) {
    const example = '''
        PakiEditListView(
          children: [
            ListTile(title: Text('Item 1')),
            ListTile(title: Text('Item 2')),
            ListTile(title: Text('Item 3')),
          ],
        )
        ''';

    return const GenerateComponent(
      example: example,
      component: SizedBox(
        height: 200,
        child: PakiEditListView(
          children: [
            ListTile(title: Text('Item 1')),
            ListTile(title: Text('Item 2')),
            ListTile(title: Text('Item 3')),
          ],
        ),
      ),
    );
  });

  dashbook.storiesOf('PakiAddButton').add('Example', (ctx) {
    const example = '''
        PakiAddButton(
          onPressed: () {},
        )
        ''';

    return GenerateComponent(
      example: example,
      component: PakiAddButton(
        onPressed: () => print('Botão flutuante pressionado'),
      ),
    );
  });

  dashbook.storiesOf('PakiImageBackground').add('Example', (ctx) {
    final text = ctx.textProperty('Texto', 'Nenhum dado encontrado');
    final example = '''
        PakiImageBackground(
          url: 'assets/images/bermuda-no-data.png',
          text: '$text',
        )
        ''';

    return GenerateComponent(
      example: example,
      component: PakiImageBackground(
        url: 'assets/images/bermuda-no-data.png',
        text: text,
      ),
    );
  });

  dashbook.storiesOf('PakiIndicator').add('Example', (ctx) {
    final isSquare = ctx.boolProperty('Quadrado', true);
    final color = ctx.colorProperty('Cor', Colors.blue);
    final label = ctx.textProperty('Texto', 'Indicador');

    final example = '''
        PakiIndicator(
          text: '$label',
          isSquare: $isSquare,
          color: Colors.blue,
        )
        ''';

    return GenerateComponent(
      example: example,
      component: PakiIndicator(
        text: label,
        isSquare: isSquare,
        color: color,
      ),
    );
  });

  dashbook.storiesOf('PakiInputCalendar').add('Example', (ctx) {
    final controller = TextEditingController();
    final isDate = ctx.boolProperty('É data?', true);
    final example = '''
        PakiInputCalendar(
          name: 'Data',
          controller: TextEditingController(),
          isDate: $isDate,
          onChanged: (value) {},
        )
        ''';

    return GenerateComponent(
      example: example,
      component: PakiInputCalendar(
        name: 'Data',
        controller: controller,
        isDate: isDate,
        onChanged: (value) => print('Selecionado: \$value'),
      ),
    );
  });

  dashbook.storiesOf('PakiInputField').add('Example', (ctx) {
    final controller = TextEditingController(text: 'Texto inicial');
    final hint = ctx.textProperty('Hint', 'Digite algo');
    final example = '''
        PakiInputField(
          name: 'Campo de texto',
          controller: TextEditingController(text: 'Texto inicial'),
          hint: '$hint',
          onChanged: (value) {},
        )
        ''';

    return GenerateComponent(
      example: example,
      component: PakiInputField(
        name: 'Campo de texto',
        controller: controller,
        hint: hint,
        onChanged: (value) => print('Digitado: \$value'),
      ),
    );
  });

  dashbook.storiesOf('PakiInputZipCode').add('Example', (ctx) {
    final controller = TextEditingController();
    const example = '''
        PakiInputZipCode(
          name: 'CEP',
          controller: TextEditingController(),
          onSuccess: (value) {},
        )
        ''';

    return GenerateComponent(
      example: example,
      component: PakiInputZipCode(
        name: 'CEP',
        controller: controller,
        onSuccess: (value) => print('Dados do CEP: \$value'),
      ),
    );
  });

  dashbook.storiesOf('PakiPrintButton').add('Example', (ctx) {
    const example = '''
        PakiPrintButton(
          onTap: () {},
        )
        ''';

    return GenerateComponent(
      example: example,
      component: PakiPrintButton(
        onTap: () => print('Imprimir acionado'),
      ),
    );
  });

  dashbook.storiesOf('PakiScaffold').add('Example', (ctx) {
    const example = '''
        PakiScaffold(
          label: 'Tela exemplo',
          body: Center(child: Text('Conteúdo principal')),
          floatingActionButton: PakiAddButton(onPressed: () {}),
        )
        ''';

    return GenerateComponent(
      example: example,
      component: const SizedBox(
        height: 300,
        child: PakiScaffold(
          label: 'Tela exemplo',
          body: Center(child: Text('Conteúdo principal')),
          floatingActionButton: PakiAddButton(onPressed: _noop),
        ),
      ),
    );
  });

  dashbook.storiesOf('PakiSkeletonIndicator').add('Example', (ctx) {
    const example = '''
        SizedBox(
          height: 300,
          child: PakiSkeletonIndicator(),
        )
        ''';

    return const GenerateComponent(
      example: example,
      component: SizedBox(
        height: 300,
        child: PakiSkeletonIndicator(),
      ),
    );
  });

  dashbook.storiesOf('PakiButton').add('Galeria', (ctx) {
    const example = '''
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            PakiButton(text: 'Adicionar', iconData: Icons.add, onPressed: () {}),
            PakiButton(text: 'Salvar', iconData: Icons.save, onPressed: () {}),
            PakiButton(text: 'Confirmar', iconData: Icons.check, onPressed: () {}),
            PakiButton(text: 'Excluir', iconData: Icons.delete, onPressed: () {}),
          ],
        )
        ''';

    return GenerateComponent(
      example: example,
      component: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 12,
        children: [
          PakiButton(text: 'Adicionar', iconData: Icons.add, onPressed: _noop),
          PakiButton(text: 'Salvar', iconData: Icons.save, onPressed: _noop),
          PakiButton(
              text: 'Confirmar', iconData: Icons.check, onPressed: _noop),
          PakiButton(text: 'Excluir', iconData: Icons.delete, onPressed: _noop),
          PakiButton(
              text: 'Pequeno',
              iconData: Icons.tune,
              width: 120,
              height: 40,
              onPressed: _noop),
          PakiButton(
              text: 'Largo',
              iconData: Icons.open_in_full,
              width: 220,
              height: 56,
              onPressed: _noop),
        ],
      ),
    );
  });

  dashbook.storiesOf('PakiInputField').add('Variações', (ctx) {
    const example = '''
        Column(
          children: [
            PakiInputField(name: 'Nome', controller: TextEditingController(), prefixIcon: Icons.person),
            PakiInputField(name: 'E-mail', controller: TextEditingController(), keyboardType: TextInputType.emailAddress),
            PakiInputField(name: 'Senha', controller: TextEditingController(), isPasswordField: true),
            PakiInputField(name: 'Observações', controller: TextEditingController(), maxLines: 3),
          ],
        )
        ''';

    return GenerateComponent(
      example: example,
      component: Column(
        children: [
          PakiInputField(
            name: 'Nome',
            controller: TextEditingController(text: 'Maria Oliveira'),
            prefixIcon: Icons.person,
            hint: 'Nome completo',
          ),
          PakiInputField(
            name: 'E-mail',
            controller: TextEditingController(text: 'maria@pakitec.com.br'),
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email,
            textAlign: TextAlign.left,
          ),
          PakiInputField(
            name: 'Senha',
            controller: TextEditingController(text: 'segredo123'),
            isPasswordField: true,
            prefixIcon: Icons.lock,
          ),
          PakiInputField(
            name: 'Observações',
            controller: TextEditingController(
                text: 'Campo com múltiplas linhas para textos maiores.'),
            maxLines: 3,
            maxLength: 120,
            textAlign: TextAlign.left,
            prefixIcon: Icons.notes,
          ),
          PakiInputField(
            name: 'Desabilitado',
            controller: TextEditingController(text: 'Não editável'),
            isEnabled: false,
            prefixIcon: Icons.block,
          ),
        ],
      ),
    );
  });

  dashbook.storiesOf('PakiInputCalendar').add('Data e hora', (ctx) {
    const example = '''
        Row(
          children: [
            Expanded(child: PakiInputCalendar(name: 'Data', controller: TextEditingController(), isDate: true, onChanged: (_) {})),
            Expanded(child: PakiInputCalendar(name: 'Hora', controller: TextEditingController(), isDate: false, onChanged: (_) {})),
          ],
        )
        ''';

    return GenerateComponent(
      example: example,
      component: Row(
        children: [
          Expanded(
            child: PakiInputCalendar(
              name: 'Data',
              controller: TextEditingController(text: '26/04/2026'),
              isDate: true,
              prefixIcon: Icons.event,
              onChanged: (value) => print('Data: \$value'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: PakiInputCalendar(
              name: 'Hora',
              controller: TextEditingController(text: '14:30'),
              isDate: false,
              prefixIcon: Icons.schedule,
              onChanged: (value) => print('Hora: \$value'),
            ),
          ),
        ],
      ),
    );
  });

  dashbook.storiesOf('PakiComboField').add('Listas', (ctx) {
    const example = '''
        Column(
          children: [
            PakiComboField(label: 'Status', list: ['Ativo', 'Pendente', 'Bloqueado'], selectedValue: 'Ativo', onSelect: (_) {}),
            PakiComboField(label: 'Categoria', list: ['Financeiro', 'Operação', 'Comercial'], onSelect: (_) {}),
          ],
        )
        ''';

    return GenerateComponent(
      example: example,
      component: Column(
        children: [
          PakiComboField(
            label: 'Status',
            list: const ['Ativo', 'Pendente', 'Bloqueado'],
            selectedValue: 'Ativo',
            onSelect: (value) => print('Status: \$value'),
          ),
          PakiComboField(
            label: 'Categoria',
            list: const ['Financeiro', 'Operação', 'Comercial', 'Suporte'],
            selectedValue: 'Operação',
            onSelect: (value) => print('Categoria: \$value'),
          ),
        ],
      ),
    );
  });

  dashbook.storiesOf('PakiIndicator').add('Status', (ctx) {
    const example = '''
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            PakiIndicator(text: 'Ativo', isSquare: false, color: Colors.green),
            PakiIndicator(text: 'Pendente', isSquare: false, color: Colors.orange),
            PakiIndicator(text: 'Bloqueado', isSquare: false, color: Colors.red),
          ],
        )
        ''';

    return const GenerateComponent(
      example: example,
      component: Wrap(
        alignment: WrapAlignment.center,
        spacing: 16,
        runSpacing: 12,
        children: [
          PakiIndicator(text: 'Ativo', isSquare: false, color: Colors.green),
          PakiIndicator(
              text: 'Pendente', isSquare: false, color: Colors.orange),
          PakiIndicator(text: 'Bloqueado', isSquare: false, color: Colors.red),
          PakiIndicator(
              text: 'Novo', isSquare: true, color: Colors.blue, size: 18),
          PakiIndicator(
              text: 'Arquivado', isSquare: true, color: Colors.grey, size: 18),
        ],
      ),
    );
  });

  dashbook.storiesOf('PakiImageBackground').add('Estados vazios', (ctx) {
    const example = '''
        Row(
          children: [
            Expanded(child: PakiImageBackground(url: 'assets/images/bermuda-no-data.png', text: 'Nenhum dado')),
            Expanded(child: PakiImageBackground(url: 'assets/images/bermuda_error.png', text: 'Erro ao carregar')),
          ],
        )
        ''';

    return const GenerateComponent(
      example: example,
      component: SizedBox(
        height: 320,
        child: Row(
          children: [
            Expanded(
                child: PakiImageBackground(
                    url: 'assets/images/bermuda-no-data.png',
                    text: 'Nenhum dado')),
            Expanded(
                child: PakiImageBackground(
                    url: 'assets/images/bermuda_error.png',
                    text: 'Erro ao carregar')),
            Expanded(
                child: PakiImageBackground(
                    url: 'assets/images/bermuda-win.png',
                    text: 'Operação concluída')),
          ],
        ),
      ),
    );
  });

  dashbook.storiesOf('PakiDialogs').add('Snackbars', (ctx) {
    const example = '''
        Column(
          children: [
            ElevatedButton(onPressed: () => pakiShowSnackBar(...), child: Text('Sucesso')),
            ElevatedButton(onPressed: () => pakiShowSnackBarErrors(...), child: Text('Erro')),
          ],
        )
        ''';

    return GenerateComponent(
      example: example,
      component: Builder(
        builder: (context) => Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: () => pakiShowSnackBar(
                context: context,
                content: const Text('Registro salvo com sucesso'),
                color: Colors.green,
              ),
              icon: const Icon(Icons.check),
              label: const Text('Sucesso'),
            ),
            ElevatedButton.icon(
              onPressed: () => pakiShowSnackBar(
                context: context,
                content: const Text('Atenção antes de continuar'),
                color: Colors.orange,
              ),
              icon: const Icon(Icons.warning),
              label: const Text('Atenção'),
            ),
            ElevatedButton.icon(
              onPressed: () => pakiShowSnackBarErrors(
                context: context,
                content: 'Não foi possível concluir a operação',
              ),
              icon: const Icon(Icons.error),
              label: const Text('Erro'),
            ),
          ],
        ),
      ),
    );
  });

  dashbook.storiesOf('PakiContainer').add('Composição', (ctx) {
    const example = '''
        PakiContainer(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(children: [...]),
          ),
        )
        ''';

    return GenerateComponent(
      example: example,
      component: PakiContainer(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Resumo operacional',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 12,
                children: [
                  PakiIndicator(
                      text: 'Pedidos', isSquare: false, color: Colors.blue),
                  PakiIndicator(
                      text: 'Pagamentos', isSquare: false, color: Colors.green),
                  PakiIndicator(
                      text: 'Alertas', isSquare: false, color: Colors.orange),
                ],
              ),
              const SizedBox(height: 20),
              PakiButton(
                  text: 'Atualizar', iconData: Icons.refresh, onPressed: _noop),
            ],
          ),
        ),
      ),
    );
  });

  dashbook.storiesOf('PakiScaffold').add('Tela completa', (ctx) {
    const example = '''
        PakiScaffold(
          label: 'Pedidos',
          head: PakiInputField(...),
          body: PakiEditListView(...),
          floatingActionButton: PakiAddButton(onPressed: () {}),
          bottomNavigationBar: BottomAppBar(...),
        )
        ''';

    return GenerateComponent(
      example: example,
      component: SizedBox(
        height: 520,
        child: PakiScaffold(
          label: 'Pedidos',
          widgetButton:
              IconButton(onPressed: _noop, icon: const Icon(Icons.filter_alt)),
          head: Padding(
            padding: const EdgeInsets.all(8),
            child: PakiInputField(
              name: 'Buscar',
              controller: TextEditingController(),
              prefixIcon: Icons.search,
              removeHorizontalDiv: true,
            ),
          ),
          body: PakiEditListView(
            children: const [
              ListTile(
                  leading: Icon(Icons.receipt_long),
                  title: Text('Pedido #1024'),
                  subtitle: Text('Aguardando pagamento')),
              ListTile(
                  leading: Icon(Icons.local_shipping),
                  title: Text('Pedido #1025'),
                  subtitle: Text('Em separação')),
              ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text('Pedido #1026'),
                  subtitle: Text('Concluído')),
            ],
          ),
          floatingActionButton: PakiAddButton(onPressed: _noop),
          bottomNavigationBar: const BottomAppBar(
            child: SizedBox(
              height: 48,
              child: Center(child: Text('3 registros encontrados')),
            ),
          ),
        ),
      ),
    );
  });
  runApp(dashbook);
}
