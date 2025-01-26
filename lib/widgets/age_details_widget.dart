import 'package:flutter/material.dart';

class AgeDetailsWidget extends StatelessWidget {
  const AgeDetailsWidget(
      {super.key, required this.ageDetails, required this.ageDetailsValue});
  final String ageDetails, ageDetailsValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(ageDetails,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w900)),
          Text(ageDetailsValue,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w900))
        ],
      ),
    );
  }
}