import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LongText extends StatelessWidget {
  final String text;
  final bool isBold;
  const LongText({super.key, required this.text, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        25,
        20,
        25,
        0,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
              fontSize: 20,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'SultanMedium',
            ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
