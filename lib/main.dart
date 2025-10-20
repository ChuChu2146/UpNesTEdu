import 'package:flutter/material.dart';
import 'package:ui_upnestedu/screens/auth/login_screen.dart';
import 'package:ui_upnestedu/screens/auth/register_screen.dart';
import 'package:ui_upnestedu/screens/news_events/news_list_screen.dart';
import 'package:ui_upnestedu/screens/news_events/events_list_screen.dart';
import 'package:ui_upnestedu/screens/news_events/admin_news_screen.dart';
import 'package:ui_upnestedu/screens/news_events/admin_events_screen.dart';
import 'package:ui_upnestedu/screens/news_events/news_detail_screen.dart';
import 'package:ui_upnestedu/screens/news_events/event_detail_screen.dart';
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
        '/events/detail': (context) => const EventDetailScreen(),
        '/admin/news': (context) {
          if (AuthService.instance.currentRole != 'Quản lý') {
            Future.microtask(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Bạn không có quyền truy cập trang này')),
              );
              Navigator.pushReplacementNamed(context, '/');
            });
            return const SizedBox.shrink();
          }
          return const AdminNewsScreen();
        },
        '/admin/events': (context) {
          if (AuthService.instance.currentRole != 'Quản lý') {
            Future.microtask(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Bạn không có quyền truy cập trang này')),
              );
              Navigator.pushReplacementNamed(context, '/');
            });
            return const SizedBox.shrink();
          }
          return const AdminEventsScreen();
        },
      },
      initialRoute: '/login',
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = AuthService.instance.isLoggedIn;
    final isAdmin = isLoggedIn && AuthService.instance.currentRole == 'Quản lý';

    return Scaffold(
      appBar: AppBar(
        title: const Text('UpNestEdu - Home'),
        actions: [
          if (isLoggedIn)
            IconButton(
              onPressed: () {
                AuthService.instance.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(Icons.logout),
              tooltip: 'Đăng xuất',
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLoggedIn) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isAdmin
                      ? Colors.blue.withOpacity(0.08)
                      : Colors.grey.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(isAdmin ? Icons.admin_panel_settings : Icons.person,
                        color: isAdmin ? Colors.blue : Colors.grey[700]),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text(
                            'Đã đăng nhập với vai trò: ${AuthService.instance.currentRole}')),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/news'),
              icon: const Icon(Icons.article),
              label: const Text('Tin tức'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/events'),
              icon: const Icon(Icons.event),
              label: const Text('Sự kiện'),
            ),
            if (isAdmin) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/admin/news'),
                icon: const Icon(Icons.admin_panel_settings),
                label: const Text('Quản trị tin tức'),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/admin/events'),
                icon: const Icon(Icons.edit_calendar),
                label: const Text('Quản trị sự kiện'),
              ),
            ],
            const Spacer(),
            if (!isLoggedIn) ...[
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: const Text('Đăng nhập'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text('Đăng ký'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
