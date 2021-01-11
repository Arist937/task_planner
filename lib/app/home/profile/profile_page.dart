import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_planner/common_widgets/show_alert_dialog.dart';
import 'package:task_planner/services/auth.dart';

class ProfilePage extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialogue(
      context,
      title: "Logout",
      content: "Are you sure that you want to log out?",
      cancelActionText: "Cancel",
      defaultActionText: "Logout",
    );
    if (didRequestSignOut == true) {
      _logout(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text("Profile"),
        trailingActions: [
          FlatButton(
            onPressed: () => _confirmSignOut(context),
            child: Text("Logout"),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
