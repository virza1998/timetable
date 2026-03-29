import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MaterialApp(home: TodoApp()));

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  // Хранилище для состояний галочек
  Map<String, bool> checkStates = {};

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int hour = now.hour;
    int month = now.month;
    
    // Определяем смену и сезон
    bool isDay = hour >= 8 && hour < 20;
    bool isWinter = month >= 10 || month <= 4;

    // Списки задач: Приемка-сдача смены
    List<String> receptionTasks = [
      "сигнализация исправности цепей управления выключателями",
      "исправность и наличие опертока на защитах",
      "введенное положение устройств РЗА - отсутствие табло на ЦС",
      "исправность аварийной, предупредительной и световой сигнализации на ЦС",
      "исправность сигнализации положения выключателей",
      "контроль нагрузки: ВЛ 500, 220, 110; 1АТ, 2АТ, 3АТ, 4АТ, 5-6АТГ; напряжение 500/220/110/10/0,4кВ",
      "исправность  3U0 на ТН-500, ТН-220, ТН-110",
      "замер тока небаланса ДЗШ-110, ДЗШ-220, ДЗО-500, КИВ-500 5-6АТГ",
      "осмотр АУПС на отсутствие неисправностей и сигналов на пультах",
      "ЩСН: уровни напряжения, нагрузка 1, 2, 4, 5, 6 ТСН",
      "ЩПТ: значения U на шинах всех источников опертока",
      "ЩПТ: замер сопротивления изоляции цепей I, I подзаряда 1-2АБ и блокировки",
      "АБ: отсутствие трещин, течей на банках 1-2АБ и уровень электролита",
      "АБ: температура и освещение в помещении 1-2АБ",
      "АБ: напряжение на вводах 1-2АБ",
      "АБ: проверка отопления в 1-2АБ (в период ОЗП)",
      "Связь, АСУТП, АРМ, ТМ: осмотр панелей, проверка климата и каналов связи",
      "Общая часть: проверка СЗ, инвентаря, ключей, регистраторов, аптечки",
      "Проверить и принять оперативную документацию",
      "Проверка схем: АРМ, макет ПС, водоснабжение и пожаротушение"
    ];

    // Ежесменные осмотры
    List<String> periodicTasks = [
      "Панели управления, ЦС, РЗА, АСУТП, ТМ, ТС, учета",
      "1ЩСН, 1АБ, 2АБ, ЩПТ, помещения ОПУ",
      "1-2ПЖТ, 1-3КПЗ, 1-2 скважины, 2ЩСН, ЗРП, ЗПП"
    ];

    // Добавляем специфические задачи по времени и сезону
    if (isDay) {
      periodicTasks.insert(0, "ОСМОТР: 5АТГ, 6АТГ, 1АТ, 2АТ, 3АТ, 4АТ");
      if (isWinter) periodicTasks.add("ДГУ: контроль работы обогрев. устройств");
    } else {
      periodicTasks.insert(0, "ОСМОТР: 5-6АТГ, 1-4АТ (контроль работы охлаждения)");
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
