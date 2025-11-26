import 'package:equatable/equatable.dart'; 
import 'package:hive/hive.dart'; 

@HiveType(typeId: 0)
class Task extends Equatable { 
  @HiveField(0) 
  final String id; 
   
  @HiveField(1) 
  final String title; 
   
  @HiveField(2) 
  final bool isCompleted; 
 
  const Task({ 
    required this.id, 
    required this.title, 
    this.isCompleted = false, 
  }); 
 
  Task copyWith({ 
    String? id, 
    String? title, 
    bool? isCompleted, 
  }) { 
    return Task( 
      id: id ?? this.id, 
      title: title ?? this.title, 
      isCompleted: isCompleted ?? this.isCompleted, 
    ); 
  } 
 
  @override 
  List<Object?> get props => [id, title, isCompleted]; 

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }
} 