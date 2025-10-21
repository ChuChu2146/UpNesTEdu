import 'package:flutter/material.dart';
import 'exams_mock_data.dart';
import 'package:url_launcher/url_launcher.dart';

class ExamScheduleScreen extends StatelessWidget {
  const ExamScheduleScreen({super.key});

  Future<void> _sendEmailReminder(BuildContext context, ExamItem exam) async {
    final subject = Uri.encodeComponent('Nhắc lịch thi: ${exam.course}');
    final body = Uri.encodeComponent(
        'Xin chào,\n\n\nĐây là lời nhắc về kỳ thi:\n${exam.course}\nNgày: ${exam.date.day}/${exam.date.month}/${exam.date.year}\nThời gian: ${exam.startTime} - ${exam.endTime}\nĐịa điểm: ${exam.location}\n\nGhi chú: ${exam.notes}\n\nChúc bạn làm bài tốt!');
    final uri = Uri.parse('mailto:?subject=$subject&body=$body');

    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không thể mở ứng dụng email.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lịch thi')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: mockExamList.length,
        itemBuilder: (context, index) {
          final exam = mockExamList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(exam.course),
              subtitle: Text(
                  'Ngày: ${exam.date.day}/${exam.date.month}/${exam.date.year} • ${exam.startTime} - ${exam.endTime}\n${exam.location}'),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.email),
                tooltip: 'Gửi email nhắc',
                onPressed: () => _sendEmailReminder(context, exam),
              ),
            ),
          );
        },
      ),
    );
  }
}
