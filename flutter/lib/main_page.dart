import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/material.dart';

import 'main/bottom_items.dart';
import 'main/date_time_picker.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        children: [
          Container(
            height: 300,
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.fromLTRB(23, 60, 23, 18),
            child: Column(children: [
              // 어디로 가실건가요? 타이틀

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

              // 어디로 가실건가요? Input 태그

              Container(
                height: 43,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: const TextField(
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 15.0,
                        color: Color(0xff767676)),
                    decoration: InputDecoration(
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

              // 언제 가고 싶으신가요? 타이틀

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

              // 데이트 타임 Input 태그
              const DateTimeField(),

              // 코스 추천 받기 버튼
              Container(
                height: 1,
                width: double.infinity,
                color: const Color.fromRGBO(255, 255, 255, 0.5),
                margin: EdgeInsets.fromLTRB(0, 20, 0, 15),
              ),
              Row(
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
              )
            ]),
          ),
          CustomTabBar()
        ],
      )),
    );
  }
}

// 여행지, 액티비티, 숙박에 대한 탭바
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
