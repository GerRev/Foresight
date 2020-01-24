import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foresight_mobile/app/home/tabs.dart';

class CupertinoScaffold extends StatelessWidget {
  const CupertinoScaffold(
      {Key key,
      @required this.currentTab,
      @required this.onSelectTab,
      // @required this.widgetItemBuilders,
      @required this.navKeys,
      @required this.widgetBuilders})
      : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  // final Map<TabItem, WidgetBuilder> widgetItemBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navKeys;
  final Map<TabItem, WidgetBuilder> widgetBuilders;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.teams),
          _buildItem(TabItem.fixtures),
          _buildItem(TabItem.account)
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final item= TabItem.values[index];
        return
          CupertinoTabView(
              builder: (context) => widgetBuilders[item](context));
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabData.allTabs[tabItem];
    final color = currentTab == tabItem ? Colors.red : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
        color: color,
      ),
      title: Text(
        itemData.title,
        style: TextStyle(color: color),
      ),
    );
  }
}
