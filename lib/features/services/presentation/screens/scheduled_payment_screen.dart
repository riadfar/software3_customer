import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/dialog_utils.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../accounts/logic/account/account_cubit.dart';
import '../../../transactions/data/models/recurring_transfer.dart';
import '../../../transactions/logic/transaction/transaction_cubit.dart';

import '../../../transactions/presentation/widgets/deposit/account_selector.dart';
import '../widgets/scheduled_payment/frequency_selector.dart';
import '../widgets/scheduled_payment/date_picker_field.dart';

class ScheduledPaymentScreen extends StatefulWidget {
  const ScheduledPaymentScreen({super.key});

  @override
  State<ScheduledPaymentScreen> createState() => _ScheduledPaymentScreenState();
}

class _ScheduledPaymentScreenState extends State<ScheduledPaymentScreen> {
  // Controllers
  final _titleController = TextEditingController(); // لإضافة عنوان للعملية
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _countController =
      TextEditingController(); // عدد مرات التكرار لحساب تاريخ الانتهاء

  // State Variables
  String _selectedAccountName = "";
  String _selectedAccountNumber = "";
  String _frequency = "Monthly";
  DateTime? _startDate;

  @override
  void initState() {
    super.initState();
    // تعيين الحساب الافتراضي
    final state = context.read<AccountCubit>().state;
    if (state.status == AccountStatus.loaded) {
      _selectedAccountName = "Main Account";
      _selectedAccountNumber = state.account.accountNumber;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _recipientController.dispose();
    _amountController.dispose();
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: BlocListener<TransactionCubit, TransactionState>(
        listener: (context, state) {
          if (state.status == TransactionStatus.loading) {
            DialogUtils.showLoading(context);
          } else if (state.status == TransactionStatus.success) {
            Navigator.of(context, rootNavigator: true).pop(); // إغلاق اللودينج
            Navigator.pop(context); // العودة للقائمة
            DialogUtils.showSuccess(
              context,
              title: "Scheduled Successfully",
              content: "Your recurring payment has been set up.",
            );
          } else if (state.status == TransactionStatus.error) {
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.messages.first),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageHeader(title: "Auto-Pay Setup"),
                const SizedBox(height: 30),

                // 1. Payment Details
                const Text(
                  "Payment Details",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.navy,
                  ),
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: "Payment Title (e.g. Rent)",
                  icon: Icons.label_outline,
                  controller: _titleController,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: "Recipient Account Number",
                  icon: Icons.person_outline_rounded,
                  inputType: TextInputType.name,
                  controller: _recipientController,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: "Amount per Payment",
                  icon: Icons.attach_money_rounded,
                  inputType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  controller: _amountController,
                ),
                const SizedBox(height: 16),

                // 2. Source Account Selector (Using BlocBuilder from AccountCubit)
                BlocBuilder<AccountCubit, AccountState>(
                  builder: (context, state) {
                    final List<Map<String, dynamic>> accountsList = [];
                    if (state.status == AccountStatus.loaded) {
                      accountsList.add({
                        'name': 'Main Account',
                        'balance': state.account.balance,
                        'identifier': state.account.accountNumber,
                      });
                      for (var sub in state.account.subAccounts) {
                        accountsList.add({
                          'name': sub.name,
                          'balance': sub.balance,
                          'identifier': sub.id.toString(),
                          // تأكد من توافق هذا مع الباك اند
                        });
                      }
                    }

                    if (_selectedAccountName.isEmpty &&
                        accountsList.isNotEmpty) {
                      _selectedAccountName = accountsList.first['name'];
                      _selectedAccountNumber = accountsList.first['identifier'];
                    }

                    return AccountSelector(
                      selectedAccountName: _selectedAccountName,
                      accounts: accountsList,
                      onAccountChanged: (name, id) {
                        setState(() {
                          _selectedAccountName = name;
                          _selectedAccountNumber = id;
                        });
                      },
                    );
                  },
                ),

                const SizedBox(height: 30),

                // 3. Scheduling Logic
                const Text(
                  "Schedule Config",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.navy,
                  ),
                ),
                const SizedBox(height: 16),

                FrequencySelector(
                  selectedFrequency: _frequency,
                  onChanged: (val) => setState(() => _frequency = val),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: DatePickerField(
                        selectedDate: _startDate,
                        onTap: _pickDate,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: CustomTextField(
                        label: "Repeats",
                        icon: Icons.repeat_rounded,
                        inputType: TextInputType.number,
                        controller: _countController,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 4.0),
                  child: Text(
                    "Leave 'Repeats' empty for indefinite (5 years).",
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ),

                const SizedBox(height: 40),

                // 4. Confirm Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSchedule,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.navy,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                      shadowColor: AppTheme.navy.withOpacity(0.4),
                    ),
                    child: const Text(
                      "Schedule Auto-Pay",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppTheme.navy,
            onPrimary: Colors.white,
            onSurface: AppTheme.navy,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _startDate = picked);
    }
  }

  void _handleSchedule() {
    if (_recipientController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _startDate == null ||
        _selectedAccountNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 1. تحويل النص إلى Enum
    Frequency freqEnum = Frequency.values.firstWhere(
      (e) => e.name.toLowerCase() == _frequency.toLowerCase(),
      orElse: () => Frequency.monthly,
    );

    // 2. حساب تاريخ الانتهاء
    int repeats =
        int.tryParse(_countController.text) ?? 60; // افتراضي 5 سنوات (60 شهر)
    DateTime endDate = _startDate!;

    switch (freqEnum) {
      case Frequency.daily:
        endDate = _startDate!.add(Duration(days: repeats));
        break;
      case Frequency.weekly:
        endDate = _startDate!.add(Duration(days: repeats * 7));
        break;
      case Frequency.monthly:
        endDate = DateTime(
          _startDate!.year,
          _startDate!.month + repeats,
          _startDate!.day,
        );
        break;
      case Frequency.yearly:
        endDate = DateTime(
          _startDate!.year + repeats,
          _startDate!.month,
          _startDate!.day,
        );
        break;
    }

    // 3. تنسيق التواريخ كنصوص
    String startDateStr =
        "${_startDate!.year}-${_startDate!.month.toString().padLeft(2, '0')}-${_startDate!.day.toString().padLeft(2, '0')}";
    String endDateStr =
        "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";

    // 4. استدعاء الكيوبت
    context.read<TransactionCubit>().createRecurringTransfer(
      title: _titleController.text.isNotEmpty
          ? _titleController.text
          : "Auto-Pay",
      fromAccountNumber: _selectedAccountNumber,
      toAccountNumber: _recipientController.text,
      amount: double.parse(_amountController.text),
      frequency: freqEnum,
      startDate: startDateStr,
      endDate: endDateStr,
    );
  }
}
