import 'package:flix_app/domain/entities/transaction.dart';
import 'package:flix_app/presentation/extensions/double_extension.dart';
import 'package:flix_app/presentation/misc/constants.dart';
import 'package:flix_app/presentation/misc/methods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: transaction.title != 'Top Up'
                      ? NetworkImage(
                          '$tmdbImageUrl${transaction.transactionImage}',
                        ) as ImageProvider
                      : const AssetImage('assets/top-up.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEEE, MMMM d, y').format(
                      DateTime.fromMillisecondsSinceEpoch(
                        transaction.transactionTime!,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpaces(5),
                  Text(
                    transaction.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    transaction.title == 'Top Up'
                        ? '+ ${(-transaction.total).toUSDCurrencyFormat()}'
                        : transaction.total.toUSDCurrencyFormat(),
                    style: TextStyle(
                      color: transaction.title == 'Top Up'
                          ? const Color.fromARGB(255, 107, 237, 90)
                          : const Color(0xFFEAA94E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
