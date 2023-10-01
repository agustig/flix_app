import 'package:flix_app/data/repositories/transaction_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/transaction.dart';
import 'package:flix_app/domain/usecases/usecase.dart';

part 'create_transaction_params.dart';

class CreateTransaction
    implements Usecase<Result<Transaction>, CreateTransactionParams> {
  final TransactionRepository _transactionRepository;

  CreateTransaction({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<Transaction>> call(CreateTransactionParams params) {
    final transactionTime = DateTime.now().millisecondsSinceEpoch;

    return _transactionRepository.createTransaction(
      transaction: params.transaction.copyWith(
        transactionTime: transactionTime,
        id: 'flx-$transactionTime-${params.transaction.uid}',
      ),
    );
  }
}
