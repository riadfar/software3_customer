import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theme/app_theme.dart';
import '../../../../../core/biometric_helper/biometric_helper.dart';
import '../../../../../core/widgets/dialog_utils.dart';
import '../../../../../core/widgets/text_field_widget.dart';
import '../../../../accounts/logic/account/account_cubit.dart';
import '../../../logic/transaction/transaction_cubit.dart';

class AmountStep extends StatefulWidget {
  final String recipientName;
  final String accountNumber;
  final VoidCallback onBack;

  const AmountStep({
    super.key,
    required this.recipientName,
    required this.accountNumber,
    required this.onBack,
  });

  @override
  State<AmountStep> createState() => _AmountStepState();
}

class _AmountStepState extends State<AmountStep> {
  final _amountController = TextEditingController();

  // لحفظ رقم الحساب المختار للإرسال منه
  String? _selectedSourceAccountNum;
  double _fee = 0.0;

  @override
  void initState() {
    super.initState();
    // تعيين الحساب الرئيسي كافتراضي عند البدء
    final accountState = context.read<AccountCubit>().state;
    if (accountState.status == AccountStatus.loaded) {
      _selectedSourceAccountNum = accountState.account.accountNumber;
    }

    _amountController.addListener(_calculateFee);
  }

  void _calculateFee() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    setState(() {
      // منطق وهمي: 1% كلفة
      _fee = amount > 0 ? (amount * 0.01).clamp(1.0, 50.0) : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionCubit, TransactionState>(
      listener: (context, state) {
        if (state.status == TransactionStatus.success) {
          Navigator.pop(context);
          DialogUtils.showSuccess(
            context,
            title: "Transfer Successful",
            content: "You sent \$${_amountController.text} to ${widget.recipientName}.",
          );
        } else if (state.status == TransactionStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error.messages.first), backgroundColor: Colors.red),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: widget.onBack,
              child: const Row(
                children: [
                  Icon(Icons.arrow_back_ios, size: 14, color: Colors.grey),
                  Text(" Back to Recipient", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.navy.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.navy.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppTheme.navy,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.recipientName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("Acc: ${widget.accountNumber}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  const Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text("Transfer From", style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.navy)),
            const SizedBox(height: 8),

            _buildSourceAccountSelector(),

            const SizedBox(height: 16),

            CustomTextField(
              label: "Amount",
              icon: Icons.attach_money,
              inputType: TextInputType.number,
              controller: _amountController,
            ),

            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Transfer Fee: \$${_fee.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
              ),
            ),

            const Spacer(),

            BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                if (state.status == TransactionStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleTransfer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.navy,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text("Confirm Transfer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ويدجت لبناء القائمة المنسدلة للحسابات
  Widget _buildSourceAccountSelector() {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        final mainAccount = state.account;
        final allAccounts = [

          {'name': 'Main Account', 'number': mainAccount.accountNumber, 'balance': mainAccount.balance},
          ...mainAccount.subAccounts.map((sub) => {
            'name': sub.name,
            'number': "${mainAccount.accountNumber}-${sub.id}",

          }),
        ];

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedSourceAccountNum,
              hint: const Text("Select Source Account"),
              items: [
                DropdownMenuItem(
                  value: mainAccount.accountNumber,
                  child: Text("Main Account - \$${mainAccount.balance}"),
                ),
                ...mainAccount.subAccounts.map((sub) {
                  return DropdownMenuItem(
                    value: sub.id.toString(),
                    child: Text("${sub.name} - \$${sub.balance}"),
                  );
                }),
              ],
              onChanged: (val) {
                setState(() {
                  _selectedSourceAccountNum = val;
                });
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleTransfer() async {
    if (_amountController.text.isEmpty || _selectedSourceAccountNum == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please check amount and source account")));
      return;
    }

    bool isAuthenticated = await BiometricHelper.authenticate();

    if (isAuthenticated) {
      if (!mounted) return;

      context.read<TransactionCubit>().makeTransfer(
        fromAccountNumber: _selectedSourceAccountNum!,
        toAccountNumber: widget.accountNumber,
        amount: double.parse(_amountController.text),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Authentication Failed"), backgroundColor: Colors.red),
      );
    }
  }
}