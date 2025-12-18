part of 'account_cubit.dart';

enum AccountStatus { initial, loading, loaded, error }

class AccountState extends Equatable {
  final AccountStatus status;
  final Account account;
  final Customer customer;
  final CustomError error;

  AccountState({
    required this.status,
    required this.account,
    required this.customer,
    required this.error,
  });

  AccountState copyWith({
    AccountStatus? status,
    Account? account,
    Customer? customer,
    CustomError? error,
  }) {
    return AccountState(
      status: status ?? this.status,
      account: account ?? this.account,
      customer: customer ?? this.customer,
      error: error ?? this.error,
    );
  }

  factory AccountState.initial() => AccountState(
    status: AccountStatus.initial,
    account: Account.initial(),
    customer: Customer.initial(),
    error: CustomError.initial(),
  );

  @override
  List<Object> get props => [status, account, customer, error];
}
