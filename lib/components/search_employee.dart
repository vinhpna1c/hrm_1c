import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/Employee.dart';

class SearchEmployee extends StatelessWidget {
  final Employees? employees;
  const SearchEmployee({super.key, this.employees});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(top: 15, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(employees!.image),
                )),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(employees!.name,
                  style: TextStyle(
                      color: Colors.grey[500], fontWeight: FontWeight.w500)),
              // SizedBox(
              //   height: 5,
              // ),
              // Text(employees!.username,
              //     style: TextStyle(color: Colors.grey[500])),
            ])
          ]),
          // GestureDetector(
          //   onTap: () {
          //     setState(() {
          //       employees.isFollowedByMe = !employees.isFollowedByMe;
          //     });
          //   },
          //   child: AnimatedContainer(
          //     height: 35,
          //     width: 110,
          //     duration: Duration(milliseconds: 300),
          //     decoration: BoxDecoration(
          //       color: user.isFollowedByMe ? Colors.blue[700] : Color(0xffffff),
          //       borderRadius: BorderRadius.circular(5),
          //       border: Border.all(color: user.isFollowedByMe ? Colors.transparent : Colors.grey.shade700,)
          //     ),
          //     child: Center(
          //       child: Text(user.isFollowedByMe ? 'Unfollow' : 'Follow', style: TextStyle(color: user.isFollowedByMe ? Colors.white : Colors.white))
          //     )
          //   ),
          // )
        ],
      ),
    );
  }
}
