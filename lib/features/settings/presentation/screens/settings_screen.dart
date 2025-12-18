import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';
import '../sub_screens/account_info_screen.dart';
import '../sub_screens/customer_support_screen.dart';
import '../sub_screens/faqs_screen.dart';
import '../sub_screens/logout_dialog.dart';
import '../sub_screens/notifications_settings_screen.dart';
import '../sub_screens/security_screen.dart';
import '../widgets/settings_tile.dart';
import '../widgets/user_info_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6), // نفس خلفية الـ Home
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(title: "Settings"),

              const SizedBox(height: 30),

              // 2. User Info Card
              const UserInfoCard(),

              const SizedBox(height: 30),

              // 3. General Settings Section
              _buildSectionTitle("General"),
              SettingsTile(
                icon: Icons.person_outline_rounded,
                title: "Account Information",
                subtitle: "Profile, Address, Personal Info",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AccountInfoScreen(),
                    ),
                  );
                },
              ),
              SettingsTile(
                icon: Icons.security_rounded,
                title: "Security & Login", // إضافة مهمة
                subtitle: "Password, Biometrics, 2FA",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SecurityScreen()),
                  );
                },
              ),
              SettingsTile(
                icon: Icons.notifications_active_outlined,
                // متعلق بالـ Observer Pattern
                title: "Notifications",
                subtitle: "Push, Email, SMS preferences",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NotificationsSettingsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // 4. Support Section
              _buildSectionTitle("Support"),
              SettingsTile(
                icon: Icons.help_outline_rounded,
                title: "FAQs",
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => FAQsScreen()));
                },
              ),
              // SettingsTile(
              //   icon: Icons.headset_mic_outlined,
              //   title: "Customer Service",
              //   subtitle: "Chat with support or call us",
              //   onTap: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) => CustomerSupportScreen(),
              //       ),
              //     );
              //   },
              // ),

              const SizedBox(height: 20),

              // 5. Logout Section
              SettingsTile(
                icon: Icons.logout_rounded,
                title: "Log Out",
                isDestructive: true, // يظهر باللون الأحمر
                onTap: () {
                  showLogoutDialog(context);
                  print("Logout Clicked");
                },
              ),

              const SizedBox(height: 20),

              // App Version
              Center(
                child: Text(
                  "Version 1.0.0 (Beta)",
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => LogoutDialog());
  }
}
