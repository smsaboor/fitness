
// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:fitness/explore_news/homepage.dart';
import 'package:fitness/about/about.dart';
import 'package:fitness/localisation/localization_two/application.dart';
import 'package:fitness/localisation/localization_two/app_translations.dart';
import 'package:fitness/localisation/localization_two/app_translations_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fitness/about/news.dart';
class NewsHome extends StatefulWidget {
  NewsHome();
  @override
  _NewsHomeState createState() => _NewsHomeState();
}

class _NewsHomeState extends State<NewsHome> {
  _NewsHomeState();
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;
  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };


  final List colorList2 = [
    Colors.pink,
    Colors.pinkAccent,
    Colors.orange,
    Colors.green,
    Colors.redAccent
  ];
  int lang = 0;

  int color;
  String theme;
  Color colorselected;
  int _currentPage;
  int selectedIndex = 0;
  List<String> mystates = [];
  List<String> mytehsils = [];
  var appLanguage;


  TabController tabController;
  TabController tabControllerLocal;
  TabController tabControllerDownloads;
  TabController tabControllerForYou;

//Show hide Bottom and Appbar dependencies
  bool _showAppbar = true; //this is to show app bar
  ScrollController _scrollBottomBarController =
  new ScrollController(); // set controller on scrolling
  bool isScrollingDown = false;
  bool _show = true;
  double bottomBarHeight = 56; // set bottom bar height
  double _bottomBarOffset = 0;
  int newsListLength;
  int firestoreListLength;
  int loacalArticleLength = 0;
  String _uuid;
  bool _dark;

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        duration: Duration(seconds: 3));
    Scaffold.of(context).showSnackBar(snackBar);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dark = false;
    colorselected = Colors.pink;
    myScroll();
    _currentPage = 0;
  }

  void showBottomBar() {
    setState(() {
      _show = true;
    });
  }

  void hideBottomBar() {
    setState(() {
      _show = false;
    });
  }

  void myScroll() async {
    _scrollBottomBarController.addListener(() {
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          hideBottomBar();
        }
      }
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          showBottomBar();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollBottomBarController.removeListener(() {});
    super.dispose();
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  Widget bottomNavbar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Icon(Icons.local_library),
            ),
            title: Text(
              'For You',
              style: TextStyle(color: Colors.black),
            )),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Icon(Icons.language),
          ),
          title: Text(
            'Yoga',
            style: TextStyle(color: Colors.black),
          ),
        ),
        BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Icon(Icons.flag),
            ),
            title: Text(
              'Gym',
              style: TextStyle(color: Colors.black),
            )),

        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Icon(Icons.location_on),
          ),
          title: Text(
            'Home',
            style: TextStyle(color: Colors.black),
          ),
        ),
        BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Icon(Icons.explore),
            ),
            title: Text(
              'Excercises',
              style: TextStyle(color: Colors.black),
            )),
      ],
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.amber,
      iconSize: 22,
      selectedFontSize: 13,
      unselectedFontSize: 12,
      unselectedItemColor: Colors.black54,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: (index) {
        debugPrint("index===========$index");
        setState(() {
          colorselected = colorList2[index];
          selectedIndex = index;
          _currentPage = index;
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return _getScaffold(_currentPage);
  }

  Widget _getScaffold(int page) {
    switch (page) {
      case 0:
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                  icon: Icon(
                    Icons.language,
                    semanticLabel: 'search',
                    color: Colors.amber,
                  ),
                  onPressed: () {}
              ),
              actions: <Widget>[
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.notifications_active,
                      size: 24.0,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      if (lang == 1) {
                        setState(() {
                          lang = 0;
                        });
                        application
                            .onLocaleChanged(Locale(languagesMap[languagesList[1]]));
                      } else {
                        setState(() {
                          lang = 1;
                        });
                        application
                            .onLocaleChanged(Locale(languagesMap[languagesList[0]]));
                      }
                    },
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      size: 24.0,
                      color: Colors.black54,
                    ),
                    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => AboutPage()),
    );
    },
                  ),
                ),
              ],
              centerTitle: true,
              title: Container(),
            ),
            bottomNavigationBar: bottomNavbar(),
            body: Container());
      case 1:
        return DefaultTabController(
          length: 5,
          child: new Scaffold(
              backgroundColor: Colors.grey.shade100,
              body: new NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      new SliverAppBar(
                        title: GestureDetector(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 6),
                                  child: Icon(
                                    Icons.language,
                                    color: Colors.amber,
                                    size: 34,
                                  ),
                                ),
                                Container(),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 25,
                                  color: Colors.black,
                                )
                              ],
                            ),
                            onTap: () {}),
                        actions: <Widget>[
                          Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.file_download,
                                size: 24.0,
                                color: Colors.red,
                              ),
                              onPressed: () {


                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 6.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.account_circle,
                                size: 24.0,
                                color: Colors.black54,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                        automaticallyImplyLeading: false,
                        elevation: 4.0,
                        backgroundColor: Colors.white,
                        floating: true,
                        pinned: true,
                        snap: true,
                        bottom: TabBarWorld(),
                      ),
                    ];
                  },
                  body: _tabBarViewWorld()),
              bottomNavigationBar: bottomNavbar()),
        );
      case 2:
        return DefaultTabController(
          length: 5,
          child: new Scaffold(
              backgroundColor: Colors.grey.shade100,
              body: new NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      new SliverAppBar(
                        title: GestureDetector(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 6),
                                  child: Icon(
                                    Icons.language,
                                    color: Colors.amber,
                                    size: 34,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 25,
                                  color: Colors.black,
                                )
                              ],
                            ),
                            onTap: () {}),
                        actions: <Widget>[
                          Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.file_download,
                                size: 24.0,
                                color: Colors.red,
                              ),
                              onPressed: () {

                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 6.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.account_circle,
                                size: 24.0,
                                color: Colors.black54,
                              ),
                              onPressed: () {

                              },
                            ),
                          ),
                        ],
                        automaticallyImplyLeading: false,
                        elevation: 4.0,
                        backgroundColor: Colors.white,
                        floating: true,
                        pinned: true,
                        snap: true,
                        bottom: TabBarNational(),
                      ),
                    ];
                  },
                  body: _tabBarViewNational()),
              bottomNavigationBar: bottomNavbar()),
        );
      case 3:
        return DefaultTabController(
          length: 8,
          child: new Scaffold(
              backgroundColor: Colors.white,
              body: new NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      new SliverAppBar(
                          title: GestureDetector(
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 6),
                                    child: Icon(
                                      Icons.language,
                                      color: Colors.amber,
                                      size: 34,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 25,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                              onTap: () {}),
                          actions: <Widget>[
                            Container(
                              child: IconButton(
                                icon: Icon(
                                  Icons.file_download,
                                  size: 24.0,
                                  color: Colors.red,
                                ),
                                onPressed: () {

                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 6.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.account_circle,
                                  size: 24.0,
                                  color: Colors.black54,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                          automaticallyImplyLeading: false,
                          elevation: 4.0,
                          backgroundColor: Colors.white,
                          floating: true,
                          pinned: true,
                          snap: true,
                          bottom: TabBarLocal())
                    ];
                  },
                  body: _tabBarViewLocal()),
              bottomNavigationBar: bottomNavbar()),
        );
      case 4:
        return Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: bottomNavbar(),
            body: AllHomePage());
    }
  }
  Widget TabBarWorld() {
    return TabBar(
      labelColor: Colors.black,
      labelStyle: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      unselectedLabelColor: Colors.black54,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 4,
      indicatorColor: Colors.amber,
//      indicator: BoxDecoration(
//          borderRadius: BorderRadius.only(
//              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
//          color: Colors.white70),
      isScrollable: true,
      tabs: [
        Text("jobs"),
        Text("Jobs"),
        Text("Business"),
        Text("Politics"),
        Text("Education"),
      ],
      controller: tabController,
    );
  }

  Widget _tabBarViewWorld() {
    debugPrint("in ........................_tabBarView");
    return TabBarView(controller: tabController, children: [
      NewsCard(),
      NewsCard(),
      NewsCard(),
      NewsCard(),
      NewsCard(),
    ]);
  }
  Widget TabBarNational() {
    return TabBar(
      labelColor: Colors.black,
      labelStyle: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      unselectedLabelColor: Colors.black54,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 4,
      indicatorColor: Colors.amber,
      isScrollable: true,
      tabs: [
        Text("Chest"),
        Text("Shoulder"),
        Text("Byceps"),
        Text("Triceps"),
        Text("Back"),
      ],
      controller: tabController,
    );
  }

  Widget _tabBarViewNational() {
    debugPrint("in ........................_tabBarView");
    return TabBarView(controller: tabController, children: [
      NewsCard(),
      NewsCard(),
      NewsCard(),
      NewsCard(),
      NewsCard(),
    ]);
  }

  Widget TabBarLocal() {
    return TabBar(
      labelStyle: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      unselectedLabelColor: Colors.black54,
      labelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 4,
      indicatorColor: Colors.amber,
      isScrollable: true,
      tabs: [
        Text("Jobs"),
        Text("Jobs"),
        Text("Jobs"),
        Text("Jobs"),
        Text("Jobs"),
        Text("Jobs"),
        Text("Jobs"),
        Text("Jobs"),
      ],
      controller: tabControllerLocal,
    );
  }

  TabBarView _tabBarViewLocal() {
    debugPrint("in ........................_tabBarView");
    return TabBarView(controller: tabControllerLocal, children: [
      Container(child: Text(AppTranslations.of(context).text("key_restorent")),),
      NewsCard(),
      NewsCard(),
      NewsCard(),
      NewsCard(),
      NewsCard(),
      NewsCard(),
      NewsCard(),
    ]);
  }


  TabBarView _tabBarViewsDownload() {
    return TabBarView(controller: tabControllerDownloads, children: [
      Container(),
      Container(),
      Container(),
      Container(),
    ]);
  }
}

