// Import Packages
import 'dart:async';
import 'package:flutter/material.dart';

// Import Styles
import 'package:kiddy/shared/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // Init state to fetch the application data when start the apps
  getInit() async {
    Timer(
      const Duration(seconds: 3),
      () {
        // User? currentUser = FirebaseAuth.instance.currentUser;
        // context.read<ConsultanCubit>().fetchConsultants();
        // context.read<ArticleCubit>().fetchArticles();
        // context.read<VideoCubit>().fetchVideos();
        // if (currentUser == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/main-page', (route) => false);
        // } else {
        // context.read<AuthCubit>().getCurrentUser(currentUser.uid);
        // Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
        // }
      },
    );
  }

  @override
  void initState() {
    getInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 24,
              ),
              width: 130,
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                ),
              ),
            ),
            Text(
              'Kiddy',
              style: darkGreyText.copyWith(
                fontSize: 40,
                fontWeight: bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
