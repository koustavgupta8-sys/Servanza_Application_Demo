import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String text;
  final Color color;
  final bool glow;

  const StatusBadge({super.key, required this.text, required this.color, this.glow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(.18),
        borderRadius: BorderRadius.circular(12),
        boxShadow: glow
            ? [
                BoxShadow(color: color.withOpacity(.35), blurRadius: 18, spreadRadius: 1),
              ]
            : [],
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}