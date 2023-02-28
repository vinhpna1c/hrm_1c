import 'package:get/get.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:hrm_1c/models/time_keeping.dart';
import 'package:hrm_1c/services/api/api_handler.dart';
import 'package:hrm_1c/services/firebase/firebase_service.dart';
import 'package:hrm_1c/utils/utils.dart';

class CheckInController extends GetxController {
  RxString documentID = "".obs;
  Rx<DateTime?> checkInDate = Rx(null);
  Rx<DateTime?> checkOutDate = Rx(null);
  static const checkInPath = "/V1/EmployeeCheckIn";
  static const checkOutPath = "/V1/EmployeeCheckOut";
  static const allLeavePath = "/V1/AllLeave";
  static const personalLeavePath = "/V1/PersonalLeave";

  Rx<TimeKeeping?> timeKeeping = Rx(null);

  Future<bool> checkIn() async {
    final userController = Get.find<UserController>();
    var respond = await ApiHandler.postRequest(checkInPath,
        body: {"EmployeeID": userController.userInformation!.code});

    if (respond.statusCode == 200) {
      var data = respond.data;
      print(respond);
      documentID.value = data['Number'].toString();
      checkInDate.value = parseDateTimeFromStr(data['Checkin']);

      timeKeeping.value = TimeKeeping.fromJson(data);
      checkOutDate.value = null;
      if (data['Checkout'] != null) {
        if (data['Checkout'].toString().isNotEmpty) {
          checkOutDate.value =
              parseDateTimeFromStr(data['Checkout'].toString());
        }
        print(checkOutDate.value);
      }

      return true;
    }
    documentID.value = "";
    checkInDate.value = null;
    checkOutDate.value = null;

    return false;
  }

  Future<bool> checkOut() async {
    var respond = await ApiHandler.postRequest(
      checkOutPath,
      body: {"Number": documentID.value},
    );

    if (respond.statusCode == 200) {
      var data = respond.data;
      if (data.toString().toLowerCase().contains("success")) {
        checkOutDate.value = DateTime.now();
        return true;
      }
    }

    return false;
  }
}
