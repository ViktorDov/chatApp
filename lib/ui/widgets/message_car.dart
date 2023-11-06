import 'package:flutter/material.dart';
import 'package:flutter_chat_app/domain/models/message.dart';
import 'package:flutter_chat_app/domain/services/user_service.dart';

class MessageCard extends StatefulWidget {
  final Message message;

  const MessageCard({super.key, required this.message});
  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  final userId = UserService().user.id;
  @override
  Widget build(BuildContext context) {
    if (widget.message.senderId == userId) {
      return _OwnMessageCardWidget(message: widget.message);
    } else {
      return _OtherMessageContainerCardWidget(message: widget.message);
    }
  }
}

class _OwnMessageCardWidget extends StatelessWidget {
  final Message message;
  const _OwnMessageCardWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
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
                children: [
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
    final _user = UserService();
    return Row(
      children: [
        const Image(image: image),
        Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 228, 228, 232),
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
                    _user.user.name,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    message.message,
                    style: const TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  const SizedBox(height: 14),
                ],
              ),
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
