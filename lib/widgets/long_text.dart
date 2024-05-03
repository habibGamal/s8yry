import 'package:flutter/material.dart';

class LongText extends StatelessWidget {
  final String text;
  const LongText({super.key, required this.text});

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
              fontSize: 18,
            ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
