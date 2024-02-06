import 'package:flutter_todolist_sqflite_app/repositories/repository.dart';

import '../models/todo.dart';

class TodoService{
  late Repository _repository;

  TodoService(){
    _repository = Repository();
  }

  saveTodo(Todo todo) async {
    return await _repository.insertData('todos', todo.todoMap());
  }

  readTodos() async {
    return await _repository.readData('todos');
  }

  readTodosByCategory(category) async {
    return await _repository.readDataByColumnName('todos','category', category);
  }


}