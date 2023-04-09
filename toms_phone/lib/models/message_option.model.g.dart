// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_option.model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetMessageOptionModelCollection on Isar {
  IsarCollection<MessageOptionModel> get messageOptionModels =>
      this.collection();
}

const MessageOptionModelSchema = CollectionSchema(
  name: r'MessageOptionModel',
  id: 8833083314609118813,
  properties: {
    r'contactName': PropertySchema(
      id: 0,
      name: r'contactName',
      type: IsarType.string,
    ),
    r'displayQuestion': PropertySchema(
      id: 1,
      name: r'displayQuestion',
      type: IsarType.string,
    ),
    r'question': PropertySchema(
      id: 2,
      name: r'question',
      type: IsarType.string,
    ),
    r'response': PropertySchema(
      id: 3,
      name: r'response',
      type: IsarType.string,
    ),
    r'used': PropertySchema(
      id: 4,
      name: r'used',
      type: IsarType.bool,
    )
  },
  estimateSize: _messageOptionModelEstimateSize,
  serialize: _messageOptionModelSerialize,
  deserialize: _messageOptionModelDeserialize,
  deserializeProp: _messageOptionModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _messageOptionModelGetId,
  getLinks: _messageOptionModelGetLinks,
  attach: _messageOptionModelAttach,
  version: '3.0.5',
);

int _messageOptionModelEstimateSize(
  MessageOptionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.contactName.length * 3;
  bytesCount += 3 + object.displayQuestion.length * 3;
  bytesCount += 3 + object.question.length * 3;
  bytesCount += 3 + object.response.length * 3;
  return bytesCount;
}

void _messageOptionModelSerialize(
  MessageOptionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.contactName);
  writer.writeString(offsets[1], object.displayQuestion);
  writer.writeString(offsets[2], object.question);
  writer.writeString(offsets[3], object.response);
  writer.writeBool(offsets[4], object.used);
}

MessageOptionModel _messageOptionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MessageOptionModel(
    contactName: reader.readString(offsets[0]),
    displayQuestion: reader.readString(offsets[1]),
    question: reader.readString(offsets[2]),
    response: reader.readString(offsets[3]),
  );
  object.id = id;
  object.used = reader.readBool(offsets[4]);
  return object;
}

P _messageOptionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _messageOptionModelGetId(MessageOptionModel object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _messageOptionModelGetLinks(
    MessageOptionModel object) {
  return [];
}

void _messageOptionModelAttach(
    IsarCollection<dynamic> col, Id id, MessageOptionModel object) {
  object.id = id;
}

extension MessageOptionModelQueryWhereSort
    on QueryBuilder<MessageOptionModel, MessageOptionModel, QWhere> {
  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MessageOptionModelQueryWhere
    on QueryBuilder<MessageOptionModel, MessageOptionModel, QWhereClause> {
  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterWhereClause>
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

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterWhereClause>
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

extension MessageOptionModelQueryFilter
    on QueryBuilder<MessageOptionModel, MessageOptionModel, QFilterCondition> {
  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      contactNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      contactNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      contactNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      contactNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contactName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      contactNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      contactNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      contactNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      contactNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contactName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      contactNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      contactNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contactName',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      displayQuestionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      displayQuestionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      displayQuestionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      displayQuestionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayQuestion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      displayQuestionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      displayQuestionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      displayQuestionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      displayQuestionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayQuestion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      displayQuestionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayQuestion',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      displayQuestionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayQuestion',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
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

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      idLessThan(
    Id? value, {
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

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      questionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      questionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      questionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      questionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'question',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      questionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      questionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      questionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      questionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'question',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      questionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      questionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      responseEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'response',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      responseGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'response',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      responseLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'response',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      responseBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'response',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      responseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'response',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      responseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'response',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      responseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'response',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      responseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'response',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      responseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'response',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      responseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'response',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterFilterCondition>
      usedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'used',
        value: value,
      ));
    });
  }
}

extension MessageOptionModelQueryObject
    on QueryBuilder<MessageOptionModel, MessageOptionModel, QFilterCondition> {}

extension MessageOptionModelQueryLinks
    on QueryBuilder<MessageOptionModel, MessageOptionModel, QFilterCondition> {}

extension MessageOptionModelQuerySortBy
    on QueryBuilder<MessageOptionModel, MessageOptionModel, QSortBy> {
  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      sortByContactName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.asc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      sortByContactNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.desc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      sortByDisplayQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayQuestion', Sort.asc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      sortByDisplayQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayQuestion', Sort.desc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      sortByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      sortByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      sortByResponse() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'response', Sort.asc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      sortByResponseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'response', Sort.desc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      sortByUsed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'used', Sort.asc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      sortByUsedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'used', Sort.desc);
    });
  }
}

extension MessageOptionModelQuerySortThenBy
    on QueryBuilder<MessageOptionModel, MessageOptionModel, QSortThenBy> {
  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      thenByContactName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.asc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      thenByContactNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.desc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      thenByDisplayQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayQuestion', Sort.asc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      thenByDisplayQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayQuestion', Sort.desc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      thenByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      thenByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      thenByResponse() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'response', Sort.asc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      thenByResponseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'response', Sort.desc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      thenByUsed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'used', Sort.asc);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QAfterSortBy>
      thenByUsedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'used', Sort.desc);
    });
  }
}

extension MessageOptionModelQueryWhereDistinct
    on QueryBuilder<MessageOptionModel, MessageOptionModel, QDistinct> {
  QueryBuilder<MessageOptionModel, MessageOptionModel, QDistinct>
      distinctByContactName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contactName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QDistinct>
      distinctByDisplayQuestion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayQuestion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QDistinct>
      distinctByQuestion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'question', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QDistinct>
      distinctByResponse({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'response', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageOptionModel, MessageOptionModel, QDistinct>
      distinctByUsed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'used');
    });
  }
}

extension MessageOptionModelQueryProperty
    on QueryBuilder<MessageOptionModel, MessageOptionModel, QQueryProperty> {
  QueryBuilder<MessageOptionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MessageOptionModel, String, QQueryOperations>
      contactNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contactName');
    });
  }

  QueryBuilder<MessageOptionModel, String, QQueryOperations>
      displayQuestionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayQuestion');
    });
  }

  QueryBuilder<MessageOptionModel, String, QQueryOperations>
      questionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'question');
    });
  }

  QueryBuilder<MessageOptionModel, String, QQueryOperations>
      responseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'response');
    });
  }

  QueryBuilder<MessageOptionModel, bool, QQueryOperations> usedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'used');
    });
  }
}
