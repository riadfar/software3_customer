import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../notifications/presentation/screens/notifications_screen.dart';
import '../../../../settings/presentation/screens/settings_screen.dart';


class ModernHeader extends StatelessWidget {
  final String customerName;

  const ModernHeader({
    super.key,
    required this.customerName, // Required
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning,",
              style: TextStyle(
                color: AppTheme.greyText,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              customerName.isNotEmpty ? customerName : "Valued Customer",
              style: const TextStyle(
                color: AppTheme.navy,
                fontSize: 26,
                fontWeight: FontWeight.w900,
                fontFamily: 'Roboto Slab',
              ),
            ),
          ],
        ),

        Row(
          children: [
            _buildNeuIconButton(
              Icons.settings_outlined,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
            ),

            const SizedBox(width: 16),

            _buildNeuIconButton(
              Icons.notifications_none_rounded,
              hasBadge: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNeuIconButton(
      IconData icon, {
        bool hasBadge = false,
        VoidCallback? onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF3F6),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.navy.withOpacity(0.15),
              offset: const Offset(5, 5),
              blurRadius: 10,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: const Offset(-5, -5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon, color: AppTheme.navy, size: 28),
            if (hasBadge)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: const Color(0xFFEFF3F6),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}