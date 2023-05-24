import 'package:flutter/material.dart';

/// The statelessWidget that handles the current screen
class {{#pascalCase}}{{name}} screen {{/pascalCase}} extends StatelessWidget {
  /// The constructor.
  const {{#pascalCase}}{{name}} screen {{/pascalCase}}({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [SizedBox()],
        ),
      ),
    );
  }
}
