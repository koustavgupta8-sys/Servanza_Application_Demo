import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../widgets/rounded_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';
import '../main_shell.dart';
import 'signup_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;

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
            const Text('Welcome back', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Sign in to continue'),
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
            const SizedBox(height: 12),

            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (v) => setState(() => rememberMe = v ?? false),
                ),
                const Text('Remember Me'),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: AppColors.orange),
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (auth.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(auth.errorMessage!, style: const TextStyle(color: Colors.redAccent)),
              ),

            PrimaryButton(
              label: auth.isLoading ? 'Signing In...' : 'Sign In',
              onPressed: auth.isLoading
                  ? null
                  : () async {
                      await authCtrl.signIn(emailController.text.trim(), passwordController.text);
                      final user = ref.read(authControllerProvider).user;
                      if (user != null && context.mounted) {
                        Navigator.pushReplacementNamed(context, MainShell.routeName);
                      }
                    },
            ),
            const SizedBox(height: 12),

            SecondaryButton(label: 'Continue with Google', onPressed: () {}, icon: Icons.g_mobiledata),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, SignUpScreen.routeName),
                  style: TextButton.styleFrom(foregroundColor: AppColors.orange),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}