// @dart=2.9
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsPapers extends StatefulWidget {
  int colorVal;
  NewsPapers(this.colorVal);
  _NewsPapersState createState() => _NewsPapersState();
}

class _NewsPapersState extends State<NewsPapers>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 7);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      widget.colorVal = 0xffe91e63;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
          bottom: PreferredSize(
          preferredSize: Size.fromHeight(5.0),
    child: TabBar(
            isScrollable: true,
            indicatorWeight: 4.0,
            indicatorColor: Color(0xffe91e63),
            unselectedLabelColor: Colors.grey,
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                child: Text('Bollywood Actrecess',
                    style: TextStyle(
                        color: _tabController.index == 0
                            ? Color(widget.colorVal)
                            : Colors.grey)),
              ),
              Tab(
                child: Text('Bollywood Actors',
                    style: TextStyle(
                        color: _tabController.index == 1
                            ? Color(widget.colorVal)
                            : Colors.grey)),
              ),
              Tab(
                child: Text('Hollywood Actor',
                    style: TextStyle(
                        color: _tabController.index == 2
                            ? Color(widget.colorVal)
                            : Colors.grey)),
              ),
              Tab(
                child: Text('Hollywood Actrecess',
                    style: TextStyle(
                        color: _tabController.index == 3
                            ? Color(widget.colorVal)
                            : Colors.grey)),
              ),
              Tab(
                child: Text('Youtubers',
                    style: TextStyle(
                        color: _tabController.index == 4
                            ? Color(widget.colorVal)
                            : Colors.grey)),
              ),
              Tab(
                child: Text('Amar Ujala',
                    style: TextStyle(
                        color: _tabController.index == 5
                            ? Color(widget.colorVal)
                            : Colors.grey)),
              ),
              Tab(
                child: Text('Hindustan',
                    style: TextStyle(
                        color: _tabController.index == 6
                            ? Color(widget.colorVal)
                            : Colors.grey)),
              ),
            ],
          ),
        )),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              height: 200.0,
              child: Center(child: Text('For you')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('TV')),
            ),
             Container(
              height: 200.0,
              child: Center(child: Text('Top Sellings')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Genres')),
            ),
             Container(
              height: 200.0,
              child: Center(child: Text('Genres')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Studio')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Family')),
            ),
          ],
        ),
      ),
    );
  }
}
