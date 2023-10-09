part of '../movie_page.dart';

List<Widget> movieList({
  required String title,
  void Function(Movie movie)? onTap,
  required AsyncValue<List<Movie>> movies,
}) =>
    [
      Padding(
        padding: const EdgeInsets.only(left: 24.0, bottom: 15.0),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(
        height: 228,
        child: movies.when(
          data: (movies) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: movies
                    .map(
                      (movie) => Padding(
                        padding: EdgeInsets.only(
                          left: movie == movies.first ? 24 : 10,
                          right: movie == movies.last ? 24 : 0,
                        ),
                        child: NetworkImageCard(
                          imageUrl: '$tmdbImageUrl/${movie.posterPath}',
                          fit: BoxFit.contain,
                          onTap: () => onTap?.call(movie),
                        ),
                      ),
                    )
                    .toList()),
          ),
          error: (error, stackTrace) => SizedBox(
            child: Center(child: Text(error.toString())),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      )
    ];
