import 'package:flutter/material.dart';
import 'package:dashbook/dashbook.dart';
import 'package:pakitec_components/pakitec_components.dart';
import 'package:pakitec_components/src/widgets/button.dart';
import 'package:pakitec_components/src/widgets/checkbox.dart';
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

  dashbook.storiesOf('PakiNewBadge').add('Example', (ctx) {
    final tooltipText = ctx.textProperty('Tooltip', 'Novo recurso disponível');
    final example = '''
        PakiNewBadge(
          tooltip: '$tooltipText',
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
        child: PakiButton(
          text: 'Ação',
          iconData: Icons.new_releases,
          onPressed: (){},
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
    final horizontalHeight = ctx.numberProperty('Altura do divisor horizontal', 20);

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
  runApp(dashbook);
}
