import 'package:allleavetrip/screen/course/tabbar.dart';

import 'package:flutter/material.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({Key? key, required this.area, required this.day})
      : super(key: key);
  final String area;
  final int day;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color(0xff58BF81)),
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              '추천 코스',
              style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: CustomTabBar(
            area: area,
            day: day,
          ),
        ));
  }
}
