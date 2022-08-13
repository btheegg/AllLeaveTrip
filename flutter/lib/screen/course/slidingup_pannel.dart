import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'course_timeline.dart';

class CourseInfoSlididngBar extends StatefulWidget {
  const CourseInfoSlididngBar({Key? key}) : super(key: key);

  @override
  State<CourseInfoSlididngBar> createState() => _CourseInfoSlididngBarState();
}

class _CourseInfoSlididngBarState extends State<CourseInfoSlididngBar> {
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
        maxHeight: 400,
        panel: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
          alignment: Alignment.topLeft,
          height: 800,
          width: 300,
          child: CourseTimeLine(),
          decoration: BoxDecoration(borderRadius: radius),
        ),
        body: Center(
          child: Text("This is the Widget behind the sliding panel"),
        ));
  }
}
