import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';
import '../../data/models/notification_model.dart';
import '../widgets/notification_tile.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      title: 'Payment Received',
      body: 'You received \$450.00 from John Doe.',
      time: '2m ago',
      type: NotificationType.transaction,
    ),
    NotificationModel(
      id: '2',
      title: 'Security Alert',
      body: 'New login detected from iPhone 13 Pro.',
      time: '1h ago',
      type: NotificationType.security,
    ),
    NotificationModel(
      id: '3',
      title: 'Statement Ready',
      body: 'Your December monthly statement is now available.',
      time: '1d ago',
      type: NotificationType.info,
    ),
    NotificationModel(
      id: '4',
      title: 'New Feature',
      body:
          'Try our new Budget Planning tool today!Try our new Budget Planning tool today!Try our new Budget Planning tool today!Try our new Budget Planning tool today!Try our new Budget Planning tool today!',
      time: '2d ago',
      type: NotificationType.promo,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: PageHeader(title: "Notifications"),
            ),

            Expanded(
              child: _notifications.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        final item = _notifications[index];
                        return NotificationTile(
                          notification: item,
                          onDismissed: (id) => _removeItem(id, index, item),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeItem(String id, int index, NotificationModel item) {
    setState(() {
      _notifications.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Notification deleted"),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
          label: "UNDO",
          textColor: AppTheme.gold,
          onPressed: () {
            setState(() {
              _notifications.insert(index, item);
            });
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            "No Notifications",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
