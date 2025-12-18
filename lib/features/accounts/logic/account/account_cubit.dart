import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/custom_error.dart';
import '../../../auth/data/model/customer.dart';
import '../../data/model/account.dart';
import '../../data/model/sub_account.dart';
import '../../data/repo/account_repo.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AccountRepo accountRepo;

  AccountCubit({required this.accountRepo}) : super(AccountState.initial());

  Future<void> getCustomerAccount({required String accountNumber}) async {
    emit(state.copyWith(status: AccountStatus.loading));
    try {
      final Account account = await accountRepo.getCustomerAccount(
        accountNumber: accountNumber,
      );
      emit(state.copyWith(status: AccountStatus.loaded, account: account));
    } catch (e) {
      emit(
        state.copyWith(
          status: AccountStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }

  Future<void> editCustomerInfo({
    required String accountNumber,
    String? fullName,
    String? phone,
    String? address,
  }) async {
    emit(state.copyWith(status: AccountStatus.loading));
    try {
      await accountRepo.editCustomerInfo(
        accountNumber: accountNumber,
        fullName: fullName,
        phone: phone,
        address: address,
      );

      final currentCustomer = state.account.customer;
      final updatedCustomer = currentCustomer.copyWith(
        fullName: fullName ?? currentCustomer.fullName,
        phone: phone ?? currentCustomer.phone,
        address: address ?? currentCustomer.address,
      );

      final updatedAccount = state.account.copyWith(customer: updatedCustomer);
      emit(
        state.copyWith(
          status: AccountStatus.loaded,
          account: updatedAccount,
          customer: updatedCustomer,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AccountStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }

  Future<void> freezeRequest({
    required String accountNumber,
    required String reason,
  }) async {
    emit(state.copyWith(status: AccountStatus.loading));
    try {
      await accountRepo.freezeRequest(
        accountNumber: accountNumber,
        reason: reason,
      );
      emit(state.copyWith(status: AccountStatus.loaded));
    } catch (e) {
      emit(
        state.copyWith(
          status: AccountStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }

  Future<void> closureRequest({
    required String accountNumber,
    required String reason,
  }) async {
    emit(state.copyWith(status: AccountStatus.loading));
    try {
      await accountRepo.closureRequest(
        accountNumber: accountNumber,
        reason: reason,
      );
      emit(state.copyWith(status: AccountStatus.loaded));
    } catch (e) {
      emit(
        state.copyWith(
          status: AccountStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }

  Future<void> createSubAccount({
    required String accountName,
  }) async {
    emit(state.copyWith(status: AccountStatus.loading));
    try {
      final mainAccountNumber = state.account.accountNumber;

      final SubAccount newSubAccount = await accountRepo.createSubAccount(
        mainAccountNumber: mainAccountNumber,
        subAccountName: accountName,
      );

      final updatedSubAccounts = List<SubAccount>.from(state.account.subAccounts)
        ..add(newSubAccount);

      final updatedAccount = state.account.copyWith(
        subAccounts: updatedSubAccounts,
      );

      emit(
        state.copyWith(
          status: AccountStatus.loaded,
          account: updatedAccount,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AccountStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }
}
