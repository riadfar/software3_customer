import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../accounts/logic/account/account_cubit.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _addressCtrl;

  @override
  void initState() {
    super.initState();
    // جلب البيانات الحالية من الـ Cubit
    final currentCustomer = context.read<AccountCubit>().state.account.customer;
    _nameCtrl = TextEditingController(text: currentCustomer.fullName);
    _phoneCtrl = TextEditingController(text: currentCustomer.phone);
    _addressCtrl = TextEditingController(text: currentCustomer.address);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {
          if (state.status == AccountStatus.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile Updated Successfully"), backgroundColor: Colors.green),
            );
            Navigator.pop(context); // الرجوع للخلف بعد الحفظ
          } else if (state.status == AccountStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error.messages.first), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status == AccountStatus.loading;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageHeader(title: "Account Info"),
                  const SizedBox(height: 30),

                  // Avatar Section
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppTheme.navy,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _nameCtrl.text.isNotEmpty ? _nameCtrl.text[0].toUpperCase() : "A",
                          style: const TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  CustomTextField(
                    label: "Full Name",
                    icon: Icons.person_outline,
                    controller: _nameCtrl,
                  ),
                  const SizedBox(height: 16),

                  // Phone
                  CustomTextField(
                    label: "Phone Number",
                    icon: Icons.phone_outlined,
                    inputType: TextInputType.phone,
                    controller: _phoneCtrl,
                  ),
                  const SizedBox(height: 16),

                  // Address
                  CustomTextField(
                    label: "Residential Address",
                    icon: Icons.location_on_outlined,
                    controller: _addressCtrl,
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () {
                        // استدعاء دالة التعديل
                        // نحتاج رقم الحساب وهو موجود في الـ State
                        final accountNumber = state.account.accountNumber;

                        context.read<AccountCubit>().editCustomerInfo(
                          accountNumber: accountNumber,
                          fullName: _nameCtrl.text,
                          phone: _phoneCtrl.text,
                          address: _addressCtrl.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.navy,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text(
                        "Save Changes",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}