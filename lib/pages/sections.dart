import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sa8yry/config/data.dart';
import 'package:sa8yry/pages/page_details.dart';
import 'package:sa8yry/widgets/header.dart';
import 'package:sa8yry/widgets/rounded_image.dart';
import 'package:sa8yry/widgets/section_title.dart';

class Sections extends StatefulWidget {
  final String title;
  final List<SectionData> data;
  final String? imagePath;
  const Sections({
    super.key,
    required this.title,
    required this.data,
    this.imagePath,
  });

  @override
  State<Sections> createState() => _SectionsState();
}

class _SectionsState extends State<Sections> with TickerProviderStateMixin {
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
            ...widget.data.map((section) {
              _titleCount++;
              return GestureDetector(
                onTap: () async {
                  // load nested sections if available
                  final sections = section.subSections;
                  if (sections != null) {
                    await Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.fade,
                      alignment: Alignment.center,
                      child: Sections(
                        title: section.title,
                        data: sections,
                      ),
                    ));
                    return;
                  }
                  final PageData pageData = await section.loadPage();
                  await Navigator.of(context).push(PageTransition(
                    type: PageTransitionType.fade,
                    alignment: Alignment.center,
                    child: PageDetails(pageData),
                  ));
                },
                child: SectionTitle(
                  title: section.title,
                  count: _titleCount,
                ).animate(delay: 200.ms).fadeIn(),
              );
            }).toList(),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
