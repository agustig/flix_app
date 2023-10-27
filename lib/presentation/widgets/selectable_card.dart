import 'package:flix_app/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

class SelectableCard extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isEnabled;

  const SelectableCard({
    super.key,
    required this.text,
    this.onTap,
    this.isSelected = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? saffron.withOpacity(0.3) : null,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: isEnabled ? saffron : Colors.grey),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isEnabled ? ghostWhite : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
