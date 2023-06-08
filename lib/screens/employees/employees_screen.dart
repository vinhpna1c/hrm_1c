import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hrm_1c/components/information_card.dart';
import 'package:hrm_1c/components/search_widget.dart';
import 'package:hrm_1c/controller/admin_data_controller.dart';

import 'package:hrm_1c/utils/styles.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  onSearch(String search) {
    // setState(() {
    //   _foundedEmployees = _employees
    //       .where((employee) => employee.name.toLowerCase().contains(search))
    //       .toList();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final adminDataCtrl = Get.find<AdminDataController>();
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   mini: true,
        //   onPressed: () {},
        //   backgroundColor: HRMColorStyles.unselectedBlueColor,
        //   child: Icon(Icons.add),
        // ),
        body: Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              children: [
                SearchWidget(),
                Expanded(
                  child: Ink(
                    color: Colors.white,
                    child: Obx(
                      () => RefreshIndicator(
                        onRefresh: () async {
                          await adminDataCtrl.getAllEmployeeList();
                        },
                        child: ListView(
                          padding: EdgeInsets.only(top: 10),
                          shrinkWrap: true,
                          children: adminDataCtrl.employees
                              .map(
                                (element) => InformationCard(
                                    employeeInformation: element),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
