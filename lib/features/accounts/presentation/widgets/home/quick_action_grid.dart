import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../services/presentation/screens/services_screen.dart';
import '../../../../transactions/data/api/transaction_api.dart';
import '../../../../transactions/data/repo/transaction_repo.dart';
import '../../../../transactions/logic/transaction/transaction_cubit.dart';
import '../../../../transactions/presentation/screens/deposit_screen.dart';
import '../../../../transactions/presentation/screens/transaction_history_screen.dart';
import '../../../../transactions/presentation/screens/transfer_screen.dart';

class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(Icons.swap_horiz_rounded, "Transfer", () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => TransactionCubit(
                  transactionRepo: TransactionRepo(
                    transactionApi: TransactionApi(),
                  ),
                ),
                child: const TransferScreen(),
              ),
            ),
          );
        }),
        _buildActionButton(Icons.add_card_rounded, "Deposit", () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => TransactionCubit(
                  transactionRepo: TransactionRepo(
                    transactionApi: TransactionApi(),
                  ),
                ),
                child: DepositScreen(),
              ),
            ),
          );
        }),
        _buildActionButton(Icons.shield_outlined, "Services", () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ServicesScreen()),
          );
        }),
        _buildActionButton(Icons.history_rounded, "History", () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TransactionHistoryScreen(),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF3F6),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.navy.withOpacity(0.15),
                  offset: const Offset(6, 6),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-6, -6),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(icon, color: AppTheme.navy, size: 30),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.navy,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
