import 'package:flutter/material.dart';
import 'package:kiddy/shared/theme.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.value,
    required this.title,
    this.onChanged,
  });

  final bool value;
  final String title;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: darkPinkColor, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: darkGreyText,
          ),
          const Spacer(),
          SizedBox(
            height: 36,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Switch(
                inactiveThumbColor: lightGreyColor,
                inactiveTrackColor: whiteColor,
                activeColor: darkPinkColor,
                activeTrackColor: whiteColor,
                trackOutlineColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return darkPinkColor;
                  }
                  return lightGreyColor;
                }),
                value: value,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
