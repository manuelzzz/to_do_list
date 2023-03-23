import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'package:todo_list/app/modules/home/widgets/home_confirm_task_delete.dart';

class Task extends StatefulWidget {
  final TaskModel model;

  const Task({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final dateFormat = DateFormat('dd/MM/y');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.grey)]),
      child: IntrinsicHeight(
        child: ListTile(
          onTap: () {},
          leading: Checkbox(
            value: widget.model.finished,
            onChanged: (value) {
              context.read<HomeController>().checkOrUncheckTask(widget.model);
            },
          ),
          subtitle: Text(
            widget.model.description,
            style: TextStyle(
              decoration:
                  widget.model.finished ? TextDecoration.lineThrough : null,
              fontSize: 16,
            ),
          ),
          title: Text(
            dateFormat.format(widget.model.dateTime),
            style: TextStyle(
              decoration:
                  widget.model.finished ? TextDecoration.lineThrough : null,
              fontSize: 14,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              HomeConfirmTaskDelete.confirm = false;
              await HomeConfirmTaskDelete.cancelDialog(
                context: context,
              );


              if (HomeConfirmTaskDelete.confirm) {
                if (mounted) {
                  context.read<HomeController>().delete(task: widget.model);
                }
              }
            },
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
