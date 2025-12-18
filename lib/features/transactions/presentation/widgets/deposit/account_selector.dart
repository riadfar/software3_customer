import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class AccountSelector extends StatelessWidget {
  final String selectedAccountName;
  final Function(String name, String identifier) onAccountChanged;
  final List<Map<String, dynamic>> accounts;

  const AccountSelector({
    super.key,
    required this.selectedAccountName,
    required this.onAccountChanged,
    required this.accounts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Deposit To Account",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showAccountPicker(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
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
                const Icon(Icons.account_balance_wallet_rounded, color: AppTheme.navy),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedAccountName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.navy,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showAccountPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Account",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.navy),
            ),
            const SizedBox(height: 16),
            if (accounts.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("No accounts available"),
              )
            else
              ...accounts.map((account) => _buildAccountItem(context, account)),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountItem(BuildContext context, Map<String, dynamic> account) {
    final isSelected = account['name'] == selectedAccountName;
    return InkWell(
      onTap: () {
        // نمرر الاسم والمعرف (رقم الحساب أو الآيدي)
        onAccountChanged(account['name']!, account['identifier']!);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppTheme.gold : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                account['name']!,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: AppTheme.navy,
                ),
              ),
            ),
            Text(
              "\$${account['balance']}",
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}