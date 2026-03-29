import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Мои дела')),
        body: const TodoLogic(),
      ),
    );
  }
}

class TodoLogic extends StatelessWidget {
  const TodoLogic({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем текущее время и день недели
    DateTime now = DateTime.now();
    int hour = now.hour;
    String dayOfWeek = DateFormat('EEEE').format(now); // Например: Monday

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Сегодня: $dayOfWeek'),
          Text('Время: $hour:00'),
          const SizedBox(height: 20),
          const Text('Список дел появится здесь...'),
        ],
      ),
    );
  }
}
