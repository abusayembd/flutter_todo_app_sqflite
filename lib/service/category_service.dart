import 'package:flutter_todolist_sqflite_app/repositories/repository.dart';

import '../models/category.dart';

class CategoryService {
  late Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  saveCategory(Category category) async {
    return await _repository.insertData('categories', category.categoryMap());

  }

  readCategories() async {
    return await _repository.readData('categories');
  }

  // Read a category by its ID
  readCategoryById(categoryId) {
    return _repository.readDataById('categories', categoryId);
  }

  // Update data from table
  updateCategory(Category category) async {
    return await _repository.updateData('categories', category.categoryMap());
  }

  // Delete data from table
  deleteCategory( categoryId) {
    return _repository.deleteData('categories', categoryId);
  }
}
