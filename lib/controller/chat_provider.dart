import 'dart:convert';

import 'package:car_dealership/models/message_model.dart';
import 'package:car_dealership/presentation/resources/constants.dart';
import 'package:directus/directus.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatProvider with ChangeNotifier {
  late WebSocketChannel _channel;
  late DirectusCore _directusSdk;

  List<Message> messages = [];
  late ScrollController _scrollController;

  bool isMessagesLoading = true;

  set scrollController(ScrollController controller) {
    _scrollController = controller;
  }

  ScrollController get listScrollController => _scrollController;

  ChatProvider() {
    _connectWebSocket();
    Directus(AppConstants.baseUrl).init().then((sdk) {
      _directusSdk = sdk;
      _getInitialMessages();
    });
  }

  //get saved messages from directus api
  void _getInitialMessages() async {
    _directusSdk.items('messages').readMany().then((value) {
      messages =
          value.data.map((message) => Message.fromJson(message)).toList();
      notifyListeners();
      isMessagesLoading = false;
      notifyListeners();
      Future.delayed(const Duration(milliseconds: 70)).then((value) {
        scrollToBottom();
      });
    }).catchError((onError) {
      print('errrrrrror:${onError.toString()}');
      isMessagesLoading = false;
      notifyListeners();
      //scrollToBottom();
    });
  }

  //connect websocket to directus server
  Future<void> _connectWebSocket() async {
    _channel = WebSocketChannel.connect(Uri.parse(AppConstants.webSocketUrl));
    await _channel.ready;
    _websocketListener();
    await _sendAuthenticationData();
    //await subscribe();
  }

  //realtime listen to any changes on messages;
  void _websocketListener() {
    _channel.stream.listen((message) {
      final data = jsonDecode(message);
      print({'event': 'onMessage', 'data': data});
      if (data['type'] == 'auth' && data['status'] == 'ok') {
        subscribe();
      } else if (data['type'] == 'subscription') {
        if (data['event'] == 'init') {
          print('websocket subscribed');
        } else if (data['event'] == 'create') {
          final Message m = Message.fromJson(data['data'].first);
          messages.add(m);
          scrollToBottom();
          notifyListeners();
        }
      } else if (data['type'] == 'items') {
        print({'event': 'onMessage', 'type': 'hello from items'});
      } else if (data['type'] == 'ping') {
        _sendPong();
        print({'event': 'pong replied'});
      }
    }, onDone: () {
      print({'event': 'onDone'});
    }, onError: (error) {
      print({
        'event': 'onError',
        'error': error.toString(),
      });
    });
  }

  Future<void> _sendAuthenticationData() async {
    _channel.sink.add(jsonEncode({
      'type': 'auth',
      'access_token': AppConstants.accessToken,
    }));
  }

  Future<void> subscribe() async {
    _channel.sink.add(jsonEncode({
      'type': 'subscribe',
      'collection': 'messages',
      'event': 'create',
    }));
  }

  //scroll to bottom of chat page
  void scrollToBottom() {
    print('srooooooooooo');
    _scrollController
        .jumpTo(_scrollController.position.maxScrollExtent + 300.0);
    notifyListeners();
  }

  //to respond to bing message from websocket to keep it active
  void _sendPong() {
    final pongMessage = json.encode({'type': 'pong'});
    _channel.sink.add(pongMessage);
  }

  void sendMessage(String content) async {
    final message = Message(
      content: content,
      senderId: AppConstants.userId,
      receiverId: AppConstants.receiverId,
    );
    _channel.sink.add(jsonEncode({
      'type': 'items',
      'collection': 'messages',
      'action': 'create',
      'data': message.toJson(),
    }));
    notifyListeners();
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  void update() {
    notifyListeners();
  }
}
