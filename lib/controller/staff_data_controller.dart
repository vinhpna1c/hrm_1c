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
    var respond = await ApiHandler.postRequest(
      shiftPath,
      params: {"Token": userCtrl.identifyString},
    );
    if (respond.statusCode == 200) {
      var data = respond.data;
      contract.value = Contract.fromJson(data['Contract'][0]);
    }
  }
}
