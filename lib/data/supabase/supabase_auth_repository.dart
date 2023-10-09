import 'package:flix_app/data/repositories/auth_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _supabase;

  SupabaseAuthRepository({SupabaseClient? supabase})
      : _supabase = supabase ?? Supabase.instance.client;

  @override
  String? getLoggedInUserId() => _supabase.auth.currentUser?.id;

  @override
  Future<Result<String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return Result.success(response.user!.id);
    } on AuthException catch (error) {
      return Result.failed(error.message);
    }
  }

  @override
  Future<Result<void>> logout() async {
    await _supabase.auth.signOut();
    if (_supabase.auth.currentUser == null) {
      return const Result.success(null);
    } else {
      return const Result.failed('Failed to sign out');
    }
  }

  @override
  Future<Result<String>> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      return Result.success(response.user!.id);
    } on AuthException catch (error) {
      return Result.failed(error.message);
    }
  }
}
