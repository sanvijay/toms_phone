// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetNotificationModelCollection on Isar {
  IsarCollection<NotificationModel> get notificationModels => this.collection();
}

const NotificationModelSchema = CollectionSchema(
  name: r'NotificationModel',
  id: 1422516433030028244,
  properties: {
    r'canPushKey': PropertySchema(
      id: 0,
      name: r'canPushKey',
      type: IsarType.string,
    ),
    r'created': PropertySchema(
      id: 1,
      name: r'created',
      type: IsarType.dateTime,
    ),
    r'messageContent': PropertySchema(
      id: 2,
      name: r'messageContent',
      type: IsarType.string,
    ),
    r'object': PropertySchema(
      id: 3,
      name: r'object',
      type: IsarType.string,
    ),
    r'pushedAt': PropertySchema(
      id: 4,
      name: r'pushedAt',
      type: IsarType.dateTime,
    ),
    r'read': PropertySchema(
      id: 5,
      name: r'read',
      type: IsarType.bool,
    )
  },
  estimateSize: _notificationModelEstimateSize,
  serialize: _notificationModelSerialize,
  deserialize: _notificationModelDeserialize,
  deserializeProp: _notificationModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'message': LinkSchema(
      id: 8855960654964917451,
      name: r'message',
      target: r'MessageModel',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _notificationModelGetId,
  getLinks: _notificationModelGetLinks,
  attach: _notificationModelAttach,
  version: '3.0.5',
);

int _notificationModelEstimateSize(
  NotificationModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.canPushKey.length * 3;
  {
    final value = object.messageContent;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.object.length * 3;
  return bytesCount;
}

void _notificationModelSerialize(
  NotificationModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.canPushKey);
  writer.writeDateTime(offsets[1], object.created);
  writer.writeString(offsets[2], object.messageContent);
  writer.writeString(offsets[3], object.object);
  writer.writeDateTime(offsets[4], object.pushedAt);
  writer.writeBool(offsets[5], object.read);
}

NotificationModel _notificationModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NotificationModel(
    canPushKey: reader.readString(offsets[0]),
    id: id,
    object: reader.readString(offsets[3]),
  );
  object.messageContent = reader.readStringOrNull(offsets[2]);
  object.pushedAt = reader.readDateTimeOrNull(offsets[4]);
  object.read = reader.readBool(offsets[5]);
  return object;
}

P _notificationModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _notificationModelGetId(NotificationModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _notificationModelGetLinks(
    NotificationModel object) {
  return [object.message];
}

void _notificationModelAttach(
    IsarCollection<dynamic> col, Id id, NotificationModel object) {
  object.message
      .attach(col, col.isar.collection<MessageModel>(), r'message', id);
}

extension NotificationModelQueryWhereSort
    on QueryBuilder<NotificationModel, NotificationModel, QWhere> {
  QueryBuilder<NotificationModel, NotificationModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NotificationModelQueryWhere
    on QueryBuilder<NotificationModel, NotificationModel, QWhereClause> {
  QueryBuilder<NotificationModel, NotificationModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension NotificationModelQueryFilter
    on QueryBuilder<NotificationModel, NotificationModel, QFilterCondition> {
  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      canPushKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canPushKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      canPushKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'canPushKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      canPushKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'canPushKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      canPushKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'canPushKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      canPushKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'canPushKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      canPushKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'canPushKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      canPushKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'canPushKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      canPushKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'canPushKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      canPushKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canPushKey',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      canPushKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'canPushKey',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      createdEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      createdGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      createdLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      createdBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'created',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      messageContentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'messageContent',
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      messageContentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'messageContent',
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      messageContentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      messageContentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      messageContentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      messageContentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageContent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      messageContentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'messageContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      messageContentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'messageContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      messageContentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'messageContent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      messageContentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'messageContent',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      messageContentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageContent',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      messageContentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'messageContent',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      objectEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'object',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      objectGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'object',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      objectLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'object',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      objectBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'object',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      objectStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'object',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      objectEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'object',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      objectContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'object',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      objectMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'object',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      objectIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'object',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      objectIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'object',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      pushedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pushedAt',
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      pushedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pushedAt',
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      pushedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pushedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      pushedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pushedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      pushedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pushedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      pushedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pushedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      readEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'read',
        value: value,
      ));
    });
  }
}

extension NotificationModelQueryObject
    on QueryBuilder<NotificationModel, NotificationModel, QFilterCondition> {}

extension NotificationModelQueryLinks
    on QueryBuilder<NotificationModel, NotificationModel, QFilterCondition> {
  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      message(FilterQuery<MessageModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'message');
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
      messageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'message', 0, true, 0, true);
    });
  }
}

extension NotificationModelQuerySortBy
    on QueryBuilder<NotificationModel, NotificationModel, QSortBy> {
  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      sortByCanPushKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canPushKey', Sort.asc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      sortByCanPushKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canPushKey', Sort.desc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      sortByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.asc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      sortByCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.desc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      sortByMessageContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageContent', Sort.asc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      sortByMessageContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageContent', Sort.desc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      sortByObject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'object', Sort.asc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      sortByObjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'object', Sort.desc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      sortByPushedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pushedAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      sortByPushedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pushedAt', Sort.desc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      sortByRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'read', Sort.asc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      sortByReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'read', Sort.desc);
    });
  }
}

extension NotificationModelQuerySortThenBy
    on QueryBuilder<NotificationModel, NotificationModel, QSortThenBy> {
  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      thenByCanPushKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canPushKey', Sort.asc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      thenByCanPushKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'canPushKey', Sort.desc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      thenByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.asc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      thenByCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.desc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      thenByMessageContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageContent', Sort.asc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      thenByMessageContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageContent', Sort.desc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      thenByObject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'object', Sort.asc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      thenByObjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'object', Sort.desc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      thenByPushedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pushedAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      thenByPushedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pushedAt', Sort.desc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      thenByRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'read', Sort.asc);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QAfterSortBy>
      thenByReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'read', Sort.desc);
    });
  }
}

extension NotificationModelQueryWhereDistinct
    on QueryBuilder<NotificationModel, NotificationModel, QDistinct> {
  QueryBuilder<NotificationModel, NotificationModel, QDistinct>
      distinctByCanPushKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'canPushKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QDistinct>
      distinctByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'created');
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QDistinct>
      distinctByMessageContent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageContent',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QDistinct>
      distinctByObject({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'object', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QDistinct>
      distinctByPushedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pushedAt');
    });
  }

  QueryBuilder<NotificationModel, NotificationModel, QDistinct>
      distinctByRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'read');
    });
  }
}

extension NotificationModelQueryProperty
    on QueryBuilder<NotificationModel, NotificationModel, QQueryProperty> {
  QueryBuilder<NotificationModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NotificationModel, String, QQueryOperations>
      canPushKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'canPushKey');
    });
  }

  QueryBuilder<NotificationModel, DateTime, QQueryOperations>
      createdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'created');
    });
  }

  QueryBuilder<NotificationModel, String?, QQueryOperations>
      messageContentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageContent');
    });
  }

  QueryBuilder<NotificationModel, String, QQueryOperations> objectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'object');
    });
  }

  QueryBuilder<NotificationModel, DateTime?, QQueryOperations>
      pushedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pushedAt');
    });
  }

  QueryBuilder<NotificationModel, bool, QQueryOperations> readProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'read');
    });
  }
}
