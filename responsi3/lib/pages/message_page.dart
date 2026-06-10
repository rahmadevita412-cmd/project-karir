import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../widgets/message_tile.dart';
import 'chat_detail_page.dart';
import 'package:responsi3/widgets/custom_drawer.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  bool isFabExpanded = false;
  final List<Message> messages = [
    Message(
      name: 'Kevin Louis',
      message: 'Hello William, Thankyou for your app',
      time: '2m ago',
      status: 'unread',
      isOnline: false,
      imageUrl: 'assets/icons/p1.png',
    ),
    Message(
      name: 'Olivia James',
      message: 'OK. Lorem ipsum dolor sect...',
      time: '2m ago',
      status: 'unread',
      isOnline: false,
      imageUrl: 'assets/icons/p2.png',
    ),
    Message(
      name: 'Cindy Sinambela',
      message: 'OK. Lorem ipsum dolor sect...',
      time: '2m ago',
      status: 'pending',
      isOnline: true,
      imageUrl: 'assets/icons/p3.png',
    ),
    Message(
      name: 'Sam Verdinand',
      message: 'Roger that sir, thankyou',
      time: '2m ago',
      status: 'read',
      isOnline: true,
      imageUrl: 'assets/icons/p4.png',
    ),
    Message(
        name: 'David Mckanzie',
        message: 'Lorem ipsum dolor sit amet...',
        time: '2m ago',
        status: 'read',
        isOnline: true,
        imageUrl: 'assets/icons/p5.png'),
    Message(
        name: 'Daphne Putri',
        message: 'OK. Lorem ipsum dolor sect...',
        time: '2m ago',
        status: 'unread',
        isOnline: true,
        imageUrl: 'assets/icons/p6.png'),
    Message(
        name: 'Cindy Sinambela',
        message: 'Lagi dimana cin?',
        time: '2m ago',
        status: 'read',
        isOnline: false,
        imageUrl: 'assets/icons/p7.png'),
  ];

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = isDark ? Colors.white : Colors.black;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor = isDark ? Colors.transparent : Colors.grey.shade300;

    return Scaffold(
      backgroundColor: bgColor, 
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: bgColor, 
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: cardColor, 
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(Icons.chevron_left, color: isDark ? Colors.white : const Color(0xFF1F3A93)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: Text(
          'Messages',
          style: TextStyle(
            color: textColor, 
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: cardColor, 
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.tune,
                    color: isDark ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: cardColor, 
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
              ),
              child: TextField(
                style: TextStyle(color: textColor), 
                decoration: InputDecoration(
                  hintText: 'Search job here...',
                  hintStyle: TextStyle(color: isDark ? Colors.grey.shade500 : Colors.grey.shade400),
                  prefixIcon: Icon(Icons.search, color: isDark ? Colors.grey.shade400 : Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(top: 14),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              physics: const BouncingScrollPhysics(),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatDetailPage(
                          name: messages[index].name,
                          imageUrl: messages[index].imageUrl,
                        ),
                      ),
                    );
                  },
                  child: MessageTile(message: messages[index]),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isFabExpanded) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00796B),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.3 : 0.08), 
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFF77F0E5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Colors.black87,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B73B7),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.3 : 0.08), 
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Messages',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDCE8FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.grid_view_rounded,
                    color: Colors.black87,
                    size: 26,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          GestureDetector(
            onTap: () {
              setState(() {
                isFabExpanded = !isFabExpanded;
              });
            },
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF1B2C7A),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.4 : 0.15), 
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                isFabExpanded ? Icons.close : Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}