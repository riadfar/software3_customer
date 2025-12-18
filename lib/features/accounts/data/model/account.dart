
import '../../../auth/data/model/customer.dart';
import 'sub_account.dart';

class Account {
  final String accountNumber;
  final AccountType accountType;
  final String balance;
  final bool isFrozen;
  final bool isClosed;
  final Customer customer;
  final List<SubAccount> subAccounts;

  Account({
    required this.accountNumber,
    required this.accountType,
    required this.balance,
    required this.isFrozen,
    required this.isClosed,
    required this.customer,
    required this.subAccounts,
  });

  Account copyWith({
    Customer? customer,
    List<SubAccount>? subAccounts,
  }) {
    return Account(
      accountNumber: accountNumber,
      accountType: accountType,
      isFrozen: isFrozen,
      isClosed: isClosed,
      balance: balance,
      customer: customer ?? this.customer,
      subAccounts: subAccounts ?? this.subAccounts,
    );
  }

  factory Account.initial() => Account(
    accountNumber: "",
    accountType: AccountType.initial,
    balance: "0.00",
    isFrozen: false,
    isClosed: false,
    customer: Customer.initial(),
    subAccounts: const [],
  );

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      accountNumber: map['account_number'],
      accountType: _mapAccountType(map['account_type']),
      balance: map['balance'],
      isFrozen: map['is_frozen'],
      isClosed: map['is_closed'],
      customer: Customer.fromMap(map['customer']),
      subAccounts: (map['sub_accounts'] as List<dynamic>? ?? [])
          .map((e) => SubAccount.fromMap(e))
          .toList(),
    );
  }

  static AccountType _mapAccountType(String? type) {
    switch (type) {
      case 'savings':
        return AccountType.savings;
      default:
        return AccountType.initial;
    }
  }


}
enum AccountType { initial, savings }
