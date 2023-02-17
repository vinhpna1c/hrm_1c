import 'package:flutter/material.dart';
import 'package:hrm_1c/components/search_widget.dart';
import 'package:hrm_1c/utils/styles.dart';

import '../../components/information_card.dart';

class JobScreen extends StatelessWidget {
  const JobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidget(),
            Text(
              'Jobs',
              style: HRMTextStyles.normalText.copyWith(color: Colors.black),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 100,
                child: Row(
                  children: [
                    JobItem(),
                    JobItem(
                      isOpen: true,
                    ),
                    JobItem(),
                    JobItem(
                      isOpen: true,
                    ),
                    JobItem(),
                    JobItem(
                      isOpen: true,
                    ),
                    JobItem(),
                    JobItem(
                      isOpen: true,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Candidates',
              style: HRMTextStyles.normalText.copyWith(color: Colors.black),
            ),
            Expanded(
              child: Container(
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

class JobItem extends StatelessWidget {
  final bool isOpen;
  const JobItem({
    this.isOpen = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Container(
              height: 45,
              width: 45,
              child: Image.asset("assets/images/job_holder.png"),
            ),
          ),
          Text(
            "Job position",
            style: HRMTextStyles.h5Text.copyWith(fontWeight: FontWeight.w200),
          ),
          Text(
            isOpen ? "Open" : "Close",
            style: HRMTextStyles.h5Text.copyWith(
                fontWeight: FontWeight.w200,
                color: isOpen ? Colors.greenAccent : Colors.red),
          ),
        ],
      ),
    );
  }
}
