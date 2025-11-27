import 'package:flutter/material.dart';
import 'package:pakitec_themes/pakitec_themes.dart';

class PakiNewBadge extends StatelessWidget {
  final Widget child;
  final String tooltip;
  final Color badgeColor;
  final EdgeInsets badgePadding;
  final BorderRadius badgeBorderRadius;
  final IconData icon;
  final double iconSize;

  const PakiNewBadge({
    Key? key,
    required this.child,
    required this.tooltip,
    this.badgeColor = const Color(0xFFFFE082),
    this.badgePadding = const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    this.badgeBorderRadius = const BorderRadius.all(Radius.circular(12)),
    this.icon = Icons.star,
    this.iconSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shadow = pakiDefaultBoxDecoration.boxShadow;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: -6,
          right: -6,
          child: Tooltip(
            message: tooltip,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: badgeBorderRadius,
                boxShadow: shadow,
              ),
              child: Padding(
                padding: badgePadding,
                child: Icon(
                  icon,
                  size: iconSize,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
