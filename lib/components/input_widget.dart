import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final Icon? prefixIcon;
  final bool isObsocured;
  final TextEditingController? controller;
  const InputWidget({
    Key? key,
    this.label = "",
    this.prefixIcon,
    this.isObsocured = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(top: 6, left: 8),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
                blurRadius: 4.0,
                offset: const Offset(0, 4),
                color: Colors.black.withOpacity(0.25)),
          ]),
      child: TextField(
        controller: controller,
        obscureText: isObsocured,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 15),
            border: InputBorder.none,
            prefixIcon: prefixIcon,
            hintText: label),
      ),
    );
  }
}
