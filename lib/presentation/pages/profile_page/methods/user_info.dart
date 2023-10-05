import 'package:flix_app/presentation/misc/methods.dart';
import 'package:flix_app/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> userInfo(WidgetRef ref) => [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 1),
          image: DecorationImage(
            image: ref.watch(userDataProvider).valueOrNull?.photoUrl != null
                ? NetworkImage(
                        ref.watch(userDataProvider).valueOrNull!.photoUrl!)
                    as ImageProvider
                : const AssetImage('assets/pp-placeholder.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      verticalSpaces(20),
      Text(
        ref.watch(userDataProvider).valueOrNull?.name ?? '',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Text(
        ref.watch(userDataProvider).valueOrNull?.email ?? '',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12),
      ),
    ];
