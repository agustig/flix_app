import 'package:flix_app/domain/entities/movie.dart';
import 'package:flix_app/domain/entities/movie_detail.dart';
import 'package:flix_app/domain/usecases/get_movie_detail/get_movie_detail.dart';
import 'package:flix_app/presentation/providers/usecases/usecases_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_movie_detail_provider.g.dart';

@riverpod
Future<MovieDetail> getMovieDetail(GetMovieDetailRef ref,
    {required Movie movie}) async {
  final movieDetailRef = ref.read(getMovieDetailUsecaseProvider);
  final movieDetailResult =
      await movieDetailRef(GetMovieDetailParams(movieId: movie.id));

  return movieDetailResult.resultValue!;
}
