import 'package:flutter/material.dart';

class EditTaskPageModel with ChangeNotifier {
  EditTaskPageModel({
    this.taskName = '',
    this.isLoading = false,
  });

  String taskName;
  bool isLoading;

  void updateTaskName(String taskName) => updateWith(taskName: taskName);

  void updateIsLoading(bool isLoading) => updateWith(isLoading: isLoading);

  void updateWith({String taskName, bool isLoading}) {
    this.taskName = taskName ?? this.taskName;
    this.isLoading = isLoading ?? this.isLoading;
    notifyListeners();
  }
}
