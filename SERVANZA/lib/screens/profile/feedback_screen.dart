import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/theme.dart';
import '../../services/task_service.dart';

class FeedbackScreen extends ConsumerStatefulWidget {
  final String? bookingId; // if provided, unlocks End Task for that booking
  const FeedbackScreen({super.key, this.bookingId});
  static const routeName = '/feedback';

  @override
  ConsumerState<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends ConsumerState<FeedbackScreen> {
  int rating = 0;
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rate your experience', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Row(
              children: List.generate(5, (i) {
                final idx = i + 1;
                final selected = idx <= rating;
                return IconButton(
                  onPressed: () => setState(() => rating = idx),
                  icon: Icon(
                    selected ? Icons.star : Icons.star_border,
                    color: selected ? AppColors.green : AppColors.gray,
                    size: 30,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            const Text('Comments (optional)', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Share any suggestions or issues…',
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: rating == 0
                    ? null
                    : () {
                        // TODO: send feedback to backend in future
                        if (widget.bookingId != null) {
                          ref.read(taskServiceProvider.notifier).markFeedbackReceived(widget.bookingId!);
                        }
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Thanks for the feedback!')),
                        );
                      },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.black),
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}


