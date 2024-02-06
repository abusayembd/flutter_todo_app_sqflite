import 'package:flutter/material.dart';
import 'package:flutter_todolist_sqflite_app/models/todo.dart';
import 'package:intl/intl.dart';

import '../service/category_service.dart';
import '../service/todo_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _todoTitleController = TextEditingController();
  final _todoDescriptionController = TextEditingController();
  final _todoDateController = TextEditingController();
  var _selectedValue;

  final _categories = <DropdownMenuItem<String>>[];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          value: category['name'],
          child: Text(category['name']),
        ));
      });
    });
  }

  DateTime _dateTime = DateTime.now();

  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        _todoDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }

  _showSuccessSnackBar(message) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _todoTitleController,
              decoration: const InputDecoration(
                labelText: "Title",
                hintText: "Write Todo Title",
              ),
            ),
            TextField(
              controller: _todoDescriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                hintText: "Write Todo Description",
              ),
            ),
            TextField(
              controller: _todoDateController,
              decoration: InputDecoration(
                labelText: "Date",
                hintText: "Pick a Date",
                prefixIcon: InkWell(
                  onTap: () {
                    _selectedTodoDate(context);
                  },
                  child: const Icon(Icons.calendar_today),
                ),
              ),
            ),
            DropdownButtonFormField(
              items: _categories,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
              value: _selectedValue,
              hint: const Text("Category"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              onPressed: () async {
                var _todoObject = Todo(
                    title: _todoTitleController.text,
                    description: _todoDescriptionController.text,
                    category: _selectedValue.toString(),
                    todoDate: _todoDateController.text,
                    isFinished: 0);
                var _todoService = TodoService();
                var result = await _todoService.saveTodo(_todoObject);
                debugPrint(result.toString());

                if (result > 0) {
                  _showSuccessSnackBar("Todo Added");
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
