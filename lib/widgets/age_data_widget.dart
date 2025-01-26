import 'package:flutter/material.dart';

class AgeDataWidget extends StatelessWidget {
  const AgeDataWidget(
      {super.key,
        required this.ageColor,
        required this.agedDate,
        required this.dateFormat});
  final Color ageColor;
  final String agedDate;
  final String dateFormat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              color: ageColor, borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Text(
                agedDate,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w900, fontSize: 23),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            dateFormat,
            style: TextStyle(
                color: Color(0xffD7D5D6), fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}