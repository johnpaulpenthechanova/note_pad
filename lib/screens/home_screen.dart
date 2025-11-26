import 'package:flutter/material.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../cubits/task_cubit.dart'; 
 
class HomeScreen extends StatefulWidget { 
  const HomeScreen({super.key}); 
 
  @override 
  State<HomeScreen> createState() => _HomeScreenState(); 
} 
 
class _HomeScreenState extends State<HomeScreen> { 
  final _textController = TextEditingController(); 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: const Text('Tasks'), 
        actions: [ 
          IconButton( 
            icon: const Icon(Icons.delete_sweep), 
            onPressed: () => _showClearDialog(context), 
          ), 
        ], 
      ), 
      body: Column( 
        children: [ 
          Padding( 
            padding: const EdgeInsets.all(16.0), 
            child: Row( 
              children: [ 
                Expanded( 
                  child: TextField( 
                    controller: _textController, 
                    decoration: const InputDecoration( 
                      hintText: 'Enter a new task...', 
                      border: OutlineInputBorder(), 
                    ), 
                    onSubmitted: (value) => _addTask(value), 
                  ), 
                ), 
                const SizedBox(width: 8), 
                FloatingActionButton( 
                  onPressed: () => _addTask(_textController.text), 
                  mini: true, 
                  child: const Icon(Icons.add), 
                ), 
              ], 
            ), 
          ), 
          Expanded( 
            child: BlocBuilder<TaskCubit, TaskState>( 
              builder: (context, state) { 
                if (state.status == TaskStatus.loading) { 
                  return const Center(child: CircularProgressIndicator()); 
                } 
 
                if (state.tasks.isEmpty) { 
                  return const Center( 
                    child: Text('No tasks yet. Add one above!'), 
                  ); 
                } 
 
                return ListView.builder( 
                  itemCount: state.tasks.length, 
                  itemBuilder: (context, index) { 
                    final task = state.tasks[index]; 
                    return ListTile( 
                      leading: Checkbox( 
                        value: task.isCompleted, 
                        onChanged: (_) => context.read<TaskCubit>().toggleTask(task.id), 
                      ), 
                      title: Text( 
                        task.title, 
                        style: TextStyle( 
                          decoration: task.isCompleted 
                              ? TextDecoration.lineThrough 
                              : null, 
                        ), 
                      ), 
                      trailing: IconButton( 
                        icon: const Icon(Icons.delete, color: Colors.red), 
                        onPressed: () => _showDeleteDialog(context, task.id), 
                      ), 
                    ); 
                  }, 
                ); 
              }, 
            ), 
          ), 
        ], 
      ), 
    ); 
  } 
 
  void _addTask(String title) { 
    if (title.trim().isNotEmpty) { 
      context.read<TaskCubit>().addTask(title.trim()); 
      _textController.clear(); 
    } 
  } 
 
  void _showDeleteDialog(BuildContext context, String taskId) { 
    showDialog( 
      context: context, 
      builder: (context) => AlertDialog( 
        title: const Text('Delete Task'), 
        content: const Text('Are you sure you want to delete this task?'), 
        actions: [ 
          TextButton( 
            onPressed: () => Navigator.pop(context), 
            child: const Text('Cancel'), 
          ), 
          TextButton( 
            onPressed: () { 
              Navigator.pop(context); 
              context.read<TaskCubit>().deleteTask(taskId); 
            }, 
            child: const Text('Delete'), 
          ), 
        ], 
      ), 
    ); 
  } 
 
  void _showClearDialog(BuildContext context) { 
    showDialog( 
      context: context, 
      builder: (context) => AlertDialog( 
        title: const Text('Clear All Tasks'), 
        content: const Text('Are you sure you want to delete all tasks?'), 
        actions: [ 
          TextButton( 
            onPressed: () => Navigator.pop(context), 
            child: const Text('Cancel'), 
          ), 
          TextButton( 
            onPressed: () { 
              Navigator.pop(context); 
              context.read<TaskCubit>().clearAllTasks(); 
            }, 
            child: const Text('Clear All'), 
          ), 
        ], 
      ), 
    ); 
  } 
} 