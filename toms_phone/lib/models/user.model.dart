import 'package:isar/isar.dart';

part 'user.model.g.dart';

@collection
class UserModel {
  UserModel({
    required this.phoneNumber,
    required this.createdAt
  });

  Id? id;

  String? contactName;

  final String phoneNumber;

  final DateTime createdAt;
}
