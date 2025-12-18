import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/widgets/text_field_widget.dart';

class AccountFormSection extends StatelessWidget {
  final TextEditingController nameController;
  // تم حذف amountController

  const AccountFormSection({
    super.key,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Account Details",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.navy),
        ),
        const SizedBox(height: 16),

        CustomTextField(
          label: "Account Name (e.g. Travel Fund)",
          icon: Icons.edit_rounded,
          controller: nameController,
        ),

      ],
    );
  }
}