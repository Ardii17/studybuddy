import 'dart:convert';
import 'package:http/http.dart' as http;
import '../object/class.dart';

class ClassService {
  static const String baseUrl = 'https://ppb-project.vercel.app/api/classes';

  // Create a new class
  static Future<Class?> createClass(Class classItem) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(classItem.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        classItem.id = responseBody['id'];
        return classItem;
      }
      return null;
    } catch (e) {
      print('Error creating class: $e');
      return null;
    }
  }

  // Get all classes
  static Future<List<Class>> getAllClasses() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((dynamic item) => Class.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching classes: $e');
      return [];
    }
  }

  // Get class by ID
  static Future<Class?> getClassById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        return Class.fromJson(json.decode(response.body));
      }
      return null;
    } catch (e) {
      print('Error fetching class: $e');
      return null;
    }
  }

  // Get class by ID
  static Future<List<Class>> getClassesByDay(String day) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/day/$day'));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((dynamic item) => Class.fromJson(item)).toList();
      } else {
        print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
      return [];
    } catch (e) {
      print('Error fetching class: $e');
      return [];
    }
  }


  // Update a class
  static Future<bool> updateClass(Class classItem) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${classItem.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(classItem.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error updating class: $e');
      return false;
    }
  }

  // Delete a class
  static Future<bool> deleteClass(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting class: $e');
      return false;
    }
  }
}