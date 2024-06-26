// Import Packages
import 'package:flutter/material.dart';

// Import Pages
import 'package:kiddy/ui/pages/home_page.dart';
import 'package:kiddy/ui/pages/menu_page.dart';
import 'package:kiddy/ui/pages/setting_page.dart';
import 'package:kiddy/ui/pages/tracker_page.dart';

// Import Widgets
import 'package:kiddy/ui/widgets/bottom_navigation.dart';

// Main Page
// Conditional Page Based On NavBar
// Pages:
// 1. Home Page
// 2. Menu Page
// 3. Tracker Page
// 4. Setting Page
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Current page state
  int currentIndex = 0;

  // Renderer Page To Routing Based On NavBar
  Widget rendererPage() {
    switch (currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const MenuPage();
      case 2:
        return const TrackerPage();
      case 3:
        return const SettingPage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          rendererPage(),
          BottomNavigation(
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
