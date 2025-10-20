import 'package:flutter/material.dart';

class AdminEventsScreen extends StatelessWidget {
  const AdminEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản trị sự kiện')),
      body: Center(
        child: Text('Giao diện quản trị sự kiện (placeholder)',
            style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}
