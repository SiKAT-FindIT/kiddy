// Import Packages
import 'package:flutter/material.dart';

// Import Widgets
import 'package:kiddy/ui/widgets/navigation_item.dart';

// Import Styles
import 'package:kiddy/shared/theme.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {super.key, required this.onTap, required this.currentIndex});

  final Function(int) onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        width: double.infinity,
        margin: const EdgeInsets.only(
          bottom: 24,
          right: 24,
          left: 24,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(300),
          boxShadow: cardShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavigationItem(
              index: 0,
              iconUrl: 'assets/icons/home.png',
              currentIndex: currentIndex,
              onSelected: onTap,
            ),
            NavigationItem(
              index: 1,
              iconUrl: 'assets/icons/menu.png',
              currentIndex: currentIndex,
              onSelected: onTap,
            ),
            NavigationItem(
              index: 2,
              iconUrl: 'assets/icons/monitor.png',
              currentIndex: currentIndex,
              onSelected: onTap,
            ),
            NavigationItem(
              index: 3,
              iconUrl: 'assets/icons/settings.png',
              currentIndex: currentIndex,
              onSelected: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
