import 'package:flix_app/presentation/extensions/build_context_extension.dart';
import 'package:flix_app/presentation/misc/methods.dart';
import 'package:flix_app/presentation/providers/router/router_provider.dart';
import 'package:flix_app/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_app/presentation/widgets/flix_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (prev, next) {
      if (next is AsyncData && next.value != null) {
        ref.read(routerProvider).goNamed('main');
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });
    return Scaffold(
      body: ListView(
        children: [
          verticalSpaces(100),
          Center(
            child: Image.asset(
              'assets/flix-app-logo.png',
              width: 150,
            ),
          ),
          verticalSpaces(50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                FlixTextField(labelText: 'Name', controller: nameController),
                verticalSpaces(24),
                FlixTextField(labelText: 'Email', controller: emailController),
                verticalSpaces(24),
                FlixTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                verticalSpaces(24),
                FlixTextField(
                  labelText: 'Password confirmation',
                  controller: passwordConfirmationController,
                  obscureText: true,
                ),
                verticalSpaces(24),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (passwordController.text ==
                                  passwordConfirmationController.text) {
                                ref.read(userDataProvider.notifier).register(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                              } else {
                                context.showSnackBar(
                                    'Please retype password with the same value');
                              }
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : const Center(child: CircularProgressIndicator()),
                  _ => const Center(
                      child: CircularProgressIndicator(),
                    ),
                },
                verticalSpaces(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have and account? '),
                    TextButton(
                      onPressed: () =>
                          ref.read(routerProvider).goNamed('login'),
                      child: const Text(
                        'Login here',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                verticalSpaces(24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }
}
