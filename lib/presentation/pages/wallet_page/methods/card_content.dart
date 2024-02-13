part of '../wallet_page.dart';

Widget _cardContent(WidgetRef ref) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 50, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current balance',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              Text(
                (ref.watch(userDataProvider).valueOrNull?.balance ?? 0)
                    .toUSDCurrencyFormat(),
                style: const TextStyle(
                  color: Color(0xFFEAA94E),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalSpaces(10),
              Text(ref.watch(userDataProvider).valueOrNull?.name ?? '')
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () => ref.read(userDataProvider.notifier).topUp(20),
                // TODO: Add top up redirection to merchand
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Color(0xFFEAA94E),
                  ),
                ),
              ),
              const Text(
                'Top Up',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              )
            ],
          )
        ],
      ),
    );
