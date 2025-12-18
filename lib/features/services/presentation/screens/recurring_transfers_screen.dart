import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/dialog_utils.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../transactions/data/models/recurring_transfer.dart';
import '../../../transactions/logic/transaction/transaction_cubit.dart';
import 'scheduled_payment_screen.dart';

class RecurringTransfersScreen extends StatefulWidget {
  const RecurringTransfersScreen({super.key});

  @override
  State<RecurringTransfersScreen> createState() =>
      _RecurringTransfersScreenState();
}

class _RecurringTransfersScreenState extends State<RecurringTransfersScreen> {
  @override
  void initState() {
    super.initState();
    // جلب البيانات عند فتح الشاشة
    context.read<TransactionCubit>().getRecurringTransfers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.navy,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ScheduledPaymentScreen(),
            ),
          ).then((_) {
            context.read<TransactionCubit>().getRecurringTransfers();
          });
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: PageHeader(title: "Scheduled Payments"),
            ),
            Expanded(
              child: BlocConsumer<TransactionCubit, TransactionState>(
                listener: (context, state) {
                  if (state.status == TransactionStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error.messages.first),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.status == TransactionStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppTheme.navy),
                    );
                  }

                  if (state.recurringTransfers.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_busy_rounded,
                            size: 60,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No scheduled payments",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(24),
                    itemCount: state.recurringTransfers.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final transfer = state.recurringTransfers[index];
                      return _buildTransferCard(transfer, context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransferCard(RecurringTransfer transfer, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                transfer.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppTheme.navy,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.navy.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  transfer.frequency.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.navy,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                "\$${transfer.amount}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppTheme.gold,
                  fontFamily: 'Roboto Slab',
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red,
                ),
                onPressed: () => _confirmCancellation(context, transfer),
              ),
            ],
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "To: ${transfer.toAccountNumber}",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              if (transfer.nextExecutionDate != null)
                Text(
                  "Next: ${transfer.nextExecutionDate}",
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmCancellation(BuildContext context, RecurringTransfer transfer) {
    DialogUtils.showConfirmation(
      context,
      title: "Cancel Auto-Pay?",
      content: "Are you sure you want to stop this recurring payment?",
      confirmText: "Stop Payment",
      confirmColor: Colors.red,
      onConfirm: () {
        Navigator.pop(context);
        context.read<TransactionCubit>().cancelRecurringTransfer(
          id: transfer.id,
        );
      },
    );
  }
}
