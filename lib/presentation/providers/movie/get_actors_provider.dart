import 'package:flix_app/domain/entities/actor.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/usecases/get_actors/get_actors.dart';
import 'package:flix_app/presentation/providers/usecases/usecases_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_actors_provider.g.dart';

@Riverpod(keepAlive: true)
class GetActors extends _$GetActors {
  @override
  FutureOr<List<Actor>> build() => [];

  Future<void> get({required int movieId}) async {
    state = const AsyncLoading();

    final getActors = ref.read(getActorsUsecaseProvider);

    final result = await getActors(GetActorsParams(movieId: movieId));

    switch (result) {
      case Success(value: final actors):
        state = AsyncData(actors);
      case Failed(message: final message):
        state = AsyncError(message, StackTrace.current);
    }
  }
}
