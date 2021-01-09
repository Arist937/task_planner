import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_planner/common_widgets/show_alert_dialog.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context, {
  @required String title,
  @required Exception exception,
}) =>
    showAlertDialogue(
      context,
      title: title,
      content: _message(exception),
      defaultActionText: "OK",
    );

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message;
  } else {
    return exception.toString();
  }
}
