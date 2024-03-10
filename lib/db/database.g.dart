// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MColorTable extends MColor with TableInfo<$MColorTable, MColorData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MColorTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _colorCodeIdMeta =
      const VerificationMeta('colorCodeId');
  @override
  late final GeneratedColumn<String> colorCodeId = GeneratedColumn<String>(
      'color_code_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns => [id, colorCodeId, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'm_color';
  @override
  VerificationContext validateIntegrity(Insertable<MColorData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('color_code_id')) {
      context.handle(
          _colorCodeIdMeta,
          colorCodeId.isAcceptableOrUnknown(
              data['color_code_id']!, _colorCodeIdMeta));
    } else if (isInserting) {
      context.missing(_colorCodeIdMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MColorData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MColorData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      colorCodeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_code_id'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $MColorTable createAlias(String alias) {
    return $MColorTable(attachedDatabase, alias);
  }
}

class MColorData extends DataClass implements Insertable<MColorData> {
  final int id;
  final String colorCodeId;
  final String createAt;
  final String updateAt;
  const MColorData(
      {required this.id,
      required this.colorCodeId,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['color_code_id'] = Variable<String>(colorCodeId);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  MColorCompanion toCompanion(bool nullToAbsent) {
    return MColorCompanion(
      id: Value(id),
      colorCodeId: Value(colorCodeId),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory MColorData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MColorData(
      id: serializer.fromJson<int>(json['id']),
      colorCodeId: serializer.fromJson<String>(json['colorCodeId']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'colorCodeId': serializer.toJson<String>(colorCodeId),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  MColorData copyWith(
          {int? id, String? colorCodeId, String? createAt, String? updateAt}) =>
      MColorData(
        id: id ?? this.id,
        colorCodeId: colorCodeId ?? this.colorCodeId,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('MColorData(')
          ..write('id: $id, ')
          ..write('colorCodeId: $colorCodeId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, colorCodeId, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MColorData &&
          other.id == this.id &&
          other.colorCodeId == this.colorCodeId &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class MColorCompanion extends UpdateCompanion<MColorData> {
  final Value<int> id;
  final Value<String> colorCodeId;
  final Value<String> createAt;
  final Value<String> updateAt;
  const MColorCompanion({
    this.id = const Value.absent(),
    this.colorCodeId = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  });
  MColorCompanion.insert({
    this.id = const Value.absent(),
    required String colorCodeId,
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  }) : colorCodeId = Value(colorCodeId);
  static Insertable<MColorData> custom({
    Expression<int>? id,
    Expression<String>? colorCodeId,
    Expression<String>? createAt,
    Expression<String>? updateAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (colorCodeId != null) 'color_code_id': colorCodeId,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
    });
  }

  MColorCompanion copyWith(
      {Value<int>? id,
      Value<String>? colorCodeId,
      Value<String>? createAt,
      Value<String>? updateAt}) {
    return MColorCompanion(
      id: id ?? this.id,
      colorCodeId: colorCodeId ?? this.colorCodeId,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (colorCodeId.present) {
      map['color_code_id'] = Variable<String>(colorCodeId.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MColorCompanion(')
          ..write('id: $id, ')
          ..write('colorCodeId: $colorCodeId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }
}

class $MAccountTable extends MAccount
    with TableInfo<$MAccountTable, MAccountData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MAccountTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _planTypeMeta =
      const VerificationMeta('planType');
  @override
  late final GeneratedColumn<String> planType = GeneratedColumn<String>(
      'plan_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('0'));
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns =>
      [accountId, address, planType, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'm_account';
  @override
  VerificationContext validateIntegrity(Insertable<MAccountData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('plan_type')) {
      context.handle(_planTypeMeta,
          planType.isAcceptableOrUnknown(data['plan_type']!, _planTypeMeta));
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId};
  @override
  MAccountData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MAccountData(
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      planType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan_type'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $MAccountTable createAlias(String alias) {
    return $MAccountTable(attachedDatabase, alias);
  }
}

class MAccountData extends DataClass implements Insertable<MAccountData> {
  final String accountId;
  final String address;
  final String planType;
  final String createAt;
  final String updateAt;
  const MAccountData(
      {required this.accountId,
      required this.address,
      required this.planType,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<String>(accountId);
    map['address'] = Variable<String>(address);
    map['plan_type'] = Variable<String>(planType);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  MAccountCompanion toCompanion(bool nullToAbsent) {
    return MAccountCompanion(
      accountId: Value(accountId),
      address: Value(address),
      planType: Value(planType),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory MAccountData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MAccountData(
      accountId: serializer.fromJson<String>(json['accountId']),
      address: serializer.fromJson<String>(json['address']),
      planType: serializer.fromJson<String>(json['planType']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<String>(accountId),
      'address': serializer.toJson<String>(address),
      'planType': serializer.toJson<String>(planType),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  MAccountData copyWith(
          {String? accountId,
          String? address,
          String? planType,
          String? createAt,
          String? updateAt}) =>
      MAccountData(
        accountId: accountId ?? this.accountId,
        address: address ?? this.address,
        planType: planType ?? this.planType,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('MAccountData(')
          ..write('accountId: $accountId, ')
          ..write('address: $address, ')
          ..write('planType: $planType, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(accountId, address, planType, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MAccountData &&
          other.accountId == this.accountId &&
          other.address == this.address &&
          other.planType == this.planType &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class MAccountCompanion extends UpdateCompanion<MAccountData> {
  final Value<String> accountId;
  final Value<String> address;
  final Value<String> planType;
  final Value<String> createAt;
  final Value<String> updateAt;
  final Value<int> rowid;
  const MAccountCompanion({
    this.accountId = const Value.absent(),
    this.address = const Value.absent(),
    this.planType = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MAccountCompanion.insert({
    required String accountId,
    required String address,
    this.planType = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : accountId = Value(accountId),
        address = Value(address);
  static Insertable<MAccountData> custom({
    Expression<String>? accountId,
    Expression<String>? address,
    Expression<String>? planType,
    Expression<String>? createAt,
    Expression<String>? updateAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (address != null) 'address': address,
      if (planType != null) 'plan_type': planType,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MAccountCompanion copyWith(
      {Value<String>? accountId,
      Value<String>? address,
      Value<String>? planType,
      Value<String>? createAt,
      Value<String>? updateAt,
      Value<int>? rowid}) {
    return MAccountCompanion(
      accountId: accountId ?? this.accountId,
      address: address ?? this.address,
      planType: planType ?? this.planType,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (planType.present) {
      map['plan_type'] = Variable<String>(planType.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MAccountCompanion(')
          ..write('accountId: $accountId, ')
          ..write('address: $address, ')
          ..write('planType: $planType, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MDevProgressListTable extends MDevProgressList
    with TableInfo<$MDevProgressListTable, MDevProgressListData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MDevProgressListTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns => [id, name, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'm_dev_progress_list';
  @override
  VerificationContext validateIntegrity(
      Insertable<MDevProgressListData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MDevProgressListData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MDevProgressListData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $MDevProgressListTable createAlias(String alias) {
    return $MDevProgressListTable(attachedDatabase, alias);
  }
}

class MDevProgressListData extends DataClass
    implements Insertable<MDevProgressListData> {
  final int id;
  final String name;
  final String createAt;
  final String updateAt;
  const MDevProgressListData(
      {required this.id,
      required this.name,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  MDevProgressListCompanion toCompanion(bool nullToAbsent) {
    return MDevProgressListCompanion(
      id: Value(id),
      name: Value(name),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory MDevProgressListData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MDevProgressListData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  MDevProgressListData copyWith(
          {int? id, String? name, String? createAt, String? updateAt}) =>
      MDevProgressListData(
        id: id ?? this.id,
        name: name ?? this.name,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('MDevProgressListData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MDevProgressListData &&
          other.id == this.id &&
          other.name == this.name &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class MDevProgressListCompanion extends UpdateCompanion<MDevProgressListData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> createAt;
  final Value<String> updateAt;
  const MDevProgressListCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  });
  MDevProgressListCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<MDevProgressListData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? createAt,
    Expression<String>? updateAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
    });
  }

  MDevProgressListCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? createAt,
      Value<String>? updateAt}) {
    return MDevProgressListCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MDevProgressListCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }
}

class $TDevLanguageTable extends TDevLanguage
    with TableInfo<$TDevLanguageTable, TDevLanguageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TDevLanguageTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _devLangIdMeta =
      const VerificationMeta('devLangId');
  @override
  late final GeneratedColumn<String> devLangId = GeneratedColumn<String>(
      'dev_lang_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _isReadOnlyMeta =
      const VerificationMeta('isReadOnly');
  @override
  late final GeneratedColumn<bool> isReadOnly = GeneratedColumn<bool>(
      'is_read_only', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_read_only" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isFrameworkMeta =
      const VerificationMeta('isFramework');
  @override
  late final GeneratedColumn<bool> isFramework = GeneratedColumn<bool>(
      'is_framework', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_framework" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES m_account (account_id)'));
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns =>
      [devLangId, name, isReadOnly, isFramework, accountId, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_dev_language';
  @override
  VerificationContext validateIntegrity(Insertable<TDevLanguageData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('dev_lang_id')) {
      context.handle(
          _devLangIdMeta,
          devLangId.isAcceptableOrUnknown(
              data['dev_lang_id']!, _devLangIdMeta));
    } else if (isInserting) {
      context.missing(_devLangIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_read_only')) {
      context.handle(
          _isReadOnlyMeta,
          isReadOnly.isAcceptableOrUnknown(
              data['is_read_only']!, _isReadOnlyMeta));
    }
    if (data.containsKey('is_framework')) {
      context.handle(
          _isFrameworkMeta,
          isFramework.isAcceptableOrUnknown(
              data['is_framework']!, _isFrameworkMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {devLangId};
  @override
  TDevLanguageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TDevLanguageData(
      devLangId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dev_lang_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isReadOnly: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_read_only'])!,
      isFramework: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_framework'])!,
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $TDevLanguageTable createAlias(String alias) {
    return $TDevLanguageTable(attachedDatabase, alias);
  }
}

class TDevLanguageData extends DataClass
    implements Insertable<TDevLanguageData> {
  final String devLangId;
  final String name;
  final bool isReadOnly;
  final bool isFramework;
  final String accountId;
  final String createAt;
  final String updateAt;
  const TDevLanguageData(
      {required this.devLangId,
      required this.name,
      required this.isReadOnly,
      required this.isFramework,
      required this.accountId,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['dev_lang_id'] = Variable<String>(devLangId);
    map['name'] = Variable<String>(name);
    map['is_read_only'] = Variable<bool>(isReadOnly);
    map['is_framework'] = Variable<bool>(isFramework);
    map['account_id'] = Variable<String>(accountId);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  TDevLanguageCompanion toCompanion(bool nullToAbsent) {
    return TDevLanguageCompanion(
      devLangId: Value(devLangId),
      name: Value(name),
      isReadOnly: Value(isReadOnly),
      isFramework: Value(isFramework),
      accountId: Value(accountId),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory TDevLanguageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TDevLanguageData(
      devLangId: serializer.fromJson<String>(json['devLangId']),
      name: serializer.fromJson<String>(json['name']),
      isReadOnly: serializer.fromJson<bool>(json['isReadOnly']),
      isFramework: serializer.fromJson<bool>(json['isFramework']),
      accountId: serializer.fromJson<String>(json['accountId']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'devLangId': serializer.toJson<String>(devLangId),
      'name': serializer.toJson<String>(name),
      'isReadOnly': serializer.toJson<bool>(isReadOnly),
      'isFramework': serializer.toJson<bool>(isFramework),
      'accountId': serializer.toJson<String>(accountId),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  TDevLanguageData copyWith(
          {String? devLangId,
          String? name,
          bool? isReadOnly,
          bool? isFramework,
          String? accountId,
          String? createAt,
          String? updateAt}) =>
      TDevLanguageData(
        devLangId: devLangId ?? this.devLangId,
        name: name ?? this.name,
        isReadOnly: isReadOnly ?? this.isReadOnly,
        isFramework: isFramework ?? this.isFramework,
        accountId: accountId ?? this.accountId,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('TDevLanguageData(')
          ..write('devLangId: $devLangId, ')
          ..write('name: $name, ')
          ..write('isReadOnly: $isReadOnly, ')
          ..write('isFramework: $isFramework, ')
          ..write('accountId: $accountId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      devLangId, name, isReadOnly, isFramework, accountId, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TDevLanguageData &&
          other.devLangId == this.devLangId &&
          other.name == this.name &&
          other.isReadOnly == this.isReadOnly &&
          other.isFramework == this.isFramework &&
          other.accountId == this.accountId &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class TDevLanguageCompanion extends UpdateCompanion<TDevLanguageData> {
  final Value<String> devLangId;
  final Value<String> name;
  final Value<bool> isReadOnly;
  final Value<bool> isFramework;
  final Value<String> accountId;
  final Value<String> createAt;
  final Value<String> updateAt;
  final Value<int> rowid;
  const TDevLanguageCompanion({
    this.devLangId = const Value.absent(),
    this.name = const Value.absent(),
    this.isReadOnly = const Value.absent(),
    this.isFramework = const Value.absent(),
    this.accountId = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TDevLanguageCompanion.insert({
    required String devLangId,
    required String name,
    this.isReadOnly = const Value.absent(),
    this.isFramework = const Value.absent(),
    required String accountId,
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : devLangId = Value(devLangId),
        name = Value(name),
        accountId = Value(accountId);
  static Insertable<TDevLanguageData> custom({
    Expression<String>? devLangId,
    Expression<String>? name,
    Expression<bool>? isReadOnly,
    Expression<bool>? isFramework,
    Expression<String>? accountId,
    Expression<String>? createAt,
    Expression<String>? updateAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (devLangId != null) 'dev_lang_id': devLangId,
      if (name != null) 'name': name,
      if (isReadOnly != null) 'is_read_only': isReadOnly,
      if (isFramework != null) 'is_framework': isFramework,
      if (accountId != null) 'account_id': accountId,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TDevLanguageCompanion copyWith(
      {Value<String>? devLangId,
      Value<String>? name,
      Value<bool>? isReadOnly,
      Value<bool>? isFramework,
      Value<String>? accountId,
      Value<String>? createAt,
      Value<String>? updateAt,
      Value<int>? rowid}) {
    return TDevLanguageCompanion(
      devLangId: devLangId ?? this.devLangId,
      name: name ?? this.name,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      isFramework: isFramework ?? this.isFramework,
      accountId: accountId ?? this.accountId,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (devLangId.present) {
      map['dev_lang_id'] = Variable<String>(devLangId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isReadOnly.present) {
      map['is_read_only'] = Variable<bool>(isReadOnly.value);
    }
    if (isFramework.present) {
      map['is_framework'] = Variable<bool>(isFramework.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TDevLanguageCompanion(')
          ..write('devLangId: $devLangId, ')
          ..write('name: $name, ')
          ..write('isReadOnly: $isReadOnly, ')
          ..write('isFramework: $isFramework, ')
          ..write('accountId: $accountId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TProjectTable extends TProject
    with TableInfo<$TProjectTable, TProjectData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TProjectTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _colorIdMeta =
      const VerificationMeta('colorId');
  @override
  late final GeneratedColumn<int> colorId = GeneratedColumn<int>(
      'color_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES m_color (id)'));
  static const VerificationMeta _industryMeta =
      const VerificationMeta('industry');
  @override
  late final GeneratedColumn<String> industry = GeneratedColumn<String>(
      'industry', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _displayCountMeta =
      const VerificationMeta('displayCount');
  @override
  late final GeneratedColumn<int> displayCount = GeneratedColumn<int>(
      'display_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tableCountMeta =
      const VerificationMeta('tableCount');
  @override
  late final GeneratedColumn<int> tableCount = GeneratedColumn<int>(
      'table_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
      'end_date', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _devSizeMeta =
      const VerificationMeta('devSize');
  @override
  late final GeneratedColumn<int> devSize = GeneratedColumn<int>(
      'dev_size', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES m_account (account_id)'));
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns => [
        projectId,
        name,
        colorId,
        industry,
        displayCount,
        tableCount,
        startDate,
        endDate,
        description,
        devSize,
        accountId,
        createAt,
        updateAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_project';
  @override
  VerificationContext validateIntegrity(Insertable<TProjectData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_id')) {
      context.handle(_colorIdMeta,
          colorId.isAcceptableOrUnknown(data['color_id']!, _colorIdMeta));
    } else if (isInserting) {
      context.missing(_colorIdMeta);
    }
    if (data.containsKey('industry')) {
      context.handle(_industryMeta,
          industry.isAcceptableOrUnknown(data['industry']!, _industryMeta));
    } else if (isInserting) {
      context.missing(_industryMeta);
    }
    if (data.containsKey('display_count')) {
      context.handle(
          _displayCountMeta,
          displayCount.isAcceptableOrUnknown(
              data['display_count']!, _displayCountMeta));
    } else if (isInserting) {
      context.missing(_displayCountMeta);
    }
    if (data.containsKey('table_count')) {
      context.handle(
          _tableCountMeta,
          tableCount.isAcceptableOrUnknown(
              data['table_count']!, _tableCountMeta));
    } else if (isInserting) {
      context.missing(_tableCountMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('dev_size')) {
      context.handle(_devSizeMeta,
          devSize.isAcceptableOrUnknown(data['dev_size']!, _devSizeMeta));
    } else if (isInserting) {
      context.missing(_devSizeMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {projectId};
  @override
  TProjectData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TProjectData(
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      colorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_id'])!,
      industry: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}industry'])!,
      displayCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}display_count'])!,
      tableCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}table_count'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_date'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      devSize: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dev_size'])!,
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $TProjectTable createAlias(String alias) {
    return $TProjectTable(attachedDatabase, alias);
  }
}

class TProjectData extends DataClass implements Insertable<TProjectData> {
  final String projectId;
  final String name;
  final int colorId;
  final String industry;
  final int displayCount;
  final int tableCount;
  final String startDate;
  final String endDate;
  final String description;
  final int devSize;
  final String accountId;
  final String createAt;
  final String updateAt;
  const TProjectData(
      {required this.projectId,
      required this.name,
      required this.colorId,
      required this.industry,
      required this.displayCount,
      required this.tableCount,
      required this.startDate,
      required this.endDate,
      required this.description,
      required this.devSize,
      required this.accountId,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['project_id'] = Variable<String>(projectId);
    map['name'] = Variable<String>(name);
    map['color_id'] = Variable<int>(colorId);
    map['industry'] = Variable<String>(industry);
    map['display_count'] = Variable<int>(displayCount);
    map['table_count'] = Variable<int>(tableCount);
    map['start_date'] = Variable<String>(startDate);
    map['end_date'] = Variable<String>(endDate);
    map['description'] = Variable<String>(description);
    map['dev_size'] = Variable<int>(devSize);
    map['account_id'] = Variable<String>(accountId);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  TProjectCompanion toCompanion(bool nullToAbsent) {
    return TProjectCompanion(
      projectId: Value(projectId),
      name: Value(name),
      colorId: Value(colorId),
      industry: Value(industry),
      displayCount: Value(displayCount),
      tableCount: Value(tableCount),
      startDate: Value(startDate),
      endDate: Value(endDate),
      description: Value(description),
      devSize: Value(devSize),
      accountId: Value(accountId),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory TProjectData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TProjectData(
      projectId: serializer.fromJson<String>(json['projectId']),
      name: serializer.fromJson<String>(json['name']),
      colorId: serializer.fromJson<int>(json['colorId']),
      industry: serializer.fromJson<String>(json['industry']),
      displayCount: serializer.fromJson<int>(json['displayCount']),
      tableCount: serializer.fromJson<int>(json['tableCount']),
      startDate: serializer.fromJson<String>(json['startDate']),
      endDate: serializer.fromJson<String>(json['endDate']),
      description: serializer.fromJson<String>(json['description']),
      devSize: serializer.fromJson<int>(json['devSize']),
      accountId: serializer.fromJson<String>(json['accountId']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'projectId': serializer.toJson<String>(projectId),
      'name': serializer.toJson<String>(name),
      'colorId': serializer.toJson<int>(colorId),
      'industry': serializer.toJson<String>(industry),
      'displayCount': serializer.toJson<int>(displayCount),
      'tableCount': serializer.toJson<int>(tableCount),
      'startDate': serializer.toJson<String>(startDate),
      'endDate': serializer.toJson<String>(endDate),
      'description': serializer.toJson<String>(description),
      'devSize': serializer.toJson<int>(devSize),
      'accountId': serializer.toJson<String>(accountId),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  TProjectData copyWith(
          {String? projectId,
          String? name,
          int? colorId,
          String? industry,
          int? displayCount,
          int? tableCount,
          String? startDate,
          String? endDate,
          String? description,
          int? devSize,
          String? accountId,
          String? createAt,
          String? updateAt}) =>
      TProjectData(
        projectId: projectId ?? this.projectId,
        name: name ?? this.name,
        colorId: colorId ?? this.colorId,
        industry: industry ?? this.industry,
        displayCount: displayCount ?? this.displayCount,
        tableCount: tableCount ?? this.tableCount,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        description: description ?? this.description,
        devSize: devSize ?? this.devSize,
        accountId: accountId ?? this.accountId,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('TProjectData(')
          ..write('projectId: $projectId, ')
          ..write('name: $name, ')
          ..write('colorId: $colorId, ')
          ..write('industry: $industry, ')
          ..write('displayCount: $displayCount, ')
          ..write('tableCount: $tableCount, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('description: $description, ')
          ..write('devSize: $devSize, ')
          ..write('accountId: $accountId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      projectId,
      name,
      colorId,
      industry,
      displayCount,
      tableCount,
      startDate,
      endDate,
      description,
      devSize,
      accountId,
      createAt,
      updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TProjectData &&
          other.projectId == this.projectId &&
          other.name == this.name &&
          other.colorId == this.colorId &&
          other.industry == this.industry &&
          other.displayCount == this.displayCount &&
          other.tableCount == this.tableCount &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.description == this.description &&
          other.devSize == this.devSize &&
          other.accountId == this.accountId &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class TProjectCompanion extends UpdateCompanion<TProjectData> {
  final Value<String> projectId;
  final Value<String> name;
  final Value<int> colorId;
  final Value<String> industry;
  final Value<int> displayCount;
  final Value<int> tableCount;
  final Value<String> startDate;
  final Value<String> endDate;
  final Value<String> description;
  final Value<int> devSize;
  final Value<String> accountId;
  final Value<String> createAt;
  final Value<String> updateAt;
  final Value<int> rowid;
  const TProjectCompanion({
    this.projectId = const Value.absent(),
    this.name = const Value.absent(),
    this.colorId = const Value.absent(),
    this.industry = const Value.absent(),
    this.displayCount = const Value.absent(),
    this.tableCount = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.description = const Value.absent(),
    this.devSize = const Value.absent(),
    this.accountId = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TProjectCompanion.insert({
    required String projectId,
    required String name,
    required int colorId,
    required String industry,
    required int displayCount,
    required int tableCount,
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    required String description,
    required int devSize,
    required String accountId,
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : projectId = Value(projectId),
        name = Value(name),
        colorId = Value(colorId),
        industry = Value(industry),
        displayCount = Value(displayCount),
        tableCount = Value(tableCount),
        description = Value(description),
        devSize = Value(devSize),
        accountId = Value(accountId);
  static Insertable<TProjectData> custom({
    Expression<String>? projectId,
    Expression<String>? name,
    Expression<int>? colorId,
    Expression<String>? industry,
    Expression<int>? displayCount,
    Expression<int>? tableCount,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<String>? description,
    Expression<int>? devSize,
    Expression<String>? accountId,
    Expression<String>? createAt,
    Expression<String>? updateAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (projectId != null) 'project_id': projectId,
      if (name != null) 'name': name,
      if (colorId != null) 'color_id': colorId,
      if (industry != null) 'industry': industry,
      if (displayCount != null) 'display_count': displayCount,
      if (tableCount != null) 'table_count': tableCount,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (description != null) 'description': description,
      if (devSize != null) 'dev_size': devSize,
      if (accountId != null) 'account_id': accountId,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TProjectCompanion copyWith(
      {Value<String>? projectId,
      Value<String>? name,
      Value<int>? colorId,
      Value<String>? industry,
      Value<int>? displayCount,
      Value<int>? tableCount,
      Value<String>? startDate,
      Value<String>? endDate,
      Value<String>? description,
      Value<int>? devSize,
      Value<String>? accountId,
      Value<String>? createAt,
      Value<String>? updateAt,
      Value<int>? rowid}) {
    return TProjectCompanion(
      projectId: projectId ?? this.projectId,
      name: name ?? this.name,
      colorId: colorId ?? this.colorId,
      industry: industry ?? this.industry,
      displayCount: displayCount ?? this.displayCount,
      tableCount: tableCount ?? this.tableCount,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      devSize: devSize ?? this.devSize,
      accountId: accountId ?? this.accountId,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorId.present) {
      map['color_id'] = Variable<int>(colorId.value);
    }
    if (industry.present) {
      map['industry'] = Variable<String>(industry.value);
    }
    if (displayCount.present) {
      map['display_count'] = Variable<int>(displayCount.value);
    }
    if (tableCount.present) {
      map['table_count'] = Variable<int>(tableCount.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (devSize.present) {
      map['dev_size'] = Variable<int>(devSize.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TProjectCompanion(')
          ..write('projectId: $projectId, ')
          ..write('name: $name, ')
          ..write('colorId: $colorId, ')
          ..write('industry: $industry, ')
          ..write('displayCount: $displayCount, ')
          ..write('tableCount: $tableCount, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('description: $description, ')
          ..write('devSize: $devSize, ')
          ..write('accountId: $accountId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TDevLanguageRelTable extends TDevLanguageRel
    with TableInfo<$TDevLanguageRelTable, TDevLanguageRelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TDevLanguageRelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => '');
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES t_project (project_id)'));
  static const VerificationMeta _devLangIdMeta =
      const VerificationMeta('devLangId');
  @override
  late final GeneratedColumn<String> devLangId = GeneratedColumn<String>(
      'dev_lang_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES t_dev_language (dev_lang_id)'));
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns =>
      [id, content, projectId, devLangId, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_dev_language_rel';
  @override
  VerificationContext validateIntegrity(
      Insertable<TDevLanguageRelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('dev_lang_id')) {
      context.handle(
          _devLangIdMeta,
          devLangId.isAcceptableOrUnknown(
              data['dev_lang_id']!, _devLangIdMeta));
    } else if (isInserting) {
      context.missing(_devLangIdMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TDevLanguageRelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TDevLanguageRelData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!,
      devLangId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dev_lang_id'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $TDevLanguageRelTable createAlias(String alias) {
    return $TDevLanguageRelTable(attachedDatabase, alias);
  }
}

class TDevLanguageRelData extends DataClass
    implements Insertable<TDevLanguageRelData> {
  final int id;
  final String content;
  final String projectId;
  final String devLangId;
  final String createAt;
  final String updateAt;
  const TDevLanguageRelData(
      {required this.id,
      required this.content,
      required this.projectId,
      required this.devLangId,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    map['project_id'] = Variable<String>(projectId);
    map['dev_lang_id'] = Variable<String>(devLangId);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  TDevLanguageRelCompanion toCompanion(bool nullToAbsent) {
    return TDevLanguageRelCompanion(
      id: Value(id),
      content: Value(content),
      projectId: Value(projectId),
      devLangId: Value(devLangId),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory TDevLanguageRelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TDevLanguageRelData(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      projectId: serializer.fromJson<String>(json['projectId']),
      devLangId: serializer.fromJson<String>(json['devLangId']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'projectId': serializer.toJson<String>(projectId),
      'devLangId': serializer.toJson<String>(devLangId),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  TDevLanguageRelData copyWith(
          {int? id,
          String? content,
          String? projectId,
          String? devLangId,
          String? createAt,
          String? updateAt}) =>
      TDevLanguageRelData(
        id: id ?? this.id,
        content: content ?? this.content,
        projectId: projectId ?? this.projectId,
        devLangId: devLangId ?? this.devLangId,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('TDevLanguageRelData(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('projectId: $projectId, ')
          ..write('devLangId: $devLangId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, content, projectId, devLangId, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TDevLanguageRelData &&
          other.id == this.id &&
          other.content == this.content &&
          other.projectId == this.projectId &&
          other.devLangId == this.devLangId &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class TDevLanguageRelCompanion extends UpdateCompanion<TDevLanguageRelData> {
  final Value<int> id;
  final Value<String> content;
  final Value<String> projectId;
  final Value<String> devLangId;
  final Value<String> createAt;
  final Value<String> updateAt;
  const TDevLanguageRelCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.projectId = const Value.absent(),
    this.devLangId = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  });
  TDevLanguageRelCompanion.insert({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    required String projectId,
    required String devLangId,
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  })  : projectId = Value(projectId),
        devLangId = Value(devLangId);
  static Insertable<TDevLanguageRelData> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<String>? projectId,
    Expression<String>? devLangId,
    Expression<String>? createAt,
    Expression<String>? updateAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (projectId != null) 'project_id': projectId,
      if (devLangId != null) 'dev_lang_id': devLangId,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
    });
  }

  TDevLanguageRelCompanion copyWith(
      {Value<int>? id,
      Value<String>? content,
      Value<String>? projectId,
      Value<String>? devLangId,
      Value<String>? createAt,
      Value<String>? updateAt}) {
    return TDevLanguageRelCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      projectId: projectId ?? this.projectId,
      devLangId: devLangId ?? this.devLangId,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (devLangId.present) {
      map['dev_lang_id'] = Variable<String>(devLangId.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TDevLanguageRelCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('projectId: $projectId, ')
          ..write('devLangId: $devLangId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }
}

class $TDevProgressRelTable extends TDevProgressRel
    with TableInfo<$TDevProgressRelTable, TDevProgressRelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TDevProgressRelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES t_project (project_id)'));
  static const VerificationMeta _devProgressIdMeta =
      const VerificationMeta('devProgressId');
  @override
  late final GeneratedColumn<int> devProgressId = GeneratedColumn<int>(
      'dev_progress_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES m_dev_progress_list (id)'));
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns =>
      [id, projectId, devProgressId, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_dev_progress_rel';
  @override
  VerificationContext validateIntegrity(
      Insertable<TDevProgressRelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('dev_progress_id')) {
      context.handle(
          _devProgressIdMeta,
          devProgressId.isAcceptableOrUnknown(
              data['dev_progress_id']!, _devProgressIdMeta));
    } else if (isInserting) {
      context.missing(_devProgressIdMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TDevProgressRelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TDevProgressRelData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!,
      devProgressId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dev_progress_id'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $TDevProgressRelTable createAlias(String alias) {
    return $TDevProgressRelTable(attachedDatabase, alias);
  }
}

class TDevProgressRelData extends DataClass
    implements Insertable<TDevProgressRelData> {
  final int id;
  final String projectId;
  final int devProgressId;
  final String createAt;
  final String updateAt;
  const TDevProgressRelData(
      {required this.id,
      required this.projectId,
      required this.devProgressId,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['project_id'] = Variable<String>(projectId);
    map['dev_progress_id'] = Variable<int>(devProgressId);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  TDevProgressRelCompanion toCompanion(bool nullToAbsent) {
    return TDevProgressRelCompanion(
      id: Value(id),
      projectId: Value(projectId),
      devProgressId: Value(devProgressId),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory TDevProgressRelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TDevProgressRelData(
      id: serializer.fromJson<int>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      devProgressId: serializer.fromJson<int>(json['devProgressId']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectId': serializer.toJson<String>(projectId),
      'devProgressId': serializer.toJson<int>(devProgressId),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  TDevProgressRelData copyWith(
          {int? id,
          String? projectId,
          int? devProgressId,
          String? createAt,
          String? updateAt}) =>
      TDevProgressRelData(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        devProgressId: devProgressId ?? this.devProgressId,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('TDevProgressRelData(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('devProgressId: $devProgressId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, projectId, devProgressId, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TDevProgressRelData &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.devProgressId == this.devProgressId &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class TDevProgressRelCompanion extends UpdateCompanion<TDevProgressRelData> {
  final Value<int> id;
  final Value<String> projectId;
  final Value<int> devProgressId;
  final Value<String> createAt;
  final Value<String> updateAt;
  const TDevProgressRelCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.devProgressId = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  });
  TDevProgressRelCompanion.insert({
    this.id = const Value.absent(),
    required String projectId,
    required int devProgressId,
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  })  : projectId = Value(projectId),
        devProgressId = Value(devProgressId);
  static Insertable<TDevProgressRelData> custom({
    Expression<int>? id,
    Expression<String>? projectId,
    Expression<int>? devProgressId,
    Expression<String>? createAt,
    Expression<String>? updateAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (devProgressId != null) 'dev_progress_id': devProgressId,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
    });
  }

  TDevProgressRelCompanion copyWith(
      {Value<int>? id,
      Value<String>? projectId,
      Value<int>? devProgressId,
      Value<String>? createAt,
      Value<String>? updateAt}) {
    return TDevProgressRelCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      devProgressId: devProgressId ?? this.devProgressId,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (devProgressId.present) {
      map['dev_progress_id'] = Variable<int>(devProgressId.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TDevProgressRelCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('devProgressId: $devProgressId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }
}

class $TTagTable extends TTag with TableInfo<$TTagTable, TTagData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TTagTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _colorIdMeta =
      const VerificationMeta('colorId');
  @override
  late final GeneratedColumn<int> colorId = GeneratedColumn<int>(
      'color_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES m_color (id)'));
  static const VerificationMeta _isReadOnlyMeta =
      const VerificationMeta('isReadOnly');
  @override
  late final GeneratedColumn<bool> isReadOnly = GeneratedColumn<bool>(
      'is_read_only', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_read_only" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES m_account (account_id)'));
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, colorId, isReadOnly, accountId, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_tag';
  @override
  VerificationContext validateIntegrity(Insertable<TTagData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_id')) {
      context.handle(_colorIdMeta,
          colorId.isAcceptableOrUnknown(data['color_id']!, _colorIdMeta));
    } else if (isInserting) {
      context.missing(_colorIdMeta);
    }
    if (data.containsKey('is_read_only')) {
      context.handle(
          _isReadOnlyMeta,
          isReadOnly.isAcceptableOrUnknown(
              data['is_read_only']!, _isReadOnlyMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TTagData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TTagData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      colorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_id'])!,
      isReadOnly: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_read_only'])!,
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $TTagTable createAlias(String alias) {
    return $TTagTable(attachedDatabase, alias);
  }
}

class TTagData extends DataClass implements Insertable<TTagData> {
  final int id;
  final String name;
  final int colorId;
  final bool isReadOnly;
  final String accountId;
  final String createAt;
  final String updateAt;
  const TTagData(
      {required this.id,
      required this.name,
      required this.colorId,
      required this.isReadOnly,
      required this.accountId,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['color_id'] = Variable<int>(colorId);
    map['is_read_only'] = Variable<bool>(isReadOnly);
    map['account_id'] = Variable<String>(accountId);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  TTagCompanion toCompanion(bool nullToAbsent) {
    return TTagCompanion(
      id: Value(id),
      name: Value(name),
      colorId: Value(colorId),
      isReadOnly: Value(isReadOnly),
      accountId: Value(accountId),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory TTagData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TTagData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      colorId: serializer.fromJson<int>(json['colorId']),
      isReadOnly: serializer.fromJson<bool>(json['isReadOnly']),
      accountId: serializer.fromJson<String>(json['accountId']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'colorId': serializer.toJson<int>(colorId),
      'isReadOnly': serializer.toJson<bool>(isReadOnly),
      'accountId': serializer.toJson<String>(accountId),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  TTagData copyWith(
          {int? id,
          String? name,
          int? colorId,
          bool? isReadOnly,
          String? accountId,
          String? createAt,
          String? updateAt}) =>
      TTagData(
        id: id ?? this.id,
        name: name ?? this.name,
        colorId: colorId ?? this.colorId,
        isReadOnly: isReadOnly ?? this.isReadOnly,
        accountId: accountId ?? this.accountId,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('TTagData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorId: $colorId, ')
          ..write('isReadOnly: $isReadOnly, ')
          ..write('accountId: $accountId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, colorId, isReadOnly, accountId, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TTagData &&
          other.id == this.id &&
          other.name == this.name &&
          other.colorId == this.colorId &&
          other.isReadOnly == this.isReadOnly &&
          other.accountId == this.accountId &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class TTagCompanion extends UpdateCompanion<TTagData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> colorId;
  final Value<bool> isReadOnly;
  final Value<String> accountId;
  final Value<String> createAt;
  final Value<String> updateAt;
  const TTagCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.colorId = const Value.absent(),
    this.isReadOnly = const Value.absent(),
    this.accountId = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  });
  TTagCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int colorId,
    this.isReadOnly = const Value.absent(),
    required String accountId,
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  })  : name = Value(name),
        colorId = Value(colorId),
        accountId = Value(accountId);
  static Insertable<TTagData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? colorId,
    Expression<bool>? isReadOnly,
    Expression<String>? accountId,
    Expression<String>? createAt,
    Expression<String>? updateAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (colorId != null) 'color_id': colorId,
      if (isReadOnly != null) 'is_read_only': isReadOnly,
      if (accountId != null) 'account_id': accountId,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
    });
  }

  TTagCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? colorId,
      Value<bool>? isReadOnly,
      Value<String>? accountId,
      Value<String>? createAt,
      Value<String>? updateAt}) {
    return TTagCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      colorId: colorId ?? this.colorId,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      accountId: accountId ?? this.accountId,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorId.present) {
      map['color_id'] = Variable<int>(colorId.value);
    }
    if (isReadOnly.present) {
      map['is_read_only'] = Variable<bool>(isReadOnly.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TTagCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorId: $colorId, ')
          ..write('isReadOnly: $isReadOnly, ')
          ..write('accountId: $accountId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }
}

class $TTagRelTable extends TTagRel with TableInfo<$TTagRelTable, TTagRelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TTagRelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _colorIdMeta =
      const VerificationMeta('colorId');
  @override
  late final GeneratedColumn<int> colorId = GeneratedColumn<int>(
      'color_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES m_color (id)'));
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES t_project (project_id)'));
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES t_tag (id)'));
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns =>
      [id, colorId, projectId, tagId, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_tag_rel';
  @override
  VerificationContext validateIntegrity(Insertable<TTagRelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('color_id')) {
      context.handle(_colorIdMeta,
          colorId.isAcceptableOrUnknown(data['color_id']!, _colorIdMeta));
    } else if (isInserting) {
      context.missing(_colorIdMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TTagRelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TTagRelData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      colorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_id'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $TTagRelTable createAlias(String alias) {
    return $TTagRelTable(attachedDatabase, alias);
  }
}

class TTagRelData extends DataClass implements Insertable<TTagRelData> {
  final int id;
  final int colorId;
  final String projectId;
  final int tagId;
  final String createAt;
  final String updateAt;
  const TTagRelData(
      {required this.id,
      required this.colorId,
      required this.projectId,
      required this.tagId,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['color_id'] = Variable<int>(colorId);
    map['project_id'] = Variable<String>(projectId);
    map['tag_id'] = Variable<int>(tagId);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  TTagRelCompanion toCompanion(bool nullToAbsent) {
    return TTagRelCompanion(
      id: Value(id),
      colorId: Value(colorId),
      projectId: Value(projectId),
      tagId: Value(tagId),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory TTagRelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TTagRelData(
      id: serializer.fromJson<int>(json['id']),
      colorId: serializer.fromJson<int>(json['colorId']),
      projectId: serializer.fromJson<String>(json['projectId']),
      tagId: serializer.fromJson<int>(json['tagId']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'colorId': serializer.toJson<int>(colorId),
      'projectId': serializer.toJson<String>(projectId),
      'tagId': serializer.toJson<int>(tagId),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  TTagRelData copyWith(
          {int? id,
          int? colorId,
          String? projectId,
          int? tagId,
          String? createAt,
          String? updateAt}) =>
      TTagRelData(
        id: id ?? this.id,
        colorId: colorId ?? this.colorId,
        projectId: projectId ?? this.projectId,
        tagId: tagId ?? this.tagId,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('TTagRelData(')
          ..write('id: $id, ')
          ..write('colorId: $colorId, ')
          ..write('projectId: $projectId, ')
          ..write('tagId: $tagId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, colorId, projectId, tagId, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TTagRelData &&
          other.id == this.id &&
          other.colorId == this.colorId &&
          other.projectId == this.projectId &&
          other.tagId == this.tagId &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class TTagRelCompanion extends UpdateCompanion<TTagRelData> {
  final Value<int> id;
  final Value<int> colorId;
  final Value<String> projectId;
  final Value<int> tagId;
  final Value<String> createAt;
  final Value<String> updateAt;
  const TTagRelCompanion({
    this.id = const Value.absent(),
    this.colorId = const Value.absent(),
    this.projectId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  });
  TTagRelCompanion.insert({
    this.id = const Value.absent(),
    required int colorId,
    required String projectId,
    required int tagId,
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  })  : colorId = Value(colorId),
        projectId = Value(projectId),
        tagId = Value(tagId);
  static Insertable<TTagRelData> custom({
    Expression<int>? id,
    Expression<int>? colorId,
    Expression<String>? projectId,
    Expression<int>? tagId,
    Expression<String>? createAt,
    Expression<String>? updateAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (colorId != null) 'color_id': colorId,
      if (projectId != null) 'project_id': projectId,
      if (tagId != null) 'tag_id': tagId,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
    });
  }

  TTagRelCompanion copyWith(
      {Value<int>? id,
      Value<int>? colorId,
      Value<String>? projectId,
      Value<int>? tagId,
      Value<String>? createAt,
      Value<String>? updateAt}) {
    return TTagRelCompanion(
      id: id ?? this.id,
      colorId: colorId ?? this.colorId,
      projectId: projectId ?? this.projectId,
      tagId: tagId ?? this.tagId,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (colorId.present) {
      map['color_id'] = Variable<int>(colorId.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TTagRelCompanion(')
          ..write('id: $id, ')
          ..write('colorId: $colorId, ')
          ..write('projectId: $projectId, ')
          ..write('tagId: $tagId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }
}

class $TToolTable extends TTool with TableInfo<$TToolTable, TToolData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TToolTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _toolIdMeta = const VerificationMeta('toolId');
  @override
  late final GeneratedColumn<String> toolId = GeneratedColumn<String>(
      'tool_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES t_project (project_id)'));
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns =>
      [toolId, name, projectId, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_tool';
  @override
  VerificationContext validateIntegrity(Insertable<TToolData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tool_id')) {
      context.handle(_toolIdMeta,
          toolId.isAcceptableOrUnknown(data['tool_id']!, _toolIdMeta));
    } else if (isInserting) {
      context.missing(_toolIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {toolId};
  @override
  TToolData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TToolData(
      toolId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tool_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $TToolTable createAlias(String alias) {
    return $TToolTable(attachedDatabase, alias);
  }
}

class TToolData extends DataClass implements Insertable<TToolData> {
  final String toolId;
  final String name;
  final String projectId;
  final String createAt;
  final String updateAt;
  const TToolData(
      {required this.toolId,
      required this.name,
      required this.projectId,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tool_id'] = Variable<String>(toolId);
    map['name'] = Variable<String>(name);
    map['project_id'] = Variable<String>(projectId);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  TToolCompanion toCompanion(bool nullToAbsent) {
    return TToolCompanion(
      toolId: Value(toolId),
      name: Value(name),
      projectId: Value(projectId),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory TToolData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TToolData(
      toolId: serializer.fromJson<String>(json['toolId']),
      name: serializer.fromJson<String>(json['name']),
      projectId: serializer.fromJson<String>(json['projectId']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'toolId': serializer.toJson<String>(toolId),
      'name': serializer.toJson<String>(name),
      'projectId': serializer.toJson<String>(projectId),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  TToolData copyWith(
          {String? toolId,
          String? name,
          String? projectId,
          String? createAt,
          String? updateAt}) =>
      TToolData(
        toolId: toolId ?? this.toolId,
        name: name ?? this.name,
        projectId: projectId ?? this.projectId,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('TToolData(')
          ..write('toolId: $toolId, ')
          ..write('name: $name, ')
          ..write('projectId: $projectId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(toolId, name, projectId, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TToolData &&
          other.toolId == this.toolId &&
          other.name == this.name &&
          other.projectId == this.projectId &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class TToolCompanion extends UpdateCompanion<TToolData> {
  final Value<String> toolId;
  final Value<String> name;
  final Value<String> projectId;
  final Value<String> createAt;
  final Value<String> updateAt;
  final Value<int> rowid;
  const TToolCompanion({
    this.toolId = const Value.absent(),
    this.name = const Value.absent(),
    this.projectId = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TToolCompanion.insert({
    required String toolId,
    required String name,
    required String projectId,
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : toolId = Value(toolId),
        name = Value(name),
        projectId = Value(projectId);
  static Insertable<TToolData> custom({
    Expression<String>? toolId,
    Expression<String>? name,
    Expression<String>? projectId,
    Expression<String>? createAt,
    Expression<String>? updateAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (toolId != null) 'tool_id': toolId,
      if (name != null) 'name': name,
      if (projectId != null) 'project_id': projectId,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TToolCompanion copyWith(
      {Value<String>? toolId,
      Value<String>? name,
      Value<String>? projectId,
      Value<String>? createAt,
      Value<String>? updateAt,
      Value<int>? rowid}) {
    return TToolCompanion(
      toolId: toolId ?? this.toolId,
      name: name ?? this.name,
      projectId: projectId ?? this.projectId,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (toolId.present) {
      map['tool_id'] = Variable<String>(toolId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TToolCompanion(')
          ..write('toolId: $toolId, ')
          ..write('name: $name, ')
          ..write('projectId: $projectId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TOsInfoTable extends TOsInfo with TableInfo<$TOsInfoTable, TOsInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TOsInfoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _osIdMeta = const VerificationMeta('osId');
  @override
  late final GeneratedColumn<String> osId = GeneratedColumn<String>(
      'os_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES t_project (project_id)'));
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns =>
      [osId, name, projectId, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_os_info';
  @override
  VerificationContext validateIntegrity(Insertable<TOsInfoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('os_id')) {
      context.handle(
          _osIdMeta, osId.isAcceptableOrUnknown(data['os_id']!, _osIdMeta));
    } else if (isInserting) {
      context.missing(_osIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {osId};
  @override
  TOsInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TOsInfoData(
      osId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}os_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $TOsInfoTable createAlias(String alias) {
    return $TOsInfoTable(attachedDatabase, alias);
  }
}

class TOsInfoData extends DataClass implements Insertable<TOsInfoData> {
  final String osId;
  final String name;
  final String projectId;
  final String createAt;
  final String updateAt;
  const TOsInfoData(
      {required this.osId,
      required this.name,
      required this.projectId,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['os_id'] = Variable<String>(osId);
    map['name'] = Variable<String>(name);
    map['project_id'] = Variable<String>(projectId);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  TOsInfoCompanion toCompanion(bool nullToAbsent) {
    return TOsInfoCompanion(
      osId: Value(osId),
      name: Value(name),
      projectId: Value(projectId),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory TOsInfoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TOsInfoData(
      osId: serializer.fromJson<String>(json['osId']),
      name: serializer.fromJson<String>(json['name']),
      projectId: serializer.fromJson<String>(json['projectId']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'osId': serializer.toJson<String>(osId),
      'name': serializer.toJson<String>(name),
      'projectId': serializer.toJson<String>(projectId),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  TOsInfoData copyWith(
          {String? osId,
          String? name,
          String? projectId,
          String? createAt,
          String? updateAt}) =>
      TOsInfoData(
        osId: osId ?? this.osId,
        name: name ?? this.name,
        projectId: projectId ?? this.projectId,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('TOsInfoData(')
          ..write('osId: $osId, ')
          ..write('name: $name, ')
          ..write('projectId: $projectId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(osId, name, projectId, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TOsInfoData &&
          other.osId == this.osId &&
          other.name == this.name &&
          other.projectId == this.projectId &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class TOsInfoCompanion extends UpdateCompanion<TOsInfoData> {
  final Value<String> osId;
  final Value<String> name;
  final Value<String> projectId;
  final Value<String> createAt;
  final Value<String> updateAt;
  final Value<int> rowid;
  const TOsInfoCompanion({
    this.osId = const Value.absent(),
    this.name = const Value.absent(),
    this.projectId = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TOsInfoCompanion.insert({
    required String osId,
    required String name,
    required String projectId,
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : osId = Value(osId),
        name = Value(name),
        projectId = Value(projectId);
  static Insertable<TOsInfoData> custom({
    Expression<String>? osId,
    Expression<String>? name,
    Expression<String>? projectId,
    Expression<String>? createAt,
    Expression<String>? updateAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (osId != null) 'os_id': osId,
      if (name != null) 'name': name,
      if (projectId != null) 'project_id': projectId,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TOsInfoCompanion copyWith(
      {Value<String>? osId,
      Value<String>? name,
      Value<String>? projectId,
      Value<String>? createAt,
      Value<String>? updateAt,
      Value<int>? rowid}) {
    return TOsInfoCompanion(
      osId: osId ?? this.osId,
      name: name ?? this.name,
      projectId: projectId ?? this.projectId,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (osId.present) {
      map['os_id'] = Variable<String>(osId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TOsInfoCompanion(')
          ..write('osId: $osId, ')
          ..write('name: $name, ')
          ..write('projectId: $projectId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TDbTable extends TDb with TableInfo<$TDbTable, TDbData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TDbTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dbIdMeta = const VerificationMeta('dbId');
  @override
  late final GeneratedColumn<String> dbId = GeneratedColumn<String>(
      'db_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES t_project (project_id)'));
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns =>
      [dbId, name, projectId, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_db';
  @override
  VerificationContext validateIntegrity(Insertable<TDbData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('db_id')) {
      context.handle(
          _dbIdMeta, dbId.isAcceptableOrUnknown(data['db_id']!, _dbIdMeta));
    } else if (isInserting) {
      context.missing(_dbIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dbId};
  @override
  TDbData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TDbData(
      dbId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}db_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $TDbTable createAlias(String alias) {
    return $TDbTable(attachedDatabase, alias);
  }
}

class TDbData extends DataClass implements Insertable<TDbData> {
  final String dbId;
  final String name;
  final String projectId;
  final String createAt;
  final String updateAt;
  const TDbData(
      {required this.dbId,
      required this.name,
      required this.projectId,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['db_id'] = Variable<String>(dbId);
    map['name'] = Variable<String>(name);
    map['project_id'] = Variable<String>(projectId);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  TDbCompanion toCompanion(bool nullToAbsent) {
    return TDbCompanion(
      dbId: Value(dbId),
      name: Value(name),
      projectId: Value(projectId),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory TDbData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TDbData(
      dbId: serializer.fromJson<String>(json['dbId']),
      name: serializer.fromJson<String>(json['name']),
      projectId: serializer.fromJson<String>(json['projectId']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dbId': serializer.toJson<String>(dbId),
      'name': serializer.toJson<String>(name),
      'projectId': serializer.toJson<String>(projectId),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  TDbData copyWith(
          {String? dbId,
          String? name,
          String? projectId,
          String? createAt,
          String? updateAt}) =>
      TDbData(
        dbId: dbId ?? this.dbId,
        name: name ?? this.name,
        projectId: projectId ?? this.projectId,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('TDbData(')
          ..write('dbId: $dbId, ')
          ..write('name: $name, ')
          ..write('projectId: $projectId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(dbId, name, projectId, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TDbData &&
          other.dbId == this.dbId &&
          other.name == this.name &&
          other.projectId == this.projectId &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class TDbCompanion extends UpdateCompanion<TDbData> {
  final Value<String> dbId;
  final Value<String> name;
  final Value<String> projectId;
  final Value<String> createAt;
  final Value<String> updateAt;
  final Value<int> rowid;
  const TDbCompanion({
    this.dbId = const Value.absent(),
    this.name = const Value.absent(),
    this.projectId = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TDbCompanion.insert({
    required String dbId,
    required String name,
    required String projectId,
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : dbId = Value(dbId),
        name = Value(name),
        projectId = Value(projectId);
  static Insertable<TDbData> custom({
    Expression<String>? dbId,
    Expression<String>? name,
    Expression<String>? projectId,
    Expression<String>? createAt,
    Expression<String>? updateAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (dbId != null) 'db_id': dbId,
      if (name != null) 'name': name,
      if (projectId != null) 'project_id': projectId,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TDbCompanion copyWith(
      {Value<String>? dbId,
      Value<String>? name,
      Value<String>? projectId,
      Value<String>? createAt,
      Value<String>? updateAt,
      Value<int>? rowid}) {
    return TDbCompanion(
      dbId: dbId ?? this.dbId,
      name: name ?? this.name,
      projectId: projectId ?? this.projectId,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dbId.present) {
      map['db_id'] = Variable<String>(dbId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TDbCompanion(')
          ..write('dbId: $dbId, ')
          ..write('name: $name, ')
          ..write('projectId: $projectId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TBoardTable extends TBoard with TableInfo<$TBoardTable, TBoardData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TBoardTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _boardIdMeta =
      const VerificationMeta('boardId');
  @override
  late final GeneratedColumn<String> boardId = GeneratedColumn<String>(
      'board_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _orderNoMeta =
      const VerificationMeta('orderNo');
  @override
  late final GeneratedColumn<int> orderNo = GeneratedColumn<int>(
      'order_no', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES t_project (project_id)'));
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns =>
      [boardId, name, orderNo, isCompleted, projectId, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_board';
  @override
  VerificationContext validateIntegrity(Insertable<TBoardData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('board_id')) {
      context.handle(_boardIdMeta,
          boardId.isAcceptableOrUnknown(data['board_id']!, _boardIdMeta));
    } else if (isInserting) {
      context.missing(_boardIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('order_no')) {
      context.handle(_orderNoMeta,
          orderNo.isAcceptableOrUnknown(data['order_no']!, _orderNoMeta));
    } else if (isInserting) {
      context.missing(_orderNoMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {boardId};
  @override
  TBoardData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TBoardData(
      boardId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}board_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      orderNo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_no'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $TBoardTable createAlias(String alias) {
    return $TBoardTable(attachedDatabase, alias);
  }
}

class TBoardData extends DataClass implements Insertable<TBoardData> {
  final String boardId;
  final String name;
  final int orderNo;
  final bool isCompleted;
  final String projectId;
  final String createAt;
  final String updateAt;
  const TBoardData(
      {required this.boardId,
      required this.name,
      required this.orderNo,
      required this.isCompleted,
      required this.projectId,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['board_id'] = Variable<String>(boardId);
    map['name'] = Variable<String>(name);
    map['order_no'] = Variable<int>(orderNo);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['project_id'] = Variable<String>(projectId);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  TBoardCompanion toCompanion(bool nullToAbsent) {
    return TBoardCompanion(
      boardId: Value(boardId),
      name: Value(name),
      orderNo: Value(orderNo),
      isCompleted: Value(isCompleted),
      projectId: Value(projectId),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory TBoardData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TBoardData(
      boardId: serializer.fromJson<String>(json['boardId']),
      name: serializer.fromJson<String>(json['name']),
      orderNo: serializer.fromJson<int>(json['orderNo']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      projectId: serializer.fromJson<String>(json['projectId']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'boardId': serializer.toJson<String>(boardId),
      'name': serializer.toJson<String>(name),
      'orderNo': serializer.toJson<int>(orderNo),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'projectId': serializer.toJson<String>(projectId),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  TBoardData copyWith(
          {String? boardId,
          String? name,
          int? orderNo,
          bool? isCompleted,
          String? projectId,
          String? createAt,
          String? updateAt}) =>
      TBoardData(
        boardId: boardId ?? this.boardId,
        name: name ?? this.name,
        orderNo: orderNo ?? this.orderNo,
        isCompleted: isCompleted ?? this.isCompleted,
        projectId: projectId ?? this.projectId,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('TBoardData(')
          ..write('boardId: $boardId, ')
          ..write('name: $name, ')
          ..write('orderNo: $orderNo, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('projectId: $projectId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      boardId, name, orderNo, isCompleted, projectId, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TBoardData &&
          other.boardId == this.boardId &&
          other.name == this.name &&
          other.orderNo == this.orderNo &&
          other.isCompleted == this.isCompleted &&
          other.projectId == this.projectId &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class TBoardCompanion extends UpdateCompanion<TBoardData> {
  final Value<String> boardId;
  final Value<String> name;
  final Value<int> orderNo;
  final Value<bool> isCompleted;
  final Value<String> projectId;
  final Value<String> createAt;
  final Value<String> updateAt;
  final Value<int> rowid;
  const TBoardCompanion({
    this.boardId = const Value.absent(),
    this.name = const Value.absent(),
    this.orderNo = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.projectId = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TBoardCompanion.insert({
    required String boardId,
    required String name,
    required int orderNo,
    this.isCompleted = const Value.absent(),
    required String projectId,
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : boardId = Value(boardId),
        name = Value(name),
        orderNo = Value(orderNo),
        projectId = Value(projectId);
  static Insertable<TBoardData> custom({
    Expression<String>? boardId,
    Expression<String>? name,
    Expression<int>? orderNo,
    Expression<bool>? isCompleted,
    Expression<String>? projectId,
    Expression<String>? createAt,
    Expression<String>? updateAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (boardId != null) 'board_id': boardId,
      if (name != null) 'name': name,
      if (orderNo != null) 'order_no': orderNo,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (projectId != null) 'project_id': projectId,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TBoardCompanion copyWith(
      {Value<String>? boardId,
      Value<String>? name,
      Value<int>? orderNo,
      Value<bool>? isCompleted,
      Value<String>? projectId,
      Value<String>? createAt,
      Value<String>? updateAt,
      Value<int>? rowid}) {
    return TBoardCompanion(
      boardId: boardId ?? this.boardId,
      name: name ?? this.name,
      orderNo: orderNo ?? this.orderNo,
      isCompleted: isCompleted ?? this.isCompleted,
      projectId: projectId ?? this.projectId,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (boardId.present) {
      map['board_id'] = Variable<String>(boardId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (orderNo.present) {
      map['order_no'] = Variable<int>(orderNo.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TBoardCompanion(')
          ..write('boardId: $boardId, ')
          ..write('name: $name, ')
          ..write('orderNo: $orderNo, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('projectId: $projectId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TTaskTable extends TTask with TableInfo<$TTaskTable, TTaskData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TTaskTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _orderNoMeta =
      const VerificationMeta('orderNo');
  @override
  late final GeneratedColumn<int> orderNo = GeneratedColumn<int>(
      'order_no', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
      'end_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<String> dueDate = GeneratedColumn<String>(
      'due_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _boardIdMeta =
      const VerificationMeta('boardId');
  @override
  late final GeneratedColumn<String> boardId = GeneratedColumn<String>(
      'board_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES t_board (board_id)'));
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns => [
        taskId,
        name,
        description,
        orderNo,
        startDate,
        endDate,
        dueDate,
        boardId,
        createAt,
        updateAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_task';
  @override
  VerificationContext validateIntegrity(Insertable<TTaskData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('order_no')) {
      context.handle(_orderNoMeta,
          orderNo.isAcceptableOrUnknown(data['order_no']!, _orderNoMeta));
    } else if (isInserting) {
      context.missing(_orderNoMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('board_id')) {
      context.handle(_boardIdMeta,
          boardId.isAcceptableOrUnknown(data['board_id']!, _boardIdMeta));
    } else if (isInserting) {
      context.missing(_boardIdMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {taskId};
  @override
  TTaskData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TTaskData(
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      orderNo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_no'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_date']),
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}due_date'])!,
      boardId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}board_id'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $TTaskTable createAlias(String alias) {
    return $TTaskTable(attachedDatabase, alias);
  }
}

class TTaskData extends DataClass implements Insertable<TTaskData> {
  final String taskId;
  final String name;
  final String description;
  final int orderNo;
  final String startDate;
  final String? endDate;
  final String dueDate;
  final String boardId;
  final String createAt;
  final String updateAt;
  const TTaskData(
      {required this.taskId,
      required this.name,
      required this.description,
      required this.orderNo,
      required this.startDate,
      this.endDate,
      required this.dueDate,
      required this.boardId,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['task_id'] = Variable<String>(taskId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['order_no'] = Variable<int>(orderNo);
    map['start_date'] = Variable<String>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<String>(endDate);
    }
    map['due_date'] = Variable<String>(dueDate);
    map['board_id'] = Variable<String>(boardId);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  TTaskCompanion toCompanion(bool nullToAbsent) {
    return TTaskCompanion(
      taskId: Value(taskId),
      name: Value(name),
      description: Value(description),
      orderNo: Value(orderNo),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      dueDate: Value(dueDate),
      boardId: Value(boardId),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory TTaskData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TTaskData(
      taskId: serializer.fromJson<String>(json['taskId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      orderNo: serializer.fromJson<int>(json['orderNo']),
      startDate: serializer.fromJson<String>(json['startDate']),
      endDate: serializer.fromJson<String?>(json['endDate']),
      dueDate: serializer.fromJson<String>(json['dueDate']),
      boardId: serializer.fromJson<String>(json['boardId']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'taskId': serializer.toJson<String>(taskId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'orderNo': serializer.toJson<int>(orderNo),
      'startDate': serializer.toJson<String>(startDate),
      'endDate': serializer.toJson<String?>(endDate),
      'dueDate': serializer.toJson<String>(dueDate),
      'boardId': serializer.toJson<String>(boardId),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  TTaskData copyWith(
          {String? taskId,
          String? name,
          String? description,
          int? orderNo,
          String? startDate,
          Value<String?> endDate = const Value.absent(),
          String? dueDate,
          String? boardId,
          String? createAt,
          String? updateAt}) =>
      TTaskData(
        taskId: taskId ?? this.taskId,
        name: name ?? this.name,
        description: description ?? this.description,
        orderNo: orderNo ?? this.orderNo,
        startDate: startDate ?? this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        dueDate: dueDate ?? this.dueDate,
        boardId: boardId ?? this.boardId,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('TTaskData(')
          ..write('taskId: $taskId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('orderNo: $orderNo, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('boardId: $boardId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(taskId, name, description, orderNo, startDate,
      endDate, dueDate, boardId, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TTaskData &&
          other.taskId == this.taskId &&
          other.name == this.name &&
          other.description == this.description &&
          other.orderNo == this.orderNo &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.dueDate == this.dueDate &&
          other.boardId == this.boardId &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class TTaskCompanion extends UpdateCompanion<TTaskData> {
  final Value<String> taskId;
  final Value<String> name;
  final Value<String> description;
  final Value<int> orderNo;
  final Value<String> startDate;
  final Value<String?> endDate;
  final Value<String> dueDate;
  final Value<String> boardId;
  final Value<String> createAt;
  final Value<String> updateAt;
  final Value<int> rowid;
  const TTaskCompanion({
    this.taskId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.orderNo = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.boardId = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TTaskCompanion.insert({
    required String taskId,
    required String name,
    required String description,
    required int orderNo,
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    required String dueDate,
    required String boardId,
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : taskId = Value(taskId),
        name = Value(name),
        description = Value(description),
        orderNo = Value(orderNo),
        dueDate = Value(dueDate),
        boardId = Value(boardId);
  static Insertable<TTaskData> custom({
    Expression<String>? taskId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? orderNo,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<String>? dueDate,
    Expression<String>? boardId,
    Expression<String>? createAt,
    Expression<String>? updateAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (taskId != null) 'task_id': taskId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (orderNo != null) 'order_no': orderNo,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (dueDate != null) 'due_date': dueDate,
      if (boardId != null) 'board_id': boardId,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TTaskCompanion copyWith(
      {Value<String>? taskId,
      Value<String>? name,
      Value<String>? description,
      Value<int>? orderNo,
      Value<String>? startDate,
      Value<String?>? endDate,
      Value<String>? dueDate,
      Value<String>? boardId,
      Value<String>? createAt,
      Value<String>? updateAt,
      Value<int>? rowid}) {
    return TTaskCompanion(
      taskId: taskId ?? this.taskId,
      name: name ?? this.name,
      description: description ?? this.description,
      orderNo: orderNo ?? this.orderNo,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dueDate: dueDate ?? this.dueDate,
      boardId: boardId ?? this.boardId,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (orderNo.present) {
      map['order_no'] = Variable<int>(orderNo.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<String>(dueDate.value);
    }
    if (boardId.present) {
      map['board_id'] = Variable<String>(boardId.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TTaskCompanion(')
          ..write('taskId: $taskId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('orderNo: $orderNo, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('boardId: $boardId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TTaskTagTable extends TTaskTag
    with TableInfo<$TTaskTagTable, TTaskTagData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TTaskTagTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES t_task (task_id)'));
  static const VerificationMeta _tagRelIdMeta =
      const VerificationMeta('tagRelId');
  @override
  late final GeneratedColumn<int> tagRelId = GeneratedColumn<int>(
      'tag_rel_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES t_tag_rel (id)'));
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns =>
      [id, taskId, tagRelId, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_task_tag';
  @override
  VerificationContext validateIntegrity(Insertable<TTaskTagData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('tag_rel_id')) {
      context.handle(_tagRelIdMeta,
          tagRelId.isAcceptableOrUnknown(data['tag_rel_id']!, _tagRelIdMeta));
    } else if (isInserting) {
      context.missing(_tagRelIdMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TTaskTagData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TTaskTagData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id'])!,
      tagRelId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_rel_id'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $TTaskTagTable createAlias(String alias) {
    return $TTaskTagTable(attachedDatabase, alias);
  }
}

class TTaskTagData extends DataClass implements Insertable<TTaskTagData> {
  final int id;
  final String taskId;
  final int tagRelId;
  final String createAt;
  final String updateAt;
  const TTaskTagData(
      {required this.id,
      required this.taskId,
      required this.tagRelId,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task_id'] = Variable<String>(taskId);
    map['tag_rel_id'] = Variable<int>(tagRelId);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  TTaskTagCompanion toCompanion(bool nullToAbsent) {
    return TTaskTagCompanion(
      id: Value(id),
      taskId: Value(taskId),
      tagRelId: Value(tagRelId),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory TTaskTagData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TTaskTagData(
      id: serializer.fromJson<int>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      tagRelId: serializer.fromJson<int>(json['tagRelId']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taskId': serializer.toJson<String>(taskId),
      'tagRelId': serializer.toJson<int>(tagRelId),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  TTaskTagData copyWith(
          {int? id,
          String? taskId,
          int? tagRelId,
          String? createAt,
          String? updateAt}) =>
      TTaskTagData(
        id: id ?? this.id,
        taskId: taskId ?? this.taskId,
        tagRelId: tagRelId ?? this.tagRelId,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('TTaskTagData(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('tagRelId: $tagRelId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taskId, tagRelId, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TTaskTagData &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.tagRelId == this.tagRelId &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class TTaskTagCompanion extends UpdateCompanion<TTaskTagData> {
  final Value<int> id;
  final Value<String> taskId;
  final Value<int> tagRelId;
  final Value<String> createAt;
  final Value<String> updateAt;
  const TTaskTagCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.tagRelId = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  });
  TTaskTagCompanion.insert({
    this.id = const Value.absent(),
    required String taskId,
    required int tagRelId,
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  })  : taskId = Value(taskId),
        tagRelId = Value(tagRelId);
  static Insertable<TTaskTagData> custom({
    Expression<int>? id,
    Expression<String>? taskId,
    Expression<int>? tagRelId,
    Expression<String>? createAt,
    Expression<String>? updateAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (tagRelId != null) 'tag_rel_id': tagRelId,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
    });
  }

  TTaskTagCompanion copyWith(
      {Value<int>? id,
      Value<String>? taskId,
      Value<int>? tagRelId,
      Value<String>? createAt,
      Value<String>? updateAt}) {
    return TTaskTagCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      tagRelId: tagRelId ?? this.tagRelId,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (tagRelId.present) {
      map['tag_rel_id'] = Variable<int>(tagRelId.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TTaskTagCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('tagRelId: $tagRelId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }
}

class $TTaskDevTable extends TTaskDev
    with TableInfo<$TTaskDevTable, TTaskDevData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TTaskDevTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES t_task (task_id)'));
  static const VerificationMeta _devLangIdMeta =
      const VerificationMeta('devLangId');
  @override
  late final GeneratedColumn<String> devLangId = GeneratedColumn<String>(
      'dev_lang_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES t_dev_language (dev_lang_id)'));
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  @override
  List<GeneratedColumn> get $columns => [taskId, devLangId, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_task_dev';
  @override
  VerificationContext validateIntegrity(Insertable<TTaskDevData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('dev_lang_id')) {
      context.handle(
          _devLangIdMeta,
          devLangId.isAcceptableOrUnknown(
              data['dev_lang_id']!, _devLangIdMeta));
    } else if (isInserting) {
      context.missing(_devLangIdMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {taskId};
  @override
  TTaskDevData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TTaskDevData(
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id'])!,
      devLangId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dev_lang_id'])!,
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $TTaskDevTable createAlias(String alias) {
    return $TTaskDevTable(attachedDatabase, alias);
  }
}

class TTaskDevData extends DataClass implements Insertable<TTaskDevData> {
  final String taskId;
  final String devLangId;
  final String createAt;
  final String updateAt;
  const TTaskDevData(
      {required this.taskId,
      required this.devLangId,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['task_id'] = Variable<String>(taskId);
    map['dev_lang_id'] = Variable<String>(devLangId);
    map['create_at'] = Variable<String>(createAt);
    map['update_at'] = Variable<String>(updateAt);
    return map;
  }

  TTaskDevCompanion toCompanion(bool nullToAbsent) {
    return TTaskDevCompanion(
      taskId: Value(taskId),
      devLangId: Value(devLangId),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory TTaskDevData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TTaskDevData(
      taskId: serializer.fromJson<String>(json['taskId']),
      devLangId: serializer.fromJson<String>(json['devLangId']),
      createAt: serializer.fromJson<String>(json['createAt']),
      updateAt: serializer.fromJson<String>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'taskId': serializer.toJson<String>(taskId),
      'devLangId': serializer.toJson<String>(devLangId),
      'createAt': serializer.toJson<String>(createAt),
      'updateAt': serializer.toJson<String>(updateAt),
    };
  }

  TTaskDevData copyWith(
          {String? taskId,
          String? devLangId,
          String? createAt,
          String? updateAt}) =>
      TTaskDevData(
        taskId: taskId ?? this.taskId,
        devLangId: devLangId ?? this.devLangId,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('TTaskDevData(')
          ..write('taskId: $taskId, ')
          ..write('devLangId: $devLangId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(taskId, devLangId, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TTaskDevData &&
          other.taskId == this.taskId &&
          other.devLangId == this.devLangId &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class TTaskDevCompanion extends UpdateCompanion<TTaskDevData> {
  final Value<String> taskId;
  final Value<String> devLangId;
  final Value<String> createAt;
  final Value<String> updateAt;
  final Value<int> rowid;
  const TTaskDevCompanion({
    this.taskId = const Value.absent(),
    this.devLangId = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TTaskDevCompanion.insert({
    required String taskId,
    required String devLangId,
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : taskId = Value(taskId),
        devLangId = Value(devLangId);
  static Insertable<TTaskDevData> custom({
    Expression<String>? taskId,
    Expression<String>? devLangId,
    Expression<String>? createAt,
    Expression<String>? updateAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (taskId != null) 'task_id': taskId,
      if (devLangId != null) 'dev_lang_id': devLangId,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TTaskDevCompanion copyWith(
      {Value<String>? taskId,
      Value<String>? devLangId,
      Value<String>? createAt,
      Value<String>? updateAt,
      Value<int>? rowid}) {
    return TTaskDevCompanion(
      taskId: taskId ?? this.taskId,
      devLangId: devLangId ?? this.devLangId,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (devLangId.present) {
      map['dev_lang_id'] = Variable<String>(devLangId.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TTaskDevCompanion(')
          ..write('taskId: $taskId, ')
          ..write('devLangId: $devLangId, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$StairsDatabase extends GeneratedDatabase {
  _$StairsDatabase(QueryExecutor e) : super(e);
  late final $MColorTable mColor = $MColorTable(this);
  late final $MAccountTable mAccount = $MAccountTable(this);
  late final $MDevProgressListTable mDevProgressList =
      $MDevProgressListTable(this);
  late final $TDevLanguageTable tDevLanguage = $TDevLanguageTable(this);
  late final $TProjectTable tProject = $TProjectTable(this);
  late final $TDevLanguageRelTable tDevLanguageRel =
      $TDevLanguageRelTable(this);
  late final $TDevProgressRelTable tDevProgressRel =
      $TDevProgressRelTable(this);
  late final $TTagTable tTag = $TTagTable(this);
  late final $TTagRelTable tTagRel = $TTagRelTable(this);
  late final $TToolTable tTool = $TToolTable(this);
  late final $TOsInfoTable tOsInfo = $TOsInfoTable(this);
  late final $TDbTable tDb = $TDbTable(this);
  late final $TBoardTable tBoard = $TBoardTable(this);
  late final $TTaskTable tTask = $TTaskTable(this);
  late final $TTaskTagTable tTaskTag = $TTaskTagTable(this);
  late final $TTaskDevTable tTaskDev = $TTaskDevTable(this);
  late final Index colorId =
      Index('color_id', 'CREATE INDEX color_id ON m_color (id)');
  late final Index accountId =
      Index('account_id', 'CREATE INDEX account_id ON m_account (account_id)');
  late final Index devProgressId = Index('dev_progress_id',
      'CREATE INDEX dev_progress_id ON m_dev_progress_list (id)');
  late final Index tDevLangId = Index('t_dev_lang_id',
      'CREATE INDEX t_dev_lang_id ON t_dev_language (dev_lang_id)');
  late final Index devLangRelId = Index('dev_lang_rel_id',
      'CREATE INDEX dev_lang_rel_id ON t_dev_language_rel (id)');
  late final Index projectId =
      Index('project_id', 'CREATE INDEX project_id ON t_project (project_id)');
  late final Index devProgressRelId = Index('dev_progress_rel_id',
      'CREATE INDEX dev_progress_rel_id ON t_dev_progress_rel (id)');
  late final Index tagId = Index('tag_id', 'CREATE INDEX tag_id ON t_tag (id)');
  late final Index tagRelId =
      Index('tag_rel_id', 'CREATE INDEX tag_rel_id ON t_tag_rel (id)');
  late final Index toolId =
      Index('tool_id', 'CREATE INDEX tool_id ON t_tool (tool_id)');
  late final Index osId =
      Index('os_id', 'CREATE INDEX os_id ON t_os_info (os_id)');
  late final Index dbId = Index('db_id', 'CREATE INDEX db_id ON t_db (db_id)');
  late final Index boardId =
      Index('board_id', 'CREATE INDEX board_id ON t_board (board_id)');
  late final Index taskId =
      Index('task_id', 'CREATE INDEX task_id ON t_task (task_id)');
  late final Index taskTagId =
      Index('task_tag_id', 'CREATE INDEX task_tag_id ON t_task_tag (id)');
  late final Index taskDevId =
      Index('task_dev_id', 'CREATE INDEX task_dev_id ON t_task_dev (task_id)');
  late final MAccountDao mAccountDao = MAccountDao(this as StairsDatabase);
  late final TProjectDao tProjectDao = TProjectDao(this as StairsDatabase);
  late final TOsInfoDao tOsInfoDao = TOsInfoDao(this as StairsDatabase);
  late final TDbDao tDbDao = TDbDao(this as StairsDatabase);
  late final TDevLangRelDao tDevLangRelDao =
      TDevLangRelDao(this as StairsDatabase);
  late final TToolDao tToolDao = TToolDao(this as StairsDatabase);
  late final TDevProgressRelDao tDevProgressRelDao =
      TDevProgressRelDao(this as StairsDatabase);
  late final TTagDao tTagDao = TTagDao(this as StairsDatabase);
  late final TTagRelDao tTagRelDao = TTagRelDao(this as StairsDatabase);
  late final TDevLangDao tDevLangDao = TDevLangDao(this as StairsDatabase);
  late final TBoardDao tBoardDao = TBoardDao(this as StairsDatabase);
  late final TTaskDao tTaskDao = TTaskDao(this as StairsDatabase);
  late final TTaskTagDao tTaskTagDao = TTaskTagDao(this as StairsDatabase);
  late final TTaskDevDao tTaskDevDao = TTaskDevDao(this as StairsDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        mColor,
        mAccount,
        mDevProgressList,
        tDevLanguage,
        tProject,
        tDevLanguageRel,
        tDevProgressRel,
        tTag,
        tTagRel,
        tTool,
        tOsInfo,
        tDb,
        tBoard,
        tTask,
        tTaskTag,
        tTaskDev,
        colorId,
        accountId,
        devProgressId,
        tDevLangId,
        devLangRelId,
        projectId,
        devProgressRelId,
        tagId,
        tagRelId,
        toolId,
        osId,
        dbId,
        boardId,
        taskId,
        taskTagId,
        taskDevId
      ];
}
