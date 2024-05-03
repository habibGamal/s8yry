import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sa8yry/config/colors.dart';

class Header extends StatelessWidget {
  final String title;
  final AnimationController animateHeaderCtrl;
  const Header({
    super.key,
    required this.title,
    required this.animateHeaderCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: primaryColors['600']!,
          ),
          padding: const EdgeInsets.fromLTRB(
            20,
            45,
            20,
            20,
          ),
          width: double.infinity,
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.white, fontSize: 26),
            // softWrap: false,
          ).animate().align(
                duration: 500.ms,
                begin: Alignment.bottomCenter,
                end: Alignment.centerRight,
              ),
        )
            .animate(
              controller: animateHeaderCtrl,
              autoPlay: false,
              onComplete: (controller) => controller.stop(),
            )
            .custom(
                duration: 500.ms,
                builder: (context, value, child) {
                  return SizedBox(
                    height: 400 - 300 * value,
                    child: child,
                  );
                })
            .fadeIn()
      ],
    );
  }
}
