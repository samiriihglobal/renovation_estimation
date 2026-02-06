import 'package:flutter/material.dart';

/// 1. CREATE THIS HELPER WIDGET (Put it at the bottom of your file)
class ReactiveNumericInput extends StatefulWidget {
  final double value;
  final double width;
  final Function(double) onChanged;
  final String fieldKey; // e.g. "unitary" or "amount"

  const ReactiveNumericInput({
    super.key,
    required this.value,
    required this.width,
    required this.onChanged,
    required this.fieldKey,
  });

  @override
  State<ReactiveNumericInput> createState() => _ReactiveNumericInputState();
}

class _ReactiveNumericInputState extends State<ReactiveNumericInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize with current value
    _controller = TextEditingController(text: widget.value.toStringAsFixed(0));
  }

  @override
  void didUpdateWidget(ReactiveNumericInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the value changed from the outside (e.g. controller reset), update text
    // But ONLY if the user isn't currently typing (to avoid jumping)
    if (double.tryParse(_controller.text) != widget.value) {
      _controller.text = widget.value.toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: const Color(0xFFD7D7D7)),
      ),
      child: TextFormField(
        controller: _controller,
        keyboardType: TextInputType.number,
        onChanged: (val) {
          final doubleValue = double.tryParse(val) ?? 0;
          widget.onChanged(doubleValue);
        },
        style: const TextStyle(fontSize: 12),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }
}