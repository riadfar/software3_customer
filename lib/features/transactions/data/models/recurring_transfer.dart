enum Frequency { daily, weekly, monthly, yearly }

class RecurringTransfer {
  final int id;
  final String title;
  final double amount;
  final Frequency frequency;
  final String fromAccountNumber;
  final String toAccountNumber;
  final String status;
  final String? nextExecutionDate;
  final String? lastExecutionDate;

  RecurringTransfer({
    required this.id,
    required this.title,
    required this.amount,
    required this.frequency,
    required this.fromAccountNumber,
    required this.toAccountNumber,
    required this.status,
    this.nextExecutionDate,
    this.lastExecutionDate,
  });

  factory RecurringTransfer.initial() => RecurringTransfer(
    id: -1,
    title: "",
    amount: 0.0,
    frequency: Frequency.daily,
    fromAccountNumber: "",
    toAccountNumber: "",
    status: "",
    nextExecutionDate: null,
    lastExecutionDate: null,
  );

  factory RecurringTransfer.fromMap(Map<String, dynamic> map) {
    return RecurringTransfer(
      id: map['id'] ?? -1,
      title: map['title'] ?? '',


      amount: double.tryParse(map['amount'].toString().replaceAll(',', '')) ?? 0.0,

      frequency: _mapToFrequency(map['frequency']),

      fromAccountNumber: map['from_account_number'] ?? '',
      toAccountNumber: map['to_account_number'] ?? '',
      status: map['status'] ?? '',

      nextExecutionDate: map['next_execution_date'],
      lastExecutionDate: map['last_execution_date'],
    );
  }

  static Frequency _mapToFrequency(String? value) {
    switch (value?.toLowerCase()) {
      case 'daily':
        return Frequency.daily;
      case 'weekly':
        return Frequency.weekly;
      case 'monthly':
        return Frequency.monthly;
      case 'yearly':
        return Frequency.yearly;
      default:
        return Frequency.monthly;
    }
  }
}


