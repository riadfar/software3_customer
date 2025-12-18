import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class DepositMethodToggle extends StatelessWidget {
  final bool isQrMode;
  final Function(bool) onModeChanged;

  const DepositMethodToggle({
    super.key,
    required this.isQrMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          _buildOption("Scan QR Code", Icons.qr_code_scanner_rounded, true),
          _buildOption("Bill Number", Icons.receipt_long_rounded, false),
        ],
      ),
    );
  }

  Widget _buildOption(String title, IconData icon, bool isQrOption) {
    final isSelected = isQrMode == isQrOption;
    return Expanded(
      child: GestureDetector(
        onTap: () => onModeChanged(isQrOption),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.navy : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? AppTheme.gold : Colors.grey, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}