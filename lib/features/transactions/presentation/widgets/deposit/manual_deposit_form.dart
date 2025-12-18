import 'package:flutter/material.dart';
import '../../../../../core/widgets/text_field_widget.dart';

class ManualDepositForm extends StatelessWidget {
  final TextEditingController refController;
  final TextEditingController amountController;

  const ManualDepositForm({
    super.key,
    required this.refController,
    required this.amountController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- التصحيح هنا ---
        CustomTextField(
          label: "Bill Reference Number",
          icon: Icons.tag_rounded,
          inputType: TextInputType.text, // جعلته text ليقبل حروفاً وأرقاماً (مثل REF-123)
          controller: refController,     // <--- هذا هو السطر الناقص
        ),

        const SizedBox(height: 16),

        CustomTextField(
          label: "Amount",
          icon: Icons.attach_money_rounded,
          inputType: const TextInputType.numberWithOptions(decimal: true),
          controller: amountController,
        ),

        const SizedBox(height: 10),

        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Min Deposit: \$10.00",
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ),
      ],
    );
  }
}