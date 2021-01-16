import 'package:http/http.dart' as http;
import 'package:flutter_todo_list_app/Api/const.dart';

class Api {
  //getAllTodo
  static Future getTodos() async {
    try {
      return await http.get(url + 'getAllTodos');
    } catch (e) {
      print(e);
    }
  }

//delete Todo
  static Future deleteTodo(String id) async {
    String json = '{"id" : "$id"}';
    try {
      return await http.post(url + 'deleteTodo',
          body: json, headers: {"Content-type": "application/json"});
    } catch (e) {
      print(e);
    }
  }

//update todo
  static Future updateTodo(String id, bool value) async {
    String json = '{"id" : "$id", "isFinished":"$value"}';
    try {
      return await http.post(url + 'updateTodo',
          body: json, headers: {"Content-type": "application/json"});
    } catch (e) {
      print(e);
    }
  }

//add todo
  static Future addTodo(String title) async {
    String json = '{"title":"$title"}';
    try {
      return await http.post(url + 'addTodo',
          body: json, headers: {"Content-type": "application/json"});
    } catch (e) {
      print(e);
    }
  }
}
