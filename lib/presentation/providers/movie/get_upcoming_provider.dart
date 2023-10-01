import 'package:flix_app/domain/entities/movie.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/usecases/get_movie_list/get_movie_list.dart';
import 'package:flix_app/presentation/providers/usecases/usecases_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_upcoming_provider.g.dart';

@Riverpod(keepAlive: true)
class GetUpcoming extends _$GetUpcoming {
  @override
  FutureOr<List<Movie>> build() => [];

  Future<void> get({int page = 1}) async {
    state = const AsyncLoading();

    final getMovieList = ref.read(getMovieListUsecaseProvider);

    final result = await getMovieList(GetMovieListParams(
      category: MovieListCategory.upcoming,
      page: page,
    ));

    switch (result) {
      case Success(value: final movies):
        state = AsyncData(movies);
      case Failed(message: final message):
        state = AsyncError(message, StackTrace.current);
    }
  }
}
