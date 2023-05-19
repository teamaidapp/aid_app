import 'package:flutter/material.dart';
import 'package:team_aid/design_system/design_system.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('Login Screen'),
            TAPrimaryInput(
              label: 'Email',
              placeholder: 'Enter your email',
            ),
          ],
        ),
      ),
    );
  }
}
