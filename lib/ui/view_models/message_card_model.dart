import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_chat_app/domain/entity/message.dart';

class MessageCardModel extends ChangeNotifier {
  Chat chatSetings;
  final Message message;
  MessageCardModel({required this.message, required this.chatSetings});
}

class MessageCardWidgetProvider extends InheritedNotifier {
  final MessageCardModel model;
  const MessageCardWidgetProvider(
      {Key? key, required this.model, required Widget child})
      : super(
          key: key,
          notifier: model,
          child: child,
        );

  static MessageCardWidgetProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MessageCardWidgetProvider>();
  }

  static MessageCardWidgetProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<MessageCardWidgetProvider>()
        ?.widget;
    return widget is MessageCardWidgetProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(MessageCardWidgetProvider oldWidget) {
    return true;
  }
}
