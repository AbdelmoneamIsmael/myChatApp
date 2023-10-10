import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger_app/cubit/chat_cubit/chat_states.dart';
import 'package:messanger_app/model/message_model.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(InitialChatState());
  late MessageInformationModel messageInformationModel;

  List<MessageInformationModel> messages = [];
  final ScrollController controller = ScrollController();

  Future<bool> sendMessage({
    required String message,
    required String senderId,
    required String dateTime,
    required String reseverId,
  }) async {
    messageInformationModel = MessageInformationModel(
      message: message,
      senderId: senderId,
      reseverId: reseverId,
      dateTime: dateTime,
    );

    try {
      // var putMessageInSenderChat =
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(senderId)
          .collection('Chats')
          .doc(reseverId)
          .collection('Messages')
          .add(messageInformationModel.toMap());

      // var putMessageInReseverChat =
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(reseverId)
          .collection('Chats')
          .doc(senderId)
          .collection('Messages')
          .add(messageInformationModel.toMap());

      emit(SuccesssChatState());
      return true;
    } catch (e) {
      emit(FailChatState());
      return false;
    }
  }

  void scrollDown() {
    if (controller.hasClients) {
      print('yes');
      controller.animateTo(controller.position.maxScrollExtent,
          duration: const Duration(microseconds: 300), curve: Curves.easeInOut);
      emit(ScrollingState());
    }
  }

  void getAllMessages({required String me, required String him}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(me)
        .collection('Chats')
        .doc(him)
        .collection('Messages')
        .orderBy('dateTime')
        .snapshots()
        .listen(
      (event) {
        messages = [];
        emit(GetMessagesSuccess());
        event.docs.forEach(
          (element) {
            messages.add(
              MessageInformationModel.fromJson(
                element.data(),
              ),
            );
            scrollDown();
          },
        );
      },
    );
  }
}
