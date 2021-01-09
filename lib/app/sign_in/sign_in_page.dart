import 'package:animated_typing/animated_typing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:task_planner/app/sign_in/email_sign_in_page.dart';
import 'package:task_planner/app/sign_in/sign_in_manager.dart';
import 'package:task_planner/common_widgets/show_exception_alert_dialog.dart';
import 'package:task_planner/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.manager}) : super(key: key);
  final SignInManager manager;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, bloc, __) => SignInPage(manager: bloc),
          ),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseAuthException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    } else {
      showExceptionAlertDialog(
        context,
        title: "Sign in Failed",
        exception: exception,
      );
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manager.signInWithFacebook();
    } catch (e) {
      _showSignInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      platformPageRoute(
        fullscreenDialog: true,
        context: context,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<ValueNotifier<bool>>(context);
    return PlatformScaffold(
      body: _buildContent(context, isLoading.value),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Padding(
      padding: EdgeInsets.only(top: 16, right: 30, left: 30, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50, child: _buildHeader(isLoading)),
          SizedBox(height: 48),
          ShowUpList(
            animationDuration: Duration(milliseconds: 800),
            curve: Curves.bounceIn,
            direction: Direction.vertical,
            offset: 0.5,
            children: _buildChildren(context),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    return <Widget>[
      SizedBox(
        height: 45,
        child: OutlineButton(
          onPressed: () => _signInWithEmail(context),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Icon(
                PlatformIcons(context).mailSolid,
                color: Colors.red[700],
                size: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign in with Email',
                    style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
          highlightedBorderColor: Colors.red,
          borderSide: new BorderSide(color: Colors.red[700]),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0),
          ),
        ),
      ),
      SizedBox(height: 18),
      SizedBox(
        height: 45,
        child: CupertinoButton(
          onPressed: () => null,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              SizedBox(
                height: 25,
                width: 25,
                child: Image.asset('images/google-logo.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sign in with Google",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          color: Colors.white,
          padding: EdgeInsets.only(left: 12),
        ),
      ),
      SizedBox(height: 18),
      SizedBox(
        height: 45,
        child: CupertinoButton(
          onPressed: () => null,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              SizedBox(
                height: 25,
                width: 25,
                child: Image.asset('images/facebook-logo.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sign in with Facebook",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          color: Color(0xff4267B2),
          padding: EdgeInsets.only(left: 12),
        ),
      ),
      SizedBox(height: 40),
      PlatformText(
        "Plan your day.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    ];
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return Center(
        child: PlatformCircularProgressIndicator(),
      );
    } else {
      return Center(
        child: AnimatedTyping(
          text: "Task Planner.",
          duration: Duration(milliseconds: 1000),
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
  }
}
