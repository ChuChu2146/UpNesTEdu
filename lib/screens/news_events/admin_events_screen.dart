import 'package:flutter/material.dart';
import 'events_mock_data.dart';

class AdminEventsScreen extends StatefulWidget {
  const AdminEventsScreen({super.key});

  @override
  State<AdminEventsScreen> createState() => _AdminEventsScreenState();
}

class _AdminEventsScreenState extends State<AdminEventsScreen> {
  late List<EventItem> _eventList;

  @override
  void initState() {
    super.initState();
    _eventList = List<EventItem>.from(mockEventList);
  }

  void _addOrEditEvent({EventItem? item, int? index}) async {
    final titleController = TextEditingController(text: item?.title ?? '');
    final descController = TextEditingController(text: item?.description ?? '');
    final imgController = TextEditingController(text: item?.imageUrl ?? '');
    final locationController =
        TextEditingController(text: item?.location ?? '');
    final organizerController =
        TextEditingController(text: item?.organizer ?? '');
    final typeController = TextEditingController(text: item?.type ?? '');
    final capacityController =
        TextEditingController(text: item?.capacity.toString() ?? '100');
    DateTime date = item?.date ?? DateTime.now();
    bool isRegistrationOpen = item?.isRegistrationOpen ?? true;
    final result = await showDialog<EventItem>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(item == null ? 'Thêm sự kiện' : 'Sửa sự kiện'),
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
                maxLines: 3,
              ),
              TextField(
                controller: imgController,
                decoration: const InputDecoration(labelText: 'Link ảnh'),
              ),
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Loại sự kiện'),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Địa điểm'),
              ),
              TextField(
                controller: organizerController,
                decoration: const InputDecoration(labelText: 'Ban tổ chức'),
              ),
              TextField(
                controller: capacityController,
                decoration: const InputDecoration(labelText: 'Sức chứa'),
                keyboardType: TextInputType.number,
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
              Row(
                children: [
                  const Text('Trạng thái đăng ký: '),
                  Switch(
                    value: isRegistrationOpen,
                    onChanged: (value) {
                      setState(() => isRegistrationOpen = value);
                    },
                  ),
                  Text(isRegistrationOpen ? 'Mở' : 'Đóng'),
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
              if (titleController.text.isEmpty ||
                  descController.text.isEmpty ||
                  typeController.text.isEmpty ||
                  locationController.text.isEmpty ||
                  organizerController.text.isEmpty ||
                  capacityController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Vui lòng điền đầy đủ thông tin')),
                );
                return;
              }

              final capacity = int.tryParse(capacityController.text);
              if (capacity == null || capacity <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sức chứa phải là số dương')),
                );
                return;
              }

              Navigator.pop(
                ctx,
                EventItem(
                  id: item?.id ?? DateTime.now().millisecondsSinceEpoch,
                  title: titleController.text,
                  description: descController.text,
                  imageUrl: imgController.text.isEmpty
                      ? 'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=400&q=80'
                      : imgController.text,
                  date: date,
                  location: locationController.text,
                  organizer: organizerController.text,
                  type: typeController.text,
                  capacity: capacity,
                  isRegistrationOpen: isRegistrationOpen,
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
          _eventList[index] = result;
        } else {
          _eventList.insert(0, result);
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                item == null ? 'Đã thêm sự kiện mới' : 'Đã cập nhật sự kiện')),
      );
    }
  }

  void _deleteEvent(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc muốn xóa sự kiện này?'),
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
      setState(() => _eventList.removeAt(index));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Đã xóa sự kiện!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản trị sự kiện'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Thêm sự kiện mới',
            onPressed: () => _addOrEditEvent(),
          ),
        ],
      ),
      body: _eventList.isEmpty
          ? const Center(child: Text('Chưa có sự kiện nào.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _eventList.length,
              itemBuilder: (context, index) {
                final item = _eventList[index];
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
                              _addOrEditEvent(item: item, index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteEvent(index),
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
