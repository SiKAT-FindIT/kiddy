// Import Packages
import 'package:flutter/material.dart';

// Import Styles
import 'package:kiddy/shared/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 100,
            right: 28,
            left: 28,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Kana is ',
                    style: whiteText.copyWith(
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    'Sleeping',
                    style: whiteText.copyWith(
                      fontSize: 32,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 54),
                width: 216,
                height: 216,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/baby-sleep.png'),
                  ),
                ),
              ),
              Text(
                'Sleep Duration',
                style: whiteText.copyWith(
                  fontSize: 16,
                  fontWeight: regular,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '43',
                    style: whiteText.copyWith(
                      fontSize: 40,
                      fontWeight: bold,
                    ),
                  ),
                  Text(
                    'M',
                    style: whiteText.copyWith(
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '27',
                    style: whiteText.copyWith(
                      fontSize: 40,
                      fontWeight: bold,
                    ),
                  ),
                  Text(
                    'S',
                    style: whiteText.copyWith(
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filled(
                    iconSize: 32,
                    onPressed: () {},
                    icon: Icon(
                      Icons.mic,
                      color: whiteColor,
                    ),
                  ),
                  const SizedBox(width: 24),
                  IconButton.filled(
                    iconSize: 32,
                    onPressed: () {
                      Navigator.pushNamed(context, '/tes');
                    },
                    icon: Icon(
                      Icons.videocam,
                      color: whiteColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
