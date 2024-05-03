import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sa8yry/config/colors.dart';
import 'package:sa8yry/config/data.dart';
import 'package:sa8yry/pages/section.dart';

class TabWidget extends StatelessWidget {
  final TabData data;

  const TabWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          child: Section(data.title),
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryColors['600']!,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: primaryColors['400']!.withOpacity(1),
                    offset: const Offset(6, 12),
                  ),
                ],
              ),
              margin: const EdgeInsets.fromLTRB(
                20,
                40,
                20,
                20,
              ),
              padding: const EdgeInsets.fromLTRB(
                20,
                45,
                20,
                20,
              ),
              width: double.infinity,
              child: Text(
                data.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white, fontSize: 26),
                textAlign: TextAlign.center,
                // softWrap: false,
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  data.iconPath,
                  height: 55,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
