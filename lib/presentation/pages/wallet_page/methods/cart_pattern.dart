part of '../wallet_page.dart';

Widget _cardPattern() => Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        3,
        (rowIndex) => Row(
          children: List.generate(
            rowIndex + 4,
            (columIndex) => Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(left: columIndex == 0 ? 3 : 0, right: 3),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity((0.05 * (rowIndex + 1)) + 0.05),
                    Colors.white.withOpacity((0.05 * rowIndex) + 0.05),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: columIndex == 0 && rowIndex == 0
                      ? const Radius.circular(10)
                      : const Radius.circular(0),
                  bottomLeft: columIndex == 0 && rowIndex == 2
                      ? const Radius.circular(10)
                      : const Radius.circular(0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
