import 'package:flix_app/domain/entities/movie.dart';
import 'package:flix_app/presentation/extensions/int_extension.dart';
import 'package:flix_app/presentation/misc/constants.dart';
import 'package:flix_app/presentation/misc/methods.dart';
import 'package:flix_app/presentation/providers/movie/get_now_playing_provider.dart';
import 'package:flix_app/presentation/providers/movie/get_upcoming_provider.dart';
import 'package:flix_app/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_app/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

part 'methods/movie_list.dart';
part 'methods/promotion_list.dart';
part 'methods/search_bar.dart';
part 'methods/user_info.dart';

class MoviePage extends ConsumerWidget {
  final _promotionImageFileNames = const ['popcorn.jpg', 'buy1get1.jpg'];

  const MoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        userInfo(ref),
        verticalSpaces(40),
        searchBar(context),
        verticalSpaces(24),
        ...movieList(
          title: 'Now Playing',
          movies: ref.watch(getNowPlayingProvider),
          onTap: (movie) {
            //TODO: Move to movie detail page
          },
        ),
        verticalSpaces(30),
        ...promotionList(_promotionImageFileNames),
        verticalSpaces(30),
        ...movieList(
          title: 'Upcoming',
          movies: ref.watch(getUpcomingProvider),
        ),
        verticalSpaces(100),
      ],
    );
  }
}
