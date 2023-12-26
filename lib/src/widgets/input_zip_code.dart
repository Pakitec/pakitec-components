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

  const PakiInputZipCode(
      {Key? key,
      required this.name,
      this.prefixIcon,
      this.textAlign,
      required this.controller,
      required this.onSuccess})
      : super(key: key);

  @override
  State<PakiInputZipCode> createState() => _PakiInputZipCodeState();
}

class _PakiInputZipCodeState extends State<PakiInputZipCode> {
  bool isLoading = false;
  TextAlign textAlign = TextAlign.center;

  @override
  void initState() {
    super.initState();
    if (widget.textAlign != null) textAlign = widget.textAlign!;
  }

  @override
  Widget build(BuildContext context) {
    TextFormField textFormField = TextFormField(
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
        decoration: InputDecoration(
            labelText: widget.name,
            prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, color: Colors.white70): null,
            suffixIcon: IconButton(
                onPressed: () {
                  widget.controller.clear();
                },
                icon: isLoading ? const PakiCompassIndicator() : const Icon(Icons.clear, color: Colors.white70))));

    return Column(children: <Widget>[textFormField, const PakiHorizontalDiv()]);
  }

  Future _getZip() async {
    _setLoading(true);

    final resultZip = await GetZip.fetchZip(zip: widget.controller.text);

    if (resultZip.cep == null) {
      pakiShowSnackBar(context: context, content: const Text('CEP inválido'), color: Colors.red);
      widget.controller.text = '';
      _setLoading(false);
    } else {
      widget.onSuccess(resultZip.toMap());
      _setLoading(false);
    }
  }

  _setLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }
}
