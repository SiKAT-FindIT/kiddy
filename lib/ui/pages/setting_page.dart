// Import Packages
import 'package:flutter/material.dart';
import 'package:kiddy/providers/device_provider.dart';

// Import Styles
import 'package:kiddy/shared/theme.dart';

// Import Widgets
import 'package:kiddy/ui/widgets/setting_item.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceProvider deviceProvider = Provider.of<DeviceProvider>(context);
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

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

    Widget signOutButton() {
      return Container(
        margin: const EdgeInsets.only(top: 32),
        child: TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size(200, 48),
            backgroundColor: purpleColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onPressed: () async {
            if (await deviceProvider.disconnect()) {
              navigator.pushNamedAndRemoveUntil('/start', (route) => false);
            } else {
              scaffoldMessenger.hideCurrentSnackBar();
              scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: Center(
                      child: Text('Disconnect failed', style: whiteText)),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Text(
            'Disconnect',
            style: whiteText,
          ),
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
          children: [
            title(),
            settingItems(),
            signOutButton(),
          ],
        ),
      );
    }

    return Scaffold(
      body: body(),
    );
  }
}
