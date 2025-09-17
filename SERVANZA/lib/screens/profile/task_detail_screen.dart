import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/task_service.dart';
import '../../theme/theme.dart';
import 'feedback_screen.dart';

class TaskDetailScreen extends ConsumerWidget {
  final String taskId;
  const TaskDetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskServiceProvider);
    final service = ref.read(taskServiceProvider.notifier);
    final task = tasks.firstWhere((t) => t.id == taskId);

    final canStart = !task.started && !task.completed;
    final canEnd = task.started && task.feedbackReceived && !task.completed;

    return Scaffold(
      appBar: AppBar(title: Text(task.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer: ${task.customerName}', style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text('Address: ${task.address}'),
            const SizedBox(height: 6),
            Text('Scheduled: ${task.scheduledAt}'),
            const SizedBox(height: 12),
            Row(
              children: [
                _Chip(text: task.started ? 'Started' : 'Not started'),
                const SizedBox(width: 8),
                _Chip(text: task.feedbackReceived ? 'Feedback received' : 'Feedback pending'),
                const SizedBox(width: 8),
                _Chip(text: task.completed ? 'Completed' : 'In progress'),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: canStart
                        ? () {
                            service.startTask(task.id);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.black),
                    child: const Text('Start Task'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: canEnd
                        ? () {
                            try {
                              service.endTask(task.id);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Task ended')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.black),
                    child: const Text('End Task'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FeedbackScreen(bookingId: task.id)),
                  );
                },
                style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.green)),
                child: const Text('Collect Customer Feedback', style: TextStyle(color: AppColors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  const _Chip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.green.withOpacity(.35)),
      ),
      child: Text(text),
    );
  }
}


