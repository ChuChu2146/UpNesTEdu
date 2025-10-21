class ClassSession {
  final String id;
  final String course;
  final String teacher;
  final String location;
  final DateTime start;
  final DateTime end;
  final int weekday; // 1 = Mon, 7 = Sun

  ClassSession({
    required this.id,
    required this.course,
    required this.teacher,
    required this.location,
    required this.start,
    required this.end,
    required this.weekday,
  });
}

final List<ClassSession> mockSchedule = [
  ClassSession(
    id: 'm1',
    course: 'Toán cao cấp',
    teacher: 'TS. Nguyễn Văn A',
    location: 'Phòng B201',
    start: DateTime(2025, 10, 20, 7, 30),
    end: DateTime(2025, 10, 20, 9, 0),
    weekday: 1,
  ),
  ClassSession(
    id: 'm2',
    course: 'Lập trình hướng đối tượng',
    teacher: 'ThS. Lê Thị B',
    location: 'Phòng LAB B1',
    start: DateTime(2025, 10, 20, 9, 15),
    end: DateTime(2025, 10, 20, 10, 45),
    weekday: 1,
  ),
  ClassSession(
    id: 't1',
    course: 'Cấu trúc dữ liệu',
    teacher: 'PGS. Trần C',
    location: 'Phòng A101',
    start: DateTime(2025, 10, 21, 13, 0),
    end: DateTime(2025, 10, 21, 14, 30),
    weekday: 2,
  ),
  ClassSession(
    id: 'w1',
    course: 'Mạng máy tính',
    teacher: 'ThS. Phạm D',
    location: 'Phòng B202',
    start: DateTime(2025, 10, 22, 10, 0),
    end: DateTime(2025, 10, 22, 11, 30),
    weekday: 3,
  ),
  ClassSession(
    id: 'f1',
    course: 'An toàn thông tin',
    teacher: 'TS. Hoàng E',
    location: 'Phòng A305',
    start: DateTime(2025, 10, 24, 14, 0),
    end: DateTime(2025, 10, 24, 15, 30),
    weekday: 5,
  ),
];
