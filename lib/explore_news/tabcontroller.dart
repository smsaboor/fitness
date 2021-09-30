// @dart=2.9
import 'package:flutter/material.dart';

class TabDemo extends StatefulWidget {
  TabDemo();
  _TabDemoState createState() => _TabDemoState();
}
class _TabDemoState extends State<TabDemo> with SingleTickerProviderStateMixin {

  TabController _tabController;

  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);

    _tabController.addListener((){
      if (!_tabController.indexIsChanging){
        setState(() {
          _selectedTab = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tab Demo"),
      ),
      backgroundColor: Colors.white,
      body: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              Material(
                color: Colors.grey.shade300,
                child: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.blue,
                  labelColor: Colors.blue,
                  indicatorColor: Colors.white,
                  controller: _tabController,
                  labelPadding: const EdgeInsets.all(0.0),
                  tabs: [
                    _getTab(0, Icon(Icons.directions_car)),
                    _getTab(1, Icon(Icons.directions_transit)),
                    _getTab(2, Icon(Icons.directions_bike)),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    Icon(Icons.directions_car),
                    Icon(Icons.directions_transit),
                    Icon(Icons.directions_bike),
                  ],
                ),
              ),
            ],
          )),
    );
  }


  _getTab(index, child) {
    return Tab(
      child: SizedBox.expand(
        child: Container(
          child: child,
          decoration: BoxDecoration(
              color:
              (_selectedTab == index ? Colors.white : Colors.grey.shade300),
              borderRadius: _generateBorderRadius(index)),
        ),
      ),
    );
  }

  _generateBorderRadius(index) {
    if ((index + 1) == _selectedTab)
      return BorderRadius.only(bottomRight: Radius.circular(10.0));
    else if ((index - 1) == _selectedTab)
      return BorderRadius.only(bottomLeft: Radius.circular(10.0));
    else
      return BorderRadius.zero;
  }
}