import 'package:flix_app/data/dummies/dummy_auth_repository.dart';
import 'package:flix_app/data/dummies/dummy_user_repository.dart';
import 'package:flix_app/domain/usecases/login/login.dart';
import 'package:flix_app/presentation/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final login = Login(
              authRepository: DummyAuthRepository(),
              userRepository: DummyUserRepository(),
            );

            login(LoginParams(email: 'email', password: 'password'))
                .then((result) {
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
