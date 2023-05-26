import 'package:flutter/material.dart';

/// The container widget.
class TAContainer extends StatelessWidget {
  /// The constructor.
  const TAContainer({
    required this.child,
    this.margin,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// The margin of the container.
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(79, 21, 121, 0.1),
            blurRadius: 22,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(40),
      ),
      child: child,
    );
  }
}
