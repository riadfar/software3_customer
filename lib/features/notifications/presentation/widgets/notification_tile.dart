import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/notification_model.dart';

class NotificationTile extends StatefulWidget {
  final NotificationModel notification;
  final Function(String) onDismissed;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onDismissed,
  });

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => widget.onDismissed(widget.notification.id),
      background: _buildSwipeBackground(),


      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: widget.notification.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.notification.icon,
                    color: widget.notification.color, size: 24),
              ),
              const SizedBox(width: 16),

              // النصوص
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.notification.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.navy,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          widget.notification.time,
                          style: TextStyle(
                              color: Colors.grey[400], fontSize: 11),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),


                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.notification.body,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                          height: 1.4,
                        ),

                        maxLines: _isExpanded ? null : 1,
                        overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                      ),
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeBackground() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(Icons.delete_outline_rounded,
          color: Colors.white, size: 28),
    );
  }
}