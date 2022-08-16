import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {Key? key,
      required this.img,
      required this.title,
      required this.address,
      required this.contents,
      required this.code})
      : super(key: key);

  final String img;
  final String title;
  final String address;
  final String contents;
  final String code;

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> item = <String>[
      'dbstn023',
      '맛집조아',
    ];
    double value = 4;

    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.img),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: null /* add child content here */,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(12, 35, 0, 0),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            DefaultTextStyle(
              style: TextStyle(
                color: const Color(0xff000000),
                height: 1.5,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.code,
                      style: TextStyle(fontSize: 12),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '평점 ',
                          ),
                          const Text(
                            '4.0',
                            style: TextStyle(color: const Color(0xffD89920)),
                          ),
                          Text(" · "),
                          const Text(
                            '리뷰 ',
                          ),
                          const Text(
                            '218',
                            style: TextStyle(color: const Color(0xff58BF81)),
                          ),
                        ],
                      ),
                    ),
                    DefaultTextStyle(
                        style: TextStyle(
                            fontSize: 14, color: const Color(0xff767676)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.pin_drop_outlined,
                              color: const Color(0xff767676),
                            ),
                            Text(widget.address),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 16,
              decoration: BoxDecoration(color: const Color(0xffF3F3F3)),
            ),
            TabBar(
              unselectedLabelColor: const Color(0xff000000),
              labelColor: const Color(0xff58BF81),
              indicatorColor: const Color(0xff58BF81),
              tabs: [
                Tab(text: "상세 정보"),
                Tab(
                  text: "리뷰",
                )
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // 상세 정보 데이터
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 21.0),
                    child: Text(widget.contents),
                  ),
                  // 리뷰 데이터
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true, //just set this property
                            itemCount: item.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 26.0,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image(
                                            width: 28,
                                            height: 28,
                                            image:
                                                AssetImage("assets/img/1.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          " dbstn023",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: const Color(0xff767676)),
                                        ),
                                        Container(
                                          width: 227,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: RatingStars(
                                              value: value,
                                              onValueChanged: (v) {
                                                //
                                                setState(() {
                                                  value = v;
                                                });
                                              },
                                              starBuilder: (index, color) =>
                                                  Icon(
                                                Icons.star,
                                                color: color,
                                              ),
                                              starCount: 5,
                                              starSize: 20,
                                              maxValue: 5,
                                              starSpacing: 0.1,
                                              maxValueVisibility: false,
                                              valueLabelVisibility: false,
                                              animationDuration:
                                                  Duration(milliseconds: 1000),
                                              starOffColor:
                                                  const Color(0xffe7e8ea),
                                              starColor: Colors.yellow,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 150,
                                              height: 48,
                                              child: Text(
                                                "넘넘 맛있어요 ^^ 최고 !! 또 방문할게요 ~~~~",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color:
                                                      const Color(0xff000000),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 12,
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  "2022-07-02",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: const Color(
                                                          0xff767676)),
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(30.0),
                          padding: const EdgeInsets.all(10.0),
                          width: 334,
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1,
                                  color: const Color(0xff58BF81)
                                      .withOpacity((0.5)))),
                          child: Center(
                            child: Text(
                              "리뷰 작성하기",
                              style: TextStyle(
                                  fontSize: 16.0, color: Color(0xff58BF81)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
