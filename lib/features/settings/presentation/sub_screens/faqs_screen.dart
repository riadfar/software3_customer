import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              PageHeader(title: "FAQs"),
              const SizedBox(height: 30),
              _buildQuestionItem(
                "How do I freeze my account?",
                "Go to home screen, select your account, and tap the freeze icon. This will instantly block all outgoing transactions.",
              ),
              _buildQuestionItem(
                "What are the transfer limits?",
                "The daily transfer limit is \$5,000 for standard accounts and \$50,000 for business accounts.",
              ),
              _buildQuestionItem(
                "How to enable 2FA?",
                "Go to Settings > Security & Login and toggle the Two-Factor Authentication switch.",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.navy,
            fontSize: 15,
          ),
        ),
        iconColor: AppTheme.gold,
        textColor: AppTheme.navy,
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Text(answer, style: TextStyle(color: Colors.grey[700], height: 1.5)),
        ],
      ),
    );
  }
}
