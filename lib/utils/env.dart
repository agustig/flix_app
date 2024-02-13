import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'TMDB_KEY', obfuscate: true)
  static final String tmdbApiKey = _Env.tmdbApiKey;
  @EnviedField(varName: 'DATABASE_TYPE')
  static const String databaseType = _Env.databaseType;
  @EnviedField(varName: 'SUPABASE_URL')
  static const String supabaseUrl = _Env.supabaseUrl;
  @EnviedField(varName: 'SUPABASE_ANON_KEY', obfuscate: true)
  static final String supabaseAnonKey = _Env.supabaseAnonKey;
  @EnviedField(varName: 'STRIPE_SECRET', obfuscate: true)
  static final String stripeSecret = _Env.stripeSecret;
}
