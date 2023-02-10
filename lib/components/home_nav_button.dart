import 'package:flutter/material.dart';

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
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: Offset(0, 4),
                blurRadius: 4)
          ]),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [icon, Text(label)],
      ),
    );
  }
}
