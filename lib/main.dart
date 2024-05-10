// Import Packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiddy/firebase_options.dart';

// Import Styles
import 'package:kiddy/shared/theme.dart';

// Import Pages
import 'package:kiddy/ui/pages/main_page.dart';
import 'package:kiddy/ui/pages/splash_page.dart';
import 'package:kiddy/ui/pages/start_page.dart';

// Import Providers
import 'package:provider/provider.dart';
import 'providers/device_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  // Main program running here
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Init providers
      providers: [
        ChangeNotifierProvider(create: (context) => DeviceProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: purpleColor),
          useMaterial3: true,
        ),
        // Init routes
        routes: {
          '/': (context) => const SplashPage(),
          '/main': (context) => const MainPage(),
          '/start': (context) => const StartPage(),
        },
      ),
    );
  }
}
