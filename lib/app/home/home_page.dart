import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foresight_mobile/app/home/tabs.dart';
import 'package:foresight_mobile/app/home/team_supporters/supporters.dart';
import 'package:foresight_mobile/app/home/users/users.dart';
import 'package:foresight_mobile/app/home/teams/team_page.dart';

import 'cupertino_scaffold.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.teams;
  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      currentTab: _currentTab,
      onSelectTab:  _select,
      widgetBuilders: widgetBuilders,
    );
  }
  void _select(TabItem tabItem) {
      setState(() => _currentTab = tabItem);
  }

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.teams: (_) => TeamPage(),
      TabItem.fixtures: (_) => Fixtures(),
      TabItem.account: (_)  =>  Supporters()//AccountPage(),
    };
  }
}





