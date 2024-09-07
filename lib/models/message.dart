import 'package:chat_app/constant.dart';

class Message {
  final String massege;
  final String id;

  Message(this.massege, this.id);
  factory Message.fromJson(jsonData) {
    return Message(jsonData[kMessage], jsonData['id']);
  }
}
