import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month,
              color: Colors.blueGrey,
              size: size.width * 0.1,
            ),
            Text(
              'CALENDAR',
              style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
