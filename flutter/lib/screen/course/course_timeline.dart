import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String BASE_URI = "http://127.0.0.1:8000";

class CourseTimeLine extends StatefulWidget {
  const CourseTimeLine({Key? key}) : super(key: key);

  @override
  State<CourseTimeLine> createState() => _CourseTimeLineState();
}

class _CourseTimeLineState extends State<CourseTimeLine> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCourse(),
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
            return (Container(
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
                      title: snapshot.data[0][0]['name'],
                      address: snapshot.data[0][0]['lat'],
                      time: snapshot.data[0][0]['time'],
                      distance: snapshot.data[0][0]['distance'],
                    ),
                    TimeLineCourseTitle(
                      alpha: "B",
                      title: "액티비티",
                    ),
                    TimeLineCourseContent(
                      title: snapshot.data[0][1]['name'],
                      address: snapshot.data[0][1]['lat'],
                      time: snapshot.data[0][1]['time'],
                      distance: snapshot.data[0][1]['distance'],
                    ),
                    TimeLineCourseTitle(
                      alpha: "B",
                      title: "액티비티",
                    ),
                    TimeLineCourseContent(
                      title: snapshot.data[0][2]['name'],
                      address: snapshot.data[0][2]['lat'],
                      time: snapshot.data[0][2]['time'],
                      distance: snapshot.data[0][2]['distance'],
                    ),
                    TimeLineCourseTitle(
                      alpha: "A",
                      title: "식당",
                    ),
                    TimeLineCourseContent(
                      title: snapshot.data[0][3]['name'],
                      address: snapshot.data[0][3]['lat'],
                      time: snapshot.data[0][3]['time'],
                      distance: snapshot.data[0][3]['distance'],
                    ),
                    TimeLineCourseTitle(
                      alpha: "B",
                      title: "액티비티",
                    ),
                    TimeLineCourseContent(
                      title: snapshot.data[0][4]['name'],
                      address: snapshot.data[0][4]['lat'],
                      time: snapshot.data[0][4]['time'],
                      distance: snapshot.data[0][4]['distance'],
                    ),
                    TimeLineEndTitle(),
                    SizedBox(
                      height: 20,
                    ),
                    TimeLineButton()
                  ],
                ),
              ),
            ));
          }
        });
  }
}

class TimeLineCourseContent extends StatefulWidget {
  const TimeLineCourseContent(
      {Key? key,
      required this.title,
      required this.address,
      required this.time,
      required this.distance})
      : super(key: key);
  final title;
  final address;
  final time;
  final distance;

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
          Column(
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
                        image: NetworkImage(
                            "https://mblogthumb-phinf.pstatic.net/MjAxODA1MDJfOTYg/MDAxNTI1MjQ0NjkxNzMx.5gA6AfkafA3mxRYaKwWrlIcz4OrLjKywwopTaKnSRCwg.KNtb49DZ7j1vCY93EWv-b_VVY8mFcZydG7kf3-n9PuMg.JPEG.flyyj1/KakaoTalk_20180430_101156677.jpg?type=w800"))),
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
                "도보 ${widget.time}분 소요, ${widget.distance}KM",
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Theme.of(context).primaryColor),
              ),
            ],
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
  const TimeLineEndTitle({Key? key}) : super(key: key);

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
          "1일차 종료",
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
        onPressed: () {},
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

Future<List> getCourse() async {
  final url = Uri.parse("$BASE_URI/course?day=1&userId=25&areaCode=3");
  final res = await http.get(url);
  final response = utf8.decode(res.bodyBytes);

  return jsonDecode(response);
}
