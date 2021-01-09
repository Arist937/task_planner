import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:task_planner/app/sign_in/email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        cupertino: (_, __) => CupertinoNavigationBarData(
          transitionBetweenRoutes: true,
          actionsForegroundColor: Colors.red[700],
          previousPageTitle: "Sign in Page",
          border: Border(),
        ),
        backgroundColor: Colors.grey[200],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            child: EmailSignInForm.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
