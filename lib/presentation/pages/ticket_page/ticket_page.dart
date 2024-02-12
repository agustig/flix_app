import 'package:flix_app/presentation/misc/methods.dart';
import 'package:flix_app/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_app/presentation/widgets/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 75, 24, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                'Upcoming Tickets',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ...ref.watch(transactionDataProvider).when(
                  data: (transactions) {
                    final upComingTickets = transactions
                        .where((transaction) =>
                            transaction.title != 'Top Up' &&
                            transaction.watchingTime! >=
                                DateTime.now().millisecondsSinceEpoch)
                        .toList()
                      ..sort(
                        (a, b) => a.watchingTime!.compareTo(b.watchingTime!),
                      );

                    return upComingTickets.isNotEmpty
                        ? upComingTickets.map((ticket) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Ticket(transaction: ticket),
                            ))
                        : [
                            verticalSpaces(100),
                            Center(
                              child: Column(
                                children: [
                                  const Text(
                                    'Ticket not found',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  verticalSpaces(8),
                                  const Text('Please book a some movie'),
                                ],
                              ),
                            ),
                          ];
                  },
                  error: (error, stackTrace) => [],
                  loading: () => const [CircularProgressIndicator()],
                )
          ],
        ),
      ),
    );
  }
}
