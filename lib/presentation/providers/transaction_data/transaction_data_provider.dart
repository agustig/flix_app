import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/transaction.dart';
import 'package:flix_app/domain/entities/user.dart';
import 'package:flix_app/domain/usecases/get_transactions/get_transactions.dart';
import 'package:flix_app/presentation/providers/usecases/usecases_provider.dart';
import 'package:flix_app/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_data_provider.g.dart';

@Riverpod(keepAlive: true)
class TransactionData extends _$TransactionData {
  @override
  Future<List<Transaction>> build() async {
    final User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      final getTransaction = ref.read(getTransactionsUsecaseProvider);
      final result = await getTransaction(GetTransactionsParams(uid: user.uid));
      switch (result) {
        case Success(value: final transaction):
          return transaction;
        case Failed(message: _):
          return [];
      }
    }

    return [];
  }

  Future<void> refreshTransactionData() async {
    final User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      state = const AsyncLoading();

      final getTransaction = ref.read(getTransactionsUsecaseProvider);
      final result = await getTransaction(GetTransactionsParams(uid: user.uid));

      switch (result) {
        case Success(value: final transaction):
          state = AsyncData(transaction);
        case Failed(:final message):
          state = AsyncError(FlutterError(message), StackTrace.current);
          state = AsyncData(state.valueOrNull ?? const []);
      }
    }
  }
}
