import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'package:task_list/models/task_model.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({Key? key, required this.task, required this.onDelete}) : super(key: key);

  final Task task;
  final Function(Task) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(),
          extentRatio: 0.5, //limita o tamanho da caixa do "deletar" ??
          children: [
          SlidableAction(
        flex: 5,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: EdgeInsets.zero,
        icon: Icons.delete,
                label: 'Delete', onPressed: (BuildContext context) { onDelete(task); },
          ),
            SlidableAction(onPressed: null,
              flex: 5,
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              padding: EdgeInsets.zero,
              icon: Icons.edit,
              label: 'Editar',)
        ],),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.black12,),
          padding: const EdgeInsets.all(10),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(DateFormat('dd/MM/yyyy - HH:mm ').format(task.dateTime), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
          Text(task.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500 ),),
        ],

          ),
        )
      ),
    );
  }
}

DoNothing(){}
