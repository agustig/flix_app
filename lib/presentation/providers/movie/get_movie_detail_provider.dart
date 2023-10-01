import 'package:flix_app/domain/entities/movie.dart';
import 'package:flix_app/domain/entities/movie_detail.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/usecases/get_movie_detail/get_movie_detail.dart';
import 'package:flix_app/presentation/providers/usecases/usecases_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_movie_detail_provider.g.dart';

@Riverpod(keepAlive: true)
class GetMovieDetail extends _$GetMovieDetail {
  @override
  Future<MovieDetail?> build() async => null;

  Future<void> get({required Movie movie}) async {
    state = const AsyncLoading();
    final getMovieDetail = ref.read(getMovieDetailUsecaseProvider);
    final movieDetailResult =
        await getMovieDetail(GetMovieDetailParams(movieId: movie.id));

    switch (movieDetailResult) {
      case Success(value: final movieDetail):
        state = AsyncData(movieDetail);
      case Failed(message: final message):
        state = AsyncError(message, StackTrace.current);
    }
  }
}
