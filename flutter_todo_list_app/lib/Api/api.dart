import 'package:http/http.dart' as http;
import 'package:flutter_todo_list_app/Api/const.dart';

class Api {
  //getAllTodo
  static Future getTodos() {
    return http.get(url + 'getAllTodos');
  }

//delete Todo
  static Future deleteTodo(String id) {
    String json = '{"id" : "$id"}';

    return http.post(url + 'deleteTodo',
        body: json, headers: {"Content-type": "application/json"});
  }

//update todo
  static Future updateTodo(String id, bool value) {
    String json = '{"id" : "$id", "isFinished":"$value"}';
    return http.post(url + 'updateTodo',
        body: json, headers: {"Content-type": "application/json"});
  }

//add todo
  static Future addTodo(String title) {
    String json = '{"title":"$title"}';
    return http.post(url + 'addTodo',
        body: json, headers: {"Content-type": "application/json"});
  }
}
