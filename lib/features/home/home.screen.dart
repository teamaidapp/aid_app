import 'package:flutter/material.dart';

/// The HomeScreen class returns a Scaffold widget with a centered
/// Text widget displaying "Home Screen".
class HomeScreen extends StatelessWidget {
  /// The HomeScreen class requires a key to be passed in.
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
