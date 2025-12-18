import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../data/models/transaction.dart';
import '../../../data/models/transaction_model.dart' hide TransactionType;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/app_theme.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    // 1. تحديد هل العملية إيداع (دخل) أم صرف
    final bool isIncome = transaction.type == TransactionType.deposit;

    // 2. تنسيق التاريخ ليظهر بشكل مقروء
    final String formattedDate = DateFormat('MMM dd, hh:mm a').format(transaction.date);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. Icon Container
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getIconColor(isIncome).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(_getIcon(), color: _getIconColor(isIncome), size: 24),
          ),
          const SizedBox(width: 16),

          // 2. Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان: نستخدم الوصف القادم من السيرفر
                Text(
                  transaction.description.isNotEmpty
                      ? transaction.description
                      : _getTypeName(), // نص احتياطي في حال كان الوصف فارغاً
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.navy,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                // العنوان الفرعي: نضع رقم العملية ليبدو احترافياً
                Text(
                  "Ref: #${transaction.transactionId}",
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
          ),

          // 3. Amount & Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // المبلغ: نضيف إشارة + أو - حسب النوع
              Text(
                "${isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isIncome ? Colors.green : AppTheme.navy,
                  fontFamily: 'Roboto Slab',
                ),
              ),
              const SizedBox(height: 4),
              // التاريخ المنسق
              Text(
                formattedDate,
                style: TextStyle(color: Colors.grey[400], fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // دوال مساعدة لتحديد الألوان والأيقونات والنصوص

  String _getTypeName() {
    switch (transaction.type) {
      case TransactionType.deposit: return "Deposit";
      case TransactionType.withdrawal: return "Withdrawal";
      case TransactionType.transfer: return "Transfer";
      case TransactionType.payment: return "Payment";
      default: return "Transaction";
    }
  }

  Color _getIconColor(bool isIncome) {
    if (isIncome) return Colors.green;
    if (transaction.type == TransactionType.payment) return Colors.orange;
    return Colors.redAccent;
  }

  IconData _getIcon() {
    switch (transaction.type) {
      case TransactionType.deposit: return Icons.arrow_downward_rounded;
      case TransactionType.withdrawal: return Icons.arrow_upward_rounded;
      case TransactionType.payment: return Icons.shopping_bag_outlined;
      case TransactionType.transfer: return Icons.swap_horiz_rounded;
      default: return Icons.receipt_long_rounded;
    }
  }
}