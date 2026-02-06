import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;

  // Size
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;

  // Style
  final Color backgroundColor;
  final Color disabledColor;
  final BorderRadius borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;

  // Content
  final String text;
  final TextStyle textStyle;
  final Widget? icon;
  final double iconSpacing;

  // Interaction
  final Color splashColor;
  final Color highlightColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,

    this.height = 40,
    this.width = double.infinity,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),

    this.backgroundColor = const Color(0xFF489B79),
    this.disabledColor = Colors.grey,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.border,
    this.boxShadow,

    this.textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    this.icon,
    this.iconSpacing = 8,

    this.splashColor = Colors.white24,
    this.highlightColor = Colors.transparent,
  });

  bool get _isDisabled => onTap == null;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: splashColor,
        highlightColor: highlightColor,
        borderRadius: borderRadius,
        child: Container(
          height: height,
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            color: _isDisabled ? disabledColor : backgroundColor,
            borderRadius: borderRadius,
            border: border,
            boxShadow: boxShadow,
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) icon!,
                if (icon != null) SizedBox(width: iconSpacing),
                Text(text, style: textStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
