import 'package:flix_app/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

Widget sliverBackNavbar({required String title, VoidCallback? onTap}) {
  return SliverLayoutBuilder(
    builder: (BuildContext context, constraints) {
      final scrolled = constraints.scrollOffset > 0;
      return SliverAppBar(
        backgroundColor: scrolled ? backgroundColor : Colors.transparent,
        pinned: true,
        leading: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: SizedBox(
              width: 36,
              height: 36,
              child: Image.asset('assets/back.png'),
            ),
          ),
        ),
        leadingWidth: 60,
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    },
  );
}
