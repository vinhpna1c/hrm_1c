import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
    setState(() {
      _foundedEmployees = _employees
          .where((employee) => employee.name.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      )
                    ]),
                child: TextField(
                  onChanged: (value) => onSearch(value),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(10),
                      // prefix: Icon(
                      //   Icons.search,
                      //   color: Colors.grey.shade500,
                      // ),
                      hintText: "Search Employee",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none)),
                ),
              ),
              Expanded(
                // color: Colors.blue,
                child: _foundedEmployees.length > 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: _foundedEmployees.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            child: SearchEmployee(
                                employees: _foundedEmployees[index]),
                            // actions: <Widget>[
                            //   new IconSlideAction(
                            //     caption: 'Archive',
                            //     color: Colors.transparent,
                            //     icon: Icons.archive,
                            //     onTap: () => print("archive"),
                            //   ),
                            //   new IconSlideAction(
                            //     caption: 'Share',
                            //     color: Colors.transparent,
                            //     icon: Icons.share,
                            //     onTap: () => print('Share'),
                            //   ),
                            // ],
                            secondaryActions: <Widget>[
                              new IconSlideAction(
                                caption: 'More',
                                color: Color.fromARGB(115, 0, 0, 0),
                                icon: Icons.more_horiz,
                                onTap: () => print('More'),
                              ),
                              new IconSlideAction(
                                caption: 'Delete',
                                color: Color.fromARGB(115, 0, 0, 0),
                                icon: Icons.delete,
                                onTap: () => print('Delete'),
                              ),
                            ],
                          );
                        })
                    : Center(
                        child: Text(
                        "No users found",
                        style: TextStyle(color: Colors.white),
                      )),
              ),
            ],
          )),
    );
  }
}
