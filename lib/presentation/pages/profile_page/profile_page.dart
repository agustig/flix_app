import 'package:flix_app/presentation/misc/methods.dart';
import 'package:flix_app/presentation/pages/profile_page/methods/profile_item.dart';
import 'package:flix_app/presentation/pages/profile_page/methods/user_info.dart';
import 'package:flix_app/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              verticalSpaces(20),
              ...userInfo(ref),
              verticalSpaces(20),
              const Divider(),
              verticalSpaces(20),
              profileItem('Update Profile'),
              verticalSpaces(20),
              profileItem('My Wallet'),
              verticalSpaces(20),
              profileItem('Change Password'),
              verticalSpaces(20),
              profileItem('Change Language'),
              verticalSpaces(20),
              const Divider(),
              verticalSpaces(20),
              profileItem('Contact Us'),
              verticalSpaces(20),
              profileItem('Privacy Policy'),
              verticalSpaces(20),
              profileItem('Term and Conditions'),
              verticalSpaces(60),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => ref.read(userDataProvider.notifier).logout(),
                  child: const Text('Logout'),
                ),
              ),
              verticalSpaces(20),
              const Text(
                'Version 0.1.0',
                style: TextStyle(fontSize: 12),
              ),
              verticalSpaces(100),
            ],
          ),
        ),
      ],
    );
  }
}
