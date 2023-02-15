import 'package:flutter/material.dart';
import 'package:hrm_1c/utils/styles.dart';

class HomeNavButton extends StatelessWidget {
  final Widget icon;
  final String label;
  const HomeNavButton({
    required this.icon,
    this.label = "",
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: Offset(0, 4),
                blurRadius: 4)
          ]),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: icon,
          ),
          Text(
            label,
            style: HRMTextStyles.h4Text,
          )
        ],
      ),
    );
  }
}
