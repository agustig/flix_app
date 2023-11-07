import 'package:flix_app/domain/entities/movie_detail.dart';
import 'package:flix_app/domain/entities/result.dart';
import 'package:flix_app/domain/entities/transaction.dart';
import 'package:flix_app/domain/usecases/create_transaction/create_transaction.dart';
import 'package:flix_app/presentation/extensions/build_context_extension.dart';
import 'package:flix_app/presentation/extensions/double_extension.dart';
import 'package:flix_app/presentation/misc/constants.dart';
import 'package:flix_app/presentation/misc/methods.dart';
import 'package:flix_app/presentation/providers/router/router_provider.dart';
import 'package:flix_app/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_app/presentation/providers/usecases/usecases_provider.dart';
import 'package:flix_app/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_app/presentation/widgets/back_nav_bar.dart';
import 'package:flix_app/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

part 'methods/transaction_row.dart';

class BookingConfirmationPage extends ConsumerWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const BookingConfirmationPage({super.key, required this.transactionDetail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var (movieDetail, transaction) = transactionDetail;

    transaction = transaction.copyWith(
      total: transaction.ticketAmount! * transaction.ticketPrice! +
          transaction.adminFee,
    );
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
            child: Column(
              children: [
                BackNavBar(
                  title: 'Booking Confirmation',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpaces(24),
                NetworkImageCard(
                  width: MediaQuery.sizeOf(context).width - 48,
                  height: (MediaQuery.sizeOf(context).width - 48) * 0.6,
                  borderRadius: 15,
                  imageUrl:
                      '$tmdbImageUrl${movieDetail.posterPath ?? movieDetail.posterPath}',
                  fit: BoxFit.cover,
                ),
                verticalSpaces(24),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 48,
                  child: Text(
                    transaction.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                verticalSpaces(5),
                const Divider(color: ghostWhite),
                verticalSpaces(5),
                transactionRow(
                  label: 'Showing date',
                  value: DateFormat('EEEE, MMMM d, y').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          transaction.watchingTime ?? 0)),
                  width: MediaQuery.sizeOf(context).width - 48,
                ),
                transactionRow(
                  label: 'Theater',
                  value: '${transaction.theaterName}',
                  width: MediaQuery.sizeOf(context).width - 48,
                ),
                transactionRow(
                  label: 'Seat number',
                  value: transaction.seats.join(', '),
                  width: MediaQuery.sizeOf(context).width - 48,
                ),
                transactionRow(
                  label: '# of ticket',
                  value: '${transaction.ticketAmount} ticket(s)',
                  width: MediaQuery.sizeOf(context).width - 48,
                ),
                transactionRow(
                  label: 'Ticket price',
                  value: '${transaction.ticketPrice?.toUSDCurrencyFormat()}',
                  width: MediaQuery.sizeOf(context).width - 48,
                ),
                transactionRow(
                  label: 'Fees',
                  value: transaction.adminFee.toUSDCurrencyFormat(),
                  width: MediaQuery.sizeOf(context).width - 48,
                ),
                const Divider(color: ghostWhite),
                transactionRow(
                  label: 'Total',
                  value: transaction.total.toUSDCurrencyFormat(),
                  width: MediaQuery.sizeOf(context).width - 48,
                ),
                verticalSpaces(40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final transactionTime =
                          DateTime.now().millisecondsSinceEpoch;

                      transaction = transaction.copyWith(
                          transactionTime: transactionTime,
                          id: 'flx-$transactionTime-${transaction.uid}');

                      final createTransaction =
                          ref.read(createTransactionUsecaseProvider);

                      await createTransaction(
                              CreateTransactionParams(transaction: transaction))
                          .then(
                        (result) {
                          switch (result) {
                            case Success(value: _):
                              ref
                                  .read(transactionDataProvider.notifier)
                                  .refreshTransactionData();
                              ref
                                  .read(userDataProvider.notifier)
                                  .refreshUserData();
                              ref.read(routerProvider).goNamed('main');
                            case Failed(:final message):
                              context.showSnackBar(message);
                          }
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: backgroundColor,
                      backgroundColor: saffron,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Pay now'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
