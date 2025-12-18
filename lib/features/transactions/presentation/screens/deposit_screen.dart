import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/dialog_utils.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../accounts/logic/account/account_cubit.dart';
import '../../logic/transaction/transaction_cubit.dart';

import '../widgets/deposit/deposit_method_toggle.dart';
import '../widgets/deposit/deposit_scanner_section.dart';
import '../widgets/deposit/deposit_form_section.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  bool _isQrMode = true;
  final _amountController = TextEditingController();
  final _refController = TextEditingController();

  String _selectedAccountName = "";
  String _selectedAccountIdentifier = "";

  @override
  void initState() {
    super.initState();
    final state = context.read<AccountCubit>().state;
    if (state.status == AccountStatus.loaded) {
      _selectedAccountName = "Main Account";
      _selectedAccountIdentifier = state.account.accountNumber;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _refController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: BlocListener<TransactionCubit, TransactionState>(
        listener: (context, state) {
          if (state.status == TransactionStatus.loading) {
            DialogUtils.showLoading(context);
          } else if (state.status == TransactionStatus.success) {
            Navigator.of(context, rootNavigator: true).pop();

            DialogUtils.showSuccess(
              context,
              title: "Deposit Successful",
              content: "Deposited \$${_amountController.text} successfully.",
            );

            _amountController.clear();
            _refController.clear();

            context.read<AccountCubit>().getCustomerAccount(
                accountNumber: context.read<AccountCubit>().state.account.accountNumber
            );
          } else if (state.status == TransactionStatus.error) {
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error.messages.first), backgroundColor: Colors.red),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const PageHeader(title: "Deposit Funds"),
                const SizedBox(height: 30),

                DepositMethodToggle(
                  isQrMode: _isQrMode,
                  onModeChanged: (val) {
                    setState(() {
                      _isQrMode = val;
                      if (val) {
                        _refController.clear();
                        _amountController.clear();
                      }
                    });
                  },
                ),
                const SizedBox(height: 30),

                BlocBuilder<AccountCubit, AccountState>(
                  builder: (context, state) {
                    final List<Map<String, dynamic>> accountsList = [];

                    if (state.status == AccountStatus.loaded) {
                      accountsList.add({
                        'name': 'Main Account',
                        'balance': state.account.balance,
                        'identifier': state.account.accountNumber,
                      });

                      for (var sub in state.account.subAccounts) {
                        accountsList.add({
                          'name': sub.name,
                          'balance': sub.balance,
                          'identifier': sub.id.toString(),
                        });
                      }
                    }

                    if (_selectedAccountName.isEmpty && accountsList.isNotEmpty) {
                      _selectedAccountName = accountsList.first['name'];
                      _selectedAccountIdentifier = accountsList.first['identifier'];
                    }

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: _isQrMode
                          ? DepositScannerSection(
                        onCodeScanned: (ref, amount) {
                          setState(() {
                            _refController.text = ref;
                            _amountController.text = amount;
                            _isQrMode = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Bill loaded!"), backgroundColor: Colors.green),
                          );
                        },
                      )
                          : DepositFormSection(
                        selectedAccountName: _selectedAccountName,
                        accounts: accountsList,
                        onAccountChanged: (name, identifier) {
                          setState(() {
                            _selectedAccountName = name;
                            _selectedAccountIdentifier = identifier;
                          });
                        },
                        refController: _refController,
                        amountController: _amountController,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleDeposit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.navy,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 5,
                      shadowColor: AppTheme.navy.withOpacity(0.4),
                    ),
                    child: const Text("Confirm Deposit", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleDeposit() {
    if (_refController.text.isEmpty || _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter details"), backgroundColor: Colors.red),
      );
      return;
    }

    if (_selectedAccountIdentifier.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an account"), backgroundColor: Colors.red),
      );
      return;
    }

    context.read<TransactionCubit>().makeDeposit(
      accountNumber: _selectedAccountIdentifier, // يتم إرسال الرقم المختار (رئيسي أو فرعي)
      reference: _refController.text,
      amount: double.tryParse(_amountController.text) ?? 0.0,
    );
  }
}