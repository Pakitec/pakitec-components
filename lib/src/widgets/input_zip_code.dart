import 'package:flutter/material.dart';
import 'package:pakitec_components/pakitec_components.dart';
import 'package:pakitec_components/src/styles/main_style.dart';
import '../services/zip_service.dart';
import 'compass_indicator.dart';
import 'dialogs.dart';


class PakiInputZipCode extends StatefulWidget {
  final String name;
  final TextEditingController controller;
  final Function(Map<String, dynamic> value) onSuccess;

  const PakiInputZipCode({Key? key, required this.name, required this.controller, required this.onSuccess}) : super(key: key);

  @override
  _PakiInputZipCodeState createState() => _PakiInputZipCodeState();
}

class _PakiInputZipCodeState extends State<PakiInputZipCode> {
  bool isLoading = false;

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
        style: const TextStyle(color: primaryColor),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            labelText: widget.name,
            suffixIcon: IconButton(
                onPressed: () {
                  widget.controller.clear();
                },
                icon: isLoading ? const CompassIndicator() : const Icon(Icons.clear, color: Colors.white70))));

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
