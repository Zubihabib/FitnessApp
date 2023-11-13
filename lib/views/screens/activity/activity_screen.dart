import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'components/analytics_view.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

int pageIndex = 0;
var pages = [
  const AnalyticsView(),
  const AnalyticsView(),
  const AnalyticsView(),
  const AnalyticsView()
];

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: screenSize.width * 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: Colors.black,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: GNav(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 13.0),
                color: Colors.white,
                backgroundColor: Colors.black,
                tabBackgroundColor: const Color(0xffBBF246),
                activeColor: Colors.black,
                gap: 1,
                onTabChange: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.rocket_launch_outlined,
                    text: 'Launch',
                  ),
                  GButton(
                    icon: Icons.analytics_outlined,
                    text: 'Analytics',
                  ),
                  GButton(
                    icon: Icons.person_outline,
                    text: 'Person',
                  )
                ]),
          ),
        ),
        body: SafeArea(
          child: pages[pageIndex],
        ));
  }
}
