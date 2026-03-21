import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _chats = [
    {'name': 'أحمد محمد', 'lastMessage': 'مرحباً، هل المنتج متوفر؟', 'time': '10:30', 'unread': 2, 'avatar': 'أ'},
    {'name': 'متجر التقنية', 'lastMessage': 'تم تأكيد طلبك بنجاح', 'time': '09:15', 'unread': 0, 'avatar': 'م'},
    {'name': 'فاطمة علي', 'lastMessage': 'شكراً لك على التعامل', 'time': 'أمس', 'unread': 0, 'avatar': 'ف'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const CustomAppBar(title: 'المحادثات'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _chats.length,
        itemBuilder: (_, i) {
          final c = _chats[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ChatDetailScreen(chat: c)),
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                    child: Text(c['avatar'], style: const TextStyle(color: AppTheme.goldColor)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(c['lastMessage'], maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(c['time'], style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                      if (c['unread'] > 0)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(color: AppTheme.goldColor, shape: BoxShape.circle),
                          child: Text(c['unread'].toString(), style: const TextStyle(fontSize: 10, color: Colors.black)),
                        ),
                    ],
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
