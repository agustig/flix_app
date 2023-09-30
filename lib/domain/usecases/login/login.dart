import 'package:flix_app/data/repositories/auth_repository.dart';
import 'package:flix_app/data/repositories/user_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/user.dart';
import 'package:flix_app/domain/usecases/usecase.dart';

part 'login_params.dart';

class Login implements Usecase<Result<User>, LoginParams> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  Login({required this.authRepository, required this.userRepository});

  @override
  Future<Result<User>> call(LoginParams params) async {
    final idResult = await authRepository.login(
      email: params.email,
      password: params.password,
    );

    if (idResult is Success) {
      final userResult =
          await userRepository.getUser(uid: idResult.resultValue!);

      return switch (userResult) {
        Success(value: final user) => Result.success(user),
        Failed(:final message) => Result.failed(message),
      };
    } else {
      return Result.failed(idResult.errorMessage!);
    }
  }
}
