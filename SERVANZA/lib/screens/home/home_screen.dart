import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../notifications/notifications_screen.dart';
import '../../models/auth.dart';
import '../../widgets/service_flip_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'title': 'Dining Place', 'cat': ServiceCategory.dining, 'icon': Icons.restaurant},
      {'title': 'Kitchen', 'cat': ServiceCategory.kitchen, 'icon': Icons.kitchen},
      {'title': 'Bathroom', 'cat': ServiceCategory.bathroom, 'icon': Icons.bathroom},
      {'title': 'Balcony', 'cat': ServiceCategory.balcony, 'icon': Icons.window},
      {'title': 'Rooms', 'cat': ServiceCategory.rooms, 'icon': Icons.bedroom_parent},
      {'title': 'Dog Walking', 'cat': ServiceCategory.dogWalking, 'icon': Icons.pets},
      {'title': 'Combos', 'cat': ServiceCategory.package, 'icon': Icons.all_inclusive},
    ];

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          title: const Text('SERVANZA'),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_rounded),
              onPressed: () => Navigator.pushNamed(context, NotificationsScreen.routeName),
            ),
          ],
        ),

        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(color: AppColors.green.withOpacity(.4), blurRadius: 18, spreadRadius: 1),
              ],
              border: Border.all(color: AppColors.green.withOpacity(.35)),
            ),
            child: const Text('Minimum Order Value: ₹399', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w700)),
          ),
        ),

        for (final c in categories) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  Icon(c['icon'] as IconData, color: AppColors.green),
                  const SizedBox(width: 8),
                  Text(c['title'] as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final items = ServiceCatalog.byCategory(c['cat'] as ServiceCategory);
                  final item = items[index];
                  return ServiceFlipCard(
                    item: item,
                    onAdd: () {
                      // TODO: integrate cart later
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${item.name} added')),
                      );
                    },
                  );
                },
                childCount: ServiceCatalog.byCategory(c['cat'] as ServiceCategory).length,
              ),
            ),
          ),
        ],
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}