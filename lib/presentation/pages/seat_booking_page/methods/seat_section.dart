part of '../seat_booking_page.dart';

Widget seatSection({
  required List<int> seatNumbers,
  required void Function(int seatNumber) onTap,
  required SeatStatus Function(int seatNumber) seatStatus,
}) =>
    SizedBox(
      height: 240,
      width: 110,
      child: Wrap(
        spacing: 10,
        runAlignment: WrapAlignment.spaceBetween,
        direction: Axis.vertical,
        children: seatNumbers
            .map((number) => Seat(
                  number: number,
                  status: seatStatus(number),
                  onTap: () => onTap(number),
                ))
            .toList(),
      ),
    );
