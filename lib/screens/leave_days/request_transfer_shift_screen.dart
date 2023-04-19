import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/shift_table.dart';
import 'package:hrm_1c/controller/staff_data_controller.dart';
import 'package:hrm_1c/controller/transfer_shift_controller.dart';
import 'package:hrm_1c/models/contract.dart';
import 'package:hrm_1c/screens/leave_days/request_information_transfer_shift_screen.dart';
import 'package:hrm_1c/screens/single_body_screen.dart';
import 'package:hrm_1c/utils/styles.dart';
import 'package:hrm_1c/utils/utils.dart';
import 'package:intl/intl.dart';

class RequestTransferShiftScreen extends StatelessWidget {
  final Rx<DateTime> requestDay = DateTime.now().obs;
  Rx<DateTime> firstDay = DateTime.now().obs;
  Rx<bool> result = false.obs;
  RequestTransferShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final staffDataCtrl = Get.find<StaffDataController>();
    List<Rx<DateTime>> days = currentWeek(DateTime.now()).obs as List<Rx<DateTime>>;
    firstDay.value = days[0].value;

    return SingleBodyScreen(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              color: HRMColorStyles.blueShade800Color,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Icon(Icons.more_horiz,
                          color: Colors.white,),
                        alignment: Alignment.topRight,
                      ),
                      Container(
                        child: Text(
                          "Time Sheet",
                          style: HRMTextStyles.h3Text.copyWith(fontSize: 24),
                        ),
                        margin: EdgeInsets.only(right: 24),
                        alignment: Alignment.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {
                              final transferShiftCtrl = Get.find<TransferShiftController>();
                              if (firstDay.value.subtract(const Duration(days:7)).isBefore(days[0].value)) {
                                Get.snackbar("1C:HRM",
                                    "You can't transfer shift in the past");
                              }
                              else{
                                firstDay.value = firstDay.value.subtract(const Duration(days:7));
                                transferShiftCtrl.firstDay.value = firstDay.value;
                              }
                              //days = currentWeek(transferShiftCtrl.firstDay.value);
                            },
                            child: Text("<"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx( ()=>
                              Text(DateFormat("dd/MM/yyyy").format(firstDay.value)+" - "+DateFormat("dd/MM/yyyy").format(firstDay.value.add(const Duration(days: 6))),
                                style: HRMTextStyles.lightText.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                           TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                final transferShiftCtrl = Get.find<TransferShiftController>();
                                firstDay.value = firstDay.value.add(const Duration(days:7));
                                transferShiftCtrl.firstDay.value = firstDay.value;
                                //days = currentWeek(transferShiftCtrl.firstDay.value);
                                },
                              child: Text(">"),
                           ),
                        ],
                      ),
                      ShiftTable(
                        timeSheets: staffDataCtrl.contract.value!.timeSheet,
                      ),
                      InkWell(
                        onTap:() => checkTransfer() ? _dialogBuilder(context) : {},
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 100,
                            right: 100,
                          ),
                          width: 160,
                          height: 52,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: HRMColorStyles.darkBlueColor,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 4),
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 4)
                              ]),
                          child: Text(
                            "Request",
                            style: HRMTextStyles.btnText.copyWith(fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final transferShiftCtrl = Get.find<TransferShiftController>();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          title: Column(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: Colors.lightGreen,
                size: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Transfer shift',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
              ),
            ],
          ),
          content:
              Container(
                //eight: 60,
                padding: const EdgeInsets.all(8),
                //margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4.0,
                          offset: const Offset(0, 4),
                          color: Colors.black.withOpacity(0.25)),
                    ]),
                child: TextField(
                  controller: transferShiftCtrl.reasonController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      //contentPadding: EdgeInsets.only(top: 15),
                      border: InputBorder.none,
                      hintText: "Enter the reason (optional)"),

                ),
              ),


          actions: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(116, 116, 191, 1.0),
                    Color.fromRGBO(52, 138, 199, 1.0)
                  ]),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                  minimumSize: Size(85, 35),
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Submit', style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  await setInformationTransferShift();
                  var respond =
                      await transferShiftCtrl.requestTransferShift();
                  if (respond) {
                    Get.snackbar(
                        "1C:HRM", "Your request has been saved!");
                  } else {
                    Get.snackbar(
                        "1C:HRM", "Error while sending request!");
                  }
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF355c7d),
                Color(0xFF6c5b7b),
                Color(0xFFc06c84),
                ]),
                borderRadius: BorderRadius.circular(8)
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                  minimumSize: Size(85, 35),
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Cancel', style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }


  List<Rx<DateTime>> currentWeek(DateTime Day) {
    List<Rx<DateTime>> days = [];
    int n = Day.weekday;
    for (var i = n-1; i >= 1; i-- ) {
      days.add(Day.subtract(Duration(days: i)).obs);
    }

    days.add(Day.obs);

    for (var i = 7; i >= n+1; i-- ) {
      days.add(Day.add(Duration(days: 8-i)).obs);
    }

    return days;
  }

  bool checkTransfer(){
    final transferShiftCtrl = Get.find<TransferShiftController>();
    int countWorkPicked = 0;
    List<int> arrayWorkPicked = [];
    int countNonePicked = 0;
    List<int> arrayNonePicked = [];
    for (int i =0; i<transferShiftCtrl.cellTypes.length; i++) {
      if (transferShiftCtrl.cellTypes[i]==3) {
        countWorkPicked = countWorkPicked + 1;
        arrayWorkPicked.add(i);
      } else if (transferShiftCtrl.cellTypes[i]==1) {
        countNonePicked = countNonePicked + 1;
        arrayNonePicked.add(i);
      }
    }

    if (countWorkPicked == countNonePicked && countWorkPicked > 0){
      return true;
    } else if (countWorkPicked == 0){
      Get.snackbar("1C:HRM",
          "Please choose working shift that you want to transfer");
    } else if (countNonePicked == 0){
      Get.snackbar("1C:HRM",
          "Please choose off shift that you want to transfer");
    } else {
      Get.snackbar("1C:HRM",
          "Number of working shift that you want to transfer has to equal to number of off shift that you want to transfer");
    }
    return false;
  }

  Future<void> setInformationTransferShift() async {
    final transferShiftCtrl = Get.find<TransferShiftController>();
    transferShiftCtrl.firstDay.value = firstDay.value;

    List<int> arrayWorkPicked = [];

    List<int> arrayNonePicked = [];
    for (int i =0; i<transferShiftCtrl.cellTypes.length; i++) {
      if (transferShiftCtrl.cellTypes[i]==3) {
        arrayWorkPicked.add(i);
      } else if (transferShiftCtrl.cellTypes[i]==1) {
        arrayNonePicked.add(i);
      }
    }

    if (arrayWorkPicked.length==2){ //main shift full day
      ////find mainshift
      transferShiftCtrl.mainShift.value = transferShiftCtrl.firstDay.value.add(Duration(days: arrayWorkPicked[0]~/3));
      transferShiftCtrl.sectionMain.value = "Full day";
      ////find transfershift
      if ((arrayNonePicked[0]-arrayNonePicked[1]).abs() == 1) { //transfer shift full day
        transferShiftCtrl.transferShift.value =
            transferShiftCtrl.firstDay.value.add(
                Duration(days: arrayNonePicked[0] ~/ 3));
        transferShiftCtrl.sectionTransfer.value = "Full day";
      } else { //transfer shift with section
        //transfer shift 1
        if (arrayNonePicked[0] % 3 == 1) {
          transferShiftCtrl.transferShift.value =
              transferShiftCtrl.firstDay.value.add(
                  Duration(days: arrayNonePicked[0] ~/ 3));
          transferShiftCtrl.sectionTransfer.value = "Morning";
        } else {
          transferShiftCtrl.transferShift.value =
              transferShiftCtrl.firstDay.value.add(
                  Duration(days: arrayNonePicked[0] ~/ 3));
          transferShiftCtrl.sectionTransfer.value = "Afternoon";
        }
        //transfer shift 2
        if (arrayNonePicked[1] % 3 == 1) {
          transferShiftCtrl.transferShift1.value =
              transferShiftCtrl.firstDay.value.add(
                  Duration(days: arrayNonePicked[1] ~/ 3));
          transferShiftCtrl.sectionTransfer1.value = "Morning";
        } else {
          transferShiftCtrl.transferShift1.value =
              transferShiftCtrl.firstDay.value.add(
                  Duration(days: arrayNonePicked[1] ~/ 3));
          transferShiftCtrl.sectionTransfer1.value = "Afternoon";
        }
      }
    } else { //main shift with section
      ////main shift
      if (arrayWorkPicked[0] % 3 == 1) {
        transferShiftCtrl.mainShift.value =
            transferShiftCtrl.firstDay.value.add(
                Duration(days: arrayWorkPicked[0] ~/ 3));
        transferShiftCtrl.sectionMain.value = "Morning";
      } else {
        transferShiftCtrl.mainShift.value =
            transferShiftCtrl.firstDay.value.add(
                Duration(days: arrayWorkPicked[0] ~/ 3));
        transferShiftCtrl.sectionMain.value = "Afternoon";
      }
      ////transfer shift
      if (arrayNonePicked[0] % 3 == 1) {
        transferShiftCtrl.transferShift.value =
            transferShiftCtrl.firstDay.value.add(
                Duration(days: arrayNonePicked[0] ~/ 3));
        transferShiftCtrl.sectionTransfer.value = "Morning";
      } else {
        transferShiftCtrl.transferShift.value =
            transferShiftCtrl.firstDay.value.add(
                Duration(days: arrayNonePicked[0] ~/ 3));
        transferShiftCtrl.sectionTransfer.value = "Afternoon";
      }
    }
  }
}




