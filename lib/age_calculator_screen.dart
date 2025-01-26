import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets/age_data_widget.dart';
import 'widgets/age_details_widget.dart';

class AgeCalculatorScreen extends StatefulWidget {
  const AgeCalculatorScreen({super.key});

  @override
  State<AgeCalculatorScreen> createState() => _AgeCalculatorScreenState();
}

class _AgeCalculatorScreenState extends State<AgeCalculatorScreen> {
  final TextEditingController _dateInputValue = TextEditingController();
  int ageYear = 0, ageMonths = 0, ageDays = 0,totalMonths = 0,totalDays=0,totalWeeks =0 ,totalHours =0 ,totalMinutes=0,totalSeconds=0,monthsUntilNextBirthday=0,daysUntilNextBirthday =0;
  String nextBirthdayDay="";
  //DateTime _dateTime=DateTime.now();
  Future<void> _showCalender() async {
    await showDatePicker(
            context: context, firstDate: DateTime(0), lastDate: DateTime.now())
        .then((value) {
      setState(() {
        if (value != null) {
          _dateInputValue.text = value.toString();
          ageYear = DateTime.now().year - value.year;
          ageMonths = DateTime.now().month - value.month;
          ageDays = DateTime.now().day - value.day;
          if (ageDays < 0) {
            ageMonths -= 1;
            ageDays += DateTime(DateTime.now().year, DateTime.now().month, 0).day;
          }

          if (ageMonths < 0) {
            ageYear -= 1;
            ageMonths += 12;
          }
          Duration ageDuration = DateTime.now().difference(value);
           totalMonths = (ageYear * 12) + ageMonths;
           totalDays = ageDuration.inDays;
           totalWeeks = totalDays ~/ 7;
           totalHours = ageDuration.inHours;
           totalMinutes = ageDuration.inMinutes;
           totalSeconds = ageDuration.inSeconds;

          // Find the next birthday
          DateTime nextBirthday = DateTime(DateTime.now().year, value.month, value.day);
          if (DateTime.now().isAfter(nextBirthday)) {
            nextBirthday = DateTime(DateTime.now().year + 1, value.month, value.day);
          }
          Duration timeUntilNextBirthday = nextBirthday.difference(DateTime.now());
           monthsUntilNextBirthday = timeUntilNextBirthday.inDays ~/ 30;
           daysUntilNextBirthday = timeUntilNextBirthday.inDays % 30;

           // find day in words like monday,tuesday etc
          nextBirthdayDay = DateFormat('EEEE').format(nextBirthday);
        } else {
          var sandbarForDate = SnackBar(
            content: Container(
                height: 50,
                child: Text(
                  "please select date",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                  textAlign: TextAlign.center,
                )),
            backgroundColor: Color(0xff676FDD),
          );
          ScaffoldMessenger.of(context).showSnackBar(sandbarForDate);
          _dateInputValue.text = "";
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color(0xffEBEBED),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Column(
              children: [
                //Birth Data container
                Container(
                 // height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                    color: Color(0xff3945B4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 15, bottom: 3),
                        child: Text(
                          "BirthData",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          //color: Colors.white,
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: _dateInputValue,
                            keyboardType: TextInputType.datetime,
                            onTap: _showCalender,
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: "please enter date here",
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.w600),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                suffixIcon: Icon(Icons.calendar_today_rounded)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //age details

                Padding(
                  padding: const EdgeInsets.only(top: 0),

                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 5, left: 5, bottom: 15, top: 10),
                          child: Text(
                            "You are (Your age right now)",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AgeDataWidget(
                              ageColor: Color(0xff656FDF),
                              agedDate: ageYear.toString(),
                              dateFormat: "Years",
                            ),
                            AgeDataWidget(
                                ageColor: Color(0xffCED498),
                                agedDate: ageMonths.toString(),
                                dateFormat: "Months"),
                            AgeDataWidget(
                                ageColor: Color(0xff75E0B7),
                                agedDate: ageDays.toString(),
                                dateFormat: "Days")
                          ],
                        ),
                        // Divider
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, left: 10, right: 10),
                          child: Divider(
                            color: Color(0xffD7D5D6),
                          ),
                        ),

                        //detailed age
                        AgeDetailsWidget(
                          ageDetails: "Months old",
                          ageDetailsValue: totalMonths.toString(),
                        ),
                        AgeDetailsWidget(
                            ageDetails: "Weeks old", ageDetailsValue: totalWeeks.toString()),
                        AgeDetailsWidget(
                            ageDetails: "Days old", ageDetailsValue: totalDays.toString()),
                        AgeDetailsWidget(
                            ageDetails: "Hours ols (approx)",
                            ageDetailsValue: totalHours.toString()),
                        AgeDetailsWidget(
                            ageDetails: "Minutes old (approx)",
                            ageDetailsValue: totalMinutes.toString()),
                        AgeDetailsWidget(
                            ageDetails: "Seconds old (approx)",
                            ageDetailsValue: totalSeconds.toString())
                      ],
                    ),
                  ),
                ),
                //next birthday
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    color: Color(0xff72E1B6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 30, bottom: 10),
                          child: Text(
                            "Next Birthday",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          // width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                             monthsUntilNextBirthday.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 30),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text(
                                                daysUntilNextBirthday.toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 30),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Months",
                                          style: TextStyle(
                                              color: Color(0xff216D4F),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text("Days",
                                            style: TextStyle(
                                                color: Color(0xff166A49),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: RichText(
                                  text: TextSpan(
                                    text: '  Your birthday is on ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight
                                            .w400), // Default text style
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:nextBirthdayDay!=""? nextBirthdayDay : "___",
                                        style: TextStyle(
                                            fontWeight: FontWeight
                                                .bold), // Bold style for "india"
                                      ),
                                      TextSpan(
                                        text: " this year",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
