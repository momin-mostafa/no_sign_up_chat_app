import 'package:flutter/material.dart';

class ChatAppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color indigo = Color(0xFF4F46E5);
  static const Color green = Color(0xFF22C55E);
  static const Color deepGreen = Color(0xFF16A34A);
  static const Color grey = Colors.grey;
  static const Color black = Color(0xFF0A0A0A);
  static const Color deepGrey = Colors.black54;

  static const Map<String, Color> memberColors = {
    "alice": Color(0xFFE91E63),
    "bob": Color(0xFF2196F3),
    "charlie": Color(0xFFFF9800),
    "diana": Color(0xFF9C27B0),
    "eve": Color(0xFF4CAF50),
    "frank": Color(0xFF00BCD4),
  };

  static Color memberColor(Color fallback, String name) {
    final key = name.toLowerCase();
    return memberColors[key] ?? fallback;
  }
}

const double radius = 16;
