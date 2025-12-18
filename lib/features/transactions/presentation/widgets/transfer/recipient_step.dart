import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theme/app_theme.dart';
import '../../../../../core/widgets/text_field_widget.dart';
import '../../../logic/transaction/transaction_cubit.dart';

class RecipientStep extends StatefulWidget {
  final Function(String name, String accNum) onVerified;

  const RecipientStep({super.key, required this.onVerified});

  @override
  State<RecipientStep> createState() => _RecipientStepState();
}

class _RecipientStepState extends State<RecipientStep> {
  final _accountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionCubit, TransactionState>(
      listener: (context, state) {
        if (state.status == TransactionStatus.loaded && state.destinationAccountName.isNotEmpty) {
          widget.onVerified(state.destinationAccountName, _accountController.text);
        } else if (state.status == TransactionStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.messages.first),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == TransactionStatus.loading;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Step 1: Recipient",
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Who are you sending money to?",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.navy),
                ),
                const SizedBox(height: 30),

                CustomTextField(
                  label: "Account Number",
                  icon: Icons.account_circle_outlined,
                  inputType: TextInputType.name,
                  controller: _accountController,
                  validator: (val) {
                    if (val == null || val.isEmpty) return "Required";
                    if (val.length < 5) return "Invalid Account Number";
                    return null;
                  },
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                      if (_formKey.currentState!.validate()) {
                        context.read<TransactionCubit>().getDestinationName(
                          accountNumber: _accountController.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.navy,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: isLoading
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Text("Verify & Next", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}