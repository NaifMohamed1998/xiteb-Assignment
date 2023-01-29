import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:calendar_assignment/utils.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'Screens/mainscreen.dart';
import 'Screens/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //readData(kEventsTemp);
    // createHolidays();
    getEvents();
    return MaterialApp(
        title: 'Calendar',
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: Splash(),
            nextScreen: MainScreen(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: Colors.white));
  }
}
