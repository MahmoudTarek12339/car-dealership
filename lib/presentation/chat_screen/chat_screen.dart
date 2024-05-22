import 'package:car_dealership/controller/chat_provider.dart';
import 'package:car_dealership/presentation/chat_screen/widgets/message_item_widget.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<ChatProvider>(
          builder: (_, value, __) {
            //show loading screen while fetching messages
            if (value.isMessagesLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorManager.green,
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: value.messages.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final message = value.messages[index];
                      return MessageItem(message: message);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          onChanged: (m) {
                            value.update();
                          },
                          decoration:
                              InputDecoration(hintText: AppLocalizations.of(context)!.typeMessage),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        //deactivate send button if form field is empty
                        onPressed: controller.text.isNotEmpty
                            ? () {
                                context
                                    .read<ChatProvider>()
                                    .sendMessage(controller.text);
                                controller.clear();
                                FocusScope.of(context).unfocus();
                                value.scrollToBottom();
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
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
      if (!provider.isMessagesLoading&&provider.messages.isNotEmpty) {
        provider.scrollToBottom();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
