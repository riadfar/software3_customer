import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/custom_error.dart';
import '../../data/models/recurring_transfer.dart';
import '../../data/models/transaction.dart';
import '../../data/repo/transaction_repo.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepo transactionRepo;

  TransactionCubit({required this.transactionRepo})
      : super(TransactionState.initial());

  Future<void> makeTransfer({
    required String fromAccountNumber,
    required String toAccountNumber,
    required double amount,
  }) async {
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      await transactionRepo.transferRequest(
        fromAccountNumber: fromAccountNumber,
        toAccountNumber: toAccountNumber,
        amount: amount,
      );
      emit(state.copyWith(status: TransactionStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }

  Future<void> makeDeposit({
    required String accountNumber,
    required String reference,
    required double amount,
  }) async {
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      await transactionRepo.deposit(
        accountNumber: accountNumber,
        reference: reference,
        amount: amount,
      );
      emit(state.copyWith(status: TransactionStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }

  Future<void> createRecurringTransfer({
    required String title,
    required String fromAccountNumber,
    required String toAccountNumber,
    required double amount,
    required Frequency frequency,
    required String startDate,
    required String endDate,
  }) async {
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      await transactionRepo.recurringTransfer(
        title: title,
        fromAccountNumber: fromAccountNumber,
        toAccountNumber: toAccountNumber,
        amount: amount,
        frequency: frequency,
        startDate: startDate,
        endDate: endDate,
      );
      emit(state.copyWith(status: TransactionStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }

  Future<void> cancelRecurringTransfer({required int id}) async {
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      await transactionRepo.cancelRecurringTransfers(id: id);


      final updatedList = List<RecurringTransfer>.from(state.recurringTransfers)
        ..removeWhere((element) => element.id == id);

      emit(state.copyWith(
        status: TransactionStatus.success,
        recurringTransfers: updatedList,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }

  Future<void> getTransactionHistory() async {
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      final List<Transaction> history = await transactionRepo.getTransactionHistory();

      emit(state.copyWith(
        status: TransactionStatus.loaded,
        transactionHistory: history,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }

  Future<void> getRecurringTransfers() async {
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      final List<RecurringTransfer> transfers = await transactionRepo.getRecurringTransfers();

      emit(state.copyWith(
        status: TransactionStatus.loaded,
        recurringTransfers: transfers,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }

  Future<void> getDestinationName({required String accountNumber}) async {
    emit(state.copyWith(
      status: TransactionStatus.loading,
      destinationAccountName: '',
    ));

    try {
      final String name = await transactionRepo.getDestinationName(
        accountNumber: accountNumber,
      );

      emit(state.copyWith(
        status: TransactionStatus.loaded,
        destinationAccountName: name,
      ));

    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }
}
