abstract class ChatState {}

class InitialChatState extends ChatState {}

class LoadingChatState extends ChatState {}

class SuccesssChatState extends ChatState {}

class FailChatState extends ChatState {}

class GetMessagesSuccess extends ChatState {}

class ScrollingState extends ChatState {}
