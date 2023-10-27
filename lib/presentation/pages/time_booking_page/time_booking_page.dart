import 'package:flix_app/domain/entities/movie_detail.dart';
import 'package:flix_app/domain/entities/transaction.dart';
import 'package:flix_app/presentation/extensions/build_context_extension.dart';
import 'package:flix_app/presentation/misc/constants.dart';
import 'package:flix_app/presentation/misc/methods.dart';
import 'package:flix_app/presentation/providers/router/router_provider.dart';
import 'package:flix_app/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_app/presentation/widgets/back_nav_bar.dart';
import 'package:flix_app/presentation/widgets/network_image_card.dart';
import 'package:flix_app/presentation/widgets/selectable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

part 'methods/options.dart';

class TimeBookingPage extends ConsumerStatefulWidget {
  final MovieDetail movieDetail;
  const TimeBookingPage({
    super.key,
    required this.movieDetail,
  });

  @override
  ConsumerState<TimeBookingPage> createState() => _TimeBookingPageState();
}

class _TimeBookingPageState extends ConsumerState<TimeBookingPage> {
  final List<String> theaters = [
    'UNITED CINEMAS Maebashi',
    'MAEBASHI CINEMA HOUSE',
    'AEON CINEMA TAKASAKI',
    'Cinematheque Takasaki',
    '109 Cinemas Takasaki',
    'Media Mega Takasaki',
    'Movix Isesaki',
    'Takasaki Denkikan',
    'Aeon Cinema Ota',
  ];

  final List<DateTime> dates = List.generate(7, (index) {
    final now = DateTime.now();
    final date = DateTime(now.year, now.month, now.day);
    return date.add(Duration(days: index));
  });

  final List<int> hours = List.generate(8, (index) => index + 9);

  String? selectedTheater;
  DateTime? selectedDate;
  int? selectedHour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: BackNavBar(
                  title: widget.movieDetail.title,
                  onTap: () => ref.read(routerProvider).pop(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: NetworkImageCard(
                  width: MediaQuery.sizeOf(context).width - 48,
                  height: (MediaQuery.sizeOf(context).width) * 0.6,
                  borderRadius: 15,
                  imageUrl:
                      '$tmdbImageUrl${widget.movieDetail.backdropPath ?? widget.movieDetail.posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
              ...options(
                title: 'Select a theater',
                options: theaters,
                selectedItem: selectedTheater,
                onTap: (object) => setState(() {
                  selectedTheater = object;
                }),
              ),
              verticalSpaces(24),
              ...options(
                title: 'Select date',
                options: dates,
                selectedItem: selectedDate,
                converter: (date) => DateFormat('EEE, MMM d').format(date),
                onTap: (object) => setState(
                  () {
                    selectedDate = object;
                  },
                ),
              ),
              verticalSpaces(24),
              ...options(
                title: 'Select showtime',
                options: hours,
                selectedItem: selectedHour,
                converter: (object) => '$object:00',
                isOptionSelectable: (hour) =>
                    selectedDate != null &&
                    DateTime(
                      selectedDate!.year,
                      selectedDate!.month,
                      selectedDate!.day,
                      hour,
                    ).isAfter(DateTime.now()),
                onTap: (object) => setState(
                  () {
                    selectedHour = object;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 40,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: backgroundColor,
                      backgroundColor: saffron,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (selectedTheater == null ||
                          selectedDate == null ||
                          selectedHour == null) {
                        context.showSnackBar('Please select all options');
                      } else {
                        final transaction = Transaction(
                          uid: ref.read(userDataProvider).value!.uid,
                          title: widget.movieDetail.title,
                          adminFee: 1,
                          total: 0,
                          watchingTime: DateTime(
                            selectedDate!.year,
                            selectedDate!.month,
                            selectedDate!.day,
                            selectedHour!,
                          ).millisecondsSinceEpoch,
                          transactionImage: widget.movieDetail.posterPath,
                          theaterName: selectedTheater!,
                        );

                        ref.read(routerProvider).pushNamed(
                          'seat-booking',
                          extra: (widget.movieDetail, transaction),
                        );
                      }
                    },
                    child: const Text('Next'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
