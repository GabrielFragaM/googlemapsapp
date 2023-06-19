import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyplay_app/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import '../../../models/user_model.dart';


class GlobalMarkerChat extends StatefulWidget {
  final String markerId;

  const GlobalMarkerChat({Key? key,
    required this.markerId
  }) : super(key: key);

  @override
  _GlobalMarkerChatState createState() => _GlobalMarkerChatState();
}

class _GlobalMarkerChatState extends State<GlobalMarkerChat> {

  List<types.Message> allMessages = [];
  final _mainUser = types.User(id: UserModel.userMapData['id']);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<types.Message>> getAllMessages = (() async* {
      List<types.Message> allMessages = [];

      QuerySnapshot messages = await FirebaseFirestore.instance.collection('markers')
          .doc(widget.markerId).collection('chat').doc('global_chat').collection('messages').get();

      for(QueryDocumentSnapshot message in messages.docs){
        DocumentSnapshot user = await FirebaseFirestore.instance.collection('users').doc(message.get('userId')).get();

        final _message = types.TextMessage(
          author: types.User(
              id: user.id,
              firstName: '@' + user.get('username'),
              imageUrl: user.get('profileImage')['image'],
          ),
          createdAt: message.get('createdAt'),
          id: message.id,
          text: message.get('text'),
        );

        allMessages.add(_message);
      }

      yield allMessages;
    }) ();

    return Scaffold(
      body: StreamBuilder<List<types.Message>>(
          stream: getAllMessages,
          builder: (context, messagesQuery) {
            if (!messagesQuery.hasData) {
              return Container();
            } else {
              return Chat(
                messages: messagesQuery.requireData,
                onMessageTap: _handleMessageTap,
                onPreviewDataFetched: (types.TextMessage message,
                    types.PreviewData previewData) {
                  setState(() {
                    allMessages[ChatModel.previewDataFetched(
                        message, previewData, allMessages)[0]] =
                    ChatModel.previewDataFetched(
                        message, previewData, allMessages)[1];
                  });
                },
                onSendPressed: (types.PartialText message) {
                  setState(() {
                    allMessages.insert(0, ChatModel.sendMessage(
                        message, UserModel.userMapData, widget.markerId));
                  });
                },
                showUserAvatars: true,
                showUserNames: true,
                user: _mainUser,
                l10n: const ChatL10nPt(),
                scrollPhysics: const BouncingScrollPhysics(),
                theme: ChatModel.defaultChatTheme,
              );
            }
          }
      ),
    );
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
  }
}