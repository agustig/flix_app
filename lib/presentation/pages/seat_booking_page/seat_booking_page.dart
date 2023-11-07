import 'dart:math';

import 'package:flix_app/domain/entities/movie_detail.dart';
import 'package:flix_app/domain/entities/transaction.dart';
import 'package:flix_app/presentation/extensions/build_context_extension.dart';
import 'package:flix_app/presentation/misc/constants.dart';
import 'package:flix_app/presentation/misc/methods.dart';
import 'package:flix_app/presentation/providers/router/router_provider.dart';
import 'package:flix_app/presentation/widgets/back_nav_bar.dart';
import 'package:flix_app/presentation/widgets/seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'methods/movie_screen.dart';
part 'methods/seat_section.dart';
part 'methods/legend.dart';

class SeatBookingPage extends ConsumerStatefulWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const SeatBookingPage({super.key, required this.transactionDetail});

  @override
  ConsumerState<SeatBookingPage> createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends ConsumerState<SeatBookingPage> {
  List<int> selectedSeats = [];
  List<int> reservedSeats = [];

  @override
  void initState() {
    super.initState();

    final random = Random();
    int reservedNumber;

    while (reservedSeats.length < 8) {
      reservedNumber = random.nextInt(36) + 1;
      if (!reservedSeats.contains(reservedNumber)) {
        reservedSeats.add(reservedNumber);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final (movieDetail, transaction) = widget.transactionDetail;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                BackNavBar(
                  title: movieDetail.title,
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                movieScreen(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    seatSection(
                      seatNumbers: List.generate(18, (index) => index + 1),
                      onTap: onSeatTap,
                      seatStatus: seatStatus,
                    ),
                    horizontalSpaces(30),
                    seatSection(
                      seatNumbers: List.generate(18, (index) => index + 19),
                      onTap: onSeatTap,
                      seatStatus: seatStatus,
                    ),
                  ],
                ),
                verticalSpaces(20),
                legend(),
                verticalSpaces(40),
                Text(
                  '${selectedSeats.length} seats selected',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaces(40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedSeats.isEmpty) {
                        context.showSnackBar('Please select at least one seat');
                      } else {
                        final updatedTransaction = transaction.copyWith(
                          seats: (selectedSeats..sort())
                              .map((seat) => '$seat')
                              .toList(),
                          ticketAmount: selectedSeats.length,
                          ticketPrice: 12.25,
                        );

                        ref.read(routerProvider).pushNamed(
                          'booking-confirmation',
                          extra: (movieDetail, updatedTransaction),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: backgroundColor,
                      backgroundColor: saffron,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Next'),
                  ),
                )
                // button
              ],
            ),
          )
        ],
      ),
    );
  }

  void onSeatTap(seatNumber) {
    if (!reservedSeats.contains(seatNumber)) {
      setState(() {
        if (!selectedSeats.contains(seatNumber)) {
          selectedSeats.add(seatNumber);
        } else {
          selectedSeats.remove(seatNumber);
        }
      });
    }
  }

  SeatStatus seatStatus(int seatNumber) {
    return reservedSeats.contains(seatNumber)
        ? SeatStatus.reserved
        : selectedSeats.contains(seatNumber)
            ? SeatStatus.selected
            : SeatStatus.available;
  }
}
