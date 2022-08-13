import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:allleavetrip/course/map.dart';
import 'package:flutter/material.dart';
import 'package:allleavetrip/course/tabbar.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({Key? key}) : super(key: key);

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
            leading: const IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              ),
              onPressed: null,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: const CustomTabBar(),
        ));
  }
}
