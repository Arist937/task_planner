import 'package:flutter/material.dart';

enum TabItem { tasks, profile }

class TabItemData {
  TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

  static Map<TabItem, TabItemData> allTabs = {
    TabItem.tasks: TabItemData(title: 'Tasks', icon: Icons.work),
    TabItem.profile: TabItemData(title: 'Profile', icon: Icons.person),
  };
}
