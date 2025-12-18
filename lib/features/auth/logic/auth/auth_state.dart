part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, loaded, error, changedPassword, loggedOut }

class AuthState extends Equatable {
  final Customer customer;
  final AuthStatus status;
  final CustomError error;

  const AuthState({
    required this.status,
    required this.customer,
    required this.error,
  });

  factory AuthState.initial() => AuthState(
    status: AuthStatus.initial,
    customer: Customer.initial(),
    error: CustomError.initial(),
  );

  AuthState copyWith({
    AuthStatus? status,
    Customer? customer,
    CustomError? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      customer: customer ?? this.customer,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, customer, error];
}
