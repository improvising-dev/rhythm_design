import 'package:flutter/widgets.dart';

import '../app/theme_provider.dart';
import '../design/ui_props.dart';
import 'touchable.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.title,
    this.textStyle,
    this.child,
    this.effects = const [UITouchableEffect.color],
    this.variant = UIVariant.primary,
    this.width,
    this.height = 50.0,
    this.padding,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
    this.textColor,
    this.backgroundColor,
    this.focusColor,
    this.onPressed,
  })  : assert(child != null || title != null),
        super(key: key);

  final String? title;
  final TextStyle? textStyle;
  final Widget? child;
  final List<UITouchableEffect> effects;
  final UIVariant variant;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final BoxShape shape;
  final BorderRadius? borderRadius;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? focusColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context);
    final buttonVariant = theme.buttonVariant[variant]!;
    final _title = title;

    Widget builder = Touchable(
      effects: effects,
      focusColor: focusColor ?? buttonVariant.focusColor,
      borderRadius: borderRadius ?? theme.borderRadius,
      onPressed: onPressed,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? buttonVariant.backgroundColor,
          borderRadius: shape == BoxShape.rectangle
              ? borderRadius ?? theme.borderRadius
              : null,
          shape: shape,
        ),
        child: _title != null
            ? Text(
                _title,
                style: TextStyle(color: textColor ?? buttonVariant.textColor)
                    .merge(textStyle),
              )
            : child,
      ),
    );

    if (onPressed == null) {
      builder = Opacity(
        opacity: theme.buttonDisabledOpacity,
        child: builder,
      );
    }

    return Semantics(
      excludeSemantics: true,
      label: title,
      button: true,
      child: builder,
    );
  }
}

class IconButton extends StatelessWidget {
  const IconButton({
    Key? key,
    required this.label,
    required this.icon,
    this.effects = const [UITouchableEffect.color],
    this.variant = UIVariant.primary,
    this.size,
    this.iconColor,
    this.backgroundColor,
    this.focusColor,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final Icon icon;
  final List<UITouchableEffect> effects;
  final UIVariant variant;
  final double? size;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? focusColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context);
    final buttonVariant = theme.buttonVariant[variant]!;

    Widget builder = Touchable(
      effects: effects,
      focusColor: focusColor ?? buttonVariant.focusColor,
      focusShape: BoxShape.circle,
      onPressed: onPressed,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? buttonVariant.backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon.icon,
          size: icon.size,
          color: icon.color ?? iconColor ?? buttonVariant.textColor,
        ),
      ),
    );

    if (onPressed == null) {
      builder = Opacity(
        opacity: theme.buttonDisabledOpacity,
        child: builder,
      );
    }

    return Semantics(
      excludeSemantics: true,
      label: label,
      button: true,
      child: builder,
    );
  }
}
