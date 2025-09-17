import 'package:flutter/material.dart';
import '../models/auth.dart';
import '../theme/theme.dart';

class ServiceFlipCard extends StatefulWidget {
  final ServiceItem item;
  final VoidCallback? onAdd;

  const ServiceFlipCard({super.key, required this.item, this.onAdd});

  @override
  State<ServiceFlipCard> createState() => _ServiceFlipCardState();
}

class _ServiceFlipCardState extends State<ServiceFlipCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );
  late final Animation<double> _anim = Tween(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  bool get _isBack => _anim.value >= 0.5;

  void _flip() {
    if (_isBack) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _anim,
        builder: (context, _) {
          final angle = _anim.value * 3.1415926535; // pi
          final isBack = angle > 1.5707963267; // pi/2

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4022C55E),
                    blurRadius: 18,
                    spreadRadius: 1,
                    offset: Offset(0, 6),
                  ),
                ],
                border: Border.all(color: AppColors.green.withOpacity(.3), width: 1),
              ),
              padding: const EdgeInsets.all(14),
              child: isBack ? _Back(item: widget.item, onBackTap: _flip, onAdd: widget.onAdd) : _Front(item: widget.item),
            ),
          );
        },
      ),
    );
  }
}

class _Front extends StatelessWidget {
  final ServiceItem item;
  const _Front({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                item.name,
                style: const TextStyle(fontWeight: FontWeight.w700),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: AppColors.green.withOpacity(.4), blurRadius: 12, spreadRadius: 1),
                ],
              ),
              child: Text(item.displayPrice, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800)),
            ),
          ],
        ),
        const Spacer(),
        const Text('Tap to flip', style: TextStyle(color: AppColors.gray, fontSize: 12)),
      ],
    );
  }
}

class _Back extends StatelessWidget {
  final ServiceItem item;
  final VoidCallback onBackTap;
  final VoidCallback? onAdd;
  const _Back({required this.item, required this.onBackTap, this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.name, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text(item.description, style: const TextStyle(color: AppColors.gray)),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.schedule, size: 16, color: AppColors.gray),
            const SizedBox(width: 6),
            Text(item.estimatedTime, style: const TextStyle(color: AppColors.gray)),
            const Spacer(),
            Text(item.displayPrice, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w700)),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            OutlinedButton(
              onPressed: onBackTap,
              style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.green)),
              child: const Text('Back', style: TextStyle(color: AppColors.white)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: onAdd,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.black),
                child: const Text('Add'),
              ),
            ),
          ],
        )
      ],
    );
  }
}


