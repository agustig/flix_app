import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_detail.freezed.dart';

@freezed
class MovieDetail with _$MovieDetail {
  const factory MovieDetail({
    required int id,
    required String title,
    String? posterPath,
    required String overview,
    String? backdropPath,
    required int runtime,
    required double voteAverage,
    required List<String> genres,
  }) = _MovieDetail;

  factory MovieDetail.fromMap(Map<String, dynamic> map) => MovieDetail(
        id: map['id'],
        title: map['title'],
        posterPath: map['poster_path'],
        overview: map['overview'],
        backdropPath: map['backdrop_path'],
        runtime: map['runtime'],
        voteAverage: map['vote_average'].toDouble(),
        genres: List<String>.from(map['genres'].map((genre) => genre['name'])),
      );
}
