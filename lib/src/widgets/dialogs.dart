import 'package:flutter/material.dart';
import 'package:pakitec_themes/pakitec_themes.dart';
import 'divider.dart';

// pakiShowQuestionYesNo(
//     {required BuildContext context,
//     required String message,
//     required Function() onConfirm,
//     required Function() onCancel,
//     bool? isLoading,
//     bool? needsConfirm}) {
//   needsConfirm ??= true;
//   isLoading ??= false;
//
//   if (!needsConfirm) {
//     onConfirm();
//   } else {
//     Widget yes = isLoading
//         ? const Center(child: CircularProgressIndicator())
//         : TextButton(
//             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(pakiDefaultButtonColor)),
//             onPressed: onConfirm,
//             child: const Text('Sim', style: TextStyle(color: Colors.white)));
//     Widget no = isLoading
//         ? const Center(child: CircularProgressIndicator())
//         : TextButton(
//             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(pakiDefaultButtonColor)),
//             onPressed: onCancel,
//             child: const Text('Não', style: TextStyle(color: Colors.white)));
//     AlertDialog alert = AlertDialog(
//         title: const Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Text('Atenção'),
//             PakiVerticalDiv(width: 5.0),
//             Icon(Icons.info),
//           ]),
//           PakiHorizontalDiv(height: 15.0),
//           Divider(height: 1.0, color: Colors.white)
//         ]),
//         content: Text(message),
//         actions: [yes, no],
//         backgroundColor: pakiDefaultSecondaryColor);
//
//     if (!context.mounted) return;
//     showDialog(
//         context: context,
//
//         builder: (BuildContext context) {
//           return alert;
//         });
//   }
// }

void pakiShowQuestionYesNo({
  required BuildContext context,
  required String message,
  required Function() onConfirm,
  required Function() onCancel,
  bool? isLoading,
  bool? needsConfirm,
}) {
  needsConfirm ??= true;
  isLoading ??= false;

  if (!needsConfirm) {
    onConfirm();
  } else {
    // Exibir o Dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder( // Permite que o diálogo atualize o estado
          builder: (context, setState) {
            // Botões que mudam dependendo do estado de isLoading

            Widget yes = isLoading!
                ? const Center(child: CircularProgressIndicator())
                : TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(pakiDefaultButtonColor)),
              onPressed: () {
                setState(() {
                  isLoading = true; // Exibe o loading
                });
                onConfirm();
              },
              child: const Text('Sim', style: TextStyle(color: Colors.white)),
            );

            Widget no = isLoading!
                ? const Center(child: CircularProgressIndicator())
                : TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(pakiDefaultButtonColor)),
              onPressed: onCancel,
              child: const Text('Não', style: TextStyle(color: Colors.white)),
            );

            return AlertDialog(
              title: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Atenção'),
                      SizedBox(width: 5.0),
                      Icon(Icons.info),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Divider(height: 1.0, color: Colors.white),
                ],
              ),
              content: Text(message),
              actions: [Row(mainAxisAlignment: MainAxisAlignment.end,  children: [yes, const PakiVerticalDiv() , no])],
              backgroundColor: pakiDefaultSecondaryColor,
            );
          },
        );
      },
    );
  }
}

pakiShowSnackBar(
    {required BuildContext context, required Widget content, required Color color, SnackBarAction? action}) {
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: content, backgroundColor: color, duration: const Duration(seconds: 5), action: action));
}

pakiShowSnackBarErrors(
    {required BuildContext context, required String content, SnackBarAction? action, String? urlImage}) {
  if (!context.mounted) return;
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

void pakiShowGlobalModal({
  required BuildContext context,
  required Widget content,
  required Color color,
}) {
  if (!context.mounted) return;

  showDialog(
    context: context,
    barrierDismissible: false, // impede fechar tocando fora
    builder: (BuildContext dialogContext) {
      // Timer para fechar após 30 segundos
      Future.delayed(const Duration(seconds: 30), () {
        if (Navigator.of(dialogContext).canPop()) {
          Navigator.of(dialogContext).pop();
        }
      });

      return AlertDialog(
        backgroundColor: color,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            content,
            const SizedBox(height: 20),
            const LinearProgressIndicator(), // barra de progresso
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (Navigator.of(dialogContext).canPop()) {
                Navigator.of(dialogContext).pop();
              }
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
