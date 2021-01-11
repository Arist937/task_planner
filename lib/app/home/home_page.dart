import 'package:flutter/material.dart';
import 'package:task_planner/app/home/cupertino_home_scaffold.dart';
import 'package:task_planner/app/home/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.tasks;

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.tasks: (_) => Container(),
      TabItem.profile: (_) => Container(),
    };
  }

  void _select(TabItem tabItem) {
    setState(() {
      _currentTab = tabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScaffold(
      currentTab: _currentTab,
      onSelectTab: _select,
      widgetBuilders: widgetBuilders,
    );
  }
}
