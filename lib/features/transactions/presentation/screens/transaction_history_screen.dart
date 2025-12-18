import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';
import '../../data/models/transaction.dart';
import '../../logic/transaction/transaction_cubit.dart';
import '../widgets/transaction_history/history_filter_bar.dart';
import '../widgets/transaction_history/transaction_tile.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  int _selectedFilterIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TransactionCubit>().getTransactionHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: PageHeader(title: "History"),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 20.0),
              child: HistoryFilterBar(
                selectedIndex: _selectedFilterIndex,
                onSelect: (index) => setState(() => _selectedFilterIndex = index),
              ),
            ),

            Expanded(
              child: BlocBuilder<TransactionCubit, TransactionState>(
                builder: (context, state) {

                  if (state.status == TransactionStatus.loading) {
                    return _buildLoadingState();
                  }

                  if (state.status == TransactionStatus.error) {
                    return _buildErrorState(state.error.messages.first);
                  }

                  if (state.status == TransactionStatus.loaded || state.transactionHistory.isNotEmpty) {
                    final filteredList = _filterTransactions(state.transactionHistory);

                    if (filteredList.isEmpty) {
                      return _buildEmptyState();
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        return TransactionTile(transaction: filteredList[index]);
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // منطق الفلترة
  List<Transaction> _filterTransactions(List<Transaction> allTransactions) {
    // الترتيب حسب التاريخ (الأحدث أولاً) - اختياري
    // allTransactions.sort((a, b) => b.date.compareTo(a.date));

    if (_selectedFilterIndex == 0) return allTransactions;

    // افتراض: TransactionType هو Enum
    if (_selectedFilterIndex == 1) {
      // Income (Deposit)
      return allTransactions.where((t) => t.type == TransactionType.deposit).toList();
    }
    if (_selectedFilterIndex == 2) {
      // Expense (Withdrawal, Transfer, Payment)
      return allTransactions.where((t) => t.type != TransactionType.deposit).toList();
    }
    if (_selectedFilterIndex == 3) {
      // Payments specifically
      return allTransactions.where((t) => t.type == TransactionType.payment).toList();
    }

    return allTransactions;
  }

  // --- Widgets للحالات المختلفة ---

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(color: AppTheme.navy),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.receipt_long_rounded, size: 50, color: Colors.grey[400]),
          ),
          const SizedBox(height: 16),
          Text(
            "No Transactions Found",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Try adjusting your filters",
            style: TextStyle(fontSize: 12, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded, size: 50, color: Colors.redAccent),
            const SizedBox(height: 16),
            const Text(
              "Oops! Something went wrong",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.navy),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<TransactionCubit>().getTransactionHistory();
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Retry"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.navy,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}