import 'dart:convert';
import 'dart:developer';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:car_dealership/models/message_model.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:car_dealership/presentation/resources/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:directus/directus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatProvider with ChangeNotifier {
  late WebSocketChannel _channel;
  late DirectusCore _directusSdk;
  late ScrollController _scrollController;
  List<Message> messages = [];

  bool isMessagesLoading = true;

  bool networkError = false;

  set scrollController(ScrollController controller) {
    _scrollController = controller;
  }

  ScrollController get listScrollController => _scrollController;

  ChatProvider() {
    initApi();
  }

  void initApi() async {
    bool internetConnected = await _checkConnection();
    if (internetConnected) {
      _connectWebSocket();
      Directus(AppConstants.baseUrl).init().then((sdk) {
        _directusSdk = sdk;
        _getInitialMessages();
      });
      networkError = false;
    } else {
      isMessagesLoading = false;
      networkError = true;
      notifyListeners();
    }
  }

  //get saved messages from directus api
  void _getInitialMessages() async {
    bool internetConnected = await _checkConnection();
    if (internetConnected) {
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
        isMessagesLoading = false;
        notifyListeners();
      });
    } else {
      isMessagesLoading = false;
      networkError = true;
      notifyListeners();
    }
  }

  //connect websocket to directus server
  Future<void> _connectWebSocket() async {
    bool internetConnected = await _checkConnection();
    if (internetConnected) {
      _channel = WebSocketChannel.connect(Uri.parse(AppConstants.webSocketUrl));
      await _channel.ready;
      _websocketListener();
      await _sendAuthenticationData();
    } else {
      isMessagesLoading = false;
      networkError = true;
      notifyListeners();
    }
  }

  //realtime listen to any changes on messages;
  void _websocketListener() async {
    bool internetConnected = await _checkConnection();
    if (internetConnected) {
      _channel.stream.listen((message) {
        final data = jsonDecode(message);
        if (data['type'] == 'auth' && data['status'] == 'ok') {
          subscribe();
        } else if (data['type'] == 'subscription') {
          if (data['event'] == 'init') {
          } else if (data['event'] == 'create') {
            final Message m = Message.fromJson(data['data'].first);
            messages.add(m);
            scrollToBottom();
            notifyListeners();
          }
        } else if (data['type'] == 'ping') {
          _sendPong();
        }
      }, onDone: () {
        if (kDebugMode) {
          log('event: onDone');
        }
      }, onError: (error) {
        if (kDebugMode) {
          log('event: error{${error.toString()}}');
        }
      });
    } else {
      networkError = true;
      notifyListeners();
    }
  }

  Future<void> _sendAuthenticationData() async {
    bool internetConnected = await _checkConnection();
    if (internetConnected) {
      _channel.sink.add(jsonEncode({
        'type': 'auth',
        'access_token': AppConstants.accessToken,
      }));
    } else {
      networkError = true;
      notifyListeners();
    }
  }

  Future<void> subscribe() async {
    bool internetConnected = await _checkConnection();

    if (internetConnected) {
      _channel.sink.add(jsonEncode({
        'type': 'subscribe',
        'collection': 'messages',
        'event': 'create',
      }));
    } else {
      isMessagesLoading = false;
      networkError = true;
      notifyListeners();
    }
  }

  //scroll to bottom of chat page
  void scrollToBottom() {
    //here i added +100 to make sure it reached the bottom of chat
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 100.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
    notifyListeners();
  }

  //to respond to bing message from websocket to keep it active
  void _sendPong() async {
    bool internetConnected = await _checkConnection();
    if (internetConnected) {
      final pongMessage = json.encode({'type': 'pong'});
      _channel.sink.add(pongMessage);
    } else {
      networkError = true;
      notifyListeners();
    }
  }

  //send user message to api
  void sendMessage(BuildContext context, String content) async {
    bool internetConnected = await _checkConnection();
    if (internetConnected) {
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
    } else {
      _showNoInternetSnackBar(context: context);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  void update() {
    notifyListeners();
  }

  // Check the internet connection status
  Future<bool> _checkConnection() async {
    List<ConnectivityResult> result =
        await (Connectivity().checkConnectivity());
    return result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi);
  }

  void _showNoInternetSnackBar({required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.pleaseCheckConnection),
        backgroundColor: ColorManager.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
