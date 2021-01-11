import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_planner/app/landing_page.dart';
import 'package:task_planner/services/auth.dart';

// need to make function async to use 'await'
Future<void> main() async {
  // required for initializing plugins
  WidgetsFlutterBinding.ensureInitialized();
  // program waits for firebase to finish initializing
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: PlatformApp(
        title: 'Task Planner',
        material: (context, __) => MaterialAppData(
          theme: ThemeData(
            primarySwatch: Colors.white,
          ),
        ),
        cupertino: (context, __) => CupertinoAppData(
          theme: CupertinoThemeData(
            primaryColor: Colors.red[700],
          ),
        ),
        home: LandingPage(),
      ),
    );
  }
}
