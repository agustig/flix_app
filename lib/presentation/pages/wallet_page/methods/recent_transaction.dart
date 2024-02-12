part of '../wallet_page.dart';

List<Widget> _recentTransaction(WidgetRef ref) => [
      const Text(
        'Recent Transactions',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      verticalSpaces(24),
      ...ref.watch(transactionDataProvider).when(
            data: (transactions) => transactions.isNotEmpty
                ? (transactions
                      ..sort((a, b) =>
                          -a.transactionTime!.compareTo(b.transactionTime!)))
                    .map((transaction) =>
                        TransactionCard(transaction: transaction))
                : [
                    const Text(
                      'Transaction not found',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    verticalSpaces(8),
                    const Text('Please create a new transaction'),
                  ],
            error: (error, stackTrace) => [],
            loading: () => [const CircularProgressIndicator()],
          ),
    ];
