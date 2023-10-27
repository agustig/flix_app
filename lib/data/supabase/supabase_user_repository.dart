import 'dart:io';

import 'package:flix_app/data/repositories/user_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class SupabaseUserRepository implements UserRepository {
  final SupabaseClient _supabaseClient;

  SupabaseUserRepository({SupabaseClient? supabaseClient})
      : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  @override
  Future<Result<User>> createUser({
    required String uid,
    required String email,
    required String name,
    String? photoUrl,
    double balance = 0,
  }) async {
    final newData = {
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'balance': balance,
    };
    final result = await _supabaseClient
        .from('users')
        .insert(newData)
        .select<PostgrestList>();

    return Result.success(User.fromJson(result.first));
  }

  @override
  Future<Result<User>> getUser({required String uid}) async {
    final result = await _supabaseClient
        .from('users')
        .select<PostgrestList>()
        .eq('uid', uid);
    if (result.isNotEmpty) {
      return Result.success(User.fromJson(result.first));
    } else {
      return const Result.failed('User not found');
    }
  }

  @override
  Future<Result<double>> getUserBalance({required String uid}) async {
    final result = await _supabaseClient
        .from('users')
        .select<PostgrestList>('balance')
        .is_('uid', uid);

    if (result.isNotEmpty) {
      return Result.success(result.first['balance']);
    } else {
      return const Result.failed('User not found');
    }
  }

  @override
  Future<Result<User>> updateUser({required User user}) async {
    final newData = {
      'email': user.email,
      'name': user.name,
      'photoUrl': user.photoUrl,
      'balance': user.balance,
    };

    final result = await _supabaseClient
        .from('users')
        .update(newData)
        .eq('uid', user.uid)
        .select<PostgrestList>();

    if (result.isNotEmpty) {
      return Result.success(User.fromJson(result.first));
    } else {
      return const Result.failed('User not found');
    }
  }

  @override
  Future<Result<User>> updateUserBalance({
    required String uid,
    required double balance,
  }) async {
    final result = await _supabaseClient
        .from('users')
        .update({'balance': balance})
        .eq('uid', uid)
        .select<PostgrestList>();

    if (result.isNotEmpty) {
      return Result.success(User.fromJson(result.first));
    } else {
      return const Result.failed('User not found');
    }
  }

  @override
  Future<Result<User>> uploadProfilePicture({
    required User user,
    required File imageFile,
  }) async {
    final String path =
        await _supabaseClient.storage.from('profile_picture').upload(
              'public/${user.uid}-${DateTime.now().millisecondsSinceEpoch}',
              imageFile,
              fileOptions: const FileOptions(cacheControl: '3600'),
            );
    final updatedResult = await updateUser(user: user.copyWith(photoUrl: path));
    return updatedResult;
  }
}
