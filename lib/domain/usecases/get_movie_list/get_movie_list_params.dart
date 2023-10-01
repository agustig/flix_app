part of 'get_movie_list.dart';

enum MovieListCategory { nowPlaying, upcoming }

class GetMovieListParams {
  final MovieListCategory category;
  final int page;

  GetMovieListParams({required this.category, this.page = 1});
}
