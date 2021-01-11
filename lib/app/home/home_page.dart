import 'package:flutter/material.dart';
import 'package:task_planner/app/home/cupertino_home_scaffold.dart';
import 'package:task_planner/app/home/groups/groups_page.dart';
import 'package:task_planner/app/home/planner/planner_page.dart';
import 'package:task_planner/app/home/profile/profile_page.dart';
import 'package:task_planner/app/home/tab_item.dart';
import 'package:task_planner/app/home/tasks/tasks_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.tasks;

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.tasks: (_) => TasksPage(),
      TabItem.groups: (_) => GroupsPage(),
      TabItem.planner: (_) => PlannerPage(),
      TabItem.profile: (_) => ProfilePage(),
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
