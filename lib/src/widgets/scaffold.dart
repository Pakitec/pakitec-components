import 'package:flutter/material.dart';
import 'package:pakitec_themes/pakitec_themes.dart';

class PakiScaffold extends StatefulWidget {
  final String? label;
  final Widget? widgetLabel;
  final Widget? head;
  final Widget? body;
  final GlobalKey<FormState>? formKey;
  final Function()? onConfirm;
  final Widget? widgetButton;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final BoxDecoration? boxDecoration;

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
      this.floatingActionButton,
      this.drawer,
      this.bottomNavigationBar,
      this.backgroundColor,
      this.boxDecoration})
      : super(key: key);

  @override
  State<PakiScaffold> createState() => _PakiScaffoldState();
}

class _PakiScaffoldState extends State<PakiScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: widget.widgetLabel ?? Text(widget.label ?? ''),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: widget.backgroundColor ?? pakiDefaultSecondaryColor,
            actions: [
              widget.widgetButton != null ? widget.widgetButton! : Container(),
              widget.onConfirm != null
                  ? IconButton(onPressed: widget.onConfirm, icon: const Icon(Icons.check))
                  : Container()
            ]),
        drawer: widget.drawer,
        floatingActionButton: widget.floatingActionButton,
        bottomNavigationBar: widget.bottomNavigationBar,
        body: Form(
            key: widget.formKey,
            child: Container(
                decoration: widget.boxDecoration ?? pakiDefaultBoxDecoration,
                child: Column(children: [
                  widget.head != null ? Container(padding: const EdgeInsets.all(5), child: widget.head) : Container(),
                  Expanded(child: widget.body ?? Container())
                ]))));
  }
}
