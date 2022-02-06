import 'package:first_task/modules/auth/auth_provider.dart';
import 'package:first_task/routes.dart';
import 'package:first_task/shared/dial_codes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const Text(
              'Register to CAT RELOADED',
              style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.4)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.4)),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Full Name cannot be empty.';
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.4)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.4)),
                    ),
                    keyboardType: TextInputType.emailAddress,
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
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 16),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: authProvider.selectedDialCode,
                              items: dialCodes.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                              alignment: Alignment.bottomCenter,
                              onChanged: (value) {
                                authProvider.changeSelectedDialCode(value ?? '+20');
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Mobile Number',
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.4)),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.4)),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            final valueInt = int.tryParse(value ?? '');
                            if (valueInt == null) {
                              return 'Write a correct phone number';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
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
                  const SizedBox(height: 24),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.4)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.4)),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null) return 'Password Confirmation must not be empty';
                      if (value.trim() != passwordController.text.trim()) {
                        return 'Password does not match';
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    final dialCode = authProvider.selectedDialCode.replaceAll('+', '00').replaceAll(' ', '');
                    final phone = phoneController.text.trim();
                    final fullPhoneNumber = int.parse(dialCode + phone);
                    authProvider.createUser(nameController.text.trim(), emailController.text.trim(), fullPhoneNumber, passwordController.text.trim());
                    Navigator.of(context).pushNamedAndRemoveUntil(RouteGenerator.honeScreen, (route) => false);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 16)),
                ),
                child: const Text(
                  'REGISTER',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'By registering you agree to terms, conditions and the privacy policy of the team',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
