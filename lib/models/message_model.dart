class Message {
  late String content;
  late String senderId;
  late String receiverId;

  Message({
    required this.content,
    required this.senderId,
    required this.receiverId,
  });

  Message.fromJson(Map<String, dynamic> json) {
    content = json['content'] ?? '';
    senderId = json['sender'] ?? '';
    receiverId = json['receiver'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'sender': senderId,
      'receiver': receiverId,
    };
  }
}
