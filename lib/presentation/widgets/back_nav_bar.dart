import 'package:flix_app/presentation/misc/methods.dart';
import 'package:flutter/material.dart';

class BackNavBar extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const BackNavBar({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Image.asset('assets/back.png'),
          ),
        ),
        horizontalSpaces(20),
        SizedBox(
          width: MediaQuery.sizeOf(context).width - 60 - 48,
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
