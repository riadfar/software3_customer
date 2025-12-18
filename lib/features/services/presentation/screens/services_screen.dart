import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../accounts/presentation/screens/create_account_screen.dart';
import '../../data/models/service_item_model.dart';
import '../widgets/service_card.dart';
import 'recurring_transfers_screen.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ServiceItemModel> services = _getServices(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(title: "Services Hub"),
              const SizedBox(height: 10),
              Text(
                "Enhance your banking experience",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(height: 30),

              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return ServiceCard(service: services[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ServiceItemModel> _getServices(BuildContext context) {
    return [
      ServiceItemModel(
        title: "New Sub-Account",
        subtitle: "Create savings or business accounts",
        icon: Icons.account_tree_rounded,
        color: Colors.blueAccent,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateAccountScreen(),
            ),
          );
        },
        isComingSoon: false,
      ),
      ServiceItemModel(
        title: "Auto-Pay",
        subtitle: "Schedule recurring transfers",
        icon: Icons.update_rounded,
        color: Colors.teal,
        isComingSoon: false,
        onTap: () {
          // التعديل هنا: الذهاب للقائمة بدلاً من الإنشاء مباشرة
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RecurringTransfersScreen()),
          );
        },
      ),
      ServiceItemModel(
        title: "Get Insurance",
        subtitle: "Protect your funds & travel safe",
        icon: Icons.security_rounded,
        color: Colors.green,
        isComingSoon: true,
        onTap: () {},
      ),
      ServiceItemModel(
        title: "Request Loan",
        subtitle: "Personal, Home, or Car loans",
        icon: Icons.monetization_on_rounded,
        color: AppTheme.gold,
        isComingSoon: true,
        onTap: () {},
      ),
      ServiceItemModel(
        title: "Overdraft",
        subtitle: "Enable overdraft protection",
        icon: Icons.trending_down_rounded,
        color: Colors.purpleAccent,
        isComingSoon: true,
        onTap: () {},
      ),
      ServiceItemModel(
        title: "Order Chequebook",
        subtitle: "Request a new book",
        icon: Icons.book_rounded,
        color: Colors.orange,
        isComingSoon: true,
        onTap: () {},
      ),
    ];
  }
}
