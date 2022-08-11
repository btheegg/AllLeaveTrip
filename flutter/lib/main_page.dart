import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/material.dart';

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
              const DateTimeField(),
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

class DateTimeField extends StatefulWidget {
  const DateTimeField({Key? key}) : super(key: key);

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

class AttractionItem extends StatefulWidget {
  const AttractionItem(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.address})
      : super(key: key);
  final String imageUrl;
  final String name;
  final String address;
  @override
  State<AttractionItem> createState() => _AttractionItemState();
}

class _AttractionItemState extends State<AttractionItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 160,
            height: 160,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("${widget.imageUrl}"))),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: Text(
              "${widget.name}",
              style: TextStyle(
                fontFamily: 'Pretendard',
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: Text(
              "${widget.address}",
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                color: Color(0xff767676),
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            height: 25,
            child: TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerLeft),
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      "코스 보러가기",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff58BF81),
                        fontSize: 12,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xff58BF81),
                      size: 12,
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}

class Attraction extends StatefulWidget {
  const Attraction({Key? key}) : super(key: key);

  @override
  State<Attraction> createState() => _AttractionState();
}

class _AttractionState extends State<Attraction> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Wrap(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: const [
                AttractionItem(
                  imageUrl:
                      "http://cdn.news.eugenes.co.kr/news/photo/201608/2245_4430_324.jpg",
                  name: "경복궁",
                  address: "서울 종로구 사직로 161 경복궁",
                ),
                AttractionItem(
                  imageUrl:
                      "http://www.jamill.kr/news/photo/202206/288780_114944_5327.jpg",
                  name: "대천해수욕장",
                  address: "충남 보령시 신흑동",
                ),
                AttractionItem(
                  imageUrl:
                      "http://cdn.news.eugenes.co.kr/news/photo/201608/2245_4430_324.jpg",
                  name: "다랭이마을",
                  address: "경남 남해군 남면 남면로 679... ",
                ),
                AttractionItem(
                  imageUrl:
                      "http://cdn.news.eugenes.co.kr/news/photo/201608/2245_4430_324.jpg",
                  name: "다산초당",
                  address: "전라남도 강진군 도암면 만덕리",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
