import 'package:freezed_annotation/freezed_annotation.dart';

part 'actor.freezed.dart';

@freezed
class Actor with _$Actor {
  const factory Actor({
    required String name,
    String? profilePath,
  }) = _Actor;

  factory Actor.fromMap(Map<String, dynamic> map) => Actor(
        name: map['name'],
        profilePath: map['profile_path'],
      );
}
