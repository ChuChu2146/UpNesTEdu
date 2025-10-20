import 'package:flutter/material.dart';

class EventsListScreen extends StatelessWidget {
  const EventsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách sự kiện')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.event_outlined),
              title: Text('Sự kiện #${index + 1}'),
              subtitle: const Text('Mô tả ngắn cho sự kiện...'),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
