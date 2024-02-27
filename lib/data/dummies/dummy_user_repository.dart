import 'dart:io';

import 'package:flix_app/data/repositories/user_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/user.dart';

class DummyUserRepository implements UserRepository {
  @override
  Future<Result<User>> createUser({
    required String uid,
    required String email,
    required String name,
    String? photoUrl,
    double balance = 0,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Result.success(User(
      uid: uid,
      email: email,
      name: name,
      photoUrl: photoUrl,
      balance: balance,
    ));
  }

  @override
  Future<Result<User>> getUser({required String uid}) async {
    await Future.delayed(const Duration(seconds: 1));
    return Result.success(User(
      uid: uid,
      email: 'dummy@dummy.com',
      name: 'dummy',
    ));
  }

  @override
  Future<Result<double>> getUserBalance({required String uid}) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Result.success(0);
  }

  @override
  Future<Result<User>> updateUser({required User user}) async {
    await Future.delayed(const Duration(seconds: 1));
    return Result.success(user);
  }

  @override
  Future<Result<User>> updateUserBalance({
    required String uid,
    required double balance,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Result.success(User(
      uid: uid,
      email: 'dummy@dummy.com',
      name: 'dummy',
      balance: balance,
    ));
  }

  @override
  Future<Result<User>> uploadProfilePicture({
    required User user,
    required File imageFile,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Result.success(user);
  }
}
