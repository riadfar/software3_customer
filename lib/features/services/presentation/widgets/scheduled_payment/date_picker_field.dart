import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // تنسيق التاريخ البسيط (YYYY-MM-DD)
    final text = selectedDate == null
        ? "Select Start Date"
        : "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: selectedDate == null ? Colors.grey : AppTheme.navy,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const Icon(Icons.calendar_today_rounded, color: AppTheme.navy, size: 20),
          ],
        ),
      ),
    );
  }
}