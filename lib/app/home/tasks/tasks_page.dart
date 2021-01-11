import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_planner/app/home/builders/item_list_builder.dart';
import 'package:task_planner/app/home/models/tasks.dart';
import 'package:task_planner/app/home/tasks/edit_task_page.dart';
import 'package:task_planner/app/home/tasks/task_list_tile.dart';
import 'package:task_planner/services/database.dart';

class TasksPage extends StatelessWidget {
  _deleteTask(BuildContext context, Task job) {}

  Widget _buildContents(BuildContext context, Database database) {
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
              onTap: () => Navigator.of(context).push(
                platformPageRoute(
                  context: context,
                  builder: (context) => EditTaskPage.create(context, database),
                ),
              ),
            ),
          ),
        );
      },
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
            icon: Icon(PlatformIcons(context).addCircled),
            onPressed: () => Navigator.of(context).push(
              platformPageRoute(
                context: context,
                builder: (context) => EditTaskPage.create(context, database),
              ),
            ),
          ),
        ],
      ),
      body: _buildContents(context, database),
    );
  }
}
