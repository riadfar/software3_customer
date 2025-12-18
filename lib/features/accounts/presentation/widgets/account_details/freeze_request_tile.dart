import 'package:flutter/material.dart';
import 'account_action_tile.dart';

class FreezeRequestTile extends StatelessWidget {
  final bool isFrozen;
  final bool isRequestPending;
  final VoidCallback onRequestAction;
  final VoidCallback onCancelRequest;

  const FreezeRequestTile({
    super.key,
    required this.isFrozen,
    required this.isRequestPending,
    required this.onRequestAction,
    required this.onCancelRequest,
  });

  @override
  Widget build(BuildContext context) {
    // حالة الانتظار (طلب معلق)
    if (isRequestPending) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.orange.withOpacity(0.5)),
        ),
        child: ListTile(
          leading: const Icon(Icons.hourglass_top_rounded, color: Colors.orange),
          title: const Text("Freeze Request Pending", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
          subtitle: const Text("Waiting for Teller approval..."),
          trailing: TextButton(onPressed: onCancelRequest, child: const Text("Cancel")),
        ),
      );
    }

    // الحالة العادية (تقديم طلب)
    return AccountActionTile(
      icon: isFrozen ? Icons.lock_open_rounded : Icons.lock_outline,
      title: isFrozen ? "Request Unfreeze" : "Request Freeze",
      subtitle: isFrozen ? "Ask bank to restore access" : "Ask bank to block transactions",
      color: isFrozen ? Colors.green : Colors.orange,
      onTap: onRequestAction,
    );
  }
}