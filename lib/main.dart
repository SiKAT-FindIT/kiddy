// Import Packages
import 'package:flutter/material.dart';

// Import Styles
import 'package:kiddy/shared/theme.dart';

// Import Pages
import 'package:kiddy/ui/pages/main_page.dart';
import 'package:kiddy/ui/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  // Main program running here
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: purpleColor),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const SplashPage(),
        '/main-page': (context) => const MainPage(),
      },
    );
  }
}
