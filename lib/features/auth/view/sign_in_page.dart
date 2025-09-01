import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giriş')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Devam (Mock Auth)'),
            ),
          ],
        ),
      ),
    );
  }
}


