class NewsItem {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime date;

  NewsItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
  });
}

final List<NewsItem> mockNewsList = [
  NewsItem(
    id: 1,
    title: 'Giáo dục Việt Nam đổi mới',
    description:
        'Nhiều trường học áp dụng phương pháp mới giúp học sinh phát triển toàn diện.',
    imageUrl:
        'https://images.unsplash.com/photo-1503676382389-4809596d5290?auto=format&fit=crop&w=400&q=80',
    date: DateTime(2025, 10, 18),
  ),
  NewsItem(
    id: 2,
    title: 'Cuộc thi sách mới 2025',
    description:
        'Cuộc thi sách mới thu hút hàng ngàn học sinh tham gia trên toàn quốc.',
    imageUrl:
        'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?auto=format&fit=crop&w=400&q=80',
    date: DateTime(2025, 10, 15),
  ),
  NewsItem(
    id: 3,
    title: 'Hội thảo giáo dục số',
    description:
        'Các chuyên gia chia sẻ về xu hướng chuyển đổi số trong giáo dục.',
    imageUrl:
        'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
    date: DateTime(2025, 10, 10),
  ),
  NewsItem(
    id: 4,
    title: 'Sách mới cho học sinh tiểu học',
    description:
        'Bộ sách mới giúp học sinh tiểu học tiếp cận kiến thức hiện đại.',
    imageUrl:
        'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?auto=format&fit=crop&w=400&q=80',
    date: DateTime(2025, 9, 30),
  ),
  NewsItem(
    id: 5,
    title: 'Giáo viên xuất sắc năm 2025',
    description:
        'Vinh danh các giáo viên có thành tích xuất sắc trong năm học.',
    imageUrl:
        'https://images.unsplash.com/photo-1506784365847-bbad939e9335?auto=format&fit=crop&w=400&q=80',
    date: DateTime(2025, 9, 25),
  ),
];
