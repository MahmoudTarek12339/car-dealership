import 'package:car_dealership/models/message_model.dart';
import 'package:car_dealership/presentation/chat_screen/widgets/message_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/chat_provider.dart';

class MessagesListWidget extends StatefulWidget {
  final List<Message> messages;

  const MessagesListWidget({required this.messages, super.key});

  @override
  State<MessagesListWidget> createState() => _MessagesListWidgetState();
}

class _MessagesListWidgetState extends State<MessagesListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.messages.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final message = widget.messages[index];
          return MessageItem(message: message);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //this line to make screen automatically scroll to last message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ChatProvider>(context, listen: false);
      provider.scrollController = _scrollController;
      if (!provider.isMessagesLoading && provider.messages.isNotEmpty) {
        provider.scrollToBottom();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
