part of '../movie_page.dart';

Widget userInfo(WidgetRef ref) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: ref.watch(userDataProvider).valueOrNull?.photoUrl != null
                    ? NetworkImage(
                        ref.watch(userDataProvider).valueOrNull!.photoUrl!,
                      ) as ImageProvider
                    : const AssetImage('assets/pp-placeholder.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          horizontalSpaces(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${getGreeting()}, ${ref.watch(userDataProvider).when(
                      data: (user) => user?.name.split(' ').first ?? '',
                      error: (error, stackTrace) => '',
                      loading: () => 'Loading...',
                    )}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Let's book your favorite movie!",
                style: TextStyle(fontSize: 12),
              ),
              verticalSpaces(5),
              GestureDetector(
                onTap: () => ref.read(routerProvider).pushNamed('wallet'),
                child: Row(
                  children: [
                    SizedBox(
                      height: 18,
                      width: 18,
                      child: Image.asset('assets/wallet.png'),
                    ),
                    horizontalSpaces(10),
                    Text(
                      ref.watch(userDataProvider).when(
                            data: (user) =>
                                (user?.balance ?? 0).toUSDCurrencyFormat(),
                            error: (error, stackTrace) =>
                                0.0.toUSDCurrencyFormat(),
                            loading: () => 'Loading...',
                          ),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );

String getGreeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good morning';
  } else if (hour < 18) {
    return 'Good afternoon';
  } else {
    return 'Good evening';
  }
}
