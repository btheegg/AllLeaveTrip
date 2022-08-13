import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'course_timeline.dart';
import 'map.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
    );

    TabController _tabController = TabController(length: 2, vsync: this);
    return SlidingUpPanel(
        minHeight: 500,
        maxHeight: 750,
        borderRadius: radius,
        panel: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
          alignment: Alignment.topLeft,
          child: CourseTimeLine(),
        ),
        body: Column(
          children: [
            Container(
              height: 45,
              child: TabBar(
                  controller: _tabController,
                  labelColor: Color(0xff58BF81),
                  labelStyle: TextStyle(
                      fontFamily: 'Pretendard',
                      color: Color(0xff58BF81),
                      fontSize: 17),
                  unselectedLabelColor: Color(0xff767676),
                  indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(color: Color(0xff58BF81), width: 2)),
                  tabs: [Tab(text: "1일차"), Tab(text: "2일차")]),
            ),
            SizedBox(
              width: double.maxFinite,
              height: 300,
              child: TabBarView(
                  controller: _tabController,
                  children: [Text("data"), Text("here")]),
            )
          ],
        ));
  }
}
