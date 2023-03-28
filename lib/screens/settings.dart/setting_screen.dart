import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/screens/single_body_screen.dart';

import '../../controller/configuration_controller.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  WebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    final _configurationCtrl = Get.find<ConfigurationController>();

    return SingleBodyScreen(
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [Text("Radius check-in:"), Text("300 m")],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Check-in position:"),
                Column(
                  children: [
                    Row(
                      children: [Text("Longtitude:"), Text("10.00006")],
                    ),
                    Row(
                      children: [Text("Latitude:"), Text("107.00006")],
                    )
                  ],
                )
              ],
            ),
            Container(
                height: 400,
                child: WebView(
                  initialUrl: 'https://www.google.com/maps',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) =>
                      webViewController = controller,
                  geolocationEnabled: true,
                  onPageFinished: (url) {
                    String decodeURI = Uri.decodeFull(url).toString();
                    //check if find locarion

                    // String decodeURL = getLocationFromMapURL(decodeURI);
                    // if (decodeURL.contains('google') == false) {
                    //   if (_searchController.text ==
                    //       "https://www.google.com/maps") {
                    //     _searchController.text = " ";
                    //   } else {
                    //     _searchController.text = decodeURL;
                    //   }
                    //   _daycareController.pickupLocation.value =
                    //       _searchController.text;
                    // }
                  },
                )),
          ],
        ),
      )),
      bottomNavigationBar:
          TextButton(onPressed: () {}, child: Text("Save changes")),
    );
  }
}
