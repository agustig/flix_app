import 'dart:math';

import 'package:flix_app/presentation/extensions/double_extension.dart';
import 'package:flix_app/presentation/misc/methods.dart';
import 'package:flix_app/presentation/providers/router/router_provider.dart';
import 'package:flix_app/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_app/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_app/presentation/widgets/back_nav_bar.dart';
import 'package:flix_app/presentation/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'methods/card_content.dart';
part 'methods/cart_pattern.dart';
part 'methods/membership_banner.dart';
part 'methods/recent_transaction.dart';
part 'methods/wallet_card.dart';

class WalletPage extends ConsumerWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 75, 24, 100),
          child: Column(
            children: [
              BackNavBar(
                title: 'My Wallet',
                onTap: () => ref.read(routerProvider).pop(),
              ),
              verticalSpaces(24),
              _walletCard(ref),
              verticalSpaces(24),
              ..._recentTransaction(ref),
            ],
          ),
        ),
      ),
    );
  }
}
