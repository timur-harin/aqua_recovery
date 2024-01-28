import 'package:aqua_recovery/ui/pages/main_page.dart';
import 'package:aqua_recovery/ui/pages/onboarding.dart';
import 'package:aqua_recovery/ui/pages/timer.dart';
import 'package:aqua_recovery/ui/widgets/timer_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Contrast Shower Timer',
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'Montserrat',
        ),
        routes: {
          '/': (context) =>  OnboardingPage(),
          '/main':(context) =>  MainPage(),
          '/timer2': (context) => TimerPage(),
          '/first': (context) => OnboardingPage(page: 0),
          '/second': (context) => OnboardingPage(page: 1),
          '/third': (context) => OnboardingPage(page: 2),
          '/timer':(context) => CountdownPage(),
        },
        initialRoute: '/',
        // initialRoute: '/timer2',
        debugShowCheckedModeBanner: false
    );
  }
}
