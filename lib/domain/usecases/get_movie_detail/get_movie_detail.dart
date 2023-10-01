import 'package:flix_app/data/repositories/movie_repository.dart';
import 'package:flix_app/domain/entities/movie_detail.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/usecases/usecase.dart';

part 'get_movie_detail_params.dart';

class GetMovieDetail
    implements Usecase<Result<MovieDetail>, GetMovieDetailParams> {
  final MovieRepository _movieRepository;

  GetMovieDetail({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Result<MovieDetail>> call(GetMovieDetailParams params) {
    return _movieRepository.getDetail(id: params.movieId);
  }
}
