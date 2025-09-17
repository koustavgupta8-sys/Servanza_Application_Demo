import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/theme.dart';
import '../../widgets/rounded_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';
import '../../controllers/auth_controller.dart';
import '../main_shell.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = '/signup';

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    final authCtrl = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(leading: BackButton(onPressed: () => Navigator.pop(context))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 24),
            const Text('Create account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Join SERVANZA in minutes'),
            const SizedBox(height: 24),

            RoundedTextField(
              controller: emailController,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            RoundedTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 16),

            if (auth.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(auth.errorMessage!, style: const TextStyle(color: Colors.redAccent)),
              ),

            PrimaryButton(
              label: auth.isLoading ? 'Creating...' : 'Create Account',
              onPressed: auth.isLoading
                  ? null
                  : () async {
                      await authCtrl.signUp(emailController.text.trim(), passwordController.text);
                      final user = ref.read(authControllerProvider).user;
                      if (user != null && context.mounted) {
                        Navigator.pushReplacementNamed(context, MainShell.routeName);
                      }
                    },
            ),
            const SizedBox(height: 12),

            SecondaryButton(label: 'Continue with Google', onPressed: () {}, icon: Icons.g_mobiledata),
          ],
        ),
      ),
    );
  }
}


