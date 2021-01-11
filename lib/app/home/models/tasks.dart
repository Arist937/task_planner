import 'package:flutter/foundation.dart';

class Task {
  Task({
    @required this.id,
    @required this.name,
  });

  final String id;
  final String name;

  factory Task.fromMap(Map<String, String> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];

    return Task(
      id: documentId,
      name: name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
