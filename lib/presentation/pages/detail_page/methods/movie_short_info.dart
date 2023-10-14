part of '../detail_page.dart';

Widget movieShortInfo(MovieDetail movieDetail) => Row(
      children: [
        SizedBox(
          width: 14,
          height: 14,
          child: Image.asset('assets/duration.png'),
        ),
        horizontalSpaces(5),
        Text(
          '${movieDetail.runtime} minutes',
          style: const TextStyle(fontSize: 12),
        ),
        horizontalSpaces(20),
        SizedBox(
          height: 18,
          width: 18,
          child: Image.asset('assets/star.png'),
        ),
        horizontalSpaces(5),
        Text(
          movieDetail.voteAverage.toStringAsFixed(1),
          style: const TextStyle(fontSize: 12),
        ),
        horizontalSpaces(20),
        SizedBox(
          width: 14,
          height: 14,
          child: Image.asset('assets/genre.png'),
        ),
        horizontalSpaces(5),
        Expanded(
          child: Text(
            movieDetail.genres.join(', '),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        )
      ],
    );
