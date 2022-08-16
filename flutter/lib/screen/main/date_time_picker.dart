import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/material.dart';

typedef void StringCallback(String start, String end);

class DateTimeField extends StatefulWidget {
  const DateTimeField({Key? key, required this.dateCallback}) : super(key: key);

  final StringCallback dateCallback;

  @override
  State<DateTimeField> createState() => DateTimeFieldState();
}

class DateTimeFieldState extends State<DateTimeField> {
  String _start = "시작날짜";
  String _end = "종료날짜";

  //변수를 변경하는 함수
  setter(String start, String end) => setState(() {
        _start = start;
        _end = end;
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: const Text('여행날짜를 선택해주세요.',
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  content: SizedBox(
                    width: 300,
                    height: 350,
                    child: Column(
                      children: [
                        DateRangPicker(
                          setter: setter,
                        ),
                        MaterialButton(
                          child: Text("OK"),
                          onPressed: () {
                            widget.dateCallback(_start, _end);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ));
            });
      },
      child: Align(
        child: Container(
          height: 43,
          // margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: TextField(
              enabled: false,
              style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 15.0,
                  color: Color(0xff767676)),
              decoration: InputDecoration(
                filled: true, //<-- SEE HERE
                fillColor: const Color.fromRGBO(255, 255, 255, 0.8),
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                hintText: '$_start ~ $_end',
                hintStyle: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 15.0,
                    color: Color(0xff767676)),
                contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
              )),
        ),
      ),
    );
  }
}

class DateRangPicker extends StatefulWidget {
  DateRangPicker({Key? key, required this.setter}) : super(key: key);

  final Function setter;
  @override
  State<DateRangPicker> createState() => _DateRangPickerState();
}

class _DateRangPickerState extends State<DateRangPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 300,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18)),
          color: Colors.white),
      child: SfDateRangePicker(
        minDate: DateTime(2000),
        maxDate: DateTime(2050),
        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
          if (args.value is PickerDateRange) {
            String start = args.value.startDate.toString().substring(0, 10);

            String end = args.value.endDate != null
                ? args.value.endDate.toString().substring(0, 10)
                : start;

            widget.setter(start, end);
          }
        },
        selectionMode: DateRangePickerSelectionMode.range,
        monthCellStyle: const DateRangePickerMonthCellStyle(
          textStyle: TextStyle(
              fontFamily: 'Pretendard', fontSize: 15.0, color: Colors.black),
          todayTextStyle: TextStyle(color: Colors.deepPurple),
        ),
        startRangeSelectionColor: const Color(0xff58BF81),
        endRangeSelectionColor: const Color(0xff58BF81),
        rangeSelectionColor: const Color.fromARGB(136, 88, 191, 129),
        selectionTextStyle: const TextStyle(color: Colors.white),
        todayHighlightColor: Colors.deepPurple,
        selectionColor: Colors.deepPurple,
        // backgroundColor: Colors.deepPurple,
        allowViewNavigation: false,
        // view:  DateRangePickerView.month,
        headerStyle: const DateRangePickerHeaderStyle(
            textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xff58BF81),
          fontSize: 18,
        )),
        monthViewSettings: const DateRangePickerMonthViewSettings(
          enableSwipeSelection: false,
        ),
      ),
    );
  }
}
