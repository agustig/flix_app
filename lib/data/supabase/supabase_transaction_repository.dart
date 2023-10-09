import 'package:flix_app/data/repositories/transaction_repository.dart';
import 'package:flix_app/data/supabase/supabase_user_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/transaction.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseTransactionRepository implements TransactionRepository {
  final SupabaseClient _supabaseClient;

  SupabaseTransactionRepository({SupabaseClient? supabaseClient})
      : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  @override
  Future<Result<Transaction>> createTransaction({
    required Transaction transaction,
  }) async {
    const createFailureMessage = 'Failed to create transaction data';
    try {
      final balanceResult = await SupabaseUserRepository().getUserBalance(
        uid: transaction.uid,
      );
      if (balanceResult.isSuccess) {
        final previousBalance = balanceResult.resultValue!;

        if (previousBalance - transaction.total >= 0) {
          final result = await _supabaseClient
              .from('transactions')
              .insert(transaction.toJson())
              .select<PostgrestList>();

          if (result.isNotEmpty) {
            await SupabaseUserRepository().updateUserBalance(
              uid: transaction.uid,
              balance: previousBalance - transaction.total,
            );
            return Result.success(Transaction.fromJson(result.first));
          } else {
            return const Result.failed(createFailureMessage);
          }
        } else {
          return const Result.failed('Insufficient balance');
        }
      } else {
        return const Result.failed(createFailureMessage);
      }
    } catch (_) {
      return const Result.failed(createFailureMessage);
    }
  }

  @override
  Future<Result<List<Transaction>>> getUserTransactions(
      {required String uid}) async {
    try {
      final result = await _supabaseClient
          .from('transactions')
          .select<PostgrestList>()
          .eq('uid', uid);
      if (result.isNotEmpty) {
        return Result.success(
          result.map((e) => Transaction.fromJson(e)).toList(),
        );
      } else {
        return const Result.success([]);
      }
    } catch (_) {
      return const Result.failed('Failed to get user transactions');
    }
  }
}
