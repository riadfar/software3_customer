import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() =>
      _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState
    extends State<NotificationsSettingsScreen> {
  // Observer Preferences
  bool _pushEnabled = true;
  bool _emailEnabled = true;
  bool _smsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageHeader(title: "Notification Preferences"),
              const SizedBox(height: 10),
              const Text(
                "Choose how you want to be notified about account activities.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              _buildNotificationOption(
                "Push Notifications",
                "Receive instant alerts on your device.",
                Icons.notifications_active_outlined,
                _pushEnabled,
                (val) => setState(() => _pushEnabled = val),
              ),
              _buildNotificationOption(
                "Email Alerts",
                "Receive transaction summaries.",
                Icons.email_outlined,
                _emailEnabled,
                (val) => setState(() => _emailEnabled = val),
              ),
              _buildNotificationOption(
                "SMS Alerts",
                "Receive secure text messages.",
                Icons.sms_outlined,
                _smsEnabled,
                (val) => setState(() => _smsEnabled = val),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationOption(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SwitchListTile(
        secondary: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.navy.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppTheme.navy),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.navy,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        value: value,
        activeColor: AppTheme.gold,
        onChanged: onChanged,
      ),
    );
  }
}
