part of '../seat_booking_page.dart';

Widget legend() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Seat(size: 20),
        horizontalSpaces(5),
        const Text('Available', style: TextStyle(fontSize: 12)),
        horizontalSpaces(10),
        const Seat(
          size: 20,
          status: SeatStatus.selected,
        ),
        horizontalSpaces(5),
        const Text('Selected', style: TextStyle(fontSize: 12)),
        horizontalSpaces(10),
        const Seat(
          size: 20,
          status: SeatStatus.reserved,
        ),
        horizontalSpaces(5),
        const Text('Reversed', style: TextStyle(fontSize: 12)),
      ],
    );
