import 'package:flix_app/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_app/presentation/widgets/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 75, 24, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: ref.watch(transactionDataProvider).when(
                data: (transactions) => (transactions
                        .where((transaction) =>
                            transaction.title != 'Top Up' &&
                            transaction.watchingTime! >=
                                DateTime.now().millisecondsSinceEpoch)
                        .toList()
                      ..sort(
                        (a, b) => a.watchingTime!.compareTo(b.watchingTime!),
                      ))
                    .map((transaction) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Ticket(transaction: transaction),
                        ))
                    .toList(),
                error: (error, stackTrace) => [],
                loading: () => const [CircularProgressIndicator()],
              ),
        ),
      ),
    );
  }
}
