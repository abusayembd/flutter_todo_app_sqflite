import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../service/todo_service.dart';

class TodosByCategory extends StatefulWidget {
   TodosByCategory({super.key, required this.category});
  final String category;


  @override
  State<TodosByCategory> createState() => _TodosByCategoryState();
}

class _TodosByCategoryState extends State<TodosByCategory> {
  final List<Todo> _todoList = <Todo>[];
  final TodoService _todoService = TodoService();

  @override
  void initState() {
    super.initState();
    getTodosByCategory();
  }
  getTodosByCategory() async{
    var todos = await _todoService.readTodosByCategory(widget.category);
    todos.forEach((todo) {
      setState(() {
        var model = Todo(
            title: todo['title'],
            description: todo['description'],
            category: todo['category'],
            todoDate: todo['todoDate'],
            isFinished: todo['isFinished']);
        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_todoList[index].title??'No Title'),
                    Text(_todoList[index].todoDate??'No Date'),
                  ],
                ),
                subtitle: Text(_todoList[index].description),
              ),
            ),
          );
        },
      ),
    );
  }
}
