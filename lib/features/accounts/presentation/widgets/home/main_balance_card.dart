import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../data/model/account.dart';
import '../../screens/account_details_screen.dart';



class MainBalanceCard extends StatelessWidget {
  final Account account;

  const MainBalanceCard({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccountDetailsScreen(
              account: account,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height *.23,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D1B2A),
              Color(0xFF1B263B),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppTheme.navy.withOpacity(0.3),
              blurRadius: 30,
              offset: const Offset(10, 10),
              spreadRadius: -5,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 1,
              offset: const Offset(-1, -1),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.nfc, color: Colors.white38, size: 30),
                Text(
                  "HORIZON",
                  style: TextStyle(
                    color: Colors.white38,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Balance",
                  style: TextStyle(
                    color: AppTheme.platinum.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                // عرض الرصيد من الكائن
                Text(
                  "\$ ${account.balance}",
                  style: const TextStyle(
                    color: AppTheme.gold,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto Slab',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // تحديد نوع الحساب للعرض
                _buildCardTag(
                    account.accountType == AccountType.savings
                        ? "Savings Account"
                        : "Current Account"
                ),
                // عرض رقم الحساب
                Text(
                  "**** ${account.accountNumber.length > 4 ? account.accountNumber.substring(account.accountNumber.length - 4) : account.accountNumber}",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
