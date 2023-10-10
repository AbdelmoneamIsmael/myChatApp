class MessageInformationModel {
  String? message;
  String? senderId;
  String? reseverId;
  String? dateTime;

  MessageInformationModel({
    required this.message,
    required this.senderId,
    required this.reseverId,
    required this.dateTime,
  });

  MessageInformationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    senderId = json['senderId'];
    reseverId = json['reseverId'];
    dateTime = json['dateTime'];
  }
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'senderId': senderId,
      'reseverId': reseverId,
      'dateTime': dateTime,
    };
  }
}
