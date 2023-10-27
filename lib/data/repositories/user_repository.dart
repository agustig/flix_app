import 'dart:io';

import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<Result<User>> createUser({
    required String uid,
    required String email,
    required String name,
    String? photoUrl,
    double balance = 0,
  });

  Future<Result<User>> getUser({required String uid});

  Future<Result<User>> updateUser({required User user});

  Future<Result<double>> getUserBalance({required String uid});

  Future<Result<User>> updateUserBalance({
    required String uid,
    required double balance,
  });

  Future<Result<User>> uploadProfilePicture({
    required User user,
    required File imageFile,
  });
}
