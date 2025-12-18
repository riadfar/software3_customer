import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({
    super.key,
    required this.isFrozen,
    required this.title,
    required this.status,
    required this.amount,
    required this.onTap,
  });

  final bool isFrozen;
  final String title;
  final String status;
  final String amount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          // --- تعديل الظل هنا ---
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0D1B2A).withOpacity(0.06),
              // ظل مائل للكحلي قليلاً جداً
              blurRadius: 15,
              offset: const Offset(0, 5),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isFrozen
                    ? Colors.red.withOpacity(0.1)
                    : AppTheme.navy.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFrozen
                    ? Icons.lock_outline
                    : Icons.account_balance_wallet_outlined,
                color: isFrozen ? Colors.red : AppTheme.navy,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.navy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status,
                    style: TextStyle(
                      color: isFrozen ? Colors.red : Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppTheme.navy,
                fontFamily: 'Roboto Slab',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
