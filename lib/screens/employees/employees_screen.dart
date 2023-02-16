import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hrm_1c/components/information_card.dart';
import 'package:hrm_1c/models/Employee.dart';
import 'package:searchfield/searchfield.dart';
import 'package:hrm_1c/utils/styles.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../components/search_employee.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  List<Employees> _employees = [
    Employees(
      'Elliana Palacios',
      '@elliana',
      'https://images.unsplash.com/photo-1504735217152-b768bcab5ebc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=0ec8291c3fd2f774a365c8651210a18b',
    ),
    Employees(
      'Kayley Dwyer',
      '@kayley',
      'https://images.unsplash.com/photo-1503467913725-8484b65b0715?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=cf7f82093012c4789841f570933f88e3',
    ),
    Employees(
      'Kathleen Mcdonough',
      '@kathleen',
      'https://images.unsplash.com/photo-1507081323647-4d250478b919?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=b717a6d0469694bbe6400e6bfe45a1da',
    ),
    Employees(
      'Kathleen Dyer',
      '@kathleen',
      'https://images.unsplash.com/photo-1502980426475-b83966705988?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=ddcb7ec744fc63472f2d9e19362aa387',
    ),
    Employees(
      'Mikayla Marquez',
      '@mikayla',
      'https://images.unsplash.com/photo-1541710430735-5fca14c95b00?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
    ),
    Employees(
      'Kiersten Lange',
      '@kiersten',
      'https://images.unsplash.com/photo-1542534759-05f6c34a9e63?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
    ),
    Employees(
      'Carys Metz',
      '@metz',
      'https://images.unsplash.com/photo-1516239482977-b550ba7253f2?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
    ),
    Employees(
      'Ignacio Schmidt',
      '@schmidt',
      'https://images.unsplash.com/photo-1542973748-658653fb3d12?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
    ),
    Employees(
      'Clyde Lucas',
      '@clyde',
      'https://images.unsplash.com/photo-1569443693539-175ea9f007e8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
    ),
    Employees(
      'Mikayla Marquez',
      '@mikayla',
      'https://images.unsplash.com/photo-1541710430735-5fca14c95b00?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
    )
  ];

  List<Employees> _foundedEmployees = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _foundedEmployees = _employees;
    });
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
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: HRMColorStyles.lightGreyColor,
                ),
              ),
              child: TextField(
                onChanged: (value) => onSearch(value),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: HRMColorStyles.lightGreyColor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.filter_list_rounded,
                          color: HRMColorStyles.lightGreyColor),
                      onPressed: () {
                        print(" showfilter");
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Search...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none)),
              ),
            ),
            Expanded(
              child: Ink(
                color: Colors.white,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    InformationCard(),
                    InformationCard(),
                    InformationCard(),
                    InformationCard(),
                    InformationCard(),
                    InformationCard()
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
