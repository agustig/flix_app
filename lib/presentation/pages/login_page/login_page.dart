import 'package:flix_app/domain/usecases/login/login.dart';
import 'package:flix_app/presentation/pages/main_page/main_page.dart';
import 'package:flix_app/presentation/providers/usecases_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final login = ref.watch(loginProvider);

            login(
              LoginParams(
                email: 'jennie.kim@blackpink.com',
                password: '123456',
              ),
            ).then((result) {
              if (result.isSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(user: result.resultValue!),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result.errorMessage!)));
              }
            });
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
