import 'package:hive_flutter/hive_flutter.dart'; 
import '../models/task.dart'; 
 
class TaskRepository { 
  static const String _boxName = 'tasks'; 
  late Box<dynamic> _box;
 
  Future<void> init() async { 
    _box = await Hive.openBox<dynamic>(_boxName);
  } 
 
  List<Task> getAllTasks() { 
    return _box.values
        .whereType<Map>()
        .map((dynamic value) {
          try {
            final map = Map<String, dynamic>.from(value as Map);
            return Task.fromJson(map);
          } catch (e) {
            return null;
          }
        })
        .whereType<Task>()
        .toList();
  } 
 
  Future<void> addTask(Task task) async { 
    await _box.put(task.id, task.toJson());
  } 
 
  Future<void> updateTask(Task task) async { 
    await _box.put(task.id, task.toJson());
  } 
 
  Future<void> deleteTask(String id) async { 
    await _box.delete(id); 
  } 
 
  Future<void> clearAll() async { 
    await _box.clear(); 
  } 
} 