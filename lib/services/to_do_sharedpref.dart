import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/models/todo.dart';

class ToDoSharedPref {
  static const String _key = 'todo_list';

  static Future<void> saveToDoList(List<ToDo> todoList) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList =
        todoList.map((todo) => json.encode(todo.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  static Future<List<ToDo>> loadToDoList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(_key);

    if (jsonList != null) {
      try {
        return jsonList.map((jsonStr) {
          final jsonMap = json.decode(jsonStr);
          return ToDo.fromJson(jsonMap);
        }).toList();
      } catch (e) {
        print('Error parsing todo list: $e');
        return [];
      }
    } else {
      return [];
    }
  }

  static Future<void> clearToDoList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
