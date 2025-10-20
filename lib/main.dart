import 'package:flutter/material.dart';
import 'package:ui_upnestedu/screens/auth/login_screen.dart';
import 'package:ui_upnestedu/screens/auth/register_screen.dart';
import 'package:ui_upnestedu/screens/news_events/news_list_screen.dart';
import 'package:ui_upnestedu/screens/news_events/events_list_screen.dart';
import 'package:ui_upnestedu/screens/news_events/admin_news_screen.dart';
import 'package:ui_upnestedu/screens/news_events/admin_events_screen.dart';
import 'package:ui_upnestedu/screens/news_events/news_detail_screen.dart';
import 'package:ui_upnestedu/services/auth_service.dart';

void main() {
  debugPrint('Starting UpNestEduApp');
  runApp(const UpNestEduApp());
}

class UpNestEduApp extends StatelessWidget {
  const UpNestEduApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UpNestEdu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue, // 🌟 màu chủ đạo của app
      ),
      // RegisterScreen kept available; we provide a HomeScreen with named routes
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/news': (context) => const NewsListScreen(),
        '/news/detail': (context) => const NewsDetailScreen(),
        '/events': (context) => const EventsListScreen(),
        '/admin/news': (context) => const AdminNewsScreen(),
        '/admin/events': (context) => const AdminEventsScreen(),
      },
      initialRoute: '/login',
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UpNestEdu - Home')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Show current role if logged in
            if (AuthService.instance.isLoggedIn)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                    'Đã đăng nhập với vai trò: ${AuthService.instance.currentRole}'),
              ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/news'),
              child: const Text('Tin tức (/news)'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/events'),
              child: const Text('Sự kiện (/events)'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/admin/news'),
              child: const Text('Quản trị tin tức (/admin/news)'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/admin/events'),
              child: const Text('Quản trị sự kiện (/admin/events)'),
            ),
            const SizedBox(height: 20),
            if (!AuthService.instance.isLoggedIn) ...[
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: const Text('Đăng nhập'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text('Đăng ký'),
              ),
            ] else ...[
              OutlinedButton(
                onPressed: () {
                  AuthService.instance.logout();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Đăng xuất'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
