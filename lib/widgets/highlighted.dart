import 'package:flutter/material.dart';
import 'package:sa8yry/config/colors.dart';

class Highlighted extends StatelessWidget {
  final String text;
  const Highlighted({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        25,
        20,
        25,
        0,
      ),
      decoration: BoxDecoration(
        color: primaryColors['700']!,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'SultanMedium',
            ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
