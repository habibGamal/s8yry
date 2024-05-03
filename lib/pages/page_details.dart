import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sa8yry/widgets/header.dart';
import 'package:sa8yry/widgets/highlighted.dart';
import 'package:sa8yry/widgets/long_text.dart';
import 'package:sa8yry/widgets/rounded_image.dart';

class PageDetails extends StatefulWidget {
  final String title;
  final List<Map<String, String>> data;
  const PageDetails(this.title, this.data, {super.key});

  @override
  State<PageDetails> createState() => _PageDetailsState();
}

class _PageDetailsState extends State<PageDetails>
    with TickerProviderStateMixin {
  late final AnimationController _animateHeaderCtrl;
  @override
  void initState() {
    super.initState();
    _animateHeaderCtrl = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animateHeaderCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // forward animation when widget is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateHeaderCtrl.forward();
    });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(255, 255, 255, 1),
              // Color.fromRGBO(236, 209, 243, 1),
              Color.fromRGBO(236, 238, 233, 1),
            ],
          ),
        ),
        child: ListView(
          children: [
            Header(title: widget.title, animateHeaderCtrl: _animateHeaderCtrl),
            const SizedBox(
              height: 25,
            ),
            ...widget.data.map(
              (data) {
                if (data.containsKey('highlighted')) {
                  return Highlighted(text: data['highlighted']!)
                      .animate(delay: 200.ms)
                      .fadeIn();
                } else if (data.containsKey('text')) {
                  return LongText(text: data['text']!)
                      .animate(delay: 200.ms)
                      .fadeIn();
                } else if (data.containsKey('image')) {
                  return RoundedImage(path: data['image']!)
                      .animate(delay: 200.ms)
                      .fadeIn();
                }
                return const SizedBox();
              },
            ).toList(),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
