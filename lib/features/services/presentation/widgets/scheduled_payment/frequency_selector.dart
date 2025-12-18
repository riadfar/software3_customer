import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class FrequencySelector extends StatelessWidget {
  final String selectedFrequency;
  final Function(String) onChanged;

  const FrequencySelector({
    super.key,
    required this.selectedFrequency,
    required this.onChanged,
  });

  final List<String> frequencies = const ["Daily", "Weekly", "Monthly", "Yearly"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Repeat Frequency",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.navy),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 45,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: frequencies.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final freq = frequencies[index];
              final isSelected = freq == selectedFrequency;
              return GestureDetector(
                onTap: () => onChanged(freq),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.navy : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppTheme.navy : Colors.grey.shade300,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      freq,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}