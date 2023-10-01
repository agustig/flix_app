import 'package:flix_app/data/repositories/movie_repository.dart';
import 'package:flix_app/domain/entities/actor.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/usecases/usecase.dart';

part 'get_actors_params.dart';

class GetActors implements Usecase<Result<List<Actor>>, GetActorsParams> {
  final MovieRepository _movieRepository;

  GetActors({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Result<List<Actor>>> call(GetActorsParams params) {
    return _movieRepository.getActors(id: params.movieId);
  }
}
