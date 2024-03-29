// @dart=2.9
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'states.dart';
import 'sports.dart';
import 'newspapers.dart';
import 'cities.dart';
import 'e_news.dart';

class AllHomePage extends StatefulWidget {
  final Widget child;

  AllHomePage({Key key, this.child}) : super(key: key);

  _AllHomePageState createState() => _AllHomePageState();
}

Color PrimaryColor = Color(0xff109618);

class _AllHomePageState extends State<AllHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // backgroundColor: Color(0xff109618),
            backgroundColor: Colors.amber,
//            title: Padding(
//              padding: EdgeInsets.only(top: 8.0),
//              child: _GooglePlayAppBar(),
//            ),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(10.0),
                child: TabBar(
                  labelColor: Colors.black,
                  indicatorWeight: 4.0,
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor:Color(0xff3f51b5),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      color: Colors.white54),
                  isScrollable: true,
                  onTap: (index) {
                    setState(() {
                      switch (index) {
                        case 0:
                          PrimaryColor = Color(0xffff5722);
                          break;
                        case 1:
                          PrimaryColor = Color(0xff3f51b5);
                          break;
                        case 2:
                          PrimaryColor = Color(0xff3f51b5);
                          break;
                        case 3:
                          PrimaryColor = Color(0xff3f51b5);
                          break;
                        case 4:
                          PrimaryColor = Color(0xff3f51b5);
                          break;
                        default:
                      }
                    });
                  },
                  tabs: <Widget>[
                    Tab(
                      child: Container(
                        child: Text(
                          'Warm Up',
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: Text(
                          'Challenges',
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: Text(
                          'WWE',
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: Text(
                          'Celebrities',
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: Text(
                          'Yoga',
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          body: TabBarView(
            children: <Widget>[
              StatesNews(0xff3f51b5),
              CityNews(0xff9c27b0),
              SportsNews(0xffff5722), //ff572
              NewsPapers(0xffe91e63), //e91e63,//ff5722,
              ElectronicNews(0xff2196f3), //2196f3 //4CAF50
            ],
          )),
    );
  }
}

Widget _GooglePlayAppBar() {
  return Container(
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: IconButton(
            icon: Icon(FontAwesomeIcons.bars),
          ),
        ),
        Container(
          child: Text(
            'Google Play',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Container(
          child: IconButton(
              icon: Icon(
                FontAwesomeIcons.microphone,
                color: Colors.blueGrey,
              ),
              onPressed: null),
        ),
      ],
    ),
  );
}
