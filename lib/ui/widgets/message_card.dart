import 'package:flutter/material.dart';
import 'package:flutter_chat_app/domain/entity/chat.dart';
import 'package:flutter_chat_app/domain/entity/message.dart';
import 'package:flutter_chat_app/ui/view_models/message_card_model.dart';

class MessageCard extends StatefulWidget {
  final Message message;
  final Chat chatSeting;

  const MessageCard(
      {super.key, required this.message, required this.chatSeting});
  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  late final MessageCardModel _model;

  @override
  void initState() {
    super.initState();
    _model = MessageCardModel(
        message: widget.message, chatSetings: widget.chatSeting);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MessageCardWidgetProvider(
      model: _model,
      child: const _MessageCardBody(),
    );
  }
}

class _MessageCardBody extends StatefulWidget {
  const _MessageCardBody();

  @override
  State<_MessageCardBody> createState() => __MessageCardBodyState();
}

class __MessageCardBodyState extends State<_MessageCardBody> {
  @override
  Widget build(BuildContext context) {
    final model = MessageCardWidgetProvider.watch(context)!.model;
    if (model.message.senderId == model.chatSetings.myUserId) {
      return _OwnMessageCardWidget(message: model.message);
    } else {
      return _OtherMessageContainerCardWidget(message: model.message);
    }
  }
}

class _OwnMessageCardWidget extends StatelessWidget {
  final Message message;
  const _OwnMessageCardWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final model = MessageCardWidgetProvider.read(context)!.model;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.message.senderNameUser,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    message.message,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  const SizedBox(height: 14),
                ],
              ),
              Row(
                children: [
                  Text(
                    message.send,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.done_all_rounded,
                    color: Colors.green,
                    size: 18,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _OtherMessageContainerCardWidget extends StatelessWidget {
  final Message message;
  const _OtherMessageContainerCardWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    const image = AssetImage('images/userAvatar.png');
    final model = MessageCardWidgetProvider.read(context)!.model;
    return Row(
      children: [
        const Image(image: image),
        Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 219, 218, 218),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(6),
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.message.senderNameUser,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    message.message,
                    style: const TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  const SizedBox(height: 14),
                ],
              ),
              const SizedBox(width: 15),
              Text(
                message.read,
                style: const TextStyle(
                    color: Color.fromARGB(255, 82, 81, 81),
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
