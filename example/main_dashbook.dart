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

import 'generate_component.dart';

class IconChoice {
  final String name;
  final IconData icon;

  const IconChoice(this.name, this.icon);

  @override
  String toString() => name;
}

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

  // dashbook.storiesOf('combo_field').add('Exemplo', (ctx) => const Placeholder());
  // dashbook.storiesOf('compass_indicator').add('Exemplo', (ctx) => const Placeholder());
  // dashbook.storiesOf('container').add('Exemplo', (ctx) => const Placeholder());
  // dashbook.storiesOf('dialogs').add('Exemplo', (ctx) => const Placeholder());
  // dashbook.storiesOf('divider').add('Exemplo', (ctx) => const PakiVerticalDiv());
  // dashbook.storiesOf('edit_list_view').add('Exemplo', (ctx) => const Placeholder());
  // dashbook.storiesOf('floating_button').add('Exemplo', (ctx) => const Placeholder());
  // dashbook.storiesOf('image_background').add('Exemplo', (ctx) => const Placeholder());
  // dashbook.storiesOf('indicator').add('Exemplo', (ctx) => const Placeholder());
  // dashbook.storiesOf('input_calendar').add('Exemplo', (ctx) => const Placeholder());
  // dashbook.storiesOf('input_field').add('Exemplo', (ctx) => const Placeholder());
  // dashbook.storiesOf('input_zip_code').add('Exemplo', (ctx) => const Placeholder());
  // dashbook.storiesOf('print_button').add('Exemplo', (ctx) => const Placeholder());
  // dashbook.storiesOf('scaffold').add('Exemplo', (ctx) => const Placeholder());
  // dashbook.storiesOf('skeleton_indicator').add('Exemplo', (ctx) => const Placeholder());
  runApp(dashbook);
}
