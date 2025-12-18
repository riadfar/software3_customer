import 'package:flutter/material.dart';
import 'account_selector.dart';
import 'manual_deposit_form.dart';

class DepositFormSection extends StatelessWidget {
  final String selectedAccountName;
  final Function(String name, String identifier) onAccountChanged;
  final TextEditingController refController;
  final TextEditingController amountController;
  final List<Map<String, dynamic>> accounts;

  const DepositFormSection({
    super.key,
    required this.selectedAccountName,
    required this.onAccountChanged,
    required this.refController,
    required this.amountController,
    required this.accounts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccountSelector(
          selectedAccountName: selectedAccountName,
          onAccountChanged: onAccountChanged,
          accounts: accounts,
        ),
        const SizedBox(height: 20),
        ManualDepositForm(
          refController: refController,
          amountController: amountController,
        ),
      ],
    );
  }
}