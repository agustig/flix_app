import 'package:firebase_core/firebase_core.dart';
import 'package:flix_app/firebase_options.dart';
import 'package:flix_app/presentation/pages/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginPage()
        // Scaffold(
        //   body: Center(
        //     child: Text('Hello World!'),
        //   ),
        // ),
        );
  }
}
