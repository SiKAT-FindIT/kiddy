import 'package:flutter/material.dart';
import 'package:kiddy/shared/theme.dart';
import 'package:kiddy/ui/pages/connecting_page.dart';
import 'package:kiddy/ui/pages/scan_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo.png",
            width: 128,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome To ',
                style: darkPinkText.copyWith(
                  fontSize: 28,
                  fontWeight: regular,
                ),
              ),
              Text(
                'Kiddy',
                style: darkPinkText.copyWith(
                  fontSize: 28,
                  fontWeight: bold,
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ready for today\'s ',
                style: darkGreyText.copyWith(
                  fontSize: 14,
                  fontWeight: regular,
                ),
              ),
              Text(
                'monitoring?',
                style: darkGreyText.copyWith(
                  fontSize: 14,
                  fontWeight: bold,
                ),
              )
            ],
          ),
          Container(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScanPage(
                      title: "Kiddy Connect",
                      onDetect: (value, cameraController) {
                        if (value != null) {
                          cameraController.dispose();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ConnectingPage(serialnumber: value),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
              child: Text(
                'Connect Kiddy',
                style: whiteText,
              ),
            ),
          )
        ],
      ),
    );
  }
}
