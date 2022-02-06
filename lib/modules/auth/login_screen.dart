import 'package:first_task/modules/auth/auth_provider.dart';
import 'package:first_task/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            SizedBox(height: screenWidth * 0.2),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset('assets/logo.jpeg', width: screenWidth * 0.45),
            ),
            SizedBox(height: screenWidth * 0.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: screenWidth * 0.33,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey, width: 0.3),
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset('assets/facebook.png', width: 20),
                      const SizedBox(width: 8),
                      const Text('Facebook'),
                    ],
                  ),
                ),
                Container(
                  width: screenWidth * 0.33,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey, width: 0.3),
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset('assets/google.png', width: 20),
                      const SizedBox(width: 8),
                      const Text('Google'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'or',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email ID',
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.4)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.4)),
                    ),
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Email cannot be empty.';
                      }
                      final isEmailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value ?? '');
                      if (!isEmailValid) {
                        return 'Write a valid email.';
                      }
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.4)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.4)),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if ((value?.trim().length ?? 0) < 8) {
                        return 'Password must not be less than 8 characters.';
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Text('Forgot password?'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    final result = authProvider.validateUser(emailController.text.trim(), passwordController.text.trim());
                    if (result) {
                      Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.honeScreen, (route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('incorrect data, or there is no saved data.'),
                        ),
                      );
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 16)),
                ),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 36),
            Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  text: "Don't have an account? ",
                  children: [
                    WidgetSpan(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(RouteGenerator.registerScreen);
                        },
                        child: const Text(
                          'Register now!',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
