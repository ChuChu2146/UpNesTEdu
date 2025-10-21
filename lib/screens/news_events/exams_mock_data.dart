class ExamItem {
  final String id;
  final String course;
  final DateTime date;
  final String startTime; // e.g. '09:00'
  final String endTime;
  final String location;
  final String notes;

  ExamItem({
    required this.id,
    required this.course,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.location,
    this.notes = '',
  });
}

final List<ExamItem> mockExamList = [
  ExamItem(
    id: 'e1',
    course: 'Toán cao cấp - Kiểm tra cuối kỳ',
    date: DateTime(2025, 12, 10),
    startTime: '09:00',
    endTime: '11:00',
    location: 'Phòng thi A1',
    notes: 'Mang thẻ sinh viên, bút, máy tính bỏ túi',
  ),
  ExamItem(
    id: 'e2',
    course: 'Lập trình hướng đối tượng - Kiểm tra giữa kỳ',
    date: DateTime(2025, 11, 25),
    startTime: '13:30',
    endTime: '15:00',
    location: 'Phòng LAB B2',
  ),
];
