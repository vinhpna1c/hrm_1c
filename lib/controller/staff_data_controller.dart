import 'package:get/get.dart';
import 'package:hrm_1c/controller/user_controller.dart';
import 'package:hrm_1c/models/contract.dart';
import 'package:hrm_1c/models/leave_request.dart';
import 'package:hrm_1c/models/transfer_shift_request.dart';
import 'package:hrm_1c/services/api/api_handler.dart';

class StaffDataController extends GetxController {
  RxList<LeaveRequest> personalLeaveRequests = <LeaveRequest>[].obs;
  RxList<TransferShiftRequest> personalTransferShiftRequests =
      <TransferShiftRequest>[].obs;

  Rx<Contract?> contract = Rx(null);

  static const shiftPath = "/V1/Shift";

  Future<void> getContract() async {
    final userCtrl = Get.find<UserController>();
    var respond = await ApiHandler.getRequest(
        userCtrl.username, userCtrl.password, shiftPath);
    if (respond.statusCode == 200) {
      var data = respond.data;
      print(data);
      contract.value = Contract.fromJson(data['Contract'][0]);
    }
  }
}
