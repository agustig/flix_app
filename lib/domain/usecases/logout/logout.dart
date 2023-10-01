import 'package:flix_app/data/repositories/auth_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/usecases/usecase.dart';

class Logout implements Usecase<Result<void>, void> {
  final AuthRepository _authRepository;

  Logout({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Result<void>> call(void _) {
    return _authRepository.logout();
  }
}
