import 'dart:io';

import 'package:flix_app/data/repositories/user_repository.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/user.dart';
import 'package:flix_app/domain/usecases/usecase.dart';

part 'upload_profile_picture_params.dart';

class UploadProfilePicture
    implements Usecase<Result<User>, UploadProfilePictureParams> {
  final UserRepository _userRepository;

  UploadProfilePicture({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Result<User>> call(UploadProfilePictureParams params) =>
      _userRepository.uploadProfilePicture(
        user: params.user,
        imageFile: params.imageFile,
      );
}
