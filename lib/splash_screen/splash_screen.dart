import 'package:flutter/material.dart';

import '../login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Container(
                color: Theme.of(context).colorScheme.background,
                child: Image.asset("asset/images/logo.png"),
              ),
              const Text(
                "Goal!",
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Spacer(flex: 2),
              const Text(
                "Amr Adi",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 40)),
            ],
          ),
        ),
      ),
    );
  }
}
