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
      "сигнализация исправности цепей управления выключателями",
      "исправность и наличие опертока на защитах",
      "введенное положение устройств РЗА - отсутствуют горящие табло на ЦС",
      "проверить исправность аварийной и предупредительной сигнализации, световой сигнализации на ЦС",
      "исправность сигнализации положения выключателей",
      "проконтролировать нагрузки ВЛ 500, 220, 110, 5АТГ, 6АТГ, 1АТ, 2АТ, 3АТ, 4АТ, величину напряжения 500, 220, 110, 10, 0,4кВ",
      "исправность цепей 3U0 на ТН-500, ТН-220, ТН-110",
      "замер тока небаланса ДЗШ-110, ДЗШ-220, ДЗО-500, КИВ-500 5АТГ, КИВ-500 6АТГ",
      "осмотр АУПС на отсутствие неисправностей и сработавших световых табло на пультах АУПС",
      "ЩСН: уровни напряжения, нагрузка 1ТСН, 2ТСН, 4ТСН, 5ТСН, 6ТСН",
      "ЩПТ: значения U на шинах оперативного тока всех источников постоянного опертока",
      "ЩПТ: по приборам замерить сопротивление изоляции цепей оперативного постоянного I, I подзаряда 1АБ, 2АБ; замер сопротивления изоляции в цепях оперативной блокировки",
      "АБ: отсутствие трещин и течей на банках 1АБ, 2АБ и уровень электролита в них",
      "АБ: температура и освещение в помещении 1АБ, 2АБ",
      "АБ: напряжение на вводах 1АБ, 2АБ",
      "АБ: проверка отопления в 1АБ, 2АБ (в период ОЗП)",
      "п.связи, АСУТП, АРМ, ТМ: Осмотр панелей связи и ТМ, проверка освещения, отопления, вентиляции узла связи; проверка каналов связи",
      "общая часть: Проверка наличия и состояния СЗ, инвентаря и приспособлений, ключей от ЭУ, средства связи, видеорегистраторы, диктофон, аптечки, бинокля, фонарей",
      "Проверить и принять оперативную документацию",
      "Проверка схем: АРМ, схемой-макет ПС, водоснабжения и пожаротушения в соответствии с ведомостью отклонения",
      

      
    ];

    List<String> periodicTasks = [
      "Панели управления, ЦС, РЗА, АСУТП, ТМ и ТС, учета, 1ЩСН, 1АБ, 2АБ, ЩПТ, помещения ОПУ, 1ПЖТ, 2ПЖТ, 1ПЖТ, 2ПЖТ, 1КПЗ, 2КПЗ, 3КПЗ, 1 скважина, 2 скважина, 2ЩСН, ЗРП, ЗПП
",
      
    ];

    if (isDay) {
      periodicTasks.insert(0, "ОСМОТР: 5АТГ, 6АТГ, 1АТ, 2АТ, 3АТ, 4АТ");
      if (isWinter) periodicTasks.add("ДГУ: контроль работы обогрев.устройств (зимний период)");
    } else {
      periodicTasks.insert(0, "ОСМОТР: 5АТГ, 6АТГ, 1АТ, 2АТ, 3АТ, 4АТ (контроль работы охлаждения)");
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
