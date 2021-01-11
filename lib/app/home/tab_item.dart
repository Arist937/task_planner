import 'package:flutter/material.dart';

enum TabItem { tasks, groups, planner, profile }

class TabItemData {
  TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

  static Map<TabItem, TabItemData> allTabs = {
    TabItem.tasks: TabItemData(title: 'Tasks', icon: Icons.check_box_outlined),
    TabItem.groups: TabItemData(title: 'Groups', icon: Icons.topic_outlined),
    TabItem.planner: TabItemData(title: 'Planner', icon: Icons.calendar_today),
    TabItem.profile: TabItemData(title: 'Profile', icon: Icons.person),
  };
}
