import 'package:get/get.dart';
import 'package:hrm_1c/services/firebase/firebase_service.dart';

class CheckInController extends GetxController {
  String employeeID = "00000002";
  RxString documentID = "".obs;
  Rx<DateTime?> checkInDate = Rx(null);
  Rx<DateTime?> checkOutDate = Rx(null);

  Future<void> getCheckInInformation() async {
    var result = await FirebaseService.findOne(
        "timeKeeping", {"Employee ID": employeeID});

    if (result.keys.isNotEmpty) {
      checkInDate.value = DateTime.tryParse(result['checkIn']);
      checkOutDate.value = DateTime.tryParse(result['checkOut']);
      print(checkInDate.value);
      print(checkOutDate.value);
    }
  }

  Future<void> checkIn() async {
    checkInDate.value = DateTime.now();
    String res = await FirebaseService.addNewDocument("timeKeeping", {
      "employeeID": employeeID,
      "checkIn": checkInDate.value,
      "checkOut": checkOutDate.value,
    });
    print(res);
    documentID.value = res;
  }
}
