import 'package:meta/meta.dart';
import 'package:task_planner/app/home/models/tasks.dart';
import 'package:task_planner/services/api_path.dart';
import 'package:task_planner/services/firestore_service.dart';

abstract class Database {
  Future<void> setTask(Task task);
  Future<void> deleteTask(Task task);
  Stream<List<Task>> tasksStream();
  Stream<Task> taskStream({@required String jobId});
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> setTask(Task job) => _service.setData(
        path: APIPath.job(uid, job.id),
        data: job.toMap(),
      );

  @override
  Future<void> deleteTask(Task job) async {
    // delete job
    await _service.deleteData(path: APIPath.job(uid, job.id));
  }

  @override
  Stream<List<Task>> tasksStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data, documentId) => Task.fromMap(data, documentId),
      );

  @override
  Stream<Task> taskStream({@required String jobId}) => _service.documentStream(
        path: APIPath.job(uid, jobId),
        builder: (data, documentId) => Task.fromMap(data, documentId),
      );
}
