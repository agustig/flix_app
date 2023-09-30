import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required int id,
    required String title,
    String? posterPath,
  }) = _Movie;

  factory Movie.fromMap(Map<String, dynamic> map) => Movie(
        id: map['id'],
        title: map['title'],
        posterPath: map['poster_path'],
      );
}
