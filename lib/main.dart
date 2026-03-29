import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MaterialApp(home: TodoLogic()));

class TodoLogic extends StatelessWidget {
  const TodoLogic({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int hour = now.hour;
    String day = DateFormat('EEEE').format(now); // Monday, Tuesday...
    bool isDay = hour >= 8 && hour < 20;

    // Группируем задачи по категориям
    List<String> tasks = [];

    // 1. ПОСТОЯННЫЕ ЗАДАЧИ (каждый день, любая смена)
    tasks.addAll([
      "Осмотр: Панели управления, ЦС, РЗА, АСУТП, ТМ, ТС, учета",
      "Осмотр: 1ЩСН, 1АБ, 2АБ, ЩПТ, помещения ОПУ",
      "Осмотр: 1ПЖТ, 2ПЖТ, 1КПЗ, 2КПЗ, 3КПЗ",
      "Осмотр: 1 и 2 скважины, 2ЩСН, ЗРП, ЗПП",
    ]);

    // 2. ЗАДАЧИ ПО СМЕНАМ (День/Ночь)
    if (isDay) {
      tasks.add("ДНЕВНОЙ ОСМОТР: 5АТГ, 6АТГ, 1АТ, 2АТ, 3АТ, 4АТ + ДГУ");
    } else {
      tasks.add("НОЧНОЙ ОСМОТР: Контроль охлаждения 5АТГ, 6АТГ, 1-4АТ");
    }

    // 3. МЕСТО ДЛЯ БУДУЩИХ ЗАДАЧ ПО ДНЯМ НЕДЕЛИ
    if (day == 'Monday') {
      // Тут добавим задачи только для понедельника
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isDay ? "ДЕНЬ: Приемка/Осмотр" : "НОЧЬ: Приемка/Осмотр"),
        backgroundColor: isDay ? Colors.orange[300] : Colors.blueGrey[800],
      ),
      body: ListView.separated(
        itemCount: tasks.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(tasks[index], style: const TextStyle(fontSize: 13)),
            value: false,
            onChanged: (val) {},
          );
        },
      ),
    );
  }
}
