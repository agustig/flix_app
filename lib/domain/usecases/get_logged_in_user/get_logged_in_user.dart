import 'package:flix_app/data/repositories/auth_repository.dart';
import 'package:flix_app/data/repositories/user_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/user.dart';
import 'package:flix_app/domain/usecases/usecase.dart';

class GetLoggedInUser implements Usecase<Result<User>, void> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  GetLoggedInUser({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  @override
  Future<Result<User>> call(void _) async {
    final loggedId = _authRepository.getLoggedInUserId();

    if (loggedId != null) {
      final userResult = await _userRepository.getUser(uid: loggedId);
      return userResult;
    } else {
      return const Result.failed('No user logged in');
    }
  }
}
