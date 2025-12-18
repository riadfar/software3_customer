import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; //
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/dialog_utils.dart';
import '../../../../core/widgets/page_header.dart';
import '../../data/model/account.dart'; //
import '../../logic/account/account_cubit.dart';
import '../widgets/account_details/account_status_card.dart';
import '../widgets/account_details/account_action_tile.dart';
import '../widgets/account_details/freeze_request_tile.dart';

class AccountDetailsScreen extends StatefulWidget {
  final Account account;

  const AccountDetailsScreen({
    super.key,
    required this.account,
  });

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {
          if (state.status == AccountStatus.loaded) {
            Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst || route.settings.name != 'loading_dialog');

            DialogUtils.showSuccess(
              context,
              title: "Success",
              content: "Your request has been submitted successfully.",
            );
          } else if (state.status == AccountStatus.error) {
            Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst || route.settings.name != 'loading_dialog');

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.messages.first),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state.status == AccountStatus.loading) {
            // إظهار Loading Dialog
            DialogUtils.showLoading(context);
          }
        },
        builder: (context, state) {

          final displayAccount = widget.account;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageHeader(title: "Account Details"),
                  const SizedBox(height: 30),

                  AccountStatusCard(
                    accountName: _getAccountTypeName(displayAccount.accountType),
                    amount: "\$${displayAccount.balance}",
                    isFrozen: displayAccount.isFrozen,
                    isRequestPending: false,
                  ),

                  const SizedBox(height: 30),
                  const Text(
                    "Management",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.navy,
                      fontFamily: 'Roboto Slab',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Freeze / Unfreeze
                  FreezeRequestTile(
                    isFrozen: displayAccount.isFrozen,
                    isRequestPending: false,
                    onCancelRequest: () {},
                    onRequestAction: () => _handleFreezeRequest(context, displayAccount),
                  ),

                  const SizedBox(height: 16),

                  // Closure Request
                  AccountActionTile(
                    icon: Icons.delete_forever_rounded,
                    title: "Request Closure",
                    subtitle: "Submit a request to close this account",
                    color: Colors.red,
                    isDestructive: true,
                    onTap: () => _handleCloseRequest(context, displayAccount),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- Logic Handlers ---

  String _getAccountTypeName(AccountType type) { //
    switch (type) {
      case AccountType.savings: return "Savings Account";
      default: return "Current Account";
    }
  }

  void _handleFreezeRequest(BuildContext context, Account account) {
    DialogUtils.showConfirmation(
      context,
      title: account.isFrozen ? "Request Unfreeze?" : "Request Freeze?",
      content: account.isFrozen
          ? "Submit a request to restore access to this account?"
          : "Submit a request to block all outgoing transactions?",
      confirmText: "Submit Request",
      confirmColor: AppTheme.navy,
      onConfirm: () {
        Navigator.pop(context); // إغلاق الديالوج

        // استدعاء الكيوبت
        context.read<AccountCubit>().freezeRequest(
          accountNumber: account.accountNumber,
          reason: "Customer requested via App", // سبب افتراضي
        );
      },
    );
  }

  void _handleCloseRequest(BuildContext context, Account account) {
    DialogUtils.showConfirmation(
      context,
      title: "Close Account?",
      content: "Are you sure you want to request permanent closure? This action cannot be undone.",
      confirmText: "Request Closure",
      confirmColor: Colors.red,
      onConfirm: () {
        Navigator.pop(context); // إغلاق الديالوج

        // استدعاء الكيوبت
        context.read<AccountCubit>().closureRequest(
          accountNumber: account.accountNumber,
          reason: "Customer requested via App",
        );
      },
    );
  }
}