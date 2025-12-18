import 'package:flutter/material.dart';
import '../../../../core/widgets/page_header.dart';
import '../widgets/transfer/amount_step.dart';
import '../widgets/transfer/recipient_step.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final PageController _pageController = PageController();

  String? _recipientName;
  String? _accountNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: PageHeader(title: "Transfer Funds"),
            ),

            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  RecipientStep(
                    onVerified: (name, accNum) {
                      setState(() {
                        _recipientName = name;
                        _accountNumber = accNum;
                      });
                      _nextPage();
                    },
                  ),

                  AmountStep(
                    recipientName: _recipientName ?? "Unknown",
                    accountNumber: _accountNumber ?? "",
                    onBack: () => _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}