import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/domain/models/message.dart';

class FirebaseDataProvider {
  final firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<dynamic, dynamic>>> getAllMessages(String chatId) {
    return firestore.collection('chats/$chatId/messages/').snapshots();
  }

  Future<void> sendMessage(Message message, String time, String chatId) async {
    final ref = firestore.collection('chats/$chatId/messages/');
    await ref.doc(time).set(message.toJson().cast());
  }

  Stream<QuerySnapshot<Map<dynamic, dynamic>>> readChatMessages(String chatId) {
    return firestore.collection('chats/$chatId/messages/').snapshots();
  }

  // Future<void> postMessage(
  //   String ms,
  //   String time,
  //   String chatId,
  //   String senderNameUser,
  //   int reciverId,
  //   int senderId,
  // ) async {
  //   final sendTime = DateTime.now().millisecondsSinceEpoch.toString();

  //   final message = Message(
  //     reciverId: reciverId,
  //     senderId: senderId,
  //     message: ms,
  //     send: sendTime,
  //     read: '',
  //     senderNameUser: senderNameUser,
  //   );

  //   // final ref = firestore.collection('chats/$chatId/messages/');
  // await ref.doc(time).set(message.toJson().cast());
  // }
}
