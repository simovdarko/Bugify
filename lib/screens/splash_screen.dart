import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const SplashScreen({Key? key, required this.onLocaleChange}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _title = "";
  final String fullTitle = "Bugify";
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _animateText();
    _navigateToNextScreen();
  }

  void _animateText() {
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (_index < fullTitle.length) {
        setState(() {
          _title += fullTitle[_index];
          _index++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _navigateToNextScreen() async {
    // Wait for animation + some buffer
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(onLocaleChange: widget.onLocaleChange),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(onLocaleChange: widget.onLocaleChange),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF004E32),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo2.png',
              width: 160,
              height: 160,
            ),
            const SizedBox(height: 20),
            Text(
              _title,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black38,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Insect Identification',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
