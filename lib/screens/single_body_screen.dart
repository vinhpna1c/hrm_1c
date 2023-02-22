import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hrm_1c/components/hrm_appbar.dart';
import 'package:hrm_1c/components/hrm_drawer.dart';

class SingleBodyScreen extends StatelessWidget {
  final bool showAppBar;
  final String title;
  final Widget body;
  const SingleBodyScreen(
      {this.showAppBar = true,
      required this.body,
      this.title = "1C:HRM",
      super.key});

  @override
  Widget build(BuildContext context) {
    print(title);
    return Scaffold(
      drawer: showAppBar ? HRMDrawer() : null,
      appBar: showAppBar ? HRMAppBar(title: title) : null,
      body: body,
    );
  }
}
