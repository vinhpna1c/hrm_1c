import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/search_widget.dart';
import 'package:hrm_1c/controller/admin_data_controller.dart';
import 'package:hrm_1c/models/leave_request.dart';
import 'package:hrm_1c/utils/styles.dart';

import '../../components/request_card.dart';

class LeaveDayScreen extends StatelessWidget {
  LeaveDayScreen({super.key});

  RxInt _selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    final adminDataCtrl = Get.find<AdminDataController>();
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            children: [
              SearchWidget(),
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
                    //Tab pending
                    ListView(
                      children: adminDataCtrl.leaveRequests
                          .where((lq) =>
                              (lq.status ?? "").toLowerCase().contains("pend"))
                          .map(
                            (e) => RequestCard(leaveRequest: e),
                          )
                          .toList(),
                    ),
                    //Tab approved
                    ListView(
                      children: adminDataCtrl.leaveRequests
                          .where((lq) => (lq.status ?? "")
                              .toLowerCase()
                              .contains("approve"))
                          .map(
                            (e) => RequestCard(leaveRequest: e),
                          )
                          .toList(),
                    ),
                    //Tab not approved
                    ListView(
                      children: adminDataCtrl.leaveRequests
                          .where((lq) => (lq.status ?? "")
                              .toLowerCase()
                              .contains("reject"))
                          .map(
                            (e) => RequestCard(leaveRequest: e),
                          )
                          .toList(),
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
