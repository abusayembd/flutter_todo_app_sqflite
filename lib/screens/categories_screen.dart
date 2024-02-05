import 'package:flutter/material.dart';
import 'package:flutter_todolist_sqflite_app/screens/home_screen.dart';
import 'package:flutter_todolist_sqflite_app/service/category_service.dart';

import '../models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _categoryNameController = TextEditingController();
  final _categoryDescriptionController = TextEditingController();
  final _editCategoryNameController = TextEditingController();
  final _editCategoryDescriptionController = TextEditingController();
  final _category = Category(name: '', description: '', id: 0);
  final _categoryService = CategoryService();
  var category;

  List<Category> _categoryList = [];

  @override
  void initState() {
    getAllCategory();
    super.initState();
  }
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllCategory() async {
    _categoryList = [];
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        var categoryModel = Category(name: '', description: '', id: 0);
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editCategoryNameController.text = category[0]['name'] ?? 'No Name';
      _editCategoryDescriptionController.text =
          category[0]['description'] ?? 'No Description';
    });
    if (!mounted) return;
    _editFormDialog(context);
  }


  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                //on press close the dialog
                onPressed: () {
                  _categoryNameController.clear();
                  _categoryDescriptionController.clear();
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                onPressed: () async {
                  _category.name = _categoryNameController.text;
                  _category.description = _categoryDescriptionController.text;
                  var result = await _categoryService.saveCategory(_category);
                  if (result > 0) {
                    debugPrint(result.toString());
                    if(!mounted) return;
                    Navigator.of(context, rootNavigator: true).pop();
                    getAllCategory();
                    _showSuccessSnackBar("Saved");
                    _categoryNameController.clear();
                    _categoryDescriptionController.clear();
                  }

                },
                child: const Text("Save"),
              ),
            ],
            title: const Text("Categories Form"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _categoryNameController,
                    decoration: const InputDecoration(
                        labelText: "Write a category", hintText: "category"),
                  ),
                  TextField(
                    controller: _categoryDescriptionController,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      hintText: "Write a description",
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                //on press close the dialog
                onPressed: () {
                  _categoryNameController.clear();
                  _categoryDescriptionController.clear();
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                onPressed: () async {
                  _category.id = category[0]["id"];
                  _category.name = _editCategoryNameController.text;
                  _category.description =
                      _editCategoryDescriptionController.text;
                  var result = await _categoryService.updateCategory(_category);
                  if (result > 0) {
                    debugPrint(result.toString());
                    if(!mounted) return;
                    Navigator.of(context, rootNavigator: true).pop();
                    getAllCategory();
                    _showSuccessSnackBar("Updated");
                  }

                },
                child: const Text("Update"),
              ),
            ],
            title: const Text("Categories Form"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _editCategoryNameController,
                    decoration: const InputDecoration(
                        labelText: "Write a category", hintText: "category"),
                  ),
                  TextField(
                    controller: _editCategoryDescriptionController,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      hintText: "Write a description",
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                //on press close the dialog
                onPressed: () {
                  _categoryNameController.clear();
                  _categoryDescriptionController.clear();
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,textStyle: const TextStyle(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                onPressed: () async {
                  var result = await _categoryService.deleteCategory(categoryId);
                  if (result > 0) {
                    debugPrint(result.toString());
                    if(!mounted) return;
                    Navigator.of(context, rootNavigator: true).pop();
                    getAllCategory();
                    _showSuccessSnackBar("Deleted");
                  }

                },
                child: const Text("Delete"),
              ),
            ],
            title: const Text("Are you sure you want to delete this?"),

          );
        });
  }

  _showSuccessSnackBar(message) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const HomeScreen()));
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: const Text("Categories"),
        ),
        body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _editCategory(context, _categoryList[index].id!);
                    },
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_categoryList[index].name),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red,),
                        onPressed: () {
                          _deleteFormDialog(context, _categoryList[index].id!);
                        },
                      ),
                    ],
                  ),
                  subtitle: Text(_categoryList[index].description),
                ),
              ),
            );
          },),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showFormDialog(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
