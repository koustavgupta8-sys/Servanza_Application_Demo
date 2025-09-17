import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/task_service.dart';
import '../../theme/theme.dart';
import 'task_detail_screen.dart';

class EmployeeTasksScreen extends ConsumerWidget {
  const EmployeeTasksScreen({super.key});
  static const routeName = '/employee/tasks';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskServiceProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: tasks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) {
          final t = tasks[i];
          return Card(
            child: ListTile(
              title: Text(t.title, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('${t.customerName} • ${t.address}\n${t.scheduledAt}'),
              isThreeLine: true,
              trailing: Icon(Icons.chevron_right, color: t.completed ? AppColors.gray : AppColors.green),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TaskDetailScreen(taskId: t.id)),
              ),
            ),
          );
        },
      ),
    );
  }
}


