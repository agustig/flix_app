import 'package:flix_app/presentation/extensions/double_extension.dart';
import 'package:flix_app/presentation/extensions/string_extension.dart';
import 'package:flix_app/presentation/misc/decimal_formatter.dart';
import 'package:flix_app/presentation/misc/methods.dart';
import 'package:flix_app/presentation/providers/router/router_provider.dart';
import 'package:flix_app/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_app/presentation/widgets/back_nav_bar.dart';
import 'package:flix_app/presentation/widgets/selectable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'methods/amount_options.dart';

class TopUpPage extends ConsumerStatefulWidget {
  const TopUpPage({super.key});

  @override
  ConsumerState<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends ConsumerState<TopUpPage> {
  final controller = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 75, 24, 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BackNavBar(
                title: 'Top Up',
                onTap: () => ref.read(routerProvider).pop(),
              ),
              TextField(
                controller: controller,
                textAlign: TextAlign.end,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 24),
                inputFormatters: [DecimalFormatter()],
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixText: 'Amount',
                  prefixStyle: TextStyle(fontSize: 16),
                  hintText: '0',
                  hintStyle: TextStyle(fontSize: 24),
                  suffixText: ' USD',
                  suffixStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  alignLabelWithHint: true,
                ),
              ),
              verticalSpaces(24),
              amountOptions(onTap: (additionalAmount) {
                setState(() {
                  controller.text =
                      (double.parse(controller.text.currencyAmountExtractor()) +
                              double.parse(
                                  additionalAmount.currencyAmountExtractor()))
                          .toCurrencyFormat(symbol: '', decimalDigits: 0);
                });
              })
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => ref
                .read(userDataProvider.notifier)
                .topUp(double.parse(controller.text.currencyAmountExtractor()))
                .then((_) => ref.read(routerProvider).pop()),
            child: const Text('Top Up'),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.clear();
    super.dispose();
  }
}
