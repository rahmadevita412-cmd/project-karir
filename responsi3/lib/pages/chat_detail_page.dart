import 'package:flutter/material.dart';
import 'dart:async'; 
import '../models/chat_message_model.dart';



class ChatDetailPage extends StatefulWidget {
  final String name;
  final String imageUrl;

  const ChatDetailPage({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  // List pesan awal
  final List<ChatMessage> _messages = [
    ChatMessage(text: 'Do you have a time for interviews today?', isMe: false),
    ChatMessage(text: 'Yes, I have.', isMe: true),
    ChatMessage(text: 'Hello William, Thankyou for your appliment', isMe: false),
  ];

  
  void _handleSend() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
    
      _messages.add(ChatMessage(text: _controller.text, isMe: true));
    });

    String userText = _controller.text;
    _controller.clear();
    _scrollToBottom();

  
    Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            text: 'Noted! I will check the schedule for "$userText" first. Stay tuned!',
            isMe: false,
          ));
        });
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey[400] : Colors.grey[500];
    final iconColor = isDark ? Colors.white : const Color(0xFF1F3A93);

    return Scaffold(
      backgroundColor: bgColor, 
      appBar: AppBar(
        backgroundColor: bgColor, 
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: iconColor, size: 32), 
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              widget.name,
              style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold), 
            ),
            Text('Last seen 12m ago', style: TextStyle(color: subTextColor, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.tune, color: isDark ? Colors.white : Colors.grey), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Sunday, Feb 9, 12:58', style: TextStyle(color: subTextColor, fontSize: 12)),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(msg, isDark); 
              },
            ),
          ),
          _buildInputSection(isDark, bgColor), 
        ],
      ),
    );
  }


  Widget _buildMessageBubble(ChatMessage msg, bool isDark) {
   
    final otherBubbleColor = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEF2FF);
    final otherTextColor = isDark ? Colors.white : Colors.black;
    final myBubbleColor = isDark ? Colors.blueAccent : const Color(0xFF1F3A93);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: msg.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!msg.isMe)
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(widget.imageUrl), 
            ),
          if (!msg.isMe) const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
            decoration: BoxDecoration(
              color: msg.isMe ? myBubbleColor : otherBubbleColor, 
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(msg.isMe ? 16 : 0),
                bottomRight: Radius.circular(msg.isMe ? 0 : 16),
              ),
            ),
            child: Text(
              msg.text,
              style: TextStyle(
                color: msg.isMe ? Colors.white : otherTextColor,
                fontSize: 15
              ),
            ),
          ),
        ],
      ),
    );
  }

 
  Widget _buildInputSection(bool isDark, Color bgColor) {
    final inputBgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor = isDark ? Colors.transparent : Colors.grey[200]!;
    final textColor = isDark ? Colors.white : Colors.black;
    final hintColor = isDark ? Colors.grey[500] : Colors.grey[400];
    final sendBtnColor = isDark ? Colors.blueAccent : const Color(0xFF1F3A93);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor, 
        border: Border(top: BorderSide(color: isDark ? Colors.black26 : borderColor)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: inputBgColor, 
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.sentiment_satisfied_alt, color: hintColor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _handleSend(),
                      style: TextStyle(color: textColor), 
                      decoration: InputDecoration(
                        hintText: 'Message',
                        hintStyle: TextStyle(color: hintColor),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _handleSend,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: sendBtnColor, 
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}