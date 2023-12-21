import 'package:flutter/material.dart';

import '../styles/main_style.dart';

class PakiScaffold extends StatefulWidget {
  final String? label;
  final Widget? widgetLabel;
  final Widget? head;
  final Widget? body;
  final GlobalKey<FormState>? formKey;
  final Function()? onConfirm;
  final Widget? widgetButton;
  final Widget? floatingActionButton;

  // final bool? showSideMenu;

  const PakiScaffold(
      {Key? key,
      this.label,
      this.widgetLabel,
      this.head,
      this.body,
      this.formKey,
      this.onConfirm,
      this.widgetButton,
      this.floatingActionButton}) : super(key: key);

  @override
  State<PakiScaffold> createState() => _PakiScaffoldState();
}

class _PakiScaffoldState extends State<PakiScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: widget.widgetLabel ?? Text(widget.label!),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: secondaryColor,
            actions: [
              widget.widgetButton != null ? widget.widgetButton! : Container(),
              widget.onConfirm != null
                  ? IconButton(onPressed: widget.onConfirm, icon: const Icon(Icons.check))
                  : Container()
            ]),
        // drawer: widget.showSideMenu == false ? Container() : const SideMenu(),
        floatingActionButton: widget.floatingActionButton,
        body: Form(
            key: widget.formKey,
            child: Container(
                decoration: boxDecoration,
                child: Column(children: [
                  widget.head != null ? Container(padding: const EdgeInsets.all(5), child: widget.head) : Container(),
                  Expanded(child: widget.body ?? Container())
                ]))));
  }
}
