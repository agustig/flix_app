import 'package:flix_app/data/repositories/movie_repository.dart';
import 'package:flix_app/domain/entities/movie.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/usecases/usecase.dart';

part 'get_movie_list_params.dart';

class GetMovieList implements Usecase<Result<List<Movie>>, GetMovieListParams> {
  final MovieRepository _movieRepository;

  GetMovieList({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Result<List<Movie>>> call(GetMovieListParams params) async {
    final movieResults = switch (params.category) {
      MovieListCategory.nowPlaying =>
        await _movieRepository.getNowPlaying(page: params.page),
      MovieListCategory.upcoming =>
        await _movieRepository.getUpcoming(page: params.page),
    };
    return movieResults;
  }
}
