part of '../booking_confirmation_page.dart';

Widget transactionRow({
  required String label,
  required String value,
  required double width,
}) =>
    Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110,
              child: Text(
                label,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            horizontalSpaces(20),
            SizedBox(
              width: width - 110 - 20,
              child: Text(value),
            ),
          ],
        ));
