import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_app/domain/data_provider/firebase_data_provider.dart';
import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_chat_app/domain/services/firebase_service.dart';

class ChatScreenModel extends ChangeNotifier {
  Chat chatSetings;
  final _firebaseService = FirebaseService();
  final FirebaseDataProvider _firebaseDataProvider = FirebaseDataProvider();

  ChatScreenModel({required this.chatSetings});

  String _getChatId() {
    return chatSetings.myUserId.hashCode <= chatSetings.chatUserId.hashCode
        ? '${chatSetings.myUserId}_${chatSetings.chatUserId}'
        : '${chatSetings.chatUserId}_${chatSetings.myUserId}';
  }

  Stream getAllMessages() {
    final chatId = _getChatId();
    return _firebaseDataProvider.getAllMessages(chatId);
  }

  Future<void> sendMessage(String message) async {
    final chatId = _getChatId();
    await _firebaseService.sendMessage(
      message,
      chatId,
      chatSetings.userName,
      chatSetings.myUserId,
      chatSetings.chatUserId,
    );
    notifyListeners();
  }
}

class ChatScreenWidgetProvider extends InheritedNotifier {
  final ChatScreenModel model;
  const ChatScreenWidgetProvider(
      {Key? key, required Widget child, required this.model})
      : super(
          key: key,
          notifier: model,
          child: child,
        );

  static ChatScreenWidgetProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ChatScreenWidgetProvider>();
  }

  static ChatScreenWidgetProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ChatScreenWidgetProvider>()
        ?.widget;
    return widget is ChatScreenWidgetProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(ChatScreenWidgetProvider oldWidget) {
    return true;
  }
}
