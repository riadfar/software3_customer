import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../logic/account/account_cubit.dart';
import '../widgets/home/account_tile.dart';
import '../widgets/home/main_balance_card.dart';
import '../widgets/home/modern_header.dart';
import '../widgets/home/quick_action_grid.dart';
import 'account_details_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/secure_storage_service.dart';
import '../../data/model/account.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _fetchAccountData();
  }

  Future<void> _fetchAccountData() async {
    // نجلب رقم الحساب المخزن (الذي تم حفظه عند تسجيل الدخول)
    final accountNumber = await SecureStorage.getAccountNumber();
    if (accountNumber != null && mounted) {
      context.read<AccountCubit>().getCustomerAccount(
        accountNumber: accountNumber,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: SafeArea(
        // استخدام BlocBuilder للاستماع لحالة البيانات
        child: BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            // 1. حالة التحميل
            if (state.status == AccountStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(color: AppTheme.navy),
              );
            }

            // 2. حالة الخطأ
            if (state.status == AccountStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 50,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.error.messages.isNotEmpty
                          ? state.error.messages.first
                          : "Something went wrong",
                    ),
                    TextButton(
                      onPressed: _fetchAccountData,
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            // 3. حالة النجاح (Loaded)
            // في حال loaded أو initial (إذا كانت الداتا موجودة مسبقاً)
            final account = state.account;
            final customer = account.customer;

            // التحقق من نوع الحساب لعرضه كنص
            String accountTypeDisplay = "Account";
            if (account.accountType == AccountType.savings) {
              accountTypeDisplay = "Savings Account";
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header (Dynamic Name)
                  ModernHeader(customerName: customer.fullName),

                  const SizedBox(height: 30),

                  // 2. Main Balance Card (Dynamic Data)
                  MainBalanceCard(account: account),

                  const SizedBox(height: 30),

                  // 3. Quick Actions
                  const Text(
                    "Quick Access",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.navy,
                      fontFamily: 'Roboto Slab',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const QuickActionGrid(),

                  const SizedBox(height: 30),

                  // 4. Sub Accounts List (Dynamic from account.subAccounts)
                  if (account.subAccounts.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Your Sub-Accounts",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.navy,
                            fontFamily: 'Roboto Slab',
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "See All",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // توليد القائمة بناءً على SubAccounts
                    ...account.subAccounts.map((subAccount) {
                      return AccountTile(
                        title: "Main Account",
                        // أو حسب نوع الحساب
                        amount: "\$${account.balance}",
                        status: account.isFrozen ? "Frozen" : "Active",
                        isFrozen: account.isFrozen,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountDetailsScreen(
                                account: account, // تمرير الأوبجكت الكامل هنا
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ] else ...[
                    // رسالة في حال لا يوجد حسابات فرعية
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "No sub-accounts available",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
