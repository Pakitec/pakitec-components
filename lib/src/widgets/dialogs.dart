import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:pakitec_components/src/styles/main_style.dart';
import '../../pakitec_components.dart';

pakiShowQuestionYesNo(
    {required BuildContext context,
    required String message,
    required Function() onConfirm,
    required Function() onCancel}) {
  Widget yes = TextButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(buttonColor)),
      child: const Text('Sim', style: TextStyle(color: Colors.white)),
      onPressed: onConfirm);
  Widget no = TextButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(buttonColor)),
      child: const Text('Não', style: TextStyle(color: Colors.white)),
      onPressed: onCancel);
  AlertDialog alert = AlertDialog(
      title: const Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Atenção'),
          PakiVerticalDiv(value: 5.0),
          Icon(FontAwesome5.exclamation_circle),
        ]),
        PakiHorizontalDiv(value: 15.0),
        Divider(height: 1.0, color: Colors.white)
      ]),
      content: Text(message),
      actions: [yes, no],
      backgroundColor: secondaryColor);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

pakiShowSnackBar(
    {required BuildContext context, required Widget content, required Color color, SnackBarAction? action}) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: content, backgroundColor: color, duration: const Duration(seconds: 5), action: action));
}

pakiShowSnackBarErrors(
    {required BuildContext context, required String content, SnackBarAction? action, String? urlImage}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 70 / 100,
            child: Text(
              content,
              style: const TextStyle(color: Colors.white),
            )),
        Image.asset(urlImage ?? 'assets/images/bermuda_error.png',
            height: 60, width: MediaQuery.of(context).size.width * 15 / 100)
      ]),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 5),
      action: action));
}
