part of '../wallet_page.dart';

List<Widget> _recentTransaction(WidgetRef ref) => [
      const Text(
        'Recent Transactions',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      verticalSpaces(24),
      ...ref.watch(transactionDataProvider).when(
            data: (transactions) => (transactions
                  ..sort((a, b) =>
                      -a.transactionTime!.compareTo(b.transactionTime!)))
                .map(
                    (transaction) => TransactionCard(transaction: transaction)),
            error: (error, stackTrace) => [],
            loading: () => [const CircularProgressIndicator()],
          ),
    ];
