import 'package:flutter/material.dart';
import 'package:flutter_todolist_sqflite_app/helpers/drawer_navigation.dart';
import 'package:flutter_todolist_sqflite_app/models/todo.dart';
import 'package:flutter_todolist_sqflite_app/screens/todo_screen.dart';
import 'package:flutter_todolist_sqflite_app/service/todo_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TodoService _todoService = TodoService();
  List<Todo> _todoList = <Todo>[];

  @override
  void initState() {
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
    _todoList = <Todo>[];
    var todos = await _todoService.readTodos();
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
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Todolist Sqflite"),
          ),
          drawer: const DrawerNavigation(),
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
                        Text(_todoList[index].title ?? 'No Title'),
                      ],
                    ),
                    subtitle: Text(_todoList[index].category ?? 'No Category'),
                    trailing: Text(_todoList[index].todoDate ?? 'No Date'),
                  ),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TodoScreen(),
              ),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
