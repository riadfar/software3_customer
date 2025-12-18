import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class AccountStatusCard extends StatelessWidget {
  final String accountName;
  final String amount;
  final bool isFrozen;
  final bool isRequestPending;

  const AccountStatusCard({
    super.key,
    required this.accountName,
    required this.amount,
    required this.isFrozen,
    required this.isRequestPending,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        // --- State Pattern Visual Logic ---
        // إذا كان مجمداً: لون رمادي سادة
        // إذا كان نشطاً: تدرج لوني كحلي فخم (نفس الشاشة الرئيسية)
        color: isFrozen ? Colors.grey.shade400 : null,
        gradient: isFrozen
            ? null
            : const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0D1B2A), // Navy
            Color(0xFF1B263B), // Light Navy
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: (isFrozen ? Colors.grey : AppTheme.navy).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // الأيقونة
              Icon(
                isFrozen ? Icons.lock : Icons.account_balance_wallet,
                color: Colors.white.withOpacity(0.5),
                size: 30,
              ),
              // شارات الحالة (Badges)
              Row(
                children: [
                  if (isRequestPending) _buildBadge("PENDING", Colors.orange),
                  if (isRequestPending) const SizedBox(width: 8),
                  _buildBadge(
                    isFrozen ? "FROZEN" : "ACTIVE",
                    isFrozen ? Colors.red : Colors.green,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),

          // اسم الحساب
          Text(
            accountName,
            style: TextStyle(
              color: isFrozen ? Colors.white70 : AppTheme.platinum.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),

          // الرصيد (ذهبي في حالة النشاط)
          Text(
            amount,
            style: TextStyle(
              color: isFrozen ? Colors.white : AppTheme.gold,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto Slab',
            ),
          ),
          const SizedBox(height: 8),

          // رقم الحساب الوهمي
          const Text(
            "**** 8459",
            style: TextStyle(
              color: Colors.white38,
              fontSize: 14,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}