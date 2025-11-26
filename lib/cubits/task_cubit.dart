import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:equatable/equatable.dart'; 
import '../models/task.dart'; 
import '../repositories/task_repository.dart'; 
 
part 'task_state.dart'; 
 
class TaskCubit extends Cubit<TaskState> { 
  final TaskRepository _repository; 
 
  TaskCubit(this._repository) : super(TaskState.initial()) { 
    _loadTasks(); 
  } 
 
  Future<void> _loadTasks() async { 
    emit(state.copyWith(status: TaskStatus.loading)); 
    try { 
      final tasks = _repository.getAllTasks(); 
      emit(state.copyWith( 
        status: TaskStatus.success, 
        tasks: tasks, 
      )); 
    } catch (e) { 
      emit(state.copyWith( 
        status: TaskStatus.error, 
        error: e.toString(), 
      )); 
    } 
  } 
 
  Future<void> addTask(String title) async { 
    final task = Task(id: DateTime.now().millisecondsSinceEpoch.toString(), title: title); 
    await _repository.addTask(task); 
    final updatedTasks = _repository.getAllTasks(); 
    emit(state.copyWith(tasks: updatedTasks)); 
  } 
 
  Future<void> toggleTask(String id) async { 
    final currentTasks = [...state.tasks]; 
    final taskIndex = currentTasks.indexWhere((task) => task.id == id); 
     
    if (taskIndex != -1) { 
      final updatedTask = currentTasks[taskIndex].copyWith( 
        isCompleted: !currentTasks[taskIndex].isCompleted, 
      ); 
      currentTasks[taskIndex] = updatedTask; 
       
      await _repository.updateTask(updatedTask); 
      emit(state.copyWith(tasks: currentTasks)); 
    } 
  } 
 
  Future<void> deleteTask(String id) async { 
    await _repository.deleteTask(id); 
    final updatedTasks = _repository.getAllTasks(); 
    emit(state.copyWith(tasks: updatedTasks)); 
  } 

  Future<void> clearAllTasks() async { 
    await _repository.clearAll(); 
    emit(state.copyWith(tasks: [])); 
  } 
} 