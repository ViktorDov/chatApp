import 'package:flutter/material.dart';
import 'package:flutter_chat_app/domain/data_provider/firebase_data_provider.dart';
import 'package:flutter_chat_app/domain/models/message.dart';
import 'package:flutter_chat_app/ui/view_models/chat_screen_view_model.dart';

import 'message_car.dart';

class ChatScreenWidget extends StatefulWidget {
  final String chatUserId;
  const ChatScreenWidget({super.key, required this.chatUserId});

  @override
  State<ChatScreenWidget> createState() => _ChatScreenWidgetState();
}

class _ChatScreenWidgetState extends State<ChatScreenWidget> {
  late final ChatScreenModel _model;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _model = ChatScreenModel(chatReciverUserId: widget.chatUserId);
    await _model.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChatScreenWidgetProvider(
      model: _model,
      child: const ChatScreenWidgetBody(),
    );
  }
}

class ChatScreenWidgetBody extends StatefulWidget {
  const ChatScreenWidgetBody({super.key});

  @override
  State<ChatScreenWidgetBody> createState() => _ChatScreenWidgetBodyState();
}

class _ChatScreenWidgetBodyState extends State<ChatScreenWidgetBody> {
  final _textController = TextEditingController();

  var _listMessage = <Message>[];
  final firebaseDataProvider = FirebaseDataProvider();

  @override
  Widget build(BuildContext context) {
    final model = ChatScreenWidgetProvider.watch(context)!.model;
    const image = AssetImage('images/userAvatar.png');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'last seen 45 minutes age',
          style: TextStyle(color: Colors.grey, fontSize: 9),
        ),
        leading: const Image(image: image),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            color: Colors.grey,
            height: 0.5,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: model.getAllMessages(),
              builder: ((context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const SizedBox();
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    _listMessage =
                        data?.map((e) => Message.fromJson(e.data())).toList() ??
                            [];
                    if (_listMessage.isNotEmpty) {
                      return ListView.builder(
                        itemCount: _listMessage.length,
                        itemBuilder: (context, index) {
                          return MessageCard(message: _listMessage[index]);
                        },
                      );
                    } else {
                      return const Center(child: Text('Say Hi'));
                    }
                }
              }),
            ),
          ),
          Container(
            width: double.infinity,
            height: 80,
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey))),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        label: Text(
                          'Start typing...',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        )),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        model.sendMessage(_textController.text);
                        _textController.text = '';
                      } else {
                        return;
                      }
                    },
                    icon: const Icon(Icons.send_rounded)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
