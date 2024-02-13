import 'package:flix_app/data/firebase/firebase_auth_repository.dart';
import 'package:flix_app/data/firebase/firebase_transaction_repository.dart';
import 'package:flix_app/data/firebase/firebase_user_repository.dart';
import 'package:flix_app/data/repositories/auth_repository.dart';
import 'package:flix_app/data/repositories/movie_repository.dart';
import 'package:flix_app/data/repositories/payment_repository.dart';
import 'package:flix_app/data/repositories/transaction_repository.dart';
import 'package:flix_app/data/repositories/user_repository.dart';
import 'package:flix_app/data/stripe/stripe_payment_repository.dart';
import 'package:flix_app/data/supabase/supabase_auth_repository.dart';
import 'package:flix_app/data/supabase/supabase_transaction_repository.dart';
import 'package:flix_app/data/supabase/supabase_user_repository.dart';
import 'package:flix_app/data/tmdb/tmdb_movie_repository.dart';
import 'package:flix_app/utils/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repositories_provider.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  switch (Env.databaseType) {
    case 'firebase':
      return FirebaseAuthRepository();
    case 'supabase':
      return SupabaseAuthRepository();
    default:
      return FirebaseAuthRepository();
  }
}

@riverpod
MovieRepository movieRepository(MovieRepositoryRef ref) =>
    TmdbMovieRepository();

@riverpod
PaymentRepository paymentRepository(PaymentRepositoryRef ref) =>
    StripePaymentRepository();

@riverpod
TransactionRepository transactionRepository(TransactionRepositoryRef ref) {
  switch (Env.databaseType) {
    case 'firebase':
      return FirebaseTransactionRepository();
    case 'supabase':
      return SupabaseTransactionRepository();
    default:
      return FirebaseTransactionRepository();
  }
}

@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  switch (Env.databaseType) {
    case 'firebase':
      return FirebaseUserRepository();
    case 'supabase':
      return SupabaseUserRepository();
    default:
      return FirebaseUserRepository();
  }
}
