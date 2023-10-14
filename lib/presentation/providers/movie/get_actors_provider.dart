import 'package:flix_app/domain/entities/actor.dart';
import 'package:flix_app/domain/entities/movie.dart';
import 'package:flix_app/domain/usecases/get_actors/get_actors.dart';
import 'package:flix_app/presentation/providers/usecases/usecases_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_actors_provider.g.dart';

@riverpod
Future<List<Actor>> getActors(GetActorsRef ref, {required Movie movie}) async {
  final getActors = ref.read(getActorsUsecaseProvider);

  final result = await getActors(GetActorsParams(movieId: movie.id));

  return result.resultValue!;
}
