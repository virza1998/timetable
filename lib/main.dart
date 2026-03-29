import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MaterialApp(home: TodoLogic()));

class TodoLogic extends StatelessWidget {
  const TodoLogic({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int hour = now.hour;
    int month = now.month;
    bool isDay = hour >= 8 && hour < 20;
    bool isWinter = month >= 10 || month <= 4;

    List<String> receptionTasks = [
      "РЗА: цепи упр. выкл., оперативный ток, отсутствие табло на ЦС",
      "Сигнализация: проверка ЦС, АУПС и положения выключателей",
      "Нагрузки: ВЛ 500/220/110 кВ, АТ 1-6, напряжение на шинах",
      "Замеры: 3U0 на ТН, ток небаланса ДЗШ, ДЗО, КИВ",
      "ЩСН/ЩПТ: нагрузка ТСН, U на шинах, работа ВУ и изоляция",
      "АБ: трещины, течи, уровень электролита, отопление",
      "Связь/АСУ ТП: панели связи, ТМ, АРМ, вентиляция узла связи",
      "Общее: СЗ, ключи, видеорегистраторы, аптечка, документация",
      "Схемы: АРМ, макет ПС, водоснабжение и пожаротушение",
    ];

    List<String> periodicTasks = [
      "Осмотр: Панели ЦС, РЗА, АСУТП, ТМ, ЩСН, ЩПТ, ОПУ",
      "Осмотр: ПЖТ, КПЗ, скважины, ЗРП, ЗПП",
      "ФИКСАЦИЯ: Опер. журнал, маршрутная карта, журнал нагрузок",
    ];

    if (isDay) {
      periodicTasks.insert(0, "ОСМОТР: 5АТГ, 6АТГ, 1АТ, 2АТ, 3АТ, 4АТ");
      if (isWinter) periodicTasks.add("ДГУ: Контроль работы обогревательных устройств");
    } else {
      periodicTasks.insert(0, "ОСМОТР: 5АТГ, 6АТГ, 1-4АТ (контроль охлаждения)");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isDay ? "ДНЕВНАЯ СМЕНА" : "НОЧНАЯ СМЕНА"),
        backgroundColor: isDay ? Colors.orange[300] : Colors.indigo[400],
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
          padding: const EdgeInsets.all(16.0),
          child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
        ),
        ...tasks.map((task) => CheckboxListTile(
          title: Text(task, style: const TextStyle(fontSize: 13)),
          value: false,
          onChanged: (val) {},
          dense: true,
        )),
        const Divider(),
      ],
    );
  }
}
