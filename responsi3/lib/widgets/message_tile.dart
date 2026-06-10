import 'package:flutter/material.dart';
import '../models/message_model.dart';

class MessageTile extends StatelessWidget {
  final Message message;
  const MessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    bool isRead = message.status == 'read';

    
    final nameColor = isDark ? Colors.white : Colors.black;
    final messageColor = isDark ? Colors.white70 : Colors.black54;
    final timeColor = isDark ? Colors.grey.shade400 : Colors.grey;
    final readColor = isDark ? Colors.blueAccent : const Color(0xFF1F3A93); 
    final unreadColor = isDark ? Colors.grey.shade500 : Colors.grey;
    final statusColor = isRead ? readColor : unreadColor;
    
   
    final bgCutoutColor = Theme.of(context).scaffoldBackgroundColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(
                    image: AssetImage(message.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (message.isOnline)
                Positioned(
                  bottom: -1,
                  left: -1,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: const Color(0xFF11C76F),
                      shape: BoxShape.circle,
                     
                      border: Border.all(color: bgCutoutColor, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: nameColor, 
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: messageColor, 
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message.time,
                  style: TextStyle(
                    fontSize: 11,
                    color: timeColor, 
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.status[0].toUpperCase() + message.status.substring(1),
                style: TextStyle(
                  fontSize: 11,
                  color: statusColor,
                ),
              ),
              const SizedBox(height: 4),
              Icon(
                isRead ? Icons.done : Icons.check,
                size: 16,
                color: statusColor, 
              ),
            ],
          ),
        ],
      ),
    );
  }
}