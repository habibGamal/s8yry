import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  final String path;
  const RoundedImage({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0), // adjust the value as needed
        child: Image.asset(
          path,
          // height: 250,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
