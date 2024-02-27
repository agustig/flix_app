import 'package:flix_app/data/repositories/auth_repository.dart';
import 'package:flix_app/domain/entities/result.dart';

class DummyAuthRepository implements AuthRepository {
  @override
  String? getLoggedInUserId() {
    return 'ID-12345';
  }

  @override
  Future<Result<String>> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Result.success('ID-12345');
  }

  @override
  Future<Result<void>> logout() async {
    await Future.delayed(const Duration(seconds: 1));
    return const Result.success(null);
  }

  @override
  Future<Result<String>> register({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Result.success('ID-12345');
  }
}
