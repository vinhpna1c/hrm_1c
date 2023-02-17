import 'package:flutter/material.dart';
import 'package:hrm_1c/utils/styles.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: HRMColorStyles.lightGreyColor,
        ),
      ),
      child: TextField(
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
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
