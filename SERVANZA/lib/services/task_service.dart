import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task.dart';

class TaskService extends StateNotifier<List<Task>> {
  TaskService() : super(_seed);

  static final List<Task> _seed = [
    Task(
      id: 'bk_1001',
      title: 'Kitchen - Sink & Slab',
      customerName: 'Aarav Sharma',
      address: '12 Park Street, Kolkata',
      scheduledAt: DateTime.now().add(const Duration(hours: 1)),
    ),
    Task(
      id: 'bk_1002',
      title: 'Bathroom - Toilet',
      customerName: 'Neha Verma',
      address: '4 MG Road, Bengaluru',
      scheduledAt: DateTime.now().add(const Duration(hours: 2)),
    ),
  ];

  void startTask(String id) {
    state = [
      for (final t in state)
        if (t.id == id)
          t.copyWith(started: true, startedAt: DateTime.now())
        else
          t,
    ];
  }

  void markFeedbackReceived(String id) {
    state = [
      for (final t in state)
        if (t.id == id)
          t.copyWith(feedbackReceived: true)
        else
          t,
    ];
  }

  void endTask(String id) {
    final task = state.firstWhere((t) => t.id == id);
    if (!task.feedbackReceived) {
      throw StateError('Feedback not received yet');
    }
    state = [
      for (final t in state)
        if (t.id == id)
          t.copyWith(completed: true, completedAt: DateTime.now())
        else
          t,
    ];
  }
}

final taskServiceProvider = StateNotifierProvider<TaskService, List<Task>>((ref) => TaskService());


