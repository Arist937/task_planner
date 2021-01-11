import 'package:flutter/foundation.dart';

class Group {
  Group({
    @required this.id,
    @required this.name,
  });

  final String id;
  final String name;

  factory Group.fromMap(Map<String, String> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];

    return Group(
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
