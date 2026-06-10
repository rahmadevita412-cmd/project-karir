class Message {
  final String name;
  final String message;
  final String time;
  final String status;
  final bool isOnline;
  final String imageUrl;

  Message({
    required this.name,
    required this.message,
    required this.time,
    required this.status,
    required this.isOnline,
    required this.imageUrl,
  });
}