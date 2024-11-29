import 'package:fb_auth_provider/pages/profile_page.dart';
import 'package:fb_auth_provider/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthProvider>().signout();
              },
              icon: const Icon(Icons.exit_to_app),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const ProfilePage(),
                  ),
                );
              },
              icon: const Icon(Icons.account_circle),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/flutter_favorite.png',
                    width: 100,
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Provider',
                    style: TextStyle(fontSize: 42),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Provider is an awesome\nstate management library\nfor flutter!',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
