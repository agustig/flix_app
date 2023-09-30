import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flix_app/data/repositories/user_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/user.dart';
import 'package:path/path.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseUserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<Result<User>> createUser({
    required String uid,
    required String email,
    required String name,
    String? photoUrl,
    int balance = 0,
  }) async {
    try {
      final users = _firebaseFirestore.collection('users');

      await users.doc(uid).set({
        'uid': uid,
        'email': email,
        'name': name,
        'photoUrl': photoUrl,
        'balance': balance,
      });

      final result = await users.doc(uid).get();
      if (result.exists) {
        return Result.success(User.fromJson(result.data()!));
      } else {
        return const Result.failed('Failed to create user data');
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? 'Failed to create user data');
    }
  }

  @override
  Future<Result<User>> getUser({required String uid}) async {
    final documentReference = _firebaseFirestore.doc('users/$uid');
    final result = await documentReference.get();

    if (result.exists) {
      return Result.success(User.fromJson(result.data()!));
    } else {
      return const Result.failed('User not found');
    }
  }

  @override
  Future<Result<int>> getUserBalance({required String uid}) async {
    final documentReference = _firebaseFirestore.doc('users/$uid');
    final result = await documentReference.get();

    if (result.exists) {
      return Result.success(result.data()!['balance']);
    } else {
      return const Result.failed('User not found');
    }
  }

  @override
  Future<Result<User>> updateUser({required User user}) async {
    try {
      final documentReference = _firebaseFirestore.doc('users/${user.uid}');
      await documentReference.update(user.toJson());

      final result = await documentReference.get();
      if (result.exists) {
        final updatedUser = User.fromJson(result.data()!);
        if (updatedUser == user) {
          return Result.success(updatedUser);
        } else {
          return const Result.failed('Failed to update user data');
        }
      } else {
        return const Result.failed('Failed to update user data');
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? 'Failed to update user data');
    }
  }

  @override
  Future<Result<User>> updateUserBalance({
    required String uid,
    required int balance,
  }) async {
    final documentReference = _firebaseFirestore.doc('users/$uid');
    final result = await documentReference.get();

    if (result.exists) {
      await documentReference.update({'balance': balance});
      final updatedResult = await documentReference.get();
      if (updatedResult.exists) {
        final updatedUser = User.fromJson(updatedResult.data()!);
        if (updatedUser.balance == balance) {
          return Result.success(updatedUser);
        } else {
          return const Result.failed('Failed to update user balance');
        }
      } else {
        return const Result.failed('Failed to retrieve updated user balance');
      }
    } else {
      return const Result.failed('User not found');
    }
  }

  @override
  Future<Result<User>> uploadProfilePicture({
    required User user,
    required File imageFile,
  }) async {
    final filename = basename(imageFile.path);
    final reference = FirebaseStorage.instance.ref().child(filename);
    try {
      await reference.putFile(imageFile);
      final downloadUrl = await reference.getDownloadURL();
      final updatedResult = await updateUser(
        user: user.copyWith(photoUrl: downloadUrl),
      );
      return updatedResult;
    } catch (_) {
      return const Result.failed('Failed to upload profile picture');
    }
  }
}
