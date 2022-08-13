import 'package:flutter/material.dart';

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
