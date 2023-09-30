import 'package:flix_app/data/firebase/firebase_auth_repository.dart';
import 'package:flix_app/data/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) =>
    FirebaseAuthRepository();
