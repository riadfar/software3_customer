import 'package:flutter/material.dart';

class AppRouter {
  // Auth routes
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyOtp = '/verify-otp';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';

  // App routes
  static const String home = '/';

  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case login:
  //       return MaterialPageRoute(builder: (_) => const LoginPage());
  //
  //     case register:
  //       return MaterialPageRoute(builder: (_) => const RegisterPage());
  //
  //     case verifyOtp:
  //       final email = settings.arguments as String? ?? '';
  //       return MaterialPageRoute(
  //         builder: (_) => VerifyOtpPage(email: email),
  //       );
  //
  //     case forgotPassword:
  //       return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
  //
  //     case resetPassword:
  //       final token = settings.arguments as String? ?? '';
  //       return MaterialPageRoute(
  //         builder: (_) => ResetPasswordPage(token: token),
  //       );
  //
  //     case home:
  //       return MaterialPageRoute(
  //         builder: (_) =>
  //             const Scaffold(body: Center(child: Text('Home Page'))),
  //       );
  //
  //
  //     default:
  //       return MaterialPageRoute(
  //         builder: (_) => Scaffold(
  //           body: Center(child: Text('No route defined for ${settings.name}')),
  //         ),
  //       );
  //   }
  // }
}
