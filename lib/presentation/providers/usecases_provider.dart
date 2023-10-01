import 'package:flix_app/domain/usecases/create_transaction/create_transaction.dart';
import 'package:flix_app/domain/usecases/get_actors/get_actors.dart';
import 'package:flix_app/domain/usecases/get_logged_in_user/get_logged_in_user.dart';
import 'package:flix_app/domain/usecases/get_movie_detail/get_movie_detail.dart';
import 'package:flix_app/domain/usecases/get_movie_list/get_movie_list.dart';
import 'package:flix_app/domain/usecases/get_transactions/get_transactions.dart';
import 'package:flix_app/domain/usecases/get_user_balance/get_user_balance.dart';
import 'package:flix_app/domain/usecases/login/login.dart';
import 'package:flix_app/domain/usecases/logout/logout.dart';
import 'package:flix_app/domain/usecases/register/register.dart';
import 'package:flix_app/domain/usecases/top_up/top_up.dart';
import 'package:flix_app/domain/usecases/upload_profile_picture/upload_profile_picture.dart';
import 'package:flix_app/presentation/providers/repositories_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecases_provider.g.dart';

// Authentication Usecase
@riverpod
Login login(LoginRef ref) => Login(
      authRepository: ref.watch(authRepositoryProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );

@riverpod
Logout logout(LogoutRef ref) =>
    Logout(authRepository: ref.watch(authRepositoryProvider));

@riverpod
Register register(RegisterRef ref) => Register(
      authRepository: ref.watch(authRepositoryProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );

@riverpod
GetLoggedInUser getLoggedInUser(GetLoggedInUserRef ref) => GetLoggedInUser(
      authRepository: ref.watch(authRepositoryProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );

// Movie Usecase
@riverpod
GetMovieList getMovieList(GetMovieListRef ref) =>
    GetMovieList(movieRepository: ref.watch(movieRepositoryProvider));

@riverpod
GetMovieDetail getMovieDetail(GetMovieDetailRef ref) =>
    GetMovieDetail(movieRepository: ref.watch(movieRepositoryProvider));

@riverpod
GetActors getActors(GetActorsRef ref) =>
    GetActors(movieRepository: ref.watch(movieRepositoryProvider));

// Transaction Usecase
@riverpod
CreateTransaction createTransaction(CreateTransactionRef ref) =>
    CreateTransaction(
      transactionRepository: ref.watch(transactionRepositoryProvider),
    );

@riverpod
GetTransactions getTransactions(GetTransactionsRef ref) => GetTransactions(
    transactionRepository: ref.watch(transactionRepositoryProvider));

@riverpod
TopUp topUp(TopUpRef ref) =>
    TopUp(transactionRepository: ref.watch(transactionRepositoryProvider));

// User Usecase
@riverpod
GetUserBalance getUserBalance(GetUserBalanceRef ref) =>
    GetUserBalance(userRepository: ref.watch(userRepositoryProvider));

@riverpod
UploadProfilePicture uploadProfilePicture(UploadProfilePictureRef ref) =>
    UploadProfilePicture(userRepository: ref.watch(userRepositoryProvider));
