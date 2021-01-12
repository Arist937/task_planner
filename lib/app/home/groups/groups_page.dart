import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_planner/app/home/builders/item_list_builder.dart';
import 'package:task_planner/app/home/models/tasks.dart';
import 'package:task_planner/app/home/tasks/task_list_tile.dart';
import 'package:task_planner/services/database.dart';

class GroupsPage extends StatelessWidget {
  _deleteTask(BuildContext context, Task job) {}

  void _addTask() {}

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Task>>(
      stream: database.tasksStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Task>(
          snapshot: snapshot,
          itemBuilder: (context, task) => Dismissible(
            key: Key('task-${task.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _deleteTask(context, task),
            child: TaskListTile(
              task: task,
              onTap: () {},
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text("Groups"),
        trailingActions: <Widget>[
          PlatformIconButton(
            icon: Icon(PlatformIcons(context).addCircled),
            onPressed: _addTask,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      body: _buildContents(context),
    );
  }
}
