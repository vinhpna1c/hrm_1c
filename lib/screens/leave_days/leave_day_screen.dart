import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/search_widget.dart';
import 'package:hrm_1c/components/transfer_card.dart';
import 'package:hrm_1c/controller/admin_data_controller.dart';
import 'package:hrm_1c/models/leave_request.dart';
import 'package:hrm_1c/models/transfer_shift_request.dart';
import 'package:hrm_1c/screens/leave_days/request_leave_screen.dart';
import 'package:hrm_1c/utils/styles.dart';

import '../../components/request_card.dart';

class LeaveDayScreen extends StatelessWidget {
  LeaveDayScreen({super.key});

  final RxInt _selectedIndex = 0.obs;
  static final tabs = ["Pending", "Approve", "Reject"];
  static final REQUEST_TYPES = ["All", "Leave-day", "Transfer shift"];
  final RxString requestType = "All".obs;
  @override
  Widget build(BuildContext context) {
    final adminDataCtrl = Get.find<AdminDataController>();
    return DefaultTabController(
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
                  width: double.infinity,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.start,
                    children: [
                      Text(
                        "Type",
                        style: HRMTextStyles.normalText.copyWith(
                          color: Colors.black,
                        ),
                      ),
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
                                  (e) => RequestCard(leaveRequest: e),
                                ),
                            ...adminDataCtrl.transferRequests
                                .where((tq) => (tq.status ?? "")
                                    .toLowerCase()
                                    .contains(tab.toLowerCase()))
                                .map(
                                  (e) => TransferCard(request: e),
                                ),
                            // ...adminDataCtrl.leaveRequests
                            //     .where((lq) => (lq.status ?? "")
                            //         .toLowerCase()
                            //         .contains(tab.toLowerCase()))
                            //     .map(
                            //       (e) => RequestCard(leaveRequest: e),
                            //     ),
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
            color: Colors.grey.shade300,
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
