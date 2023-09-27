import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hrm_1c/components/headers/hrm_appbar.dart';
import 'package:hrm_1c/components/headers/hrm_drawer.dart';

class SingleBodyScreen extends StatelessWidget {
  final bool showAppBar;
  final String title;
  final Widget body;
  final Widget? bottomNavigationBar;
  const SingleBodyScreen(
      {this.showAppBar = true,
      required this.body,
      this.title = "1C:HRM",
      this.bottomNavigationBar,
      super.key});

  @override
  Widget build(BuildContext context) {
    print(title);
    return WillPopScope(
      onWillPop: () async {
        // prevent back button
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        drawer: showAppBar ? const HRMDrawer() : null,
        appBar: showAppBar ? HRMAppBar(title: title) : null,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
