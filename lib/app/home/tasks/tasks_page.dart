import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_planner/app/home/builders/item_list_builder.dart';
import 'package:task_planner/app/home/models/tasks.dart';
import 'package:task_planner/app/home/tasks/edit_task_page.dart';
import 'package:task_planner/app/home/tasks/task_list_tile.dart';
import 'package:task_planner/services/database.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  bool _showAddTaskField = false;

  Future<void> _deleteTask(
      BuildContext context, Task task, Database database) async {
    await database.deleteTask(task);
  }

  Widget _buildTaskAdder() {
    if (_showAddTaskField == true) {
      return Container(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Task Name:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              PlatformTextField(),
              SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.only(left: 125, right: 125),
                child: RaisedButton(
                  child: Text("SAVE"),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2.0,
              color: Colors.grey[400],
            ),
          ),
          color: Colors.red[700],
        ),
      );
    }

    return SizedBox.shrink();
  }

  void _showTaskAdder() {
    setState(() => _showAddTaskField = _showAddTaskField ? false : true);
  }

  Widget _buildContents(BuildContext context, Database database) {
    return SafeArea(
      child: Stack(
        children: [
          _buildTaskAdder(),
          StreamBuilder<List<Task>>(
            stream: database.tasksStream(),
            builder: (context, snapshot) {
              return ListItemsBuilder<Task>(
                snapshot: snapshot,
                itemBuilder: (context, task) => Dismissible(
                  key: Key('task-${task.id}'),
                  background: Container(color: Colors.red),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) =>
                      _deleteTask(context, task, database),
                  child: TaskListTile(task: task, onTap: () {}),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text("Tasks"),
        trailingActions: <Widget>[
          PlatformIconButton(
            icon: Icon(
              PlatformIcons(context).addCircled,
            ),
            onPressed: _showTaskAdder,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      body: _buildContents(context, database),
    );
  }
}
