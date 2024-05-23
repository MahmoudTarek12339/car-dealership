import 'package:car_dealership/controller/chat_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({super.key});

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (m) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.typeMessage),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            //deactivate send button if form field is empty
            onPressed: controller.text.isNotEmpty
                ? () {
                    context
                        .read<ChatProvider>()
                        .sendMessage(context, controller.text);
                    controller.clear();
                    FocusScope.of(context).unfocus();
                    context.read<ChatProvider>().scrollToBottom();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
