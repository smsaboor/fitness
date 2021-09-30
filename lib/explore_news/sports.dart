// @dart=2.9
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SportsNews extends StatefulWidget {
  SportsNews(this.colorVal);

  int colorVal;

  _SportsNewsState createState() => _SportsNewsState();
}

class _SportsNewsState extends State<SportsNews>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 6);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      widget.colorVal = 0xffff5722;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(1.0),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorWeight: 4.0,
                indicatorColor: Color(0xffff5722),
                unselectedLabelColor: Colors.grey,
                tabs: <Widget>[
                  Tab(
                    child: Text('Cricket',
                        style: TextStyle(
                            color: _tabController.index == 0
                                ? Color(widget.colorVal)
                                : Colors.grey)),
                  ),
                  Tab(
                    child: Text('FootBall',
                        style: TextStyle(
                            color: _tabController.index == 1
                                ? Color(widget.colorVal)
                                : Colors.grey)),
                  ),
                  Tab(
                    child: Text('Hockey',
                        style: TextStyle(
                            color: _tabController.index == 2
                                ? Color(widget.colorVal)
                                : Colors.grey)),
                  ),
                  Tab(
                    child: Text('WWE',
                        style: TextStyle(
                            color: _tabController.index == 3
                                ? Color(widget.colorVal)
                                : Colors.grey)),
                  ),
                  Tab(
                    child: Text('Judo',
                        style: TextStyle(
                            color: _tabController.index == 4
                                ? Color(widget.colorVal)
                                : Colors.grey)),
                  ),
                  Tab(
                    child: Text('Chess',
                        style: TextStyle(
                            color: _tabController.index == 5
                                ? Color(widget.colorVal)
                                : Colors.grey)),
                  ),
                ],
              )),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
//              HomeForYouTabs(),
            Container(
              height: 200.0,
              child: Center(child: Text('Category')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Category')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Category')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Family')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Early Access')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Editor Choice')),
            ),
          ],
        ),
      ),
    );
  }
}
