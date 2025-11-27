import 'package:flutter/material.dart';
import '../services/zip_service.dart';
import 'package:pakitec_themes/pakitec_themes.dart';
import 'dialogs.dart';
import 'divider.dart';

@Deprecated('Não usar esse componente temporariamente')
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
  String cleanZip = '';

  @override
  void initState() {
    super.initState();
    if (widget.textAlign != null) textAlign = widget.textAlign!;

    // Inicializa o FocusNode
    _focusNode = FocusNode();

    // Adiciona listener para detectar quando o campo perde o foco
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && !isLoading) {
        cleanZip = _cleanZip(widget.controller.text);

        if (cleanZip.length < 8) {
          // Mostra mensagem de erro para CEP inválido
          pakiShowSnackBar(
            context: context,
            content: const Text('CEP inválido. Digite o CEP completo.'),
            color: Colors.red,
          );
        } else {
          _getZip(cleanZip);
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
            cleanZip = _cleanZip(value);
            if (cleanZip.length == 8) {
              _getZip(cleanZip);
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
              // icon: isLoading
              //     ? const PakiCompassIndicator()
              //     : const Icon(Icons.clear, color: Colors.white70),
              icon: const Icon(Icons.clear, color: Colors.white70)
            ),
          ),
        ),
        const PakiHorizontalDiv(),
      ],
    );
  }

  Future<void> _getZip(String cleanZip) async {
    if (isLoading) return; // Evita chamadas concorrentes

    _setLoading(true);

    try {
      final resultZip = await GetZip.fetchZip(zip: cleanZip);


      if (resultZip.cep == '') {
        // ignore: use_build_context_synchronously
        pakiShowSnackBar(
          context: context,
          content: const Text('CEP inválido'),
          color: Colors.red,
        );
        widget.controller.text = '';
      } else {
        widget.onSuccess(resultZip.toMap());
      }
      widget.onSuccess(resultZip.toMap());
    } catch (e) {
      // ignore: use_build_context_synchronously
      // print('err component: ${e.toString()}');
      //
      // pakiShowSnackBar(
      //   context: context,
      //   content: const Text('Erro ao buscar CEP'),
      //   color: Colors.red,
      // );
    } finally {
      // Garante que isLoading será atualizado
      _setLoading(false);
    }
  }

  void _setLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  String _cleanZip(String zip) {
    // Remove todos os caracteres não numéricos
    return zip.replaceAll(RegExp(r'[^0-9]'), '');
  }
}
