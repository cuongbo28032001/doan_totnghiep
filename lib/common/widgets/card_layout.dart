import 'package:flutter/material.dart';

class CardLayoutWidget extends StatelessWidget {
  final Widget child;
  const CardLayoutWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(139, 146, 165, 0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: child,
    );
  }
}
