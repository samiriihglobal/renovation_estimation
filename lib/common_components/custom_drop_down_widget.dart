import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  final double height;
  final double width;
  final TextStyle textStyle;
  final Color backgroundColor;
  final Color borderColor;
  final BorderRadius borderRadius;
  final Widget? icon;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.height = 30,
    this.width = 54,
    this.textStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFD7D7D7),
    this.borderRadius = const BorderRadius.all(Radius.circular(7)),
    this.icon,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    // 1. Logic to determine if the current value is actually valid/present in the list
    // If it's an empty string or not in the list, we treat it as null
    final bool isValuePresent = widget.items.contains(widget.value);
    final T? effectiveValue = (widget.value == "" || !isValuePresent) ? null : widget.value;

    return Container(
      height: widget.height,
      width: widget.width,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        border: Border.all(color: widget.borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: effectiveValue, // Use the sanitized value
          isExpanded: true,
          // 2. This hint shows when effectiveValue is null
          hint: Text("", style: widget.textStyle),
          icon: widget.icon ?? const Icon(Icons.keyboard_arrow_down, size: 15),
          style: widget.textStyle,
          onChanged: widget.onChanged,
          items: widget.items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                item.toString(),
                style: widget.textStyle,
                overflow: TextOverflow.ellipsis, // Prevents text overflow
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
