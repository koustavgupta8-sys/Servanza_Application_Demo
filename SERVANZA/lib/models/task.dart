class Task {
  final String id; // booking/task id
  final String title;
  final String customerName;
  final String address;
  final DateTime scheduledAt;
  final bool started;
  final DateTime? startedAt;
  final bool feedbackReceived;
  final bool completed;
  final DateTime? completedAt;

  const Task({
    required this.id,
    required this.title,
    required this.customerName,
    required this.address,
    required this.scheduledAt,
    this.started = false,
    this.startedAt,
    this.feedbackReceived = false,
    this.completed = false,
    this.completedAt,
  });

  Task copyWith({
    String? id,
    String? title,
    String? customerName,
    String? address,
    DateTime? scheduledAt,
    bool? started,
    DateTime? startedAt,
    bool? feedbackReceived,
    bool? completed,
    DateTime? completedAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      customerName: customerName ?? this.customerName,
      address: address ?? this.address,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      started: started ?? this.started,
      startedAt: startedAt ?? this.startedAt,
      feedbackReceived: feedbackReceived ?? this.feedbackReceived,
      completed: completed ?? this.completed,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}


