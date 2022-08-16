import 'package:flutter/cupertino.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../detail_screen.dart';
import '../main/mainpage.dart';
import 'package:fluttertoast/fluttertoast.dart';

String BASE_URI = "http://127.0.0.1:8000";

class CourseTimeLine extends StatefulWidget {
  const CourseTimeLine(
      {Key? key,
      required this.courseData,
      required this.currentDay,
      required this.lastDay})
      : super(key: key);

  final List courseData;
  final int currentDay;
  final int lastDay;
  @override
  State<CourseTimeLine> createState() => _CourseTimeLineState();
}

class _CourseTimeLineState extends State<CourseTimeLine> {
  _CourseTimeLineState();
  @override
  Widget build(BuildContext context) {
    print("${widget.currentDay} 와 ${widget.lastDay}");
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ScrollBar(),
            TimeLineCourseTitle(
              alpha: "A",
              title: "식당",
            ),
            TimeLineCourseContent(
              title: widget.courseData[0]['name'],
              address: widget.courseData[0]['address'],
              time: widget.courseData[0]['time'],
              distance: widget.courseData[0]['distance'],
              img: widget.courseData[0]['img'],
              code: widget.courseData[0]['code'],
              contents: widget.courseData[0]['contents'],
            ),
            TimeLineCourseTitle(
              alpha: "B",
              title: "액티비티",
            ),
            TimeLineCourseContent(
              title: widget.courseData[1]['name'],
              address: widget.courseData[1]['address'],
              time: widget.courseData[1]['time'],
              distance: widget.courseData[1]['distance'],
              img: widget.courseData[1]['img'],
              code: widget.courseData[1]['code'],
              contents: widget.courseData[1]['contents'],
            ),
            TimeLineCourseTitle(
              alpha: "C",
              title: "액티비티",
            ),
            TimeLineCourseContent(
              title: widget.courseData[2]['name'],
              address: widget.courseData[2]['address'],
              time: widget.courseData[2]['time'],
              distance: widget.courseData[2]['distance'],
              img: widget.courseData[2]['img'],
              code: widget.courseData[2]['code'],
              contents: widget.courseData[2]['contents'],
            ),
            TimeLineCourseTitle(
              alpha: "D",
              title: "식당",
            ),
            TimeLineCourseContent(
              title: widget.courseData[3]['name'],
              address: widget.courseData[3]['address'],
              time: widget.courseData[3]['time'],
              distance: widget.courseData[3]['distance'],
              img: widget.courseData[3]['img'],
              code: widget.courseData[3]['code'],
              contents: widget.courseData[3]['contents'],
            ),
            widget.currentDay == widget.lastDay
                ? SizedBox.shrink()
                : TimeLineCourseTitle(
                    alpha: "E",
                    title: "호텔",
                  ),
            widget.currentDay == widget.lastDay
                ? SizedBox.shrink()
                : TimeLineCourseContent(
                    title: widget.courseData[4]['name'],
                    address: widget.courseData[4]['address'],
                    time: widget.courseData[4]['time'],
                    distance: widget.courseData[4]['distance'],
                    img: widget.courseData[4]['img'],
                    code: widget.courseData[4]['code'],
                    contents: widget.courseData[4]['contents'],
                  ),
            TimeLineEndTitle(
              day: widget.currentDay,
            ),
            SizedBox(
              height: 20,
            ),
            TimeLineButton()
          ],
        ),
      ),
    );
  }
}

class TimeLineCourseContent extends StatefulWidget {
  const TimeLineCourseContent(
      {Key? key,
      required this.title,
      required this.address,
      required this.time,
      required this.distance,
      required this.img,
      required this.contents,
      required this.code})
      : super(key: key);
  final title;
  final address;
  final time;
  final distance;
  final img;
  final contents;
  final code;

  @override
  State<TimeLineCourseContent> createState() => _TimeLineCourseContentState();
}

class _TimeLineCourseContentState extends State<TimeLineCourseContent> {
  @override
  Widget build(BuildContext context) {
    return (Container(
      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Dash(
            direction: Axis.vertical,
            length: 200,
            dashLength: 3,
            dashThickness: 2,
            dashColor: Theme.of(context).primaryColor,
          ),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(
                            img: widget.img,
                            title: widget.title,
                            code: widget.code,
                            address: widget.address,
                            contents: widget.contents,
                          )));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 290,
                  height: 120,
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("${widget.img}"))),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "${widget.title}",
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "${widget.address}",
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Color(0xff767676)),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "자동차 ${widget.time}분 소요, ${widget.distance}KM",
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class TimeLineCourseTitle extends StatelessWidget {
  const TimeLineCourseTitle(
      {Key? key, required this.alpha, required this.title})
      : super(key: key);
  final String alpha;
  final String title;

  @override
  Widget build(BuildContext context) {
    return (Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 35,
          height: 35,
          margin: EdgeInsets.fromLTRB(0, 0, 7, 0),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: Text(
            "$alpha",
            style: TextStyle(
                fontFamily: 'Pretendard',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            textAlign: TextAlign.center,
          )),
        ),
        Text(
          "$title",
          style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              fontSize: 17),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 17,
            color: Color(0xff767676),
          ),
        ),
      ],
    ));
  }
}

class TimeLineEndTitle extends StatelessWidget {
  const TimeLineEndTitle({Key? key, required this.day}) : super(key: key);
  final int day;

  @override
  Widget build(BuildContext context) {
    return (Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 35,
          height: 35,
          margin: EdgeInsets.fromLTRB(0, 0, 7, 0),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: Icon(
            Icons.check,
            color: Colors.white,
            size: 16,
          )),
        ),
        Text(
          "$day일차 종료",
          style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              fontSize: 17),
        ),
      ],
    ));
  }
}

class TimeLineButton extends StatelessWidget {
  const TimeLineButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: (ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContextcontext) => CustomDialog());
        },
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                // shape : 버튼의 모양을 디자인 하는 기능

                borderRadius: BorderRadius.circular(9.0)),
            elevation: 0.0),
        child: Text(
          '코스 확정하기',
          style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
      )),
    );
  }
}

class ScrollBar extends StatelessWidget {
  const ScrollBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        Container(
          width: 200,
          height: 5,
          decoration: BoxDecoration(
              color: Color(0xffdedede),
              borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    ));
  }
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (CupertinoAlertDialog(
      title: Text("코스 확정"),
      content: const Text('해당 코스로 코스 확정을 하시겠습니까?'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(
            "아니요",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: (() {
            Navigator.pop(context);
          }),
        ),
        CupertinoDialogAction(
          child: Text(
            "확정하기",
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            showToast("코스가 확정되었습니다.");
            Navigator.pop(context);
            // //첫 페이지 위젯으로 이동하면서 연결된 모든 위젯을 트리에서 삭제
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => MainPage()),
            //     (route) => false);
          },
        ),
      ],
    ));
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM);
}
