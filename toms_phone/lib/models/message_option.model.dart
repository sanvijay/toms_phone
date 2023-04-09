import 'package:isar/isar.dart';

part 'message_option.model.g.dart';

@collection
class MessageOptionModel {
  MessageOptionModel({
    required this.response,
    required this.contactName,
    required this.question,
    required this.displayQuestion,
  });

  Id? id = Isar.autoIncrement;

  final String contactName;

  bool used = false;

  final String response;
  final String question;
  final String displayQuestion;
}
