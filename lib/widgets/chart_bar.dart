import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
  });

  final double fill;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill,
          child: const DecoratedBox(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 34, 34, 34),
                borderRadius: BorderRadius.all(Radius.circular(3.0))),
          ),
        ),
      ),
    );
  }
}
