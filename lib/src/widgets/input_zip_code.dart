import 'package:flutter/material.dart';
import '../services/zip_service.dart';
import 'package:pakitec_themes/pakitec_themes.dart';
import 'compass_indicator.dart';
import 'dialogs.dart';
import 'divider.dart';

class PakiInputZipCode extends StatefulWidget {
  final String name;
  final IconData? prefixIcon;
  final TextAlign? textAlign;
  final TextEditingController controller;
  final Function(Map<String, dynamic> value) onSuccess;

  const PakiInputZipCode({
    Key? key,
    required this.name,
    this.prefixIcon,
    this.textAlign,
    required this.controller,
    required this.onSuccess,
  }) : super(key: key);

  @override
  State<PakiInputZipCode> createState() => _PakiInputZipCodeState();
}

class _PakiInputZipCodeState extends State<PakiInputZipCode> {
  bool isLoading = false;
  TextAlign textAlign = TextAlign.center;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    if (widget.textAlign != null) textAlign = widget.textAlign!;

    // Inicializa o FocusNode
    _focusNode = FocusNode();

    // Adiciona listener para detectar quando o campo perde o foco
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        if (widget.controller.text.length < 9) {
          // Mostra mensagem de erro para CEP inválido
          pakiShowSnackBar(
            context: context,
            content: const Text('CEP inválido. Digite o CEP completo.'),
            color: Colors.red,
          );
        } else {
          _getZip();
        }
      }
    });
  }

  @override
  void dispose() {
    // Certifique-se de descartar o FocusNode para evitar vazamentos de memória
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          onChanged: (value) {
            if (value.length == 9) {
              _getZip();
            }
          },
          controller: widget.controller,
          enabled: !isLoading,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: pakiDefaultPrimaryColor),
          textAlign: textAlign,
          focusNode: _focusNode, // Adiciona o FocusNode ao campo
          decoration: InputDecoration(
            labelText: widget.name,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: Colors.white70)
                : null,
            suffixIcon: IconButton(
              onPressed: () {
                widget.controller.clear();
              },
              icon: isLoading
                  ? const PakiCompassIndicator()
                  : const Icon(Icons.clear, color: Colors.white70),
            ),
          ),
        ),
        const PakiHorizontalDiv(),
      ],
    );
  }

  Future _getZip() async {
    if (isLoading) return;

    _setLoading(true);

    final resultZip = await GetZip.fetchZip(zip: widget.controller.text);

    if (resultZip.cep == null) {
      // ignore: use_build_context_synchronously
      pakiShowSnackBar(
        context: context,
        content: const Text('CEP inválido'),
        color: Colors.red,
      );
      widget.controller.text = '';
      _setLoading(false);
    } else {
      widget.onSuccess(resultZip.toMap());
      _setLoading(false);
    }

    _setLoading(false);
  }

  void _setLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }
}
