import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger_app/core/const.dart';
import 'package:messanger_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:messanger_app/cubit/chat_cubit/chat_states.dart';
import 'package:messanger_app/model/message_model.dart';
import 'package:messanger_app/model/user_model.dart';
import 'package:messanger_app/screens/widgets/custom_text_field.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, this.user});
  final UserInformation? user;
  final TextEditingController textMessage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user!.name)),
      body: BlocProvider(
        create: (context) =>
            ChatCubit()..getAllMessages(me: token, him: user!.uid),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<ChatCubit, ChatState>(
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    controller: BlocProvider.of<ChatCubit>(context).controller,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => _messageBox(
                              message: BlocProvider.of<ChatCubit>(context)
                                  .messages[index]),
                          itemCount: BlocProvider.of<ChatCubit>(context)
                              .messages
                              .length,
                        ),
                        const SizedBox(
                          height: 70,
                        )
                      ],
                    ),
                  ),
                  _typeMessage(
                      context: context, reseverId: user!.uid, senderId: token),
                ],
              );
            },
            listener: (context, state) {
              if (state is SuccesssChatState) {
                textMessage.text = '';

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Message Sent !'),
                  ),
                );
              } else if (state is FailChatState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Message failed !'),
                  ),
                );
              }
              if (state is GetMessagesSuccess) {
                BlocProvider.of<ChatCubit>(context).scrollDown();
              }
            },
          ),
        ),
      ),
    );
  }

  Align _typeMessage(
      {required BuildContext context,
      required String senderId,
      required String reseverId}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
        ),
        height: 70,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                child: CustomTextField(
                    hintText: 'type your message ...', controller: textMessage),
              ),
            ),
            IconButton(
                onPressed: () {
                  print('i will scroll');
                  BlocProvider.of<ChatCubit>(context).scrollDown();
                },
                icon: const Icon(
                  Icons.image,
                  size: 35,
                )),
            IconButton(
              onPressed: () {
                BlocProvider.of<ChatCubit>(context).sendMessage(
                  message: textMessage.text,
                  senderId: senderId,
                  reseverId: reseverId,
                  dateTime: DateTime.now().toString(),
                );
              },
              icon: const Icon(
                Icons.send,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _messageBox({required MessageInformationModel message}) {
    bool isFromMe;
    if (message.senderId == token) {
      isFromMe = true;
    } else {
      isFromMe = false;
    }
    return Row(
      mainAxisAlignment:
          isFromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: isFromMe
                ? const Color.fromARGB(255, 126, 117, 108)
                : Colors.black,
            borderRadius: BorderRadius.only(
              bottomRight: isFromMe ? Radius.zero : const Radius.circular(15),
              bottomLeft: isFromMe ? const Radius.circular(15) : Radius.zero,
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
            ),
          ),
          constraints: const BoxConstraints(
            maxWidth: double.infinity,

            // maxHeight:
          ),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              message.message!,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
