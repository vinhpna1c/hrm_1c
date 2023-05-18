import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/controller/geo_controller.dart';
import 'package:hrm_1c/screens/single_body_screen.dart';
import 'package:hrm_1c/utils/styles.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../controller/configuration_controller.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  WebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _configurationCtrl = Get.find<ConfigurationController>();
    final geoController = Get.find<GeoController>();

    Rx<double> _currentSliderValue = geoController.checkInRadius.obs;
    return SingleBodyScreen(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Check-in Radius:",
                    style: HRMTextStyles.h4Text.copyWith(color: Colors.black),
                  ),
                  Obx(
                    () => SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 5.0,
                        showValueIndicator: ShowValueIndicator.always,
                        trackShape: RoundedRectSliderTrackShape(),
                        //activeTrackColor: Colors.purple.shade800,
                        //inactiveTrackColor: Colors.purple.shade100,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 7.0,
                          pressedElevation: 4.0,
                        ),
                        //thumbColor: Colors.pinkAccent,
                        //overlayColor: Colors.pink.withOpacity(0.2),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 16.0),
                        tickMarkShape: RoundSliderTickMarkShape(),
                        //activeTickMarkColor: Colors.pinkAccent,
                        inactiveTickMarkColor: Colors.white,
                        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: Colors.lightBlueAccent,
                        valueIndicatorTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      child: Slider(
                        value: _currentSliderValue.value,
                        max: 1000,
                        divisions: 100,
                        label: _currentSliderValue.round().toString(),
                        onChanged: (value) {
                          _currentSliderValue.value = value;
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => Text(
                      _currentSliderValue.toInt().toString() + " m",
                      style: HRMTextStyles.lightText,
                    ),
                  ),
                ],
              ),
              Text(
                "Current check-in position:",
                style: HRMTextStyles.h4Text.copyWith(color: Colors.black),
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0),
                child: Obx(
                  () => Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Longtitude:",
                            style: HRMTextStyles.lightText,
                          ),
                          Text(
                            _configurationCtrl.checkInPosition.value.longitude
                                        .toString() ==
                                    "0.0"
                                ? geoController.longitude.toString()
                                : _configurationCtrl
                                    .checkInPosition.value.longitude
                                    .toString(),
                            style: HRMTextStyles.lightText,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Latitude:",
                            style: HRMTextStyles.lightText,
                          ),
                          Text(
                            _configurationCtrl.checkInPosition.value.latitude
                                        .toString() ==
                                    "0.0"
                                ? geoController.latitude.toString()
                                : _configurationCtrl
                                    .checkInPosition.value.latitude
                                    .toString(),
                            style: HRMTextStyles.lightText,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Set up check-in location",
                    style: HRMTextStyles.h4Text.copyWith(color: Colors.black),
                  ),
                  TextButton(
                      onPressed: () async {
                        String url =
                            await webViewController!.currentUrl() ?? "";
                        print("URL: " + url);
                        //update position
                        _configurationCtrl.handlePostionFromUrl(url);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: HRMColorStyles.darkBlueColor,
                      ),
                      child: Text(
                        "Set",
                        style:
                            HRMTextStyles.h4Text.copyWith(color: Colors.white),
                      ))
                ],
              ),
              Container(
                  height: 400,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 0),
                          spreadRadius: 0.2,
                          blurRadius: 2)
                    ],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: WebView(
                      initialUrl: geoController.latitude.toString() == "0.0"
                          ? 'https://www.google.com/maps'
                          : "https://www.google.com/maps/@" +
                              geoController.latitude.toString() +
                              "," +
                              geoController.longitude.toString() +
                              ",14z",
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
                    ),
                  )),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  backgroundColor: HRMColorStyles.lightBlueColor),
              child: Text(
                "Save changes",
                style: HRMTextStyles.h3Text.copyWith(color: Colors.white),
              ))),
    );
  }
}
