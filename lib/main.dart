import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sa8yry/config/colors.dart';
import 'package:sa8yry/config/data.dart';
import 'package:sa8yry/widgets/tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme:
            // GoogleFonts.tajawalTextTheme(Theme.of(context).textTheme.copyWith(
            //       headlineLarge: TextStyle(
            //         fontSize: 32,
            //         fontWeight: FontWeight.w500,
            //         color: primaryColors['900'],
            //       ),
            //       headlineMedium: TextStyle(
            //         color: primaryColors['900'],
            //       ),
            //     ))
            Theme.of(context).textTheme.copyWith(
                  headlineLarge: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: primaryColors['900'],
                    // fontFamily: 'AlMohanad',
                    fontFamily: 'SultanMedium',
                  ),
                  headlineMedium: TextStyle(
                    color: primaryColors['900'],
                    // fontFamily: 'AlMohanad',
                    fontFamily: 'SultanMedium',
                  ),
                ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(255, 147, 163, 1)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'صغيري'),
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TabData> tabsData = [];
  // loadTabs
  @override
  void initState() {
    loadTabs().then((value) {
      setState(() {
        tabsData = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Text(
              'صغيري',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '(لأنك حياه)',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: Image.asset(
                'assets/images/hero.png',
                height: 300,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ...tabsData
                .map(
                  (data) => TabWidget(data: data),
                )
                .toList()
                .animate()
                .fadeIn()
          ],
        ),
      ),
    );
  }
}
