import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/custom_error.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../data/model/customer.dart';
import '../../data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit({required this.authRepo}) : super(AuthState.initial());


  Future<void> login({required String accountNumber, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await authRepo.login(accountNumber: accountNumber, password: password);
      print('start emitting');
      await SecureStorage.storeAccountNumber(accountNumber);
      emit(state.copyWith(status: AuthStatus.loaded,));
    } on CustomError catch (err) {

      emit(state.copyWith(status: AuthStatus.error, error: err));
    } catch (err) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          error: CustomError.initial().copyWith(messages: [err.toString()]),
        ),
      );
    }
  }

  Future<void> getCustomerAccount({required String accountNumber}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final Customer customer = await authRepo.getCustomerAccount(
        accountNumber: accountNumber,
      );
      emit(
        state.copyWith(
          status: AuthStatus.loaded,
          customer: customer,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }

  Future<void> getCustomerInformation({required String accountNumber}) async{
    emit(state.copyWith(status: AuthStatus.loading));
    try{

    } catch (err) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          error: CustomError.initial().copyWith(messages: [err.toString()]),
        ),
      );
    }
  }


  Future<void> changePassword({required String oldPassword, required String newPassword}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await authRepo.changePassword(oldPassword: oldPassword, newPassword: newPassword);
      print('start emitting');
      emit(state.copyWith(status: AuthStatus.loaded,));
    } on CustomError catch (err) {
      emit(state.copyWith(status: AuthStatus.error, error: err));
    } catch (err) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          error: CustomError.initial().copyWith(messages: [err.toString()]),
        ),
      );
    }
  }

  Future<void> logout() async{
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await authRepo.logout();
      print('start emitting');
      await SecureStorage.removeAll();
      emit(state.copyWith(status: AuthStatus.loaded,));
    } on CustomError catch (err) {
      emit(state.copyWith(status: AuthStatus.error, error: err));
    } catch (err) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          error: CustomError.initial().copyWith(messages: [err.toString()]),
        ),
      );
    }
  }




}
