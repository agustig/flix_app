part of '../detail_page.dart';

List<Widget> movieOverview(MovieDetail movieDetail) => [
      const Text(
        'Overview',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      verticalSpaces(10),
      Text(movieDetail.overview),
    ];
