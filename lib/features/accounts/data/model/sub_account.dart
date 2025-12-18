class SubAccount {
  final int id;
  final String name;
  final String balance;

  SubAccount({
    required this.id,
    required this.name,
    required this.balance,
  });

  factory SubAccount.fromMap(Map<String, dynamic> map) {
    return SubAccount(
      id: map['id'],
      name: map['name'],
      balance: map['balance'],
    );
  }
}
