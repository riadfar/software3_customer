import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'login_screen.dart'; // تأكد من استيراد شاشة اللوجين

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// نستخدم SingleTickerProviderStateMixin من أجل الأنيميشن
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // 1. إعداد الأنيميشن (مدة الحركة 2 ثانية)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // تأثير الظهور (الشفافية من 0 إلى 1)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // تأثير التكبير (من حجم 0.8 إلى 1.0) ليعطي نبضة خفيفة
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // بدء الأنيميشن
    _controller.forward();

    // 2. المؤقت للانتقال (3 ثواني كاملة)
    Future.delayed(const Duration(seconds: 3), () {
      _navigateToLogin();
    });
  }

  void _navigateToLogin() {
    // نستخدم pushReplacement لمنع العودة للسبلاش
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // تنظيف الذاكرة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.navy,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset(
                  'assets/images/mian_logo.png',
                  width: 300,
                  height: 300,
                ),


                const SizedBox(height: 10),

                Text(
                  "Future of Banking",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 24,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}