import 'package:flix_app/domain/usecases/login/login.dart';
import 'package:flix_app/presentation/providers/repositories/auth_repository/auth_repository_provider.dart';
import 'package:flix_app/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
Login login(LoginRef ref) => Login(
      authRepository: ref.watch(authRepositoryProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );
