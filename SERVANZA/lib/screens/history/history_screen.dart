import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../widgets/status_badge.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(8, (i) => {
          'name': 'Service ${i + 1}',
          'date': '2025-09-${(i + 1).toString().padLeft(2, '0')}',
          'address': '123 Main Street, City',
          'status': i % 3 == 0 ? 'Active' : i % 3 == 1 ? 'Cancelled' : 'Done',
        });

    Color badgeColor(String s) {
      switch (s) {
        case 'Active':
          return AppColors.green;
        case 'Cancelled':
          return AppColors.orange;
        default:
          return AppColors.gray;
      }
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final it = items[i];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              it['name']!,
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          StatusBadge(
                            text: it['status']!,
                            color: badgeColor(it['status']!),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        it['date']!,
                        style: const TextStyle(color: AppColors.gray),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        it['address']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}