import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sa8yry/config/colors.dart';

class SectionTitle extends StatelessWidget {
  final int count;
  final String title;
  const SectionTitle({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        20,
        40,
        20,
        0,
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryColors['100']!,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: primaryColors['900']!,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              35,
              20,
            ),
            margin: const EdgeInsets.only(right: 25),
            width: double.infinity,
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black, fontSize: 22),
              textAlign: TextAlign.right,
              // softWrap: false,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: primaryColors['900']!,
              borderRadius: BorderRadius.circular(999),
            ),
            width: 50,
            height: 50,
            child: Center(
                child: Text(
              count.toString(),
              style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            )),
          )
        ],
      ),
    );
  }
}
