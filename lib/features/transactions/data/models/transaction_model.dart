enum TransactionType { deposit, withdrawal, transfer, payment }

class TransactionModel {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final String date;
  final TransactionType type;

  TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.type,
  });


  bool get isIncome =>
      type == TransactionType.deposit ||
          (type == TransactionType.transfer && amount > 0);
}