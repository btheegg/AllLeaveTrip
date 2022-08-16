import 'package:allleavetrip/screen/course/course_page.dart';
import 'package:flutter/material.dart';

import '../course/tabbar.dart';
import 'bottom_items.dart';
import 'date_time_picker.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final textController = TextEditingController();
  String area = "";
  late int day;

  @override
  void dispose() {
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        children: [
          Container(
            height: 300,
            color: const Color(0xff58BF81),
            padding: const EdgeInsets.fromLTRB(23, 60, 23, 18),
            child: Column(children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(5, 0, 0, 9),
                child: RichText(
                  text: const TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '어디',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 17)),
                      TextSpan(
                          text: '로 가실건가요?',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              color: Colors.white,
                              fontSize: 17)),
                    ],
                  ),
                ),
              ),
              Container(
                height: 43,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextField(
                    onChanged: (text) {
                      setState(() {
                        area = text;
                      });
                    },
                    controller: textController,
                    style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 15.0,
                        color: Color(0xff767676)),
                    decoration: const InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Color.fromRGBO(255, 255, 255, 0.8),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      hintText: '서울, 경남, 경북, 전남, 전북',
                      hintStyle: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 15.0,
                          color: Color(0xff767676)),
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                    )),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(5, 0, 0, 9),
                child: RichText(
                  text: const TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '언제 ',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 17)),
                      TextSpan(
                          text: '가고 싶으신가요?',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              color: Colors.white,
                              fontSize: 17)),
                    ],
                  ),
                ),
              ),
              DateTimeField(
                dateCallback: (start, end) => setState(() {
                  print("$start와 $end");
                  setState(() {
                    day = getDateDiff(start, end);
                  });
                }),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: const Color.fromRGBO(255, 255, 255, 0.5),
                margin: EdgeInsets.fromLTRB(0, 20, 0, 15),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CoursePage(
                                area: area,
                                day: day + 1,
                              )));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: const Icon(
                        Icons.repeat,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const Text(
                      '코스 추천 받기',
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 18.0,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ]),
          ),
          CustomTabBar()
        ],
      )),
    );
  }
}

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Column(
      children: [
        Container(
          height: 45,
          child: TabBar(
              controller: _tabController,
              labelColor: Color(0xff58BF81),
              labelStyle:
                  TextStyle(fontFamily: 'Pretendard', color: Color(0xff58BF81)),
              unselectedLabelColor: Color(0xff767676),
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xff58BF81), width: 2)),
              tabs: [Tab(text: "여행지"), Tab(text: "액티비티"), Tab(text: "숙박")]),
        ),
        SizedBox(
          width: double.maxFinite,
          height: 450,
          child: TabBarView(controller: _tabController, children: [
            SingleChildScrollView(child: Attraction()),
            Text("there"),
            Text("here")
          ]),
        )
      ],
    );
  }
}

int getDateDiff(String start, String end) {
  DateTime newStart = DateTime.parse(start);
  DateTime endStart = DateTime.parse(end);

  return endStart.difference(newStart).inDays;
}
