import 'package:flutter/material.dart';

class AttachmentItem {
  final String name;
  final IconData icon;
  final Color color;
  final String value;

  AttachmentItem({
    required this.name,
    required this.icon,
    required this.color,
    required this.value,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AttachmentItem && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
