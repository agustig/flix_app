import 'dart:io';

import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/user.dart';
import 'package:flix_app/domain/usecases/login/login.dart';
import 'package:flix_app/domain/usecases/register/register.dart';
import 'package:flix_app/domain/usecases/top_up/top_up.dart';
import 'package:flix_app/domain/usecases/upload_profile_picture/upload_profile_picture.dart';
import 'package:flix_app/presentation/providers/movie/get_now_playing_provider.dart';
import 'package:flix_app/presentation/providers/movie/get_upcoming_provider.dart';
import 'package:flix_app/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_app/presentation/providers/usecases/usecases_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async {
    final getLoggedInUser = ref.read(getLoggedInUserUsecaseProvider);
    final result = await getLoggedInUser(null);

    switch (result) {
      case Success(value: final user):
        _getMovies();
        return user;
      case Failed(message: _):
        return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    final login = ref.read(loginUsecaseProvider);
    final result = await login(LoginParams(email: email, password: password));

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);
        refreshUserData();
        ref.read(transactionDataProvider.notifier).refreshTransactionData();
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    String? photoUrl,
  }) async {
    state = const AsyncLoading();

    final register = ref.read(registerUsecaseProvider);
    final result = await register(RegisterParams(
      name: name,
      email: email,
      password: password,
      photoUrl: photoUrl,
    ));

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);
        refreshUserData();
        ref.read(transactionDataProvider.notifier).refreshTransactionData();
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> refreshUserData() async {
    final getLoggedInUser = ref.read(getLoggedInUserUsecaseProvider);
    state = const AsyncLoading();
    final result = await getLoggedInUser(null);

    switch (result) {
      case Success(value: final user):
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> logout() async {
    state = const AsyncLoading();

    final logout = ref.read(logoutUsecaseProvider);
    final result = await logout(null);

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }

  Future<void> topUp(double amount) async {
    final topUp = ref.read(topUpUsecaseProvider);
    final String? userId = state.valueOrNull?.uid;

    if (userId != null) {
      final result = await topUp(TopUpParams(amount: amount, uid: userId));
      if (result.isSuccess) {
        refreshUserData();
        ref.read(transactionDataProvider.notifier).refreshTransactionData();
      }
    }
  }

  Future<void> uploadProfilePicture(
      {required User user, required File imageFile}) async {
    state = const AsyncLoading();

    final uploadProfilePicture = ref.read(uploadProfilePictureUsecaseProvider);
    final result = await uploadProfilePicture(UploadProfilePictureParams(
      imageFile: imageFile,
      user: user,
    ));

    switch (result) {
      case Success(value: final user):
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  void _getMovies() {
    ref.read(getNowPlayingProvider.notifier).get();
    ref.read(getUpcomingProvider.notifier).get();
  }
}
