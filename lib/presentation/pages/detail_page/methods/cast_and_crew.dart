part of '../detail_page.dart';

List<Widget> castAndCrew(Movie movie, WidgetRef ref) => [
      const Padding(
        padding: EdgeInsets.only(left: 24),
        child: Text(
          'Cast & Crew',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      verticalSpaces(10),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            horizontalSpaces(24),
            ...ref.watch(getActorsProvider(movie: movie)).whenOrNull(
                      data: (actors) => actors
                          .where((actor) => actor.profilePath != null)
                          .map(
                            (actor) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  NetworkImageCard(
                                    width: 100,
                                    height: 152,
                                    imageUrl:
                                        '$tmdbProfileImageUrl${actor.profilePath}',
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      actor.name,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                    ) ??
                [],
            horizontalSpaces(14),
          ],
        ),
      )
    ];
