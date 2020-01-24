import 'package:flutter/material.dart';

enum TabItem { teams, fixtures, account }

class TabData {
  const TabData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

  static const Map<TabItem, TabData> allTabs = {
    TabItem.teams: TabData(title: 'Teams', icon: Icons.people),
    TabItem.fixtures: TabData(title: 'Users', icon: Icons.supervised_user_circle),
    TabItem.account: TabData(title: 'Subscribed', icon: Icons.favorite),
  };
}