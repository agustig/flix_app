import 'package:flix_app/data/repositories/user_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/usecases/usecase.dart';

part 'get_user_balance_params.dart';

class GetUserBalance implements Usecase<Result<int>, GetUserBalanceParams> {
  final UserRepository _userRepository;

  GetUserBalance({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Result<int>> call(GetUserBalanceParams params) =>
      _userRepository.getUserBalance(uid: params.uid);
}
