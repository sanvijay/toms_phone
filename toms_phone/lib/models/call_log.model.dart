import 'package:isar/isar.dart';
import 'package:maxs_phone/models/user.model.dart';

part 'call_log.model.g.dart';

@collection
class CallLogModel {
  CallLogModel({
    required this.callType,
    required this.createdAt
  });

  Id? id;

  @enumerated
  final CallType callType;

  final callWith = IsarLink<UserModel>();
  final DateTime createdAt;
}

enum CallType {
  incoming,
  outgoing,
  missed,
  rejected
}
