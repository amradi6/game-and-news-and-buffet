import 'package:flutter/material.dart';
import 'package:goal/splash_screen/splash_screen.dart';
import 'package:goal/widget/use_provider.dart';
import 'package:provider/provider.dart';

import 'login_screen/local_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          background: const Color(0xff22283b),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
