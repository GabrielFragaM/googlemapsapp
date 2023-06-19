import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../constants/theme/theme_app.dart';

class ChatModel {
  static DefaultChatTheme defaultChatTheme = DefaultChatTheme(
    receivedMessageBodyTextStyle: const TextStyle(fontSize: 12.5),
    sentMessageBodyTextStyle: const TextStyle(fontSize: 12.5, color: Colors.white),
    inputBorderRadius: BorderRadius.circular(20),
    inputMargin: const EdgeInsets.all(10),
    inputBackgroundColor: const Color(0x93000000),
    inputTextCursorColor: Colors.white,
    primaryColor: ThemeApp.themeMainColor,
    inputTextStyle: const TextStyle(fontSize: 12.5, color: Colors.white),
    sendButtonMargin: const EdgeInsets.all(0),
  );

  static sendMessage(types.PartialText message, Map<String, dynamic> user, String makerId) {
    Map<String, dynamic> data = {
      'id': const Uuid().v4(),
      'userId': 'user1',
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'text': message.text,
    };

    FirebaseFirestore.instance.collection('markers').doc(makerId).collection('chat').doc('global_chat').collection('messages').add(data);

    final messageFinal = types.TextMessage(
      author: types.User(
          id: user['id'],
          firstName: '@' + user['username'],
          imageUrl: user['profileImage']
      ),
      createdAt: data['createdAt'],
      id: data['id'],
      text: message.text,
    );

    return messageFinal;
  }

  static previewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      messages
      ) {
    final index = messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (messages[index] as types.TextMessage).copyWith(previewData: previewData,);

    return [index, updatedMessage];
  }

  factory ChatModel() => ChatModel._internal();
  ChatModel._internal();
}