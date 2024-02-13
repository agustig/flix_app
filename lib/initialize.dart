import 'package:firebase_core/firebase_core.dart';
import 'package:flix_app/firebase_options.dart';
import 'package:flix_app/utils/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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

  // Assign publishable key to flutter_stripe
  Stripe.publishableKey =
      "pk_test_51NwYbBKXvlXOKZCsIHLiQfsW9MHNcUXVcfZc6PQqKGXJceZBhT1OStE8Qa7CwDjpBKTMe644luxApW15neYR0zb800wv7JSxuS";
}
