import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Importa dotenv

final String apiKey = dotenv.env['apiKey'] ?? '';
const String sourceId = "src_jxebBqdmiN67V4HgySdcL";
const String apiUrl = "https://api.chatpdf.com/v1/chats/message";

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  Future<void> _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);

    // Llamada a la API de ChatPDF
    String response = await sendMessageToChatPDF(message.text);

    final botMessage = types.TextMessage(
      author: const types.User(id: 'bot', firstName: 'ChatPDF'),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: response,
    );

    _addMessage(botMessage);
  }

  Future<String> sendMessageToChatPDF(String userMessage) async {
    final messages = _messages
        .where((msg) => msg is types.TextMessage)
        .take(5)
        .map((msg) => {
              "role": msg.author.id == _user.id ? "user" : "assistant",
              "content": (msg as types.TextMessage).text
            })
        .toList();

    messages.add({"role": "user", "content": userMessage});

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        "x-api-key": apiKey,
      },
      body: jsonEncode({
        "sourceId": sourceId,
        "messages": messages,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["content"];
    } else {
      return "Error al obtener respuesta de ChatPDF";
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
        ),
      );
}
