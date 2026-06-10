import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsi3/widgets/custom_drawer.dart';

const Color primaryDark = Color(0xFF1B2C6F);

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  List<Map<String, dynamic>> notifications = [
    {
      "title": "Apply Success",
      "desc": "You has apply an job in Queenify Group as UI Designer",
      "time": "10h ago",
      "isNew": true,
    },
    {
      "title": "Interview Calls",
      "desc":
          "Congratulations! You have interview calls tomorrow. Check schedule here..",
      "time": "4m ago",
      "isNew": true,
    },
    {
      "title": "Apply Success",
      "desc": "You has apply an job in Queenify Group as UI Designer",
      "time": "8h ago",
      "isNew": false,
    },
    {
      "title": "Complete your profile",
      "desc":
          "Please verify your profile information to continue using this app",
      "time": "4h ago",
      "isNew": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  Future<void> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/notifications'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        for (var item in data) {
          notifications.add({
            "title": item['title'],
            "desc": item['message'],
            "time": "Baru",
            "isNew": true,
          });
        }
      });
    }

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFFBFBFD);
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: _buildHeaderButton(Icons.arrow_back_ios_new_rounded, isDark),
                  ),

                  Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),

                  Builder(
                    builder: (context) => InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: _buildHeaderButton(Icons.tune_rounded, isDark),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: notifications.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return NotificationCard(
                    item: notifications[index],
                    isFirstItem: (index == 0),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderButton(IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? Colors.transparent : Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Icon(
        icon, 
        size: 16, 
        color: isDark ? Colors.white : Colors.black87,
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final Map item;
  final bool isFirstItem;

  const NotificationCard({
    super.key,
    required this.item,
    required this.isFirstItem,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final titleColor = isDark ? Colors.white : Colors.black;
    final descColor = isDark ? Colors.white70 : const Color(0xFF6B7280);
    final blueColor = isDark ? Colors.blueAccent : primaryDark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cardColor, 
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isFirstItem)
                Container(
                  width: 7,
                  height: 7,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: blueColor,
                    shape: BoxShape.circle,
                  ),
                ),
              Text(
                item["title"],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: titleColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            item["desc"],
            style: TextStyle(
              color: descColor,
              fontSize: 12,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: descColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item["time"],
                    style: TextStyle(
                      color: descColor,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              if (item["isNew"] == true)
                Text(
                  "Mark as read",
                  style: TextStyle(
                    color: blueColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}