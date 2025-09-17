import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = List.generate(10, (i) => Colors.primaries[i % Colors.primaries.length]);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Latest promotions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: cards.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) => Container(
              width: 240,
              decoration: BoxDecoration(
                color: cards[i],
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(child: SizedBox()),
                  Text('Limited-time offer', style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}