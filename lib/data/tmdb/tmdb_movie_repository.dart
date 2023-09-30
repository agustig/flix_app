import 'package:dio/dio.dart';
import 'package:flix_app/data/repositories/movie_repository.dart';
import 'package:flix_app/domain/entities/actor.dart';
import 'package:flix_app/domain/entities/movie.dart';
import 'package:flix_app/domain/entities/movie_detail.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/utils/env.dart';

class TmdbMovieRepository implements MovieRepository {
  final Dio _dio;

  final _options = Options(headers: {
    'Authorization': 'Bearer ${Env.tmdbApiKey}',
    'accept': 'application/json'
  });

  TmdbMovieRepository({Dio? dio}) : _dio = dio ?? Dio();

  @override
  Future<Result<List<Actor>>> getActors({required int id}) async {
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/$id/credits?language=en-US',
        options: _options,
      );
      final results = List<Map<String, dynamic>>.from(response.data['cast']);

      return Result.success(results.map((e) => Actor.fromMap(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<MovieDetail>> getDetail({required int id}) async {
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/$id/language=en-US',
        options: _options,
      );

      return Result.success(MovieDetail.fromMap(response.data));
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) async =>
      _getMovies(_MovieCategory.nowPlaying.toString(), page);

  @override
  Future<Result<List<Movie>>> getUpcoming({int page = 1}) async =>
      _getMovies(_MovieCategory.upcoming.toString(), page);

  Future<Result<List<Movie>>> _getMovies(String category, int page) async {
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/$category?language=en-US&page=$page',
        options: _options,
      );
      final results = List<Map<String, dynamic>>.from(response.data['results']);

      return Result.success(results.map((e) => Movie.fromMap(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }
}

enum _MovieCategory {
  nowPlaying('now_playing'),
  upcoming('upcoming');

  final String _inString;
  const _MovieCategory(String inString) : _inString = inString;

  @override
  String toString() => _inString;
}
