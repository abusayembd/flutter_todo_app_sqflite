import 'package:flutter/material.dart';

import '../service/category_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var todoTitleController = TextEditingController();
  var todoDescriptionController = TextEditingController();
  var todoDateController = TextEditingController();
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
              controller: todoTitleController,
              decoration: const InputDecoration(
                labelText: "Title",
                hintText: "Write Todo Title",
              ),
            ),
            TextField(
              controller: todoDescriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                hintText: "Write Todo Description",
              ),
            ),
            TextField(
              controller: todoDateController,
              decoration: InputDecoration(
                labelText: "Date",
                hintText: "Pick a Date",
                prefixIcon: InkWell(
                  onTap: () {
                    //todo: implement date time picker
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
              onPressed: () {},
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
