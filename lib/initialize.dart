import 'package:firebase_core/firebase_core.dart';
import 'package:flix_app/firebase_options.dart';
import 'package:flix_app/utils/env.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  switch (Env.databaseType) {
    case 'firebase':
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    case 'supabase':
      await Supabase.initialize(
        url: Env.supabaseUrl,
        anonKey: Env.supabaseAnonKey,
      );
    default:
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
  }
}
