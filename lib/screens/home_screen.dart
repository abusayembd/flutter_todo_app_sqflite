import 'package:flutter/material.dart';
import 'package:flutter_todolist_sqflite_app/helpers/drawer_navigation.dart';
import 'package:flutter_todolist_sqflite_app/screens/todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Todolist Sqflite"),
        ),
        drawer: const DrawerNavigation(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TodoScreen(),
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    ));
  }
}
