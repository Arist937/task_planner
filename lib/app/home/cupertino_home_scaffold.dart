import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_planner/app/home/tab_item.dart';
import 'package:task_planner/services/auth.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
    @required this.widgetBuilders,
  }) : super(key: key);

  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  void _logout(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    auth.signOut();
  }

  BottomNavigationBarItem _buildCupertinoTabItem(TabItem tabItem) {
    final TabItemData item = TabItemData.allTabs[tabItem];
    return BottomNavigationBarItem(
      label: item.title,
      icon: Icon(item.icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('${TabItemData.allTabs[currentTab].title} Page'),
        trailingActions: [
          FlatButton(
            onPressed: () => _logout(context),
            child: Text("Logout"),
          )
        ],
      ),
      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            _buildCupertinoTabItem(TabItem.tasks),
            _buildCupertinoTabItem(TabItem.profile),
          ],
        ),
        tabBuilder: (context, index) {
          final item = TabItem.values[index];

          return CupertinoTabView(
            builder: (context) => widgetBuilders[item](context),
          );
        },
      ),
    );
  }
}
