part of 'transaction_cubit.dart';

enum TransactionStatus { initial, loading, loaded, success, error }

class TransactionState extends Equatable {
  final TransactionStatus status;
  final List<Transaction> transactionHistory;
  final List<RecurringTransfer> recurringTransfers;
  final String destinationAccountName;
  final CustomError error;

  const TransactionState({
    required this.status,
    required this.transactionHistory,
    required this.recurringTransfers,
    required this.destinationAccountName,
    required this.error,
  });

  factory TransactionState.initial() => TransactionState(
    status: TransactionStatus.initial,
    transactionHistory: const [],
    recurringTransfers: const [],
    destinationAccountName: '',
    error: CustomError.initial(),
  );

  TransactionState copyWith({
    TransactionStatus? status,
    List<Transaction>? transactionHistory,
    List<RecurringTransfer>? recurringTransfers,
    String? destinationAccountName,
    CustomError? error,
  }) {
    return TransactionState(
      status: status ?? this.status,
      transactionHistory: transactionHistory ?? this.transactionHistory,
      recurringTransfers: recurringTransfers ?? this.recurringTransfers,
      destinationAccountName: destinationAccountName ?? this.destinationAccountName,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
    status,
    transactionHistory,
    recurringTransfers,
    destinationAccountName,
    error,
  ];
}