import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/accounts/data/api/account_api.dart';
import 'features/accounts/data/repo/account_repo.dart';
import 'features/accounts/logic/account/account_cubit.dart';
import 'features/auth/data/api/auth_api.dart';
import 'features/auth/data/repo/auth_repo.dart';
import 'features/auth/logic/auth/auth_cubit.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/transactions/data/api/transaction_api.dart';
import 'features/transactions/data/repo/transaction_repo.dart';
import 'features/transactions/logic/transaction/transaction_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (create) => AuthCubit(authRepo: AuthRepo(authApi: AuthApi())),
        ),
        BlocProvider(
          create: (create) =>
              AccountCubit(accountRepo: AccountRepo(accountApi: AccountApi())),
        ),
        BlocProvider(
          create: (create) => TransactionCubit(
            transactionRepo: TransactionRepo(transactionApi: TransactionApi()),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Horizon Bank',
        home: SplashScreen(),
      ),
    );
  }
}
