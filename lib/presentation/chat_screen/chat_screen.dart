import 'package:car_dealership/controller/chat_provider.dart';
import 'package:car_dealership/presentation/chat_screen/widgets/messages_list_widget.dart';
import 'package:car_dealership/presentation/chat_screen/widgets/send_message_widget.dart';
import 'package:car_dealership/presentation/home_screen/widgets/no_internet_widget.dart';
import 'package:car_dealership/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<ChatProvider>(
          builder: (_, value, __) {
            //show network error widget if no internet connection
            if (value.networkError) {
              return Center(
                child: NoInternetWidget(onPressed: () {
                  value.initApi();
                }),
              );
            }
            //show loading screen while fetching messages
            else if (value.isMessagesLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorManager.green,
                ),
              );
            }
            return Column(
              children: [
                MessagesListWidget(
                  messages: value.messages,
                ),
                const SendMessageWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
