import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_planner/app/sign_in/email_sign_in_change_model.dart';
import 'package:task_planner/common_widgets/show_exception_alert_dialog.dart';
import 'package:task_planner/services/auth.dart';

class EmailSignInForm extends StatefulWidget {
  EmailSignInForm({Key key, @required this.model}) : super(key: key);
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, model, __) => EmailSignInForm(model: model),
      ),
    );
  }

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void _emailEditingComplete() {
    final newfocus = widget.model.emailValidator.isValid(widget.model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newfocus);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.model.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: "Sign in Failed",
        exception: e,
      );
    }
  }

  void _toggleForm() {
    widget.model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  void _forgotPassword(BuildContext context) {
    Navigator.of(context).push(
      platformPageRoute(
        context: context,
        fullscreenDialog: true,
        builder: (context) => Container(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    return [
      PlatformText(
        widget.model.formType == EmailSignInFormType.signIn
            ? "Sign in with Email"
            : "Create an account",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 30),
      PlatformText("Email:"),
      SizedBox(height: 3),
      _buildEmailTextField(),
      SizedBox(height: 18),
      PlatformText("Password:"),
      SizedBox(height: 3),
      _buildPasswordTextField(),
      SizedBox(height: 25),
      PlatformButton(
        child: widget.model.formType == EmailSignInFormType.signIn
            ? Text("Continue with Email")
            : Text("Create my account"),
        onPressed: _submit,
        color: Colors.red[700],
      ),
      SizedBox(height: 15),
      SizedBox(
        height: 30,
        child: FlatButton(
          onPressed: !widget.model.isLoading ? _toggleForm : null,
          child: Text(widget.model.secondaryButtonText),
        ),
      ),
      SizedBox(
        height: 30,
        child: FlatButton(
          onPressed: () => _forgotPassword(context),
          child: Text("Forgot your password? Tap here to reset."),
        ),
      ),
    ];
  }

  PlatformTextField _buildPasswordTextField() {
    return PlatformTextField(
      material: (_, __) => MaterialTextFieldData(
        decoration: InputDecoration(
          hintText: "Enter your password",
          errorText: widget.model.passwordErrorText,
          enabled: !widget.model.isLoading,
        ),
      ),
      cupertino: (_, __) => CupertinoTextFieldData(
        placeholder: "Enter your password",
        enabled: !widget.model.isLoading,
      ),
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: (password) => widget.model.updatePassword(password),
    );
  }

  PlatformTextField _buildEmailTextField() {
    return PlatformTextField(
      material: (_, __) => MaterialTextFieldData(
        decoration: InputDecoration(
          hintText: "Enter your email",
          errorText: widget.model.emailErrorText,
          enabled: !widget.model.isLoading,
        ),
      ),
      cupertino: (_, __) => CupertinoTextFieldData(
        placeholder: "Enter your email",
        enabled: !widget.model.isLoading,
      ),
      controller: _emailController,
      autocorrect: false,
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emailEditingComplete(),
      onChanged: (email) => widget.model.updateEmail(email),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        minimum: EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            left: 16,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: _buildChildren(),
          ),
        ),
      ),
    );
  }
}
