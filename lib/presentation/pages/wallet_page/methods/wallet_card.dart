part of '../wallet_page.dart';

Widget _walletCard(WidgetRef ref) => Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          _cardPattern(),
          _membershipBanner(),
          _cardContent(ref),
        ],
      ),
    );
