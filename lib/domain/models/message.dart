class Message {
  Message(
      {required this.reciverId,
      required this.senderId,
      required this.message,
      required this.send,
      required this.read,
      required this.senderNameUser});
  late final String reciverId;
  late final String senderId;
  late final String read;
  late final String message;
  late final String send;
  late final String senderNameUser;

  Message.fromJson(Map<dynamic, dynamic> json) {
    reciverId = json['reciverId'];
    senderId = json['senderId'];
    message = json['message'];
    send = json['send'];
    read = json['read'];
    senderNameUser = json['senderNameUser'];
  }

  Map<dynamic, dynamic> toJson() {
    final data = <dynamic, dynamic>{};
    data['reciverId'] = reciverId;
    data['senderId'] = senderId;
    data['message'] = message;
    data['read'] = read;
    data['send'] = send;
    data['senderNameUser'] = senderNameUser;
    return data;
  }
}
