import 'package:flix_app/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

enum SeatStatus { available, reserved, selected }

class Seat extends StatelessWidget {
  final int? number;
  final SeatStatus status;
  final double size;
  final VoidCallback? onTap;

  const Seat({
    super.key,
    this.number,
    this.status = SeatStatus.available,
    this.size = 30,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color colorFromStatus(SeatStatus status) {
      switch (status) {
        case SeatStatus.available:
          return Colors.white;
        case SeatStatus.reserved:
          return Colors.grey;
        case SeatStatus.selected:
          return saffron;
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: colorFromStatus(status),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            number?.toString() ?? '',
            style: const TextStyle(
              color: backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
