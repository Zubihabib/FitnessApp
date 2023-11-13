import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:fitness_app/utils/date_utils.dart' as date_util;

import '../../../widgets/icon_widget.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  double width = 0.0;
  double height = 0.0;
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();

  @override
  void initState() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
    super.initState();
  }

  Widget titleView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
      child: Text(
        date_util.DateUtils.months[currentDateTime.month - 1] +
            ' ' +
            currentDateTime.year.toString(),
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget hrizontalCapsuleListView() {
    return SizedBox(
      width: width,
      height: 75,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) {
          return capsuleView(index);
        },
      ),
    );
  }

  Widget capsuleView(int index) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currentDateTime = currentMonthList[index];
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (currentMonthList[index].day != currentDateTime.day)
                      ? const Color(0xffBBF246)
                      : Colors.black,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        date_util.DateUtils
                            .weekdays[currentMonthList[index].weekday - 1],
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: (currentMonthList[index].day !=
                                    currentDateTime.day)
                                ? Colors.black
                                : Colors.white),
                      ),
                      Text(
                        currentMonthList[index].day.toString(),
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: (currentMonthList[index].day !=
                                    currentDateTime.day)
                                ? Colors.black
                                //HexColor("465876")
                                : Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              currentMonthList[index].day != currentDateTime.day
                  ? Container()
                  : Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black,
                      ),
                    ),
            ],
          ),
        ));
  }

  Widget topView() {
    return SizedBox(
      width: width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            titleView(),
            hrizontalCapsuleListView(),
          ]),
    );
  }

  Widget caloriesView() {
    return Container(
      width: width * 0.4,
      height: height * 0.07,
      padding: EdgeInsets.only(
          top: height * 0.005, left: width * 0.01, bottom: height * 0.0001),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 2,
            color: Colors.grey,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Active calories",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
            ),
          ),
          SizedBox(
            height: height * 0.001,
          ),
          const Text(
            "645 Cal",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget trainingTimeView() {
    return Container(
      width: width * 0.4,
      height: height * 0.17,
      padding: EdgeInsets.only(top: height * 0.02, bottom: height * 0.003),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xffEAECFF),
      ),
      child: Column(
        children: [
          const Center(
            child: Text(
              "Training Time",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          Center(
            child: SleekCircularSlider(
              onChange: (double value) {
                // callback providing a value while its being changed (with a pan gesture)
              },
              onChangeStart: (double startValue) {
                // callback providing a starting value (when a pan gesture starts)
              },
              onChangeEnd: (double endValue) {
                // ucallback providing an ending value (when a pan gesture ends)
              },
              initialValue: 80,
              max: 100,
              appearance: CircularSliderAppearance(
                counterClockwise: true,
                angleRange: 360,
                startAngle: 270,
                size: height * 0.09,
                customColors: CustomSliderColors(
                  progressBarColor: const Color(0xffA48AED),
                  trackColor: Colors.white,
                  hideShadow: true,
                  dotColor: Colors.transparent,
                ),
                customWidths: CustomSliderWidths(
                  progressBarWidth: 10,
                  trackWidth: 10,
                ),
                infoProperties: InfoProperties(
                    bottomLabelText: "%",
                    bottomLabelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20),
                    mainLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                    modifier: (double value) {
                      final roundedValue = value.ceil().toInt().toString();
                      return '$roundedValue ';
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cyclingView() {
    return Container(
      width: width * 0.5,
      height: height * 0.25,
      padding: EdgeInsets.only(top: height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.015),
            child: Row(
              children: [
                IconWidget(
                    image: "images/cycling.png",
                    color: const Color(0xffFFFFFF)),
                SizedBox(
                  width: width * 0.015,
                ),
                const Text(
                  "Cycling",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(height * 0.01),
            child: Container(
              height: height * 0.16,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: const DecorationImage(
                      image: AssetImage('images/map.png'), fit: BoxFit.cover)),
            ),
          ),
        ],
      ),
    );
  }

  Widget heartRate() {
    return Container(
      width: width * 0.53,
      height: height * 0.2,
      padding: EdgeInsets.only(top: height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xffFFEBEB),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.015),
            child: Row(
              children: [
                IconWidget(
                    image: "images/heart.png", color: const Color(0xffF9B9B9)),
                SizedBox(
                  width: width * 0.015,
                ),
                const Text(
                  "Hearth Rate",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(height * 0.01),
            child: Container(
              height: height * 0.11,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: const DecorationImage(
                      image: AssetImage('images/graph.png'),
                      fit: BoxFit.cover)),
            ),
          ),
        ],
      ),
    );
  }

  Widget sleepView() {
    return Container(
      width: width * 0.5,
      height: height * 0.17,
      padding: EdgeInsets.only(top: height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xffEFE2FF),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.015),
            child: Row(
              children: [
                IconWidget(
                    image: "images/sleep.png", color: const Color(0xffD6BBF8)),
                SizedBox(
                  width: width * 0.015,
                ),
                const Text(
                  "Sleep",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(height * 0.01),
            child: Container(
              height: height * 0.07,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: const DecorationImage(
                      image: AssetImage('images/sleep_graph.png'),
                      fit: BoxFit.cover)),
            ),
          ),
        ],
      ),
    );
  }

  Widget waterView() {
    return Container(
      width: width * 0.4,
      height: height * 0.17,
      padding: EdgeInsets.only(top: height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xffD8E6EC),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.015),
            child: Row(
              children: [
                IconWidget(
                    image: "images/water1.png", color: const Color(0xffAED1E0)),
                SizedBox(
                  width: width * 0.015,
                ),
                const Text(
                  "Water",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(height * 0.01),
            child: Container(
              height: height * 0.07,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: const DecorationImage(
                      image: AssetImage('images/water_graph.png'),
                      fit: BoxFit.cover)),
            ),
          ),
        ],
      ),
    );
  }

  Widget stepsView() {
    return Container(
      width: width * 0.38,
      height: height * 0.12,
      padding: EdgeInsets.only(top: height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xffFFE8C6),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.015),
            child: Row(
              children: [
                IconWidget(
                    image: "images/steps.png", color: const Color(0xffF8D39D)),
                SizedBox(
                  width: width * 0.015,
                ),
                const Text(
                  "Steps",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(height * 0.01),
              child: Column(
                children: [
                  const Text(
                    "999/2000",
                    style: TextStyle(color: Colors.black),
                  ),
                  Container(
                    width: width * 0.3, // Set your desired width
                    // Set your desired height
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(10), // Set border radius
                      color: Colors.white, // Set background color
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        value: 0.4,
                        backgroundColor: Color(
                            0xffFFEDD1), // Set background color of the progress bar
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xffFCC46F)), // Set color of the progress bar
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 5.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topView(),
            const Text(
              "Today Report",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: height * 0.01),
                      child: caloriesView(),
                    ),
                    trainingTimeView()
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.02),
                  child: cyclingView(),
                )
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heartRate(),
                SizedBox(
                  width: width * 0.01,
                ),
                Column(
                  children: [
                    stepsView(),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      height: height * 0.06,
                      width: width * 0.38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: const DecorationImage(
                              image: AssetImage('images/Banner.png'),
                              fit: BoxFit.cover)),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              children: [
                sleepView(),
                SizedBox(
                  width: width * 0.01,
                ),
                waterView()
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
