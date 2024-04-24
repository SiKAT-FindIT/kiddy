// Import Packages
import 'package:flutter/material.dart';

// Import styles
import 'package:kiddy/shared/theme.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    super.key,
    required this.iconUrl,
    required this.index,
    required this.currentIndex,
    required this.onSelected,
  });

  final String iconUrl;
  final Function(int index) onSelected;
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 4,
          width: 40,
          decoration: BoxDecoration(
            color: index == currentIndex ? darkYellowColor : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        IconButton(
          iconSize: 32,
          onPressed: () => onSelected(index),
          icon: Image.asset(
            iconUrl,
            color: index == currentIndex ? darkYellowColor : lightGreyColor,
            height: 28,
            width: 28,
          ),
        ),
        const SizedBox(),
      ],
    );
  }
}
