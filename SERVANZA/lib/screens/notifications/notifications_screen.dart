import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  static const routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.alarm, 'text': 'Reminder: Cleaning tomorrow', 'time': '2h'},
      {'icon': Icons.mail, 'text': 'Message from provider', 'time': '5h'},
      {'icon': Icons.check_circle, 'text': 'Booking confirmed', 'time': '1d'},
      {'icon': Icons.local_offer, 'text': 'Special offer just for you', 'time': '2d'},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final it = items[i];
        return Card(
          child: ListTile(
            leading: Icon(it['icon'] as IconData, color: AppColors.orange),
            title: Text(it['text'] as String),
            trailing: Text(it['time'] as String, style: const TextStyle(color: AppColors.gray)),
          ),
        );
      },
    );
  }
}