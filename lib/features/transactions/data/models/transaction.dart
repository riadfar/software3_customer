enum TransactionType { deposit, withdrawal, transfer, payment, unknown }

class Transaction {
  final int transactionId;
  final TransactionType type;
  final double amount;
  final String description;
  final DateTime date;
  final String performedBy;
  final String mainAccountNumber;
  final String? subAccount;

  Transaction({
    required this.transactionId,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
    required this.performedBy,
    required this.mainAccountNumber,
    this.subAccount,
  });

  factory Transaction.initial() => Transaction(
    transactionId: -1,
    type: TransactionType.unknown,
    amount: 0.0,
    description: "",
    date: DateTime.now(),
    performedBy: "",
    mainAccountNumber: "",
    subAccount: null,
  );

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      transactionId: map['transaction_id'] ?? -1,

      type: _mapToType(map['type']),

      amount: double.tryParse(map['amount']?.toString().replaceAll(',', '') ?? '0') ?? 0.0,

      description: map['description'] ?? '',
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),

      performedBy: map['performed_by'] ?? '',
      mainAccountNumber: map['main_account_number'] ?? '',

      subAccount: map['sub_account'],
    );
  }

  static TransactionType _mapToType(String? type) {
    switch (type?.toLowerCase()) {
      case 'deposit':
        return TransactionType.deposit;
      case 'withdrawal':
        return TransactionType.withdrawal;
      case 'transfer':
        return TransactionType.transfer;
      case 'payment':
        return TransactionType.payment;
      default:
        return TransactionType.unknown;
    }
  }
}