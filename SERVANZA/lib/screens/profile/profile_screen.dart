import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import 'feedback_screen.dart';
import 'employee_tasks_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: const [
            CircleAvatar(radius: 28, backgroundColor: AppColors.orange, child: Icon(Icons.person, color: Colors.black)),
            SizedBox(width: 12),
            Expanded(child: Text('Your Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
          ],
        ),
        const SizedBox(height: 16),

        Card(
          child: ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Employee Tasks (dev)'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EmployeeTasksScreen()),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.rate_review),
            title: const Text('Feedback'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FeedbackScreen()),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & Support'),
            onTap: () {},
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}


