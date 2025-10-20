import 'package:flutter/material.dart';
import 'news_mock_data.dart';

class AdminNewsScreen extends StatefulWidget {
  const AdminNewsScreen({super.key});

  @override
  State<AdminNewsScreen> createState() => _AdminNewsScreenState();
}

class _AdminNewsScreenState extends State<AdminNewsScreen> {
  late List<NewsItem> _newsList;

  @override
  void initState() {
    super.initState();
    _newsList = List<NewsItem>.from(mockNewsList);
  }

  void _addOrEditNews({NewsItem? item, int? index}) async {
    final titleController = TextEditingController(text: item?.title ?? '');
    final descController = TextEditingController(text: item?.description ?? '');
    final imgController = TextEditingController(text: item?.imageUrl ?? '');
    DateTime date = item?.date ?? DateTime.now();
    final result = await showDialog<NewsItem>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(item == null ? 'Thêm tin tức' : 'Sửa tin tức'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Tiêu đề'),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Mô tả'),
              ),
              TextField(
                controller: imgController,
                decoration: const InputDecoration(labelText: 'Link ảnh'),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Ngày: '),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: date,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => date = picked);
                      }
                    },
                    child: Text('${date.day}/${date.month}/${date.year}'),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isEmpty || descController.text.isEmpty)
                return;
              Navigator.pop(
                ctx,
                NewsItem(
                  id: item?.id ?? DateTime.now().millisecondsSinceEpoch,
                  title: titleController.text,
                  description: descController.text,
                  imageUrl: imgController.text.isEmpty
                      ? 'https://images.unsplash.com/photo-1503676382389-4809596d5290?auto=format&fit=crop&w=400&q=80'
                      : imgController.text,
                  date: date,
                ),
              );
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
    if (result != null) {
      setState(() {
        if (index != null) {
          _newsList[index] = result;
        } else {
          _newsList.insert(0, result);
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(item == null ? 'Đã thêm tin mới' : 'Đã cập nhật tin')),
      );
    }
  }

  void _deleteNews(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc muốn xóa tin này?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Hủy')),
          ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Xóa')),
        ],
      ),
    );
    if (confirm == true) {
      setState(() => _newsList.removeAt(index));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Đã xóa tin tức!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản trị tin tức'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Thêm tin mới',
            onPressed: () => _addOrEditNews(),
          ),
        ],
      ),
      body: _newsList.isEmpty
          ? const Center(child: Text('Chưa có tin tức nào.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _newsList.length,
              itemBuilder: (context, index) {
                final item = _newsList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.imageUrl,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                          width: 56,
                          height: 56,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                    title: Text(item.title,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () =>
                              _addOrEditNews(item: item, index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteNews(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
