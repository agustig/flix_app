part of '../time_booking_page.dart';

List<Widget> options<T>({
  required String title,
  required List<T> options,
  required T? selectedItem,
  String Function(T object)? converter,
  bool Function(T object)? isOptionSelectable,
  required void Function(T object) onTap,
}) =>
    [
      Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      verticalSpaces(10),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: options
              .map((option) => Padding(
                    padding: EdgeInsets.only(
                      left: option == options.first ? 24 : 0,
                      right: option == options.last ? 24 : 10,
                    ),
                    child: SelectableCard(
                      text: converter != null
                          ? converter(option)
                          : option.toString(),
                      isSelected: option == selectedItem,
                      isEnabled: isOptionSelectable?.call(option) ?? true,
                      onTap: () => onTap(option),
                    ),
                  ))
              .toList(),
        ),
      )
    ];
