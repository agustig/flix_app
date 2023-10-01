import 'package:flix_app/data/repositories/transaction_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/transaction.dart';
import 'package:flix_app/domain/usecases/usecase.dart';

part 'get_transactions_params.dart';

class GetTransactions
    implements Usecase<Result<List<Transaction>>, GetTransactionsParams> {
  final TransactionRepository _transactionRepository;

  GetTransactions({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<List<Transaction>>> call(GetTransactionsParams params) =>
      _transactionRepository.getUserTransactions(uid: params.uid);
}
