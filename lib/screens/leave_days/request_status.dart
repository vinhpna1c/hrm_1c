import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hrm_1c/controller/leave_day_controller.dart';
import 'package:hrm_1c/screens/leave_days/request_information_transfer_shift_screen.dart';

import '../../components/request_card.dart';
import '../../components/search_widget.dart';
import '../../components/transfer_card.dart';
import '../../controller/admin_data_controller.dart';
import '../../models/leave_request.dart';
import '../../utils/styles.dart';
import '../single_body_screen.dart';


class RequestStatus extends StatelessWidget {
  RequestStatus({super.key});

  final RxInt _selectedIndex = 0.obs;
  static final tabs = ["Pending", "Approve", "Reject"];
  static final REQUEST_TYPES = ["All", "Leave-day", "Transfer shift"];
  final RxString requestType = "All".obs;

  @override
  Widget build(BuildContext context) {
    final adminDataCtrl = Get.find<AdminDataController>();
    final leaveDayCtrl = Get.find<LeaveDayController>();

    return SingleBodyScreen(
      body: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              children: [
                const SearchWidget(),
                Obx(
                      () => Container(
                    // color: Colors.yellow,
                        alignment: Alignment.center,
                    width: double.infinity,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      children: [
                        // Text(
                        //   "Type",
                        //   style: HRMTextStyles.normalText.copyWith(
                        //     color: Colors.black,
                        //   ),
                        // ),
                        ...REQUEST_TYPES.map(
                              (type) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SectionRadio(
                                value: type,
                                groupValue: requestType.value,
                                onChanged: (value) {
                                  if (value != null) {
                                    requestType.value = value;
                                  }
                                },
                              ),
                              Text(
                                type,
                                style: HRMTextStyles.h4Text
                                    .copyWith(fontWeight: FontWeight.w200),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                      () => TabBar(
                    padding: EdgeInsets.all(4.0),
                    onTap: (val) {
                      _selectedIndex.value = val;
                    },
                    indicatorColor:
                    LeaveRequest.statusColors[_selectedIndex.value],
                    unselectedLabelStyle: HRMTextStyles.h4Text,
                    tabs: [
                      StatusTab(
                          isSelected: _selectedIndex.value == 0,
                          selectedColor: LeaveRequest.statusColors[0],
                          label: "Pending"),
                      StatusTab(
                          isSelected: _selectedIndex.value == 1,
                          selectedColor: LeaveRequest.statusColors[1],
                          label: "Approved"),
                      StatusTab(
                          isSelected: _selectedIndex.value == 2,
                          selectedColor: LeaveRequest.statusColors[2],
                          label: "Rejected"),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ...tabs.map(
                            (tab) => RefreshIndicator(
                          onRefresh: () async {
                            await adminDataCtrl.getAllLeaveRequest();
                            await adminDataCtrl.getAllTransferRequest();
                          },
                          child: Obx(
                                () => ListView(children: [
                              ...adminDataCtrl.leaveRequests
                                  .where((lq) => (lq.status ?? "")
                                  .toLowerCase()
                                  .contains(tab.toLowerCase()))
                                  .map(
                                    (e) => (requestType.value
                                    .toLowerCase()
                                    .contains('all') ||
                                    requestType.value
                                        .toLowerCase()
                                        .contains('leave'))
                                    ? RequestCard(
                                  leaveRequest: e,
                                  onPostFunction: () {
                                    print("load dât");
                                    adminDataCtrl.getAllLeaveRequest();
                                  },
                                )
                                    : const SizedBox(),
                              ),
                              ...adminDataCtrl.transferRequests
                                  .where((tq) => (tq.status ?? "")
                                  .toLowerCase()
                                  .contains(tab.toLowerCase()))
                                  .map(
                                    (e) => (requestType.value
                                    .toLowerCase()
                                    .contains('all') ||
                                    requestType.value
                                        .toLowerCase()
                                        .contains('transfer'))
                                    ? TransferCard(
                                  request: e,
                                  onPostFunction: () {
                                    adminDataCtrl
                                        .getAllTransferRequest();
                                  },
                                )
                                    : const SizedBox(),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }

  Widget StatusTab({
    required bool isSelected,
    required Color selectedColor,
    String label = "",
  }) {
    return Tab(
      child: Container(
        // alignment: Alignment.center,
        width: double.infinity,
        height: 30,
        padding: const EdgeInsets.symmetric(
          horizontal: 2.0,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0)),
        child: Center(
          child: Text(
            label,
            style: HRMTextStyles.h5Text.copyWith(
              color: isSelected ? selectedColor : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}