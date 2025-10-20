import 'package:flutter/material.dart';

class AdminNewsScreen extends StatelessWidget {
  const AdminNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản trị tin tức')),
      body: Center(
        child: Text('Giao diện quản trị tin tức (placeholder)',
            style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}
