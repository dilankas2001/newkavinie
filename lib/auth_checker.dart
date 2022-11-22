import 'package:kavinie/providers/auth_provider.dart';
import 'package:kavinie/home_screen.dart';
import 'package:kavinie/login_screen.dart';
import 'package:kavinie/wapper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kavinie/spalashscreen.dart';
import 'datapage.dart';



class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);

    return _authState.when(
        data: (user) {
          if (user != null) return  HomePage();
          return const LoginScreen();
        },
        loading: () => const SplashScreen(),
        error: (e, trace) => const LoginScreen());
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
