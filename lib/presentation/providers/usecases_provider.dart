import 'package:flix_app/domain/usecases/login/login.dart';
import 'package:flix_app/presentation/providers/repositories_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecases_provider.g.dart';

@riverpod
Login login(LoginRef ref) => Login(
      authRepository: ref.watch(authRepositoryProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );
