import 'package:flix_app/domain/entities/movie.dart';
import 'package:flix_app/domain/entities/movie_detail.dart';
import 'package:flix_app/presentation/misc/constants.dart';
import 'package:flix_app/presentation/misc/methods.dart';
import 'package:flix_app/presentation/providers/movie/get_actors_provider.dart';
import 'package:flix_app/presentation/providers/movie/get_movie_detail_provider.dart';
import 'package:flix_app/presentation/providers/router/router_provider.dart';
import 'package:flix_app/presentation/widgets/network_image_card.dart';
import 'package:flix_app/presentation/widgets/sliver_back_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'methods/background.dart';
part 'methods/cast_and_crew.dart';
part 'methods/movie_short_info.dart';
part 'methods/movie_overview.dart';

class DetailPage extends ConsumerWidget {
  final Movie movie;

  const DetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMovieDetail = ref.watch(getMovieDetailProvider(movie: movie));

    return Scaffold(
      body: Stack(
        children: [
          ...background(movie),
          CustomScrollView(
            slivers: [
              sliverBackNavbar(
                title: movie.title,
                onTap: () => ref.read(routerProvider).pop(),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          asyncMovieDetail.when(
                            data: (movieDetail) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  verticalSpaces(24),
                                  NetworkImageCard(
                                    width:
                                        MediaQuery.sizeOf(context).width - 48,
                                    height: (MediaQuery.sizeOf(context).width -
                                            48) *
                                        0.6,
                                    borderRadius: 15,
                                    imageUrl:
                                        '$tmdbImageUrl/${movieDetail.backdropPath ?? movie.posterPath}',
                                    fit: BoxFit.cover,
                                  ),
                                  verticalSpaces(24),
                                  movieShortInfo(movieDetail),
                                  verticalSpaces(20),
                                  ...movieOverview(movieDetail),
                                  verticalSpaces(40),
                                ],
                              );
                            },
                            error: (error, stackTrace) => Center(
                              child: Text(error.toString()),
                            ),
                            loading: () => const Center(
                              child: Column(
                                children: [
                                  CircularProgressIndicator(),
                                  Text('Loading...'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...castAndCrew(movie, ref),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 24,
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: backgroundColor,
                          backgroundColor: saffron,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Book this movie'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
