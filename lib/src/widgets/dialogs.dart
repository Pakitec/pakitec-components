import 'package:flutter/material.dart';
import 'package:pakitec_themes/pakitec_themes.dart';
import 'divider.dart';
import 'dart:async';

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
  required String title,
  required String message,
  required Color color,
  int secondsToClose = 30,
  IconData iconData = Icons.warning,
  Function()? onOk,
}) {
  if (!context.mounted) return;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      ValueNotifier<double> progress = ValueNotifier(0);

      final int totalMillis = secondsToClose * 1000;
      final int stepMillis = 100;
      int elapsedMillis = 0;

      Timer.periodic(Duration(milliseconds: stepMillis), (timer) {
        elapsedMillis += stepMillis;
        progress.value = elapsedMillis / totalMillis;

        if (elapsedMillis >= totalMillis) {
          timer.cancel();
          if (Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
            onOk?.call();
          }
        }
      });

      return AlertDialog(
        backgroundColor: color.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2),
                radius: 30,
                child: Icon(
                  iconData,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.3),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                if (Navigator.of(dialogContext).canPop()) {
                  Navigator.of(dialogContext).pop();
                  onOk?.call();
                }
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight,
              child: ValueListenableBuilder<double>(
                valueListenable: progress,
                builder: (context, value, _) => SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    value: value.clamp(0.0, 1.0),
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 3,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
