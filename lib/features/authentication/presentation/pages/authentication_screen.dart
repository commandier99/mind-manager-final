import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1)); // placeholder for real auth
    setState(() => _loading = false);
    // Replace with your real navigation after successful sign-in
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signed in (placeholder)')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      import 'package:flutter/material.dart';

      class AuthenticationScreen extends StatefulWidget {
        const AuthenticationScreen({super.key});

        @override
        State<AuthenticationScreen> createState() => _AuthenticationScreenState();
      }

      class _AuthenticationScreenState extends State<AuthenticationScreen> {
        final _emailController = TextEditingController();
        final _passwordController = TextEditingController();
        bool _loading = false;

        @override
        void dispose() {
          _emailController.dispose();
          _passwordController.dispose();
          super.dispose();
        }

        void _signIn() async {
          setState(() => _loading = true);
          await Future.delayed(const Duration(seconds: 1)); // placeholder for real auth
          setState(() => _loading = false);
          // Replace with your real navigation after successful sign-in
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signed in (placeholder)')));
        }

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Sign In')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _signIn,
                      child: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Sign In'),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }
