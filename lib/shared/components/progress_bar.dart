import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int value;
  final Color? color;

  const ProgressBar({
    super.key,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final doubleValue = value / 100.0;
    final currValue = doubleValue.clamp(0.0, 1.0);
    return LinearProgressIndicator(
      value: currValue,
      color: color,
    );
  }
}
