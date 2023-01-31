import 'package:flutter/material.dart';
import 'package:task_list/repositories/task_repository.dart';

import 'package:task_list/widgets/task_list_item.dart';
import 'package:task_list/models/task_model.dart';

class TaskListPage extends StatefulWidget {
  TaskListPage({Key? key}) : super(key: key);

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final TextEditingController taskController = TextEditingController();
  final TaskRepository taskRepository = TaskRepository();

  List<Task> taskList = [];
  Task? deletedTask;
  int? deletedTaskPos;
  String? errorText;

  @override
  void initState(){
    super.initState();
    taskRepository.getTaskList().then((value) {
      setState(() {
        taskList =  value;
      });
    });

  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      //onChanged: onChanged,
                      //onSubmitted: onSubmitted,
                      controller: taskController,
                      decoration: InputDecoration(
                        errorText: errorText,
                        labelText: "Adicione uma tarefa",
                        hintText: "Exemplo: Estudar Flutter",
                        border: OutlineInputBorder(),
                        //errorText: "campo obrigatório",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: add,
                    style: ElevatedButton.styleFrom(
                        primary: Colors.purple, padding: EdgeInsets.all(12)),
                    child: Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Flexible(
                child: ListView(
                  //shrinkWrap: true,
                  children: [
                    for (Task task in taskList)
                      TaskListItem(task: task, onDelete: onDelete),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: Text(
                          "Você possui ${taskList.length} tarefa(s) pendente(s)")),
                  ElevatedButton(
                      onPressed: showDeleteTasksConfirmationDialog,
                      child: Text("Limpar Tudo"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onDelete(Task task) {
    deletedTask = task;
    deletedTaskPos = taskList.indexOf(task);
    setState(() {
      taskList.remove(task);
    });
    taskRepository.saveTaskList(taskList);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 5),
      content: Text("Tarefa ${task.title} removida com sucesso!"),
      backgroundColor: Colors.white12,
      action: SnackBarAction(
        label: "Desfazer",
        onPressed: () {
          setState(() {
            taskList.insert(deletedTaskPos!, deletedTask!);
          });
        },
      ),
    ));
  }

  void add() {
    String text = taskController.text;

    if(text.isEmpty){
      setState(() {
        errorText = "O título não pode estar vazio";
      });
          return;
    }
    Task newTask = Task(title: text, dateTime: DateTime.now());
    setState(() {
      taskList.add(newTask);
      errorText= null;
    });
    taskController.clear();
    taskRepository.saveTaskList(taskList);
      }

  void showDeleteTasksConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Limpar Tudo?"),
        content: Text("Tem certeza que deseja APAGAR TUDO?"),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Cancelar")),
          TextButton(onPressed: (){
            Navigator.of(context).pop();
            deleteAllTasks();
          },
              style:TextButton.styleFrom(primary: Colors.red),
              child: Text("Limpar tudo")),
        ],
      ),
    );
  }

  void deleteAllTasks(){
    setState(() {
      taskList.clear();
    });
    taskRepository.saveTaskList(taskList);
  }
}

void onChanged(String text) {
  print(text);
}

void onSubmitted(String text) {
  print(text);
}

