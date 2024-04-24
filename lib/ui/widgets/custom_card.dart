import 'package:flutter/material.dart';
import 'package:kiddy/shared/theme.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, this.child, this.margin});

  final Widget? child;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: margin,
      width: double.infinity,
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: cardShadow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
