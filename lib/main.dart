import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MaterialApp(home: TodoApp()));

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  // Хранилище для состояний галочек (выбрано или нет)
  Map<String, bool> checkStates = {};

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int hour = now.hour;
    int month = now.month;
    bool isDay = hour >= 8 && hour < 20;
    bool isWinter = month >= 10 || month <= 4;

    // Списки задач
    List<String> receptionTasks = [
      "РЗА: цепи упр. выкл., опер. ток, табло на ЦС",
      "Сигнализация: проверка ЦС, АУПС и выключателей",
      "Нагрузки: ВЛ 500/220/110 кВ, АТ 1-6, напряжение",
      "Замеры: 3U0 на ТН, ток небаланса ДЗШ, ДЗО, КИВ",
      "ЩСН/ЩПТ: нагрузка ТСН, U на шинах, работа ВУ",
      "АБ: трещины, течи, уровень электролита, отопление",
      "Связь/АСУ ТП: панели, ТМ, АРМ, вентиляция",
      "Общее: СЗ, ключи, регистраторы, документация",
      "Схемы: АРМ, макет ПС, водоснабжение",
    ];

    List<String> periodicTasks = [
      "Осмотр: Панели ЦС, РЗА, АСУТП, ТМ, ЩСН, ЩПТ, ОПУ",
      "Осмотр: ПЖТ, КПЗ, скважины, ЗРП, ЗПП",
      "ФИКСАЦИЯ: Опер. журнал, маршрутная карта, нагрузки",
    ];

    if (isDay) {
      periodicTasks.insert(0, "ОСМОТР: 5АТГ, 6АТГ, 1АТ, 2АТ, 3АТ, 4АТ");
      if (isWinter) periodicTasks.add("ДГУ: Обогрев (зимний период)");
    } else {
      periodicTasks.insert(0, "ОСМОТР: 5АТГ, 6АТГ, 1-4АТ (охлаждение)");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isDay ? "ДНЕВНАЯ СМЕНА" : "НОЧНАЯ СМЕНА"),
        backgroundColor: isDay ? Colors.orange[400] : Colors.indigo[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSection("Приемка-сдача смены", receptionTasks),
            _buildSection("Ежесменные осмотры", periodicTasks),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
        ),
        ...tasks.map((task) => CheckboxListTile(
          title: Text(task, style: const TextStyle(fontSize: 14)),
          value: checkStates[task] ?? false,
          onChanged: (bool? value) {
            setState(() {
              checkStates[task] = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          dense: true,
        )),
        const Divider(),
      ],
    );
  }
}
