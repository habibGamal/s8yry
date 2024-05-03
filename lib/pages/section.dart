import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sa8yry/config/data.dart';
import 'package:sa8yry/pages/page_details.dart';
import 'package:sa8yry/widgets/header.dart';
import 'package:sa8yry/widgets/rounded_image.dart';
import 'package:sa8yry/widgets/section_title.dart';

class Section extends StatefulWidget {
  final String title;
  const Section(this.title, {super.key});

  @override
  State<Section> createState() => _SectionState();
}

class _SectionState extends State<Section> with TickerProviderStateMixin {
  int _titleCount = 0;
  late final AnimationController _animateHeaderCtrl;
  @override
  void initState() {
    super.initState();
    _titleCount = 0;
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
            const RoundedImage(path: 'assets/images/page1/1.jpg'),
            ...section1.map(
              (data) {
                _titleCount++;
                return GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.fade,
                      alignment: Alignment.center,
                      child: PageDetails(
                        data['title']! as String,
                        data['page']! as List<Map<String, String>>,
                      ),
                    ));
                  },
                  child: SectionTiltle(
                    title: data['title']! as String,
                    count: _titleCount,
                  ).animate(delay: 200.ms).fadeIn(),
                );
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
