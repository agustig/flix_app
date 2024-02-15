part of '../top_up_page.dart';

Widget amountOptions({required void Function(String value) onTap}) {
  final additionalAmountOptions = [
    '10',
    '25',
    '30',
    '50',
    '100',
    '200',
    '500',
    '1,000',
  ];
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: additionalAmountOptions
          .map((option) => Padding(
                padding: EdgeInsets.only(
                  right: option == additionalAmountOptions.last ? 24 : 10,
                ),
                child: SelectableCard(
                  text: '+ $option',
                  isEnabled: true,
                  onTap: () => onTap(option),
                ),
              ))
          .toList(),
    ),
  );
}
