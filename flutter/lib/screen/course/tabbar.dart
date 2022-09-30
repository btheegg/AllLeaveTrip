import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'course_timeline.dart';
import 'map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String BASE_URI = "http://203.255.3.66:3091";
bool visibility = true;

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key, required this.day, required this.area})
      : super(key: key);
  final String area;
  final int day;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCourse(widget.day, widget.area),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
          if (snapshot.hasData == false) {
            return CircularProgressIndicator();
          }
          //error가 발생하게 될 경우 반환하게 되는 부분
          else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          }
          // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
          else {
            return CustomSlidingBar(
              day: widget.day,
              courseData: snapshot.data,
            );
          }
        });
  }
}

List<Widget> createTabBar(int day) {
  List<Widget> tabBar = [];
  for (int i = 1; i < day + 1; i++) {
    tabBar.add(Text("$i일차"));
  }
  return tabBar;
}

List<Widget> createTabBarView(int day, List markerPos) {
  List<Widget> tabBarView = [];
  for (int i = 1; i < day + 1; i++) {
    tabBarView.add(Map(
      markerPos: markerPos,
    ));
  }
  return tabBarView;
}

Future<List> getCourse(int day, String area) async {
  final url = Uri.parse("$BASE_URI/course?day=$day&userId=25&area=$area");
  final res = await http.get(url);
  final response = utf8.decode(res.bodyBytes);

  return jsonDecode(response);
}

class CustomSlidingBar extends StatefulWidget {
  const CustomSlidingBar(
      {Key? key, required this.day, required this.courseData})
      : super(key: key);
  final int day;
  final List courseData;

  @override
  State<CustomSlidingBar> createState() => _CustomSlidingBarState();
}

class _CustomSlidingBarState extends State<CustomSlidingBar>
    with TickerProviderStateMixin {
  List data = [];
  int currentDay = 1;
  late TabController _tabController;
  List markerPos = [];

  @override
  void initState() {
    // TODO: implement initState
    data = widget.courseData[0];
    currentDay = 0;
    _tabController = TabController(length: widget.day, vsync: this);
    for (int i = 0; i < data.length; i++) {
      markerPos
          .add([double.parse(data[i]["lat"]), double.parse(data[i]["lng"])]);
    }

    _tabController.addListener(() {
      setState(() {
        data = widget.courseData[_tabController.index];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
    );

    List<Widget> tabBar = createTabBar(widget.day);
    List<Widget> tabBarView = createTabBarView(widget.day, markerPos);

    return SlidingUpPanel(
        minHeight: 500,
        maxHeight: 750,
        borderRadius: radius,
        panel: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
          alignment: Alignment.topLeft,
          child: CourseTimeLine(
            currentDay: currentDay + 1,
            courseData: data,
            lastDay: widget.day,
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 45,
              child: TabBar(
                  onTap: (index) {
                    setState(() {
                      List result = [];
                      data = widget.courseData[index];
                      for (int i = 0; i < data.length; i++) {
                        result.add([
                          double.parse(data[i]["lat"]),
                          double.parse(data[i]["lng"])
                        ]);
                      }
                      currentDay = index;
                      markerPos = result;
                    });
                  },
                  controller: _tabController,
                  labelColor: const Color(0xff58BF81),
                  labelStyle: const TextStyle(
                      fontFamily: 'Pretendard',
                      color: Color(0xff58BF81),
                      fontSize: 17),
                  unselectedLabelColor: Color(0xff767676),
                  indicator: const UnderlineTabIndicator(
                      borderSide:
                          BorderSide(color: Color(0xff58BF81), width: 2)),
                  tabs: tabBar),
            ),
            SizedBox(
              width: double.maxFinite,
              height: 500,
              child:
                  TabBarView(controller: _tabController, children: tabBarView),
            )
          ],
        ));
  }
}
