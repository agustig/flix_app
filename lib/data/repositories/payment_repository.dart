import 'package:flix_app/domain/entities/result.dart';

abstract interface class PaymentRepository {
  Future<Result<void>> makePayment({
    required double amount,
    String currency = 'USD',
  });
}
