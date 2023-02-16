import 'package:flutter/material.dart';

import '../utils/styles.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10.0, left: 5, right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4.0,
              offset: Offset(0, 0),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              "assets/images/avatar_holder.png",
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name"),
                TextInformation(field: "Position: ", content: "IT Specialist"),
                TextInformation(field: "Old: ", content: "29"),
                TextInformation(
                    field: "Email: ", content: "it@1cinnovation.com"),
                TextInformation(
                    field: "Phone: ", content: "(+84) 9 123 456 78"),
                TextInformation(field: "Status: ", content: "Working"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget TextInformation({String field = "", String content = ""}) {
    return RichText(
      text: TextSpan(
          text: field,
          style: HRMTextStyles.lightText
              .copyWith(fontSize: 12, color: HRMColorStyles.darkGreyColor),
          children: [
            TextSpan(
              text: content,
              style: HRMTextStyles.lightText.copyWith(fontSize: 12),
            ),
          ]),
    );
  }
}
