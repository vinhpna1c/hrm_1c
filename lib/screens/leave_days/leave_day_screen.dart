import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/search_widget.dart';
import 'package:hrm_1c/utils/styles.dart';

import '../../components/request_card.dart';

class LeaveDayScreen extends StatelessWidget {
  LeaveDayScreen({super.key});
  static final statusColor = [
    HRMColorStyles.pendingColor,
    HRMColorStyles.approveColor,
    HRMColorStyles.denyColor,
  ];

  RxInt _selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                indicatorColor: statusColor[_selectedIndex.value],
                unselectedLabelStyle: HRMTextStyles.h4Text,
                tabs: [
                  StatusTab(
                      isSelected: _selectedIndex.value == 0,
                      selectedColor: statusColor[0],
                      label: "Pending"),
                  StatusTab(
                      isSelected: _selectedIndex.value == 1,
                      selectedColor: statusColor[1],
                      label: "Approved"),
                  StatusTab(
                      isSelected: _selectedIndex.value == 2,
                      selectedColor: statusColor[2],
                      label: "Not approved"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  //Tab pending
                  SingleChildScrollView(
                    child: Container(
                      child: Column(children: [
                        RequestCard(
                          isPending: true,
                        ),
                        RequestCard(
                          isPending: true,
                        ),
                        RequestCard(
                          isPending: true,
                        ),
                        RequestCard(
                          isPending: true,
                        ),
                        RequestCard(
                          isPending: true,
                        ),
                        RequestCard(
                          isPending: true,
                        ),
                        const SizedBox(
                          height: 120,
                        )
                      ]),
                    ),
                  ),
                  //Tab approved
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          RequestCard(),
                          RequestCard(),
                          RequestCard(),
                        ],
                      ),
                    ),
                  ),
                  //Tab not approved
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          RequestCard(),
                          RequestCard(),
                          RequestCard(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
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
