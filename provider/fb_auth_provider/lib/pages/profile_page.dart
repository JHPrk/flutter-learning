import 'package:fb_auth_provider/providers/profile/profile_provider.dart';
import 'package:fb_auth_provider/providers/profile/profile_state.dart';
import 'package:fb_auth_provider/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileProvider profileProvider;
  @override
  void initState() {
    super.initState();
    profileProvider = context.read<ProfileProvider>();
    profileProvider.addListener(errorDialogListener);
    _getProfile();
  }

  void _getProfile() {
    final String uid = context.read<fbAuth.User?>()!.uid;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<ProfileProvider>().getProfile(uid: uid),
    );
  }

  void errorDialogListener() {
    if (profileProvider.state.profileStatus == ProfileStatus.error) {
      errorDialog(context, profileProvider.state.error);
    }
  }

  @override
  void dispose() {
    profileProvider.removeListener(errorDialogListener);
    super.dispose();
  }

  Widget _buildProfile() {
    final profileState = context.watch<ProfileProvider>().state;
    if (profileState.profileStatus == ProfileStatus.initial) {
      return Container();
    } else if (profileState.profileStatus == ProfileStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (profileState.profileStatus == ProfileStatus.error) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/error.png',
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 20),
            const Text(
              'Opps!\nSomething went wrong.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          ],
        ),
      );
    }
    return SingleChildScrollView(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: profileState.user.profileImage,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '- id: ${profileState.user.id}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    '- name: ${profileState.user.name}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    '- email: ${profileState.user.email}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    '- point: ${profileState.user.point}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    '- rank: ${profileState.user.rank}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: _buildProfile(),
    );
  }
}
