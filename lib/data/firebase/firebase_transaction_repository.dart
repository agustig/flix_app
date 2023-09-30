import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flix_app/data/firebase/firebase_user_repository.dart';
import 'package:flix_app/data/repositories/transaction_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/transaction.dart';

class FirebaseTransactionRepository implements TransactionRepository {
  final firestore.FirebaseFirestore _firebaseFirestore;
  FirebaseTransactionRepository(
      {firestore.FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore =
            firebaseFirestore ?? firestore.FirebaseFirestore.instance;

  @override
  Future<Result<Transaction>> createTransaction(
      {required Transaction transaction}) async {
    const createFailureMessage = 'Failed to create transaction data';
    final transactions = _firebaseFirestore.collection('transactions');
    try {
      final balanceResult =
          await FirebaseUserRepository().getUserBalance(uid: transaction.uid);

      if (balanceResult.isSuccess) {
        final previousBalance = balanceResult.resultValue!;
        if (previousBalance - transaction.total >= 0) {
          await transactions.doc(transaction.id).set(transaction.toJson());
          final result = await transactions.doc(transaction.id).get();

          if (result.exists) {
            await FirebaseUserRepository().updateUserBalance(
              uid: transaction.uid,
              balance: previousBalance - transaction.total,
            );
            return Result.success(Transaction.fromJson(result.data()!));
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
    final transactions = _firebaseFirestore.collection('transactions');
    try {
      final result = await transactions.where('uid', isEqualTo: uid).get();
      if (result.docs.isNotEmpty) {
        return Result.success(
          result.docs.map((e) => Transaction.fromJson(e.data())).toList(),
        );
      } else {
        return const Result.success([]);
      }
    } catch (_) {
      return const Result.failed('Failed to get user transactions');
    }
  }
}
