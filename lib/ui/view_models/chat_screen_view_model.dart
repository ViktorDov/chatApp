import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_app/domain/data_provider/firebase_data_provider.dart';
import 'package:flutter_chat_app/domain/models/chat.dart';
import 'package:flutter_chat_app/domain/services/firebase_service.dart';
import 'package:flutter_chat_app/domain/services/user_service.dart';

import '../../domain/data_provider/user_data_provider.dart';

class ChatScreenModel extends ChangeNotifier {
  Chat chatSetings;
  var myUserName;
  var myUserId;
  final _userDataProvider = UserDataProvider();
  final _firebaseService = FirebaseService();
  final FirebaseDataProvider _firebaseDataProvider = FirebaseDataProvider();
  final userService = UserService().user;

  ChatScreenModel({required this.chatSetings});

  Future<void> initialize() async {
    await getUser();
  }

  Future<void> getUser() async {
    myUserId = await _userDataProvider.getUserId();
  }

  String getChatId() {
    return chatSetings.myUserId.hashCode <= chatSetings.chatUserId.hashCode
        ? '${chatSetings.myUserId}_${chatSetings.chatUserId}'
        : '${chatSetings.chatUserId}_${chatSetings.myUserId}';
  }

  Stream getAllMessages() {
    final chatId = getChatId();
    return _firebaseDataProvider.getAllMessages(chatId);
  }

  // check tihs function
  String _createTimeString() {
    final hour = DateTime.now().hour.toString();
    final minutes = DateTime.now().minute.toString();

    return '$hour:$minutes';
  }

  Future<void> sendMessage(String message) async {
    final chatId = getChatId();

    // fix this parse ( send reciverId like int, useless function)
    final reciverId = int.parse(chatSetings.chatUserId);
    await _firebaseService.sendMessage(
        message, chatId, myUserName, myUserId, reciverId);
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
