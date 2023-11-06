import 'package:flutter_chat_app/domain/data_provider/firebase_data_provider.dart';
import 'package:flutter_chat_app/domain/models/message.dart';
import 'package:flutter_chat_app/domain/services/user_service.dart';

class FirebaseService {
  final firebaseDataProvider = FirebaseDataProvider();
  final userService = UserService();
  var myUserId = 1;

  Future<void> initialize() async {
    _getUser();
  }

  Future<void> _getUser() async {
    final responseUserId = await userService.getUserId();
    myUserId = responseUserId;
  }

  String _createTimeString() {
    final hour = DateTime.now().hour.toString();
    final minutes = DateTime.now().minute.toString();

    return '$hour:$minutes';
  }

  _getChatId(String chatUserId) {
    return myUserId.hashCode <= userService.chatUserId.hashCode
        ? '${myUserId}_${userService.chatUserId}'
        : '${userService.chatUserId}_$myUserId';
  }

  Future<void> sendMessage(String ms, String chatId, String userName,
      int senderId, int reciverId) async {
    final read = _createTimeString();
    // final time = DateTime.now().microsecond.toString();

    final Message message = Message(
        reciverId: reciverId,
        senderId: senderId,
        message: ms,
        read: read,
        send: read,
        senderNameUser: userName);
    await firebaseDataProvider.sendMessage(message, read, chatId);
  }
}
