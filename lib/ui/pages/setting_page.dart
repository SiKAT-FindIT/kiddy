// Import Packages
import 'package:flutter/material.dart';

// Import Styles
import 'package:kiddy/shared/theme.dart';

// Import Widgets
import 'package:kiddy/ui/widgets/setting_item.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Title
    Widget title() {
      return Text(
        'Settings',
        style: darkGreyText.copyWith(fontSize: 20, fontWeight: bold),
      );
    }

    // Setting Items
    Widget settingItems() {
      return Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            SettingItem(
              title: 'Kana\'s Sleep Tracker Device',
              value: true,
              onChanged: (value) {},
            ),
            SettingItem(
              title: 'Kana\'s Camera',
              value: true,
              onChanged: (value) {},
            ),
            SettingItem(
              title: 'Kana\'s Vibration Mode',
              value: false,
              onChanged: (value) {},
            ),
            SettingItem(
              title: 'Baim\'s Location',
              value: true,
              onChanged: (value) {},
            ),
          ],
        ),
      );
    }

    // render body
    Widget body() {
      return SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(
            top: 48,
            bottom: 100,
            right: 28,
            left: 28,
          ),
          children: [title(), settingItems()],
        ),
      );
    }

    return Scaffold(
      body: body(),
    );
  }
}
