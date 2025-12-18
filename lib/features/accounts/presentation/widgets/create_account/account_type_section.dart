import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import 'account_type_selector.dart';

class AccountTypeSection extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTypeSelected;

  const AccountTypeSection({
    super.key,
    required this.selectedIndex,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Account Type",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.navy),
        ),
        const SizedBox(height: 16),

        AccountTypeSelector(
          title: "Savings Account",
          subtitle: "High interest, limited withdrawals.",
          icon: Icons.savings_rounded,
          isSelected: selectedIndex == 0,
          onTap: () => onTypeSelected(0),
        ),
        const SizedBox(height: 12),

        AccountTypeSelector(
          title: "Checking Account",
          subtitle: "For daily expenses and transfers.",
          icon: Icons.payments_rounded,
          isSelected: selectedIndex == 1,
          onTap: () => onTypeSelected(1),
        ),
        const SizedBox(height: 12),

        AccountTypeSelector(
          title: "Business Account",
          subtitle: "High limits, special features.",
          icon: Icons.business_center_rounded,
          isSelected: selectedIndex == 2,
          onTap: () => onTypeSelected(2),
        ),
      ],
    );
  }
}