import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('ru_RU', null);
  runApp(const MaterialApp(home: TodoApp()));
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  Map<String, bool> checkStates = {};

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int hour = now.hour;
    int month = now.month;
    String dayName = DateFormat('EEEE', 'ru_RU').format(now).toLowerCase();
    
    bool isDay = hour >= 8 && hour < 20;
    bool isWinter = month >= 10 || month <= 4;

    // Группы дней
    List<String> group1Days = ["понедельник", "среда", "пятница", "воскресенье"];
    bool isGroup1 = group1Days.contains(dayName);

    String shiftTitle = isDay ? "ДНЕВНАЯ СМЕНА" : "НОЧНАЯ СМЕНА";
    String seasonInfo = isWinter ? "ОЗП (ЗИМА)" : "ЛЕТО";
    String dateInfo = DateFormat('dd.MM (EEEE)', 'ru_RU').format(now);

    // 1. ПРИЕМКА-СДАЧА СМЕНЫ (Обязательно всегда)
    List<String> receptionTasks = [
      "РЗА: сигнализация исправности цепей управления выключателями",
      "РЗА: исправность и наличие опертока на защитах",
      "РЗА: введенное положение устройств РЗА - отсутствие горящих табло на ЦС",
      "РЗА: исправность аварийной, предупредительной, световой сигнализации на ЦС",
      "РЗА: исправность сигнализации положения выключателей",
      "контроль нагрузки: ВЛ 500/220/110; 1/2/3/4АТ, 5/6АТГ", 
      "РЗА: контроль напряжения 500/220/110/10/0,4кВ",
      "РЗА: исправность 3U0 на ТН-500/220/110; замер небаланса ДЗШ-220/110, ДЗО-500 5/6АТГ, КИВ-500 5/6АТГ",
      "осмотр АУПС на отсутствие неисправности, сработавших табло на пультах АУПС"

    ];

    // 2. СУТОЧНЫЕ ОСМОТРЫ (Раз в сутки)
    List<String> dailyTasks = [];
    if (isDay) {
      if (isGroup1) {
        // Пн, Ср, Пт, Вс
        dailyTasks.addAll([
          "ДЭМ: 5-6АТГ, 4-6ТСН (уровни масла и давление)",
          "ДЭМ: 1 скважина, 2ПЖТ, 2КПЗ, ЗРП, 2ЩСН, ЗРУ-10, 3ПП, контейнеры АСУ ОТ",
          "ДИП: ОРУ-500 (масло, элегаз), 2 скважина"
        ]);
      } else {
        // Вт, Чт, Сб
        dailyTasks.addAll([
          "ДЭМ: ОРУ-220, 1-2ТСН (масло, элегаз), КПП, гараж, 1КПЗ, 3КПЗ, 1ПЖТ",
          "ДИП: 1-4АТ, ОРУ-110 (масло, элегаз)",
          "ДИП: ЗРУ-10 База, КРУН-10 1-2АТ, 1-2КТП"
        ]);
      }
    } else {
      // Ночные суточные
      dailyTasks.addAll([
        "Наружное освещение ОРУ, кабельный полуэтаж",
        "Проверка состояния эвакуационных выходов"
      ]);
    }

    // 3. ЕЖЕСМЕННЫЕ ОСМОТРЫ
    List<String> periodicTasks = [
      "Панели управления, ЦС, РЗА, АСУТП, ТМ, ТС, учета",
      "1ЩСН, 1АБ, 2АБ, ЩПТ, помещения ОПУ",
      "1-2ПЖТ, 1-3КПЗ, 1-2 скважины, 2ЩСН, ЗРП, ЗПП"
    ];

    if (isDay) {
      periodicTasks.insert(0, "ОСМОТР АТ: 5-6АТГ, 1-4АТ");
      if (isWinter) periodicTasks.add("ДГУ: контроль работы обогрева");
    } else {
      periodicTasks.insert(0, "ОСМОТР АТ: 5-6АТГ, 1-4АТ (охлаждение)");
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(shiftTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("$seasonInfo | $dateInfo", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
          ],
        ),
        backgroundColor: isDay ? Colors.orange : Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSection("Приемка-сдача смены", receptionTasks),
            _buildSection("Суточные осмотры (по графику)", dailyTasks),
            _buildSection("Ежесменные осмотры", periodicTasks),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> tasks) {
    if (tasks.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
        ),
        ...tasks.map((task) => CheckboxListTile(
          title: Text(task, style: const TextStyle(fontSize: 13)),
          value: checkStates[task] ?? false,
          onChanged: (val) => setState(() => checkStates[task] = val!),
          controlAffinity: ListTileControlAffinity.leading,
          dense: true,
        )),
        const Divider(),
      ],
    );
  }
}
