import 'package:flutter/material.dart';

class EditTaskPageModel with ChangeNotifier {
  EditTaskPageModel({
    this.taskName = '',
    this.id,
    this.isLoading = false,
  });

  String taskName;
  String id;
  bool isLoading;

  void updateTaskName(String taskName) => updateWith(taskName: taskName);

  void updateIsLoading(bool isLoading) => updateWith(isLoading: isLoading);

  void updateWith({String taskName, String id, bool isLoading}) {
    this.id = id ?? this.id;
    this.taskName = taskName ?? this.taskName;
    this.isLoading = isLoading ?? this.isLoading;
    notifyListeners();
  }
}
