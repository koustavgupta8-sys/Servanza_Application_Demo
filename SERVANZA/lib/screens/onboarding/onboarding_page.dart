import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  static const routeName = '/onboarding';

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final slides = [
      _slide(
        color: const Color(0xFF0D47A1),
        title: 'Book in a pinch!',
        desc: 'Find trusted services fast with SERVANZA.',
        illustration: Icons.handyman,
      ),
      _slide(
        color: const Color(0xFF6A1B9A),
        title: 'Schedule your services',
        desc: 'Pick time slots that fit your day.',
        illustration: Icons.event_available,
      ),
      _slide(
        color: AppColors.orange,
        title: 'Get exclusive offers',
        desc: 'Unlock special deals tailored to you.',
        illustration: Icons.local_offer,
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (i) => setState(() => index = i),
            children: slides,
          ),
          Positioned(
            right: 16,
            top: 40,
            child: TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('onboarding_complete', true);
                if (!mounted) return;
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: const Text('Skip', style: TextStyle(color: Colors.white)),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 28,
            child: Row(
              children: [
                Row(
                  children: List.generate(
                    slides.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: i == index ? 22 : 8,
                      height: 8,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(i == index ? 1 : .5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    if (index < slides.length - 1) {
                      controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
                    } else {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('onboarding_complete', true);
                      if (!mounted) return;
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  ),
                  child: Text(index < slides.length - 1 ? 'Next' : 'Get Started'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _slide({
    required Color color,
    required String title,
    required String desc,
    required IconData illustration,
  }) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(24),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Align(
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.15),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(illustration, size: 96, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            Text(title, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            Text(desc, style: const TextStyle(fontSize: 16, color: Colors.white)),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}