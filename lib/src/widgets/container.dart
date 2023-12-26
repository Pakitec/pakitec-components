import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pakitec_themes/pakitec_themes.dart';

class PakiContainer extends StatefulWidget {
  final Widget? child;
  final bool? ignoreMaxWidth;
  final bool? withDecoration;

  const PakiContainer({Key? key, this.child, this.ignoreMaxWidth, this.withDecoration}) : super(key: key);

  @override
  State<PakiContainer> createState() => _PakiContainerState();
}

class _PakiContainerState extends State<PakiContainer> {
  bool ignoreMaxWidth = false;
  bool withDecoration = true;

  @override
  void initState() {
    super.initState();
    if (widget.ignoreMaxWidth != null) ignoreMaxWidth = widget.ignoreMaxWidth!;
    if (widget.withDecoration != null) withDecoration = widget.withDecoration!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: withDecoration ? pakiDefaultBoxDecoration : null,
        child: Center(
            child: Container(
                width: ignoreMaxWidth
                    ? double.maxFinite
                    : kIsWeb
                        ? 1280
                        : double.maxFinite,
                alignment: Alignment.center,
                child: widget.child)));
  }
}
