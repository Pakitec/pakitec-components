import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pakitec_components/pakitec_components.dart';

class GenerateComponent extends StatefulWidget {
  final String example;
  final Widget component;

  const GenerateComponent({Key? key, required this.example, required this.component}) : super(key: key);

  @override
  State<GenerateComponent> createState() => _GenerateComponentState();
}

class _GenerateComponentState extends State<GenerateComponent> {
  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PakiScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.component,
            const SizedBox(height: 24),
            const Text('Código gerado:', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.all(12),
              color: isDark ? Colors.black : Colors.white,
              width: double.infinity,
              child: SelectableText(
                widget.example,
                style: TextStyle(fontFamily: 'monospace', color: isDark ? Colors.white: Colors.black),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: widget.example));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Código copiado para a área de transferência')),
                );
              },
              icon: const Icon(Icons.copy),
              label: const Text('Copiar código'),
            ),
          ],
        ),
      ),
    );
  }
}
