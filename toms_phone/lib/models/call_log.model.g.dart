// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_log.model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetCallLogModelCollection on Isar {
  IsarCollection<CallLogModel> get callLogModels => this.collection();
}

const CallLogModelSchema = CollectionSchema(
  name: r'CallLogModel',
  id: -2361268975012158913,
  properties: {
    r'callType': PropertySchema(
      id: 0,
      name: r'callType',
      type: IsarType.byte,
      enumMap: _CallLogModelcallTypeEnumValueMap,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _callLogModelEstimateSize,
  serialize: _callLogModelSerialize,
  deserialize: _callLogModelDeserialize,
  deserializeProp: _callLogModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'callWith': LinkSchema(
      id: 5158033709228634046,
      name: r'callWith',
      target: r'UserModel',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _callLogModelGetId,
  getLinks: _callLogModelGetLinks,
  attach: _callLogModelAttach,
  version: '3.0.5',
);

int _callLogModelEstimateSize(
  CallLogModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _callLogModelSerialize(
  CallLogModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.callType.index);
  writer.writeDateTime(offsets[1], object.createdAt);
}

CallLogModel _callLogModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CallLogModel(
    callType:
        _CallLogModelcallTypeValueEnumMap[reader.readByteOrNull(offsets[0])] ??
            CallType.incoming,
    createdAt: reader.readDateTime(offsets[1]),
  );
  object.id = id;
  return object;
}

P _callLogModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_CallLogModelcallTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          CallType.incoming) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CallLogModelcallTypeEnumValueMap = {
  'incoming': 0,
  'outgoing': 1,
  'missed': 2,
  'rejected': 3,
};
const _CallLogModelcallTypeValueEnumMap = {
  0: CallType.incoming,
  1: CallType.outgoing,
  2: CallType.missed,
  3: CallType.rejected,
};

Id _callLogModelGetId(CallLogModel object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _callLogModelGetLinks(CallLogModel object) {
  return [object.callWith];
}

void _callLogModelAttach(
    IsarCollection<dynamic> col, Id id, CallLogModel object) {
  object.id = id;
  object.callWith
      .attach(col, col.isar.collection<UserModel>(), r'callWith', id);
}

extension CallLogModelQueryWhereSort
    on QueryBuilder<CallLogModel, CallLogModel, QWhere> {
  QueryBuilder<CallLogModel, CallLogModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CallLogModelQueryWhere
    on QueryBuilder<CallLogModel, CallLogModel, QWhereClause> {
  QueryBuilder<CallLogModel, CallLogModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<CallLogModel, CallLogModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterWhereClause> idBetween(
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

extension CallLogModelQueryFilter
    on QueryBuilder<CallLogModel, CallLogModel, QFilterCondition> {
  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition>
      callTypeEqualTo(CallType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callType',
        value: value,
      ));
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition>
      callTypeGreaterThan(
    CallType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'callType',
        value: value,
      ));
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition>
      callTypeLessThan(
    CallType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'callType',
        value: value,
      ));
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition>
      callTypeBetween(
    CallType lower,
    CallType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'callType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition> idBetween(
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
}

extension CallLogModelQueryObject
    on QueryBuilder<CallLogModel, CallLogModel, QFilterCondition> {}

extension CallLogModelQueryLinks
    on QueryBuilder<CallLogModel, CallLogModel, QFilterCondition> {
  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition> callWith(
      FilterQuery<UserModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'callWith');
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterFilterCondition>
      callWithIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'callWith', 0, true, 0, true);
    });
  }
}

extension CallLogModelQuerySortBy
    on QueryBuilder<CallLogModel, CallLogModel, QSortBy> {
  QueryBuilder<CallLogModel, CallLogModel, QAfterSortBy> sortByCallType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callType', Sort.asc);
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterSortBy> sortByCallTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callType', Sort.desc);
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }
}

extension CallLogModelQuerySortThenBy
    on QueryBuilder<CallLogModel, CallLogModel, QSortThenBy> {
  QueryBuilder<CallLogModel, CallLogModel, QAfterSortBy> thenByCallType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callType', Sort.asc);
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterSortBy> thenByCallTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callType', Sort.desc);
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension CallLogModelQueryWhereDistinct
    on QueryBuilder<CallLogModel, CallLogModel, QDistinct> {
  QueryBuilder<CallLogModel, CallLogModel, QDistinct> distinctByCallType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'callType');
    });
  }

  QueryBuilder<CallLogModel, CallLogModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }
}

extension CallLogModelQueryProperty
    on QueryBuilder<CallLogModel, CallLogModel, QQueryProperty> {
  QueryBuilder<CallLogModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CallLogModel, CallType, QQueryOperations> callTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'callType');
    });
  }

  QueryBuilder<CallLogModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }
}
