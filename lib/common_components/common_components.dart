
import 'package:flutter/material.dart';

class UpArrowWidget extends StatelessWidget {
  const UpArrowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E6),
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Icon(
        Icons.arrow_upward,
        color: Color(0xFF6E6E6E),
        size: 16,
      ),
    );
  }
}

class DownArrowWidget extends StatelessWidget {
  const DownArrowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E6),
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Icon(
        Icons.arrow_downward,
        color: Color(0xFF6E6E6E),
        size: 16,
      ),
    );
  }
}