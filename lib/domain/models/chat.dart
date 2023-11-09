class Chat {
  int myUserId;
  String chatUserId;
  String userName;

  Chat(
      {required this.myUserId,
      required this.chatUserId,
      required this.userName});

  Chat copyWith({int? myUserId, String? chatUserId, String? userName}) {
    return Chat(
        myUserId: myUserId ?? this.myUserId,
        chatUserId: chatUserId ?? this.chatUserId,
        userName: userName ?? this.userName);
  }
}
