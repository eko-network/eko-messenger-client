import 'package:eko_messenger/utils/constants.dart' as c;
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MaybeCard extends StatelessWidget {
  final Widget? child;
  final Widget? title;
  final Widget? description;
  final Widget? footer;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final ShadBorder? border;
  final BorderRadius? radius;
  final List<BoxShadow>? shadows;
  final Color? backgroundColor;

  const MaybeCard({
    super.key,
    this.child,
    this.title,
    this.description,
    this.footer,
    this.trailing,
    this.padding,
    this.width,
    this.height,
    this.border,
    this.radius,
    this.shadows,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < c.wideScreen;

        return ShadCard(
          title: title,
          description: description,
          footer: footer,
          trailing: trailing,
          padding: padding,
          width: width,
          height: height,
          border: isNarrow ? ShadBorder.all(color: Colors.transparent) : border,
          radius: radius,
          shadows: shadows,
          backgroundColor: backgroundColor,
          child: child,
        );
      },
    );
  }
}
