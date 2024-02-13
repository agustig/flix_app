import 'package:flix_app/data/repositories/payment_repository.dart';
import 'package:flix_app/data/repositories/transaction_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/transaction.dart';
import 'package:flix_app/domain/usecases/usecase.dart';

part 'top_up_params.dart';

class TopUp implements Usecase<Result<void>, TopUpParams> {
  final PaymentRepository _paymentRepository;
  final TransactionRepository _transactionRepository;

  TopUp({
    required PaymentRepository paymentRepository,
    required TransactionRepository transactionRepository,
  })  : _paymentRepository = paymentRepository,
        _transactionRepository = transactionRepository;

  @override
  Future<Result<void>> call(TopUpParams params) async {
    final transactionTime = DateTime.now().millisecondsSinceEpoch;
    final transaction = Transaction(
      id: 'flxtp-$transactionTime-${params.uid}',
      uid: params.uid,
      title: 'Top Up',
      adminFee: 0,
      total: -params.amount,
      transactionTime: transactionTime,
    );

    final paymentResult = await _paymentRepository.makePayment(
      amount: params.amount,
    );

    switch (paymentResult) {
      case Success():
        final transactionResult = await _transactionRepository
            .createTransaction(transaction: transaction);

        return switch (transactionResult) {
          Success(value: _) => const Result.success(null),
          Failed(message: _) =>
            const Result.failed('Failed to create transaction'),
        };

      case Failed():
        return const Result.failed('Failed to create payment');
    }
  }
}
