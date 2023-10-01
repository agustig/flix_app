import 'package:flix_app/data/repositories/auth_repository.dart';
import 'package:flix_app/data/repositories/user_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/user.dart';
import 'package:flix_app/domain/usecases/usecase.dart';

part 'register_params.dart';

class Register implements Usecase<Result<User>, RegisterParams> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Register({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  @override
  Future<Result<User>> call(RegisterParams params) async {
    final uidResult = await _authRepository.register(
      email: params.email,
      password: params.password,
    );

    if (uidResult.isSuccess) {
      final userResult = await _userRepository.createUser(
        uid: uidResult.resultValue!,
        email: params.email,
        name: params.name,
        photoUrl: params.photoUrl,
      );

      return userResult;
    } else {
      return Result.failed(uidResult.errorMessage!);
    }
  }
}
