import 'package:flutter/material.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:hive_flutter/hive_flutter.dart'; 
import 'cubits/task_cubit.dart'; 
import 'repositories/task_repository.dart'; 
import 'screens/home_screen.dart'; 
 
void main() async { 
  WidgetsFlutterBinding.ensureInitialized(); 
  await Hive.initFlutter(); 
   
  final repository = TaskRepository(); 
  await repository.init(); 
   
  runApp(MyApp(repository: repository)); 
} 
 
class MyApp extends StatelessWidget { 
  final TaskRepository repository; 
 
  const MyApp({super.key, required this.repository}); 
 
  @override 
  Widget build(BuildContext context) { 
    return BlocProvider( 
      create: (context) => TaskCubit(repository), 
      child: MaterialApp( 
        title: 'Task Manager', 
        theme: ThemeData(primarySwatch: Colors.blue), 
        home: const HomeScreen(), 
      ), 
    ); 
  } 
} 