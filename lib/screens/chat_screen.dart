import '../models/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../services/supabase_service.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _chats = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  Future<void> _loadChats() async {
    // تحميل المحادثات من Supabase
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'المحادثات'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _chats.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      const Text('لا توجد محادثات', style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      const Text('تواصل مع البائعين لبدء محادثة'),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _chats.length,
                  itemBuilder: (context, index) {
                    final chat = _chats[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ChatDetailScreen(
                              chatId: chat['id'],
                              userName: chat['name'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                            child: Text(chat['name'][0], style: const TextStyle(color: AppTheme.goldColor)),
                          ),
                          title: Text(chat['name']),
                          subtitle: Text(chat['lastMessage'] ?? '...', maxLines: 1),
                          trailing: chat['unread'] > 0
                              ? Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: AppTheme.goldColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${chat['unread']}',
                                    style: const TextStyle(color: Colors.black, fontSize: 10),
                                  ),
                                )
                              : null,
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
