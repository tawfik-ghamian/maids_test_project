import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';
import 'package:test_maids_project/utils/constants.dart';


class TaskService {

  Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse('${Constants.apiUrl}/tasks'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((data) => Task.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch tasks');
    }
  }

  Future<bool> login({required String email, required String password}) async {
    final response = await http.post(
      Uri.parse('${Constants.apiUrl}/login'),
      body: {'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      // Login successful
      return true;
    } else {
      // Login failed
      return false;
    }
  }
}
