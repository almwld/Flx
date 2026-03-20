import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ChatDetailScreen extends StatefulWidget {
  final Map<String, dynamic> chat;
  const ChatDetailScreen({super.key, required this.chat});
  @override State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'text': 'مرحباً، كيف حالك؟', 'isMe': false, 'time': '10:30'},
    {'text': 'أهلاً بك، بخير', 'isMe': true, 'time': '10:31'},
    {'text': 'هل المنتج متوفر؟', 'isMe': false, 'time': '10:32'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: Row(children: [
        CircleAvatar(backgroundColor: AppTheme.goldColor.withOpacity(0.2), child: Text(widget.chat['avatar'], style: const TextStyle(color: AppTheme.goldColor))),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.chat['name']),
          Text('متصل الآن', style: TextStyle(fontSize: 12, color: Colors.green[400])),
        ]),
      ])),
      body: Column(children: [
        Expanded(child: ListView.builder(reverse: true, padding: const EdgeInsets.all(16), itemCount: _messages.length,
          itemBuilder: (_, i) {
            final msg = _messages[_messages.length - 1 - i];
            final isMe = msg['isMe'] as bool;
            return Align(alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                decoration: BoxDecoration(color: isMe ? AppTheme.goldColor : (isDark ? Colors.grey[800] : Colors.grey[200]),
                  borderRadius: BorderRadius.only(topLeft: const Radius.circular(16), topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isMe ? 4 : 16), bottomRight: Radius.circular(isMe ? 16 : 4))),
                child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(msg['text'], style: TextStyle(color: isMe ? Colors.black : null)),
                  const SizedBox(height: 4),
                  Text(msg['time'], style: TextStyle(fontSize: 10, color: isMe ? Colors.black54 : Colors.grey[600])) ]))); })),
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
          border: Border(top: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[300]!))),
          child: Row(children: [
            IconButton(icon: const Icon(Icons.attach_file), onPressed: () {}),
            IconButton(icon: const Icon(Icons.camera_alt), onPressed: () {}),
            Expanded(child: TextField(controller: _controller, decoration: InputDecoration(hintText: 'اكتب رسالة...',
              filled: true, fillColor: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none)))),
            const SizedBox(width: 8),
            GestureDetector(onTap: () {}, child: Container(padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldLight]), shape: BoxShape.circle),
              child: const Icon(Icons.send, color: Colors.black, size: 20))) ])) ]));
  }
}
