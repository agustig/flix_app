import 'package:dio/dio.dart';
import 'package:flix_app/data/repositories/payment_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/utils/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StripePaymentRepository implements PaymentRepository {
  final Dio _dio;
  final Stripe _stripeInstance;

  final _options = Options(headers: {
    'Authorization': 'Bearer ${Env.stripeSecret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  });

  StripePaymentRepository({Dio? dio, Stripe? stripeInstance})
      : _dio = dio ?? Dio(),
        _stripeInstance = stripeInstance ?? Stripe.instance;

  Future<Map<String, dynamic>> _createPaymentIntent(
    double amount,
    String currency,
  ) async {
    final body = {
      'amount': (amount * 100).toInt(),
      'currency': currency,
    };
    final response = await _dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: _options,
      data: body,
    );
    return response.data as Map<String, dynamic>;
  }

  Future<void> _displayPaymentSheet() async {
    try {
      await _stripeInstance.presentPaymentSheet().then((value) {
        return Fluttertoast.showToast(msg: 'Payment completed');
      });
    } on StripeException catch (e) {
      Fluttertoast.showToast(
        msg: 'Error from Stripe: ${e.error.localizedMessage}',
      );
      throw Exception(e.toString());
    } catch (e) {
      Fluttertoast.showToast(msg: 'Unforeseen error:  $e');

      throw Exception(e.toString());
    }
  }

  @override
  Future<Result<void>> makePayment({
    required double amount,
    String currency = 'USD',
  }) async {
    try {
      final paymentIntent = await _createPaymentIntent(amount, currency);
      await _stripeInstance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent['client_secret'],
            style: ThemeMode.dark,
            merchantDisplayName: 'Flix App',
          ))
          .then((value) => null);

      await _displayPaymentSheet()
          .then((value) => null)
          .onError((error, stackTrace) => throw Exception(error));

      return const Result.success(null);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }
}
