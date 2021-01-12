import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_planner/app/home/models/tasks.dart';
import 'package:task_planner/app/home/tasks/edit_task_page_model.dart';
import 'package:task_planner/services/database.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({Key key, @required this.model, @required this.database})
      : super(key: key);
  final EditTaskPageModel model;
  final Database database;

  static Widget create(BuildContext context, Database database) {
    return ChangeNotifierProvider<EditTaskPageModel>(
      create: (context) => EditTaskPageModel(),
      child: Consumer<EditTaskPageModel>(
        builder: (_, model, __) => EditTaskPage(
          model: model,
          database: database,
        ),
      ),
    );
  }

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  Future<void> _addTask() async {
    print(widget.model.taskName);
    await widget.database.setTask(
      Task(
        name: widget.model.taskName,
        id: widget.model.id ?? documentIdFromCurrentDate(),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText("Add a new task"),
        trailingActions: [FlatButton(onPressed: _addTask, child: Text("Save"))],
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PlatformText(
                    "Task Name:",
                    textAlign: TextAlign.left,
                  ),
                  PlatformTextField(
                    onChanged: (value) => widget.model.updateTaskName(value),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
