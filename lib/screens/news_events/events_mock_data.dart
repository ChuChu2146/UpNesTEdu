class EventItem {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime date;
  final String location;
  final String organizer;
  final String type;
  final int capacity;
  final bool isRegistrationOpen;

  EventItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.location,
    required this.organizer,
    required this.type,
    required this.capacity,
    required this.isRegistrationOpen,
  });
}

final List<EventItem> mockEventList = [
  EventItem(
    id: 1,
    title: 'Hội thảo chuyển đổi số',
    description:
        'Hội thảo về chuyển đổi số trong giáo dục với nhiều chuyên gia tham dự. Tham gia để cập nhật xu hướng công nghệ mới nhất trong lĩnh vực giáo dục và đào tạo.',
    imageUrl:
        'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=400&q=80',
    date: DateTime(2025, 10, 22),
    location: 'Hội trường A1 - Tòa nhà A',
    organizer: 'Khoa Công nghệ Thông tin',
    type: 'Hội thảo',
    capacity: 200,
    isRegistrationOpen: true,
  ),
  EventItem(
    id: 2,
    title: 'Cuộc thi sáng tạo trẻ',
    description:
        'Cuộc thi dành cho học sinh, sinh viên với nhiều ý tưởng sáng tạo. Cơ hội thể hiện tài năng và nhận giải thưởng giá trị từ nhà tài trợ.',
    imageUrl:
        'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
    date: DateTime(2025, 11, 5),
    location: 'Sân vận động trường',
    organizer: 'Đoàn Thanh niên',
    type: 'Cuộc thi',
    capacity: 500,
    isRegistrationOpen: true,
  ),
  EventItem(
    id: 3,
    title: 'Ngày hội đọc sách',
    description:
        'Sự kiện khuyến khích văn hóa đọc trong cộng đồng. Tham gia các hoạt động thú vị và nhận quà tặng từ ban tổ chức.',
    imageUrl:
        'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
    date: DateTime(2025, 12, 1),
    location: 'Thư viện trường',
    organizer: 'CLB Sách & Tri thức',
    type: 'Ngày hội',
    capacity: 300,
    isRegistrationOpen: true,
  ),
  EventItem(
    id: 4,
    title: 'Workshop kỹ năng mềm',
    description:
        'Chuỗi workshop giúp học sinh phát triển kỹ năng mềm. Chương trình do các chuyên gia đào tạo hàng đầu hướng dẫn.',
    imageUrl:
        'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
    date: DateTime(2025, 12, 10),
    location: 'Phòng hội thảo B2',
    organizer: 'Trung tâm Phát triển Kỹ năng',
    type: 'Workshop',
    capacity: 100,
    isRegistrationOpen: false,
  ),
];
