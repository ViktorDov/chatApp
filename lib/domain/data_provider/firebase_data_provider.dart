import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/domain/models/message.dart';

class FirebaseDataProvider {
  final firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<dynamic, dynamic>>> getAllMessages(String chatId) {
    return firestore.collection('chats/$chatId/messages/').snapshots();
  }

  Future<void> sendMessage(Message message, String time, String chatId) async {
    final sendTime = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = firestore.collection('chats/$chatId/messages/');
    await ref.doc(sendTime).set({'time': sendTime, ...message.toJson()});
  }
}
