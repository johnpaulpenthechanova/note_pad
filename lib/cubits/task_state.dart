part of 'task_cubit.dart'; 
 
enum TaskStatus { initial, loading, success, error } 
 
class TaskState extends Equatable { 
  final TaskStatus status; 
  final List<Task> tasks; 
  final String? error; 
 
  const TaskState({ 
    required this.status, 
    required this.tasks, 
    this.error, 
  }); 
 
  factory TaskState.initial() => const TaskState( 
    status: TaskStatus.initial, 
    tasks: [], 
  ); 
 
  TaskState copyWith({ 
    TaskStatus? status, 
    List<Task>? tasks, 
    String? error, 
  }) { 
    return TaskState( 
      status: status ?? this.status, 
      tasks: tasks ?? this.tasks, 
      error: error ?? this.error, 
    ); 
  } 
 
  @override 
  List<Object?> get props => [status, tasks, error]; 
} 