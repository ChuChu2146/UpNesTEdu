import 'package:flutter/material.dart';
import 'schedules_mock_data.dart';
// avoid intl dependency for now; use a simple time formatter

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  Map<int, List<ClassSession>> _groupByWeekday(List<ClassSession> sessions) {
    final map = <int, List<ClassSession>>{};
    for (var s in sessions) {
      map.putIfAbsent(s.weekday, () => []).add(s);
    }
    for (var list in map.values) {
      list.sort((a, b) => a.start.compareTo(b.start));
    }
    return map;
  }

  String _weekdayName(int d) {
    const names = [
      '',
      'Thứ 2',
      'Thứ 3',
      'Thứ 4',
      'Thứ 5',
      'Thứ 6',
      'Thứ 7',
      'Chủ nhật'
    ];
    if (d >= 1 && d <= 7) return names[d];
    return 'Ngày lạ';
  }

  String _fmtTime(DateTime t) {
    String two(int v) => v.toString().padLeft(2, '0');
    return '${two(t.hour)}:${two(t.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByWeekday(mockSchedule);
    final orderedWeekdays =
        [1, 2, 3, 4, 5, 6, 7].where((d) => grouped.containsKey(d)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Lịch học của sinh viên')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: orderedWeekdays.length,
        itemBuilder: (context, idx) {
          final weekday = orderedWeekdays[idx];
          final sessions = grouped[weekday]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  _weekdayName(weekday),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              ...sessions.map((s) => Card(
                    child: ListTile(
                      title: Text(s.course),
                      subtitle: Text('${s.teacher} • ${s.location}'),
                      trailing:
                          Text('${_fmtTime(s.start)} - ${_fmtTime(s.end)}'),
                    ),
                  )),
              const SizedBox(height: 12),
            ],
          );
        },
      ),
    );
  }
}
