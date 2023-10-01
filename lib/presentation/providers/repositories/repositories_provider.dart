import 'package:flix_app/data/firebase/firebase_auth_repository.dart';
import 'package:flix_app/data/firebase/firebase_transaction_repository.dart';
import 'package:flix_app/data/firebase/firebase_user_repository.dart';
import 'package:flix_app/data/repositories/auth_repository.dart';
import 'package:flix_app/data/repositories/movie_repository.dart';
import 'package:flix_app/data/repositories/transaction_repository.dart';
import 'package:flix_app/data/repositories/user_repository.dart';
import 'package:flix_app/data/tmdb/tmdb_movie_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repositories_provider.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) =>
    FirebaseAuthRepository();

@riverpod
MovieRepository movieRepository(MovieRepositoryRef ref) =>
    TmdbMovieRepository();

@riverpod
TransactionRepository transactionRepository(TransactionRepositoryRef ref) =>
    FirebaseTransactionRepository();

@riverpod
UserRepository userRepository(UserRepositoryRef ref) =>
    FirebaseUserRepository();
