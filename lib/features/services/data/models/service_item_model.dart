import 'package:flutter/material.dart';

class ServiceItemModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isComingSoon;

  ServiceItemModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isComingSoon = true,
  });
}