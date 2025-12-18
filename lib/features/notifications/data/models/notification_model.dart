import 'package:flutter/material.dart';

enum NotificationType { transaction, security, info, promo }

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String time;
  final NotificationType type;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.type,
    this.isRead = false,
  });

  // دالة مساعدة لاختيار اللون والأيقونة حسب النوع
  Color get color {
    switch (type) {
      case NotificationType.transaction: return Colors.green;
      case NotificationType.security: return Colors.red;
      case NotificationType.promo: return Colors.orange;
      default: return const Color(0xFF0D1B2A); // Navy
    }
  }

  IconData get icon {
    switch (type) {
      case NotificationType.transaction: return Icons.attach_money;
      case NotificationType.security: return Icons.shield_outlined;
      case NotificationType.promo: return Icons.local_offer_outlined;
      default: return Icons.notifications_none;
    }
  }
}