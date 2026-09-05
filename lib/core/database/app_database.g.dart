// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AccountGroupsTable extends AccountGroups
    with TableInfo<$AccountGroupsTable, AccountGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AccountGroupType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AccountGroupType>($AccountGroupsTable.$convertertype);
  @override
  List<GeneratedColumn> get $columns => [id, code, name, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountGroup> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountGroup(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: $AccountGroupsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
    );
  }

  @override
  $AccountGroupsTable createAlias(String alias) {
    return $AccountGroupsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AccountGroupType, String, String> $convertertype =
      const EnumNameConverter<AccountGroupType>(AccountGroupType.values);
}

class AccountGroup extends DataClass implements Insertable<AccountGroup> {
  final int id;
  final String code;
  final String name;
  final AccountGroupType type;
  const AccountGroup({
    required this.id,
    required this.code,
    required this.name,
    required this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    {
      map['type'] = Variable<String>(
        $AccountGroupsTable.$convertertype.toSql(type),
      );
    }
    return map;
  }

  AccountGroupsCompanion toCompanion(bool nullToAbsent) {
    return AccountGroupsCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      type: Value(type),
    );
  }

  factory AccountGroup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountGroup(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      type: $AccountGroupsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(
        $AccountGroupsTable.$convertertype.toJson(type),
      ),
    };
  }

  AccountGroup copyWith({
    int? id,
    String? code,
    String? name,
    AccountGroupType? type,
  }) => AccountGroup(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    type: type ?? this.type,
  );
  AccountGroup copyWithCompanion(AccountGroupsCompanion data) {
    return AccountGroup(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountGroup(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, name, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountGroup &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.type == this.type);
}

class AccountGroupsCompanion extends UpdateCompanion<AccountGroup> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<AccountGroupType> type;
  const AccountGroupsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
  });
  AccountGroupsCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    required AccountGroupType type,
  }) : code = Value(code),
       name = Value(name),
       type = Value(type);
  static Insertable<AccountGroup> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
    });
  }

  AccountGroupsCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? name,
    Value<AccountGroupType>? type,
  }) {
    return AccountGroupsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $AccountGroupsTable.$convertertype.toSql(type.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountGroupsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $GeneralAccountsTable extends GeneralAccounts
    with TableInfo<$GeneralAccountsTable, GeneralAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GeneralAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupIDMeta = const VerificationMeta(
    'groupID',
  );
  @override
  late final GeneratedColumn<int> groupID = GeneratedColumn<int>(
    'group_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES account_groups (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<GeneralAccountType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<GeneralAccountType>($GeneralAccountsTable.$convertertype);
  @override
  List<GeneratedColumn> get $columns => [id, code, name, groupID, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'general_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<GeneralAccount> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('group_i_d')) {
      context.handle(
        _groupIDMeta,
        groupID.isAcceptableOrUnknown(data['group_i_d']!, _groupIDMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GeneralAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GeneralAccount(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      groupID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_i_d'],
      )!,
      type: $GeneralAccountsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
    );
  }

  @override
  $GeneralAccountsTable createAlias(String alias) {
    return $GeneralAccountsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GeneralAccountType, String, String> $convertertype =
      const EnumNameConverter<GeneralAccountType>(GeneralAccountType.values);
}

class GeneralAccount extends DataClass implements Insertable<GeneralAccount> {
  final int id;
  final String code;
  final String name;
  final int groupID;
  final GeneralAccountType type;
  const GeneralAccount({
    required this.id,
    required this.code,
    required this.name,
    required this.groupID,
    required this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['group_i_d'] = Variable<int>(groupID);
    {
      map['type'] = Variable<String>(
        $GeneralAccountsTable.$convertertype.toSql(type),
      );
    }
    return map;
  }

  GeneralAccountsCompanion toCompanion(bool nullToAbsent) {
    return GeneralAccountsCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      groupID: Value(groupID),
      type: Value(type),
    );
  }

  factory GeneralAccount.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GeneralAccount(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      groupID: serializer.fromJson<int>(json['groupID']),
      type: $GeneralAccountsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'groupID': serializer.toJson<int>(groupID),
      'type': serializer.toJson<String>(
        $GeneralAccountsTable.$convertertype.toJson(type),
      ),
    };
  }

  GeneralAccount copyWith({
    int? id,
    String? code,
    String? name,
    int? groupID,
    GeneralAccountType? type,
  }) => GeneralAccount(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    groupID: groupID ?? this.groupID,
    type: type ?? this.type,
  );
  GeneralAccount copyWithCompanion(GeneralAccountsCompanion data) {
    return GeneralAccount(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      groupID: data.groupID.present ? data.groupID.value : this.groupID,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GeneralAccount(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('groupID: $groupID, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, name, groupID, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GeneralAccount &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.groupID == this.groupID &&
          other.type == this.type);
}

class GeneralAccountsCompanion extends UpdateCompanion<GeneralAccount> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<int> groupID;
  final Value<GeneralAccountType> type;
  const GeneralAccountsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.groupID = const Value.absent(),
    this.type = const Value.absent(),
  });
  GeneralAccountsCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    required int groupID,
    required GeneralAccountType type,
  }) : code = Value(code),
       name = Value(name),
       groupID = Value(groupID),
       type = Value(type);
  static Insertable<GeneralAccount> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? groupID,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (groupID != null) 'group_i_d': groupID,
      if (type != null) 'type': type,
    });
  }

  GeneralAccountsCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? name,
    Value<int>? groupID,
    Value<GeneralAccountType>? type,
  }) {
    return GeneralAccountsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      groupID: groupID ?? this.groupID,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (groupID.present) {
      map['group_i_d'] = Variable<int>(groupID.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $GeneralAccountsTable.$convertertype.toSql(type.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GeneralAccountsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('groupID: $groupID, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $SubsidiaryAccountsTable extends SubsidiaryAccounts
    with TableInfo<$SubsidiaryAccountsTable, SubsidiaryAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubsidiaryAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _generalIdMeta = const VerificationMeta(
    'generalId',
  );
  @override
  late final GeneratedColumn<int> generalId = GeneratedColumn<int>(
    'general_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES general_accounts (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 4,
      maxTextLength: 8,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SubsidiaryAccountType, String>
  type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SubsidiaryAccountType>(
        $SubsidiaryAccountsTable.$convertertype,
      );
  @override
  List<GeneratedColumn> get $columns => [id, generalId, code, name, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subsidiary_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<SubsidiaryAccount> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('general_id')) {
      context.handle(
        _generalIdMeta,
        generalId.isAcceptableOrUnknown(data['general_id']!, _generalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_generalIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubsidiaryAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubsidiaryAccount(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      generalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}general_id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: $SubsidiaryAccountsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
    );
  }

  @override
  $SubsidiaryAccountsTable createAlias(String alias) {
    return $SubsidiaryAccountsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SubsidiaryAccountType, String, String>
  $convertertype = const EnumNameConverter<SubsidiaryAccountType>(
    SubsidiaryAccountType.values,
  );
}

class SubsidiaryAccount extends DataClass
    implements Insertable<SubsidiaryAccount> {
  final int id;
  final int generalId;
  final String code;
  final String name;
  final SubsidiaryAccountType type;
  const SubsidiaryAccount({
    required this.id,
    required this.generalId,
    required this.code,
    required this.name,
    required this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['general_id'] = Variable<int>(generalId);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    {
      map['type'] = Variable<String>(
        $SubsidiaryAccountsTable.$convertertype.toSql(type),
      );
    }
    return map;
  }

  SubsidiaryAccountsCompanion toCompanion(bool nullToAbsent) {
    return SubsidiaryAccountsCompanion(
      id: Value(id),
      generalId: Value(generalId),
      code: Value(code),
      name: Value(name),
      type: Value(type),
    );
  }

  factory SubsidiaryAccount.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubsidiaryAccount(
      id: serializer.fromJson<int>(json['id']),
      generalId: serializer.fromJson<int>(json['generalId']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      type: $SubsidiaryAccountsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'generalId': serializer.toJson<int>(generalId),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(
        $SubsidiaryAccountsTable.$convertertype.toJson(type),
      ),
    };
  }

  SubsidiaryAccount copyWith({
    int? id,
    int? generalId,
    String? code,
    String? name,
    SubsidiaryAccountType? type,
  }) => SubsidiaryAccount(
    id: id ?? this.id,
    generalId: generalId ?? this.generalId,
    code: code ?? this.code,
    name: name ?? this.name,
    type: type ?? this.type,
  );
  SubsidiaryAccount copyWithCompanion(SubsidiaryAccountsCompanion data) {
    return SubsidiaryAccount(
      id: data.id.present ? data.id.value : this.id,
      generalId: data.generalId.present ? data.generalId.value : this.generalId,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubsidiaryAccount(')
          ..write('id: $id, ')
          ..write('generalId: $generalId, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, generalId, code, name, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubsidiaryAccount &&
          other.id == this.id &&
          other.generalId == this.generalId &&
          other.code == this.code &&
          other.name == this.name &&
          other.type == this.type);
}

class SubsidiaryAccountsCompanion extends UpdateCompanion<SubsidiaryAccount> {
  final Value<int> id;
  final Value<int> generalId;
  final Value<String> code;
  final Value<String> name;
  final Value<SubsidiaryAccountType> type;
  const SubsidiaryAccountsCompanion({
    this.id = const Value.absent(),
    this.generalId = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
  });
  SubsidiaryAccountsCompanion.insert({
    this.id = const Value.absent(),
    required int generalId,
    required String code,
    required String name,
    required SubsidiaryAccountType type,
  }) : generalId = Value(generalId),
       code = Value(code),
       name = Value(name),
       type = Value(type);
  static Insertable<SubsidiaryAccount> custom({
    Expression<int>? id,
    Expression<int>? generalId,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (generalId != null) 'general_id': generalId,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
    });
  }

  SubsidiaryAccountsCompanion copyWith({
    Value<int>? id,
    Value<int>? generalId,
    Value<String>? code,
    Value<String>? name,
    Value<SubsidiaryAccountType>? type,
  }) {
    return SubsidiaryAccountsCompanion(
      id: id ?? this.id,
      generalId: generalId ?? this.generalId,
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (generalId.present) {
      map['general_id'] = Variable<int>(generalId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $SubsidiaryAccountsTable.$convertertype.toSql(type.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubsidiaryAccountsCompanion(')
          ..write('id: $id, ')
          ..write('generalId: $generalId, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _profileImageMeta = const VerificationMeta(
    'profileImage',
  );
  @override
  late final GeneratedColumn<String> profileImage = GeneratedColumn<String>(
    'profile_image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _telegramIdMeta = const VerificationMeta(
    'telegramId',
  );
  @override
  late final GeneratedColumn<String> telegramId = GeneratedColumn<String>(
    'telegram_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _instagramIdMeta = const VerificationMeta(
    'instagramId',
  );
  @override
  late final GeneratedColumn<String> instagramId = GeneratedColumn<String>(
    'instagram_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthdayMeta = const VerificationMeta(
    'birthday',
  );
  @override
  late final GeneratedColumn<DateTime> birthday = GeneratedColumn<DateTime>(
    'birthday',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<UserAccountRole, String> role =
      GeneratedColumn<String>(
        'role',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<UserAccountRole>($UsersTable.$converterrole);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    phoneNumber,
    isActive,
    profileImage,
    telegramId,
    instagramId,
    birthday,
    role,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('profile_image')) {
      context.handle(
        _profileImageMeta,
        profileImage.isAcceptableOrUnknown(
          data['profile_image']!,
          _profileImageMeta,
        ),
      );
    }
    if (data.containsKey('telegram_id')) {
      context.handle(
        _telegramIdMeta,
        telegramId.isAcceptableOrUnknown(data['telegram_id']!, _telegramIdMeta),
      );
    }
    if (data.containsKey('instagram_id')) {
      context.handle(
        _instagramIdMeta,
        instagramId.isAcceptableOrUnknown(
          data['instagram_id']!,
          _instagramIdMeta,
        ),
      );
    }
    if (data.containsKey('birthday')) {
      context.handle(
        _birthdayMeta,
        birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      profileImage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_image'],
      ),
      telegramId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telegram_id'],
      ),
      instagramId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instagram_id'],
      ),
      birthday: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birthday'],
      ),
      role: $UsersTable.$converterrole.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}role'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<UserAccountRole, String, String> $converterrole =
      const EnumNameConverter<UserAccountRole>(UserAccountRole.values);
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String? description;
  final String? phoneNumber;
  final bool isActive;
  final String? profileImage;
  final String? telegramId;
  final String? instagramId;
  final DateTime? birthday;
  final UserAccountRole role;
  final DateTime createdAt;
  final DateTime updatedAt;
  const User({
    required this.id,
    required this.name,
    this.description,
    this.phoneNumber,
    required this.isActive,
    this.profileImage,
    this.telegramId,
    this.instagramId,
    this.birthday,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || profileImage != null) {
      map['profile_image'] = Variable<String>(profileImage);
    }
    if (!nullToAbsent || telegramId != null) {
      map['telegram_id'] = Variable<String>(telegramId);
    }
    if (!nullToAbsent || instagramId != null) {
      map['instagram_id'] = Variable<String>(instagramId);
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<DateTime>(birthday);
    }
    {
      map['role'] = Variable<String>($UsersTable.$converterrole.toSql(role));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      isActive: Value(isActive),
      profileImage: profileImage == null && nullToAbsent
          ? const Value.absent()
          : Value(profileImage),
      telegramId: telegramId == null && nullToAbsent
          ? const Value.absent()
          : Value(telegramId),
      instagramId: instagramId == null && nullToAbsent
          ? const Value.absent()
          : Value(instagramId),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      role: Value(role),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      profileImage: serializer.fromJson<String?>(json['profileImage']),
      telegramId: serializer.fromJson<String?>(json['telegramId']),
      instagramId: serializer.fromJson<String?>(json['instagramId']),
      birthday: serializer.fromJson<DateTime?>(json['birthday']),
      role: $UsersTable.$converterrole.fromJson(
        serializer.fromJson<String>(json['role']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'isActive': serializer.toJson<bool>(isActive),
      'profileImage': serializer.toJson<String?>(profileImage),
      'telegramId': serializer.toJson<String?>(telegramId),
      'instagramId': serializer.toJson<String?>(instagramId),
      'birthday': serializer.toJson<DateTime?>(birthday),
      'role': serializer.toJson<String>(
        $UsersTable.$converterrole.toJson(role),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  User copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> phoneNumber = const Value.absent(),
    bool? isActive,
    Value<String?> profileImage = const Value.absent(),
    Value<String?> telegramId = const Value.absent(),
    Value<String?> instagramId = const Value.absent(),
    Value<DateTime?> birthday = const Value.absent(),
    UserAccountRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    isActive: isActive ?? this.isActive,
    profileImage: profileImage.present ? profileImage.value : this.profileImage,
    telegramId: telegramId.present ? telegramId.value : this.telegramId,
    instagramId: instagramId.present ? instagramId.value : this.instagramId,
    birthday: birthday.present ? birthday.value : this.birthday,
    role: role ?? this.role,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      profileImage: data.profileImage.present
          ? data.profileImage.value
          : this.profileImage,
      telegramId: data.telegramId.present
          ? data.telegramId.value
          : this.telegramId,
      instagramId: data.instagramId.present
          ? data.instagramId.value
          : this.instagramId,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
      role: data.role.present ? data.role.value : this.role,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('isActive: $isActive, ')
          ..write('profileImage: $profileImage, ')
          ..write('telegramId: $telegramId, ')
          ..write('instagramId: $instagramId, ')
          ..write('birthday: $birthday, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    phoneNumber,
    isActive,
    profileImage,
    telegramId,
    instagramId,
    birthday,
    role,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.phoneNumber == this.phoneNumber &&
          other.isActive == this.isActive &&
          other.profileImage == this.profileImage &&
          other.telegramId == this.telegramId &&
          other.instagramId == this.instagramId &&
          other.birthday == this.birthday &&
          other.role == this.role &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> phoneNumber;
  final Value<bool> isActive;
  final Value<String?> profileImage;
  final Value<String?> telegramId;
  final Value<String?> instagramId;
  final Value<DateTime?> birthday;
  final Value<UserAccountRole> role;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.isActive = const Value.absent(),
    this.profileImage = const Value.absent(),
    this.telegramId = const Value.absent(),
    this.instagramId = const Value.absent(),
    this.birthday = const Value.absent(),
    this.role = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.isActive = const Value.absent(),
    this.profileImage = const Value.absent(),
    this.telegramId = const Value.absent(),
    this.instagramId = const Value.absent(),
    this.birthday = const Value.absent(),
    required UserAccountRole role,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       role = Value(role);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? phoneNumber,
    Expression<bool>? isActive,
    Expression<String>? profileImage,
    Expression<String>? telegramId,
    Expression<String>? instagramId,
    Expression<DateTime>? birthday,
    Expression<String>? role,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (isActive != null) 'is_active': isActive,
      if (profileImage != null) 'profile_image': profileImage,
      if (telegramId != null) 'telegram_id': telegramId,
      if (instagramId != null) 'instagram_id': instagramId,
      if (birthday != null) 'birthday': birthday,
      if (role != null) 'role': role,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? phoneNumber,
    Value<bool>? isActive,
    Value<String?>? profileImage,
    Value<String?>? telegramId,
    Value<String?>? instagramId,
    Value<DateTime?>? birthday,
    Value<UserAccountRole>? role,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isActive: isActive ?? this.isActive,
      profileImage: profileImage ?? this.profileImage,
      telegramId: telegramId ?? this.telegramId,
      instagramId: instagramId ?? this.instagramId,
      birthday: birthday ?? this.birthday,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (profileImage.present) {
      map['profile_image'] = Variable<String>(profileImage.value);
    }
    if (telegramId.present) {
      map['telegram_id'] = Variable<String>(telegramId.value);
    }
    if (instagramId.present) {
      map['instagram_id'] = Variable<String>(instagramId.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<DateTime>(birthday.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(
        $UsersTable.$converterrole.toSql(role.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('isActive: $isActive, ')
          ..write('profileImage: $profileImage, ')
          ..write('telegramId: $telegramId, ')
          ..write('instagramId: $instagramId, ')
          ..write('birthday: $birthday, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TeamsTable extends Teams with TableInfo<$TeamsTable, Team> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teams';
  @override
  VerificationContext validateIntegrity(
    Insertable<Team> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Team map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Team(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TeamsTable createAlias(String alias) {
    return $TeamsTable(attachedDatabase, alias);
  }
}

class Team extends DataClass implements Insertable<Team> {
  final int id;
  final String title;
  final String? description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Team({
    required this.id,
    required this.title,
    this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TeamsCompanion toCompanion(bool nullToAbsent) {
    return TeamsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Team.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Team(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Team copyWith({
    int? id,
    String? title,
    Value<String?> description = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Team(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Team copyWithCompanion(TeamsCompanion data) {
    return Team(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Team(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Team &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TeamsCompanion extends UpdateCompanion<Team> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TeamsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TeamsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Team> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TeamsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return TeamsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIDMeta = const VerificationMeta('teamID');
  @override
  late final GeneratedColumn<int> teamID = GeneratedColumn<int>(
    'team_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES teams (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _isClosedMeta = const VerificationMeta(
    'isClosed',
  );
  @override
  late final GeneratedColumn<bool> isClosed = GeneratedColumn<bool>(
    'is_closed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_closed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    teamID,
    date,
    isClosed,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(
    Insertable<Event> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('team_i_d')) {
      context.handle(
        _teamIDMeta,
        teamID.isAcceptableOrUnknown(data['team_i_d']!, _teamIDMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIDMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('is_closed')) {
      context.handle(
        _isClosedMeta,
        isClosed.isAcceptableOrUnknown(data['is_closed']!, _isClosedMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      teamID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_i_d'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      isClosed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_closed'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final int id;
  final String title;
  final int teamID;
  final DateTime date;
  final bool isClosed;
  final bool isActive;
  final DateTime createdAt;
  const Event({
    required this.id,
    required this.title,
    required this.teamID,
    required this.date,
    required this.isClosed,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['team_i_d'] = Variable<int>(teamID);
    map['date'] = Variable<DateTime>(date);
    map['is_closed'] = Variable<bool>(isClosed);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      title: Value(title),
      teamID: Value(teamID),
      date: Value(date),
      isClosed: Value(isClosed),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Event.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      teamID: serializer.fromJson<int>(json['teamID']),
      date: serializer.fromJson<DateTime>(json['date']),
      isClosed: serializer.fromJson<bool>(json['isClosed']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'teamID': serializer.toJson<int>(teamID),
      'date': serializer.toJson<DateTime>(date),
      'isClosed': serializer.toJson<bool>(isClosed),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Event copyWith({
    int? id,
    String? title,
    int? teamID,
    DateTime? date,
    bool? isClosed,
    bool? isActive,
    DateTime? createdAt,
  }) => Event(
    id: id ?? this.id,
    title: title ?? this.title,
    teamID: teamID ?? this.teamID,
    date: date ?? this.date,
    isClosed: isClosed ?? this.isClosed,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      teamID: data.teamID.present ? data.teamID.value : this.teamID,
      date: data.date.present ? data.date.value : this.date,
      isClosed: data.isClosed.present ? data.isClosed.value : this.isClosed,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('teamID: $teamID, ')
          ..write('date: $date, ')
          ..write('isClosed: $isClosed, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, teamID, date, isClosed, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.title == this.title &&
          other.teamID == this.teamID &&
          other.date == this.date &&
          other.isClosed == this.isClosed &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> teamID;
  final Value<DateTime> date;
  final Value<bool> isClosed;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.teamID = const Value.absent(),
    this.date = const Value.absent(),
    this.isClosed = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int teamID,
    this.date = const Value.absent(),
    this.isClosed = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title),
       teamID = Value(teamID);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? teamID,
    Expression<DateTime>? date,
    Expression<bool>? isClosed,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (teamID != null) 'team_i_d': teamID,
      if (date != null) 'date': date,
      if (isClosed != null) 'is_closed': isClosed,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  EventsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int>? teamID,
    Value<DateTime>? date,
    Value<bool>? isClosed,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return EventsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      teamID: teamID ?? this.teamID,
      date: date ?? this.date,
      isClosed: isClosed ?? this.isClosed,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (teamID.present) {
      map['team_i_d'] = Variable<int>(teamID.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (isClosed.present) {
      map['is_closed'] = Variable<bool>(isClosed.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('teamID: $teamID, ')
          ..write('date: $date, ')
          ..write('isClosed: $isClosed, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BanksTable extends Banks with TableInfo<$BanksTable, Bank> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BanksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    number,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'banks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bank> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bank map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bank(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BanksTable createAlias(String alias) {
    return $BanksTable(attachedDatabase, alias);
  }
}

class Bank extends DataClass implements Insertable<Bank> {
  final int id;
  final String name;
  final String? description;
  final String? number;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Bank({
    required this.id,
    required this.name,
    this.description,
    this.number,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || number != null) {
      map['number'] = Variable<String>(number);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BanksCompanion toCompanion(bool nullToAbsent) {
    return BanksCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      number: number == null && nullToAbsent
          ? const Value.absent()
          : Value(number),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Bank.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bank(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      number: serializer.fromJson<String?>(json['number']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'number': serializer.toJson<String?>(number),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Bank copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> number = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Bank(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    number: number.present ? number.value : this.number,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Bank copyWithCompanion(BanksCompanion data) {
    return Bank(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      number: data.number.present ? data.number.value : this.number,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bank(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('number: $number, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    number,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bank &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.number == this.number &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BanksCompanion extends UpdateCompanion<Bank> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> number;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BanksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.number = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BanksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.number = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Bank> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? number,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (number != null) 'number': number,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BanksCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? number,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return BanksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      number: number ?? this.number,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BanksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('number: $number, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DetailedAccountsTable extends DetailedAccounts
    with TableInfo<$DetailedAccountsTable, DetailedAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DetailedAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 4,
      maxTextLength: 15,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  late final GeneratedColumnWithTypeConverter<DetailedAccountType, String>
  type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<DetailedAccountType>($DetailedAccountsTable.$convertertype);
  static const VerificationMeta _userIDMeta = const VerificationMeta('userID');
  @override
  late final GeneratedColumn<int> userID = GeneratedColumn<int>(
    'user_i_d',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _eventIDMeta = const VerificationMeta(
    'eventID',
  );
  @override
  late final GeneratedColumn<int> eventID = GeneratedColumn<int>(
    'event_i_d',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id)',
    ),
  );
  static const VerificationMeta _bankIDMeta = const VerificationMeta('bankID');
  @override
  late final GeneratedColumn<int> bankID = GeneratedColumn<int>(
    'bank_i_d',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES banks (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    isActive,
    type,
    userID,
    eventID,
    bankID,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'detailed_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<DetailedAccount> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('user_i_d')) {
      context.handle(
        _userIDMeta,
        userID.isAcceptableOrUnknown(data['user_i_d']!, _userIDMeta),
      );
    }
    if (data.containsKey('event_i_d')) {
      context.handle(
        _eventIDMeta,
        eventID.isAcceptableOrUnknown(data['event_i_d']!, _eventIDMeta),
      );
    }
    if (data.containsKey('bank_i_d')) {
      context.handle(
        _bankIDMeta,
        bankID.isAcceptableOrUnknown(data['bank_i_d']!, _bankIDMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {eventID, userID, bankID},
  ];
  @override
  DetailedAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DetailedAccount(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      type: $DetailedAccountsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      userID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_i_d'],
      ),
      eventID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_i_d'],
      ),
      bankID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bank_i_d'],
      ),
    );
  }

  @override
  $DetailedAccountsTable createAlias(String alias) {
    return $DetailedAccountsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DetailedAccountType, String, String>
  $convertertype = const EnumNameConverter<DetailedAccountType>(
    DetailedAccountType.values,
  );
}

class DetailedAccount extends DataClass implements Insertable<DetailedAccount> {
  final int id;
  final String code;
  final String name;
  final bool isActive;
  final DetailedAccountType type;
  final int? userID;
  final int? eventID;
  final int? bankID;
  const DetailedAccount({
    required this.id,
    required this.code,
    required this.name,
    required this.isActive,
    required this.type,
    this.userID,
    this.eventID,
    this.bankID,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    {
      map['type'] = Variable<String>(
        $DetailedAccountsTable.$convertertype.toSql(type),
      );
    }
    if (!nullToAbsent || userID != null) {
      map['user_i_d'] = Variable<int>(userID);
    }
    if (!nullToAbsent || eventID != null) {
      map['event_i_d'] = Variable<int>(eventID);
    }
    if (!nullToAbsent || bankID != null) {
      map['bank_i_d'] = Variable<int>(bankID);
    }
    return map;
  }

  DetailedAccountsCompanion toCompanion(bool nullToAbsent) {
    return DetailedAccountsCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      isActive: Value(isActive),
      type: Value(type),
      userID: userID == null && nullToAbsent
          ? const Value.absent()
          : Value(userID),
      eventID: eventID == null && nullToAbsent
          ? const Value.absent()
          : Value(eventID),
      bankID: bankID == null && nullToAbsent
          ? const Value.absent()
          : Value(bankID),
    );
  }

  factory DetailedAccount.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DetailedAccount(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      type: $DetailedAccountsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      userID: serializer.fromJson<int?>(json['userID']),
      eventID: serializer.fromJson<int?>(json['eventID']),
      bankID: serializer.fromJson<int?>(json['bankID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
      'type': serializer.toJson<String>(
        $DetailedAccountsTable.$convertertype.toJson(type),
      ),
      'userID': serializer.toJson<int?>(userID),
      'eventID': serializer.toJson<int?>(eventID),
      'bankID': serializer.toJson<int?>(bankID),
    };
  }

  DetailedAccount copyWith({
    int? id,
    String? code,
    String? name,
    bool? isActive,
    DetailedAccountType? type,
    Value<int?> userID = const Value.absent(),
    Value<int?> eventID = const Value.absent(),
    Value<int?> bankID = const Value.absent(),
  }) => DetailedAccount(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
    type: type ?? this.type,
    userID: userID.present ? userID.value : this.userID,
    eventID: eventID.present ? eventID.value : this.eventID,
    bankID: bankID.present ? bankID.value : this.bankID,
  );
  DetailedAccount copyWithCompanion(DetailedAccountsCompanion data) {
    return DetailedAccount(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      type: data.type.present ? data.type.value : this.type,
      userID: data.userID.present ? data.userID.value : this.userID,
      eventID: data.eventID.present ? data.eventID.value : this.eventID,
      bankID: data.bankID.present ? data.bankID.value : this.bankID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DetailedAccount(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('type: $type, ')
          ..write('userID: $userID, ')
          ..write('eventID: $eventID, ')
          ..write('bankID: $bankID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, code, name, isActive, type, userID, eventID, bankID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DetailedAccount &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.isActive == this.isActive &&
          other.type == this.type &&
          other.userID == this.userID &&
          other.eventID == this.eventID &&
          other.bankID == this.bankID);
}

class DetailedAccountsCompanion extends UpdateCompanion<DetailedAccount> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<bool> isActive;
  final Value<DetailedAccountType> type;
  final Value<int?> userID;
  final Value<int?> eventID;
  final Value<int?> bankID;
  const DetailedAccountsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
    this.type = const Value.absent(),
    this.userID = const Value.absent(),
    this.eventID = const Value.absent(),
    this.bankID = const Value.absent(),
  });
  DetailedAccountsCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    this.isActive = const Value.absent(),
    required DetailedAccountType type,
    this.userID = const Value.absent(),
    this.eventID = const Value.absent(),
    this.bankID = const Value.absent(),
  }) : code = Value(code),
       name = Value(name),
       type = Value(type);
  static Insertable<DetailedAccount> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<bool>? isActive,
    Expression<String>? type,
    Expression<int>? userID,
    Expression<int>? eventID,
    Expression<int>? bankID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (type != null) 'type': type,
      if (userID != null) 'user_i_d': userID,
      if (eventID != null) 'event_i_d': eventID,
      if (bankID != null) 'bank_i_d': bankID,
    });
  }

  DetailedAccountsCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? name,
    Value<bool>? isActive,
    Value<DetailedAccountType>? type,
    Value<int?>? userID,
    Value<int?>? eventID,
    Value<int?>? bankID,
  }) {
    return DetailedAccountsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      type: type ?? this.type,
      userID: userID ?? this.userID,
      eventID: eventID ?? this.eventID,
      bankID: bankID ?? this.bankID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $DetailedAccountsTable.$convertertype.toSql(type.value),
      );
    }
    if (userID.present) {
      map['user_i_d'] = Variable<int>(userID.value);
    }
    if (eventID.present) {
      map['event_i_d'] = Variable<int>(eventID.value);
    }
    if (bankID.present) {
      map['bank_i_d'] = Variable<int>(bankID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DetailedAccountsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('type: $type, ')
          ..write('userID: $userID, ')
          ..write('eventID: $eventID, ')
          ..write('bankID: $bankID')
          ..write(')'))
        .toString();
  }
}

class $JournalHeadersTable extends JournalHeaders
    with TableInfo<$JournalHeadersTable, JournalHeader> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalHeadersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entryNumberMeta = const VerificationMeta(
    'entryNumber',
  );
  @override
  late final GeneratedColumn<String> entryNumber = GeneratedColumn<String>(
    'entry_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _entryDateMeta = const VerificationMeta(
    'entryDate',
  );
  @override
  late final GeneratedColumn<DateTime> entryDate = GeneratedColumn<DateTime>(
    'entry_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<JournalType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(JournalType.normal.name),
      ).withConverter<JournalType>($JournalHeadersTable.$convertertype);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entryNumber,
    entryDate,
    description,
    type,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_headers';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalHeader> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entry_number')) {
      context.handle(
        _entryNumberMeta,
        entryNumber.isAcceptableOrUnknown(
          data['entry_number']!,
          _entryNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_entryNumberMeta);
    }
    if (data.containsKey('entry_date')) {
      context.handle(
        _entryDateMeta,
        entryDate.isAcceptableOrUnknown(data['entry_date']!, _entryDateMeta),
      );
    } else if (isInserting) {
      context.missing(_entryDateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalHeader map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalHeader(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entryNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_number'],
      )!,
      entryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}entry_date'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      type: $JournalHeadersTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $JournalHeadersTable createAlias(String alias) {
    return $JournalHeadersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<JournalType, String, String> $convertertype =
      const EnumNameConverter<JournalType>(JournalType.values);
}

class JournalHeader extends DataClass implements Insertable<JournalHeader> {
  final int id;
  final String entryNumber;
  final DateTime entryDate;
  final String? description;
  final JournalType type;
  final DateTime createdAt;
  const JournalHeader({
    required this.id,
    required this.entryNumber,
    required this.entryDate,
    this.description,
    required this.type,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entry_number'] = Variable<String>(entryNumber);
    map['entry_date'] = Variable<DateTime>(entryDate);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    {
      map['type'] = Variable<String>(
        $JournalHeadersTable.$convertertype.toSql(type),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  JournalHeadersCompanion toCompanion(bool nullToAbsent) {
    return JournalHeadersCompanion(
      id: Value(id),
      entryNumber: Value(entryNumber),
      entryDate: Value(entryDate),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      type: Value(type),
      createdAt: Value(createdAt),
    );
  }

  factory JournalHeader.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalHeader(
      id: serializer.fromJson<int>(json['id']),
      entryNumber: serializer.fromJson<String>(json['entryNumber']),
      entryDate: serializer.fromJson<DateTime>(json['entryDate']),
      description: serializer.fromJson<String?>(json['description']),
      type: $JournalHeadersTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entryNumber': serializer.toJson<String>(entryNumber),
      'entryDate': serializer.toJson<DateTime>(entryDate),
      'description': serializer.toJson<String?>(description),
      'type': serializer.toJson<String>(
        $JournalHeadersTable.$convertertype.toJson(type),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  JournalHeader copyWith({
    int? id,
    String? entryNumber,
    DateTime? entryDate,
    Value<String?> description = const Value.absent(),
    JournalType? type,
    DateTime? createdAt,
  }) => JournalHeader(
    id: id ?? this.id,
    entryNumber: entryNumber ?? this.entryNumber,
    entryDate: entryDate ?? this.entryDate,
    description: description.present ? description.value : this.description,
    type: type ?? this.type,
    createdAt: createdAt ?? this.createdAt,
  );
  JournalHeader copyWithCompanion(JournalHeadersCompanion data) {
    return JournalHeader(
      id: data.id.present ? data.id.value : this.id,
      entryNumber: data.entryNumber.present
          ? data.entryNumber.value
          : this.entryNumber,
      entryDate: data.entryDate.present ? data.entryDate.value : this.entryDate,
      description: data.description.present
          ? data.description.value
          : this.description,
      type: data.type.present ? data.type.value : this.type,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalHeader(')
          ..write('id: $id, ')
          ..write('entryNumber: $entryNumber, ')
          ..write('entryDate: $entryDate, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, entryNumber, entryDate, description, type, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalHeader &&
          other.id == this.id &&
          other.entryNumber == this.entryNumber &&
          other.entryDate == this.entryDate &&
          other.description == this.description &&
          other.type == this.type &&
          other.createdAt == this.createdAt);
}

class JournalHeadersCompanion extends UpdateCompanion<JournalHeader> {
  final Value<int> id;
  final Value<String> entryNumber;
  final Value<DateTime> entryDate;
  final Value<String?> description;
  final Value<JournalType> type;
  final Value<DateTime> createdAt;
  const JournalHeadersCompanion({
    this.id = const Value.absent(),
    this.entryNumber = const Value.absent(),
    this.entryDate = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  JournalHeadersCompanion.insert({
    this.id = const Value.absent(),
    required String entryNumber,
    required DateTime entryDate,
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : entryNumber = Value(entryNumber),
       entryDate = Value(entryDate);
  static Insertable<JournalHeader> custom({
    Expression<int>? id,
    Expression<String>? entryNumber,
    Expression<DateTime>? entryDate,
    Expression<String>? description,
    Expression<String>? type,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entryNumber != null) 'entry_number': entryNumber,
      if (entryDate != null) 'entry_date': entryDate,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  JournalHeadersCompanion copyWith({
    Value<int>? id,
    Value<String>? entryNumber,
    Value<DateTime>? entryDate,
    Value<String?>? description,
    Value<JournalType>? type,
    Value<DateTime>? createdAt,
  }) {
    return JournalHeadersCompanion(
      id: id ?? this.id,
      entryNumber: entryNumber ?? this.entryNumber,
      entryDate: entryDate ?? this.entryDate,
      description: description ?? this.description,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entryNumber.present) {
      map['entry_number'] = Variable<String>(entryNumber.value);
    }
    if (entryDate.present) {
      map['entry_date'] = Variable<DateTime>(entryDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $JournalHeadersTable.$convertertype.toSql(type.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalHeadersCompanion(')
          ..write('id: $id, ')
          ..write('entryNumber: $entryNumber, ')
          ..write('entryDate: $entryDate, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $JournalLinesTable extends JournalLines
    with TableInfo<$JournalLinesTable, JournalLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _headerIdMeta = const VerificationMeta(
    'headerId',
  );
  @override
  late final GeneratedColumn<int> headerId = GeneratedColumn<int>(
    'header_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES journal_headers (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _subsidiaryIdMeta = const VerificationMeta(
    'subsidiaryId',
  );
  @override
  late final GeneratedColumn<int> subsidiaryId = GeneratedColumn<int>(
    'subsidiary_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subsidiary_accounts (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _detailedIdMeta = const VerificationMeta(
    'detailedId',
  );
  @override
  late final GeneratedColumn<int> detailedId = GeneratedColumn<int>(
    'detailed_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES detailed_accounts (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _detailedIdSecondMeta = const VerificationMeta(
    'detailedIdSecond',
  );
  @override
  late final GeneratedColumn<int> detailedIdSecond = GeneratedColumn<int>(
    'detailed_id_second',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES detailed_accounts (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _debitMeta = const VerificationMeta('debit');
  @override
  late final GeneratedColumn<BigInt> debit = GeneratedColumn<BigInt>(
    'debit',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creditMeta = const VerificationMeta('credit');
  @override
  late final GeneratedColumn<BigInt> credit = GeneratedColumn<BigInt>(
    'credit',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seriesMeta = const VerificationMeta('series');
  @override
  late final GeneratedColumn<String> series = GeneratedColumn<String>(
    'series',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
    'memo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    headerId,
    subsidiaryId,
    detailedId,
    detailedIdSecond,
    debit,
    credit,
    series,
    memo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalLine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('header_id')) {
      context.handle(
        _headerIdMeta,
        headerId.isAcceptableOrUnknown(data['header_id']!, _headerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_headerIdMeta);
    }
    if (data.containsKey('subsidiary_id')) {
      context.handle(
        _subsidiaryIdMeta,
        subsidiaryId.isAcceptableOrUnknown(
          data['subsidiary_id']!,
          _subsidiaryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subsidiaryIdMeta);
    }
    if (data.containsKey('detailed_id')) {
      context.handle(
        _detailedIdMeta,
        detailedId.isAcceptableOrUnknown(data['detailed_id']!, _detailedIdMeta),
      );
    }
    if (data.containsKey('detailed_id_second')) {
      context.handle(
        _detailedIdSecondMeta,
        detailedIdSecond.isAcceptableOrUnknown(
          data['detailed_id_second']!,
          _detailedIdSecondMeta,
        ),
      );
    }
    if (data.containsKey('debit')) {
      context.handle(
        _debitMeta,
        debit.isAcceptableOrUnknown(data['debit']!, _debitMeta),
      );
    } else if (isInserting) {
      context.missing(_debitMeta);
    }
    if (data.containsKey('credit')) {
      context.handle(
        _creditMeta,
        credit.isAcceptableOrUnknown(data['credit']!, _creditMeta),
      );
    } else if (isInserting) {
      context.missing(_creditMeta);
    }
    if (data.containsKey('series')) {
      context.handle(
        _seriesMeta,
        series.isAcceptableOrUnknown(data['series']!, _seriesMeta),
      );
    } else if (isInserting) {
      context.missing(_seriesMeta);
    }
    if (data.containsKey('memo')) {
      context.handle(
        _memoMeta,
        memo.isAcceptableOrUnknown(data['memo']!, _memoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalLine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      headerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}header_id'],
      )!,
      subsidiaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subsidiary_id'],
      )!,
      detailedId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}detailed_id'],
      ),
      detailedIdSecond: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}detailed_id_second'],
      ),
      debit: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}debit'],
      )!,
      credit: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}credit'],
      )!,
      series: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}series'],
      )!,
      memo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}memo'],
      ),
    );
  }

  @override
  $JournalLinesTable createAlias(String alias) {
    return $JournalLinesTable(attachedDatabase, alias);
  }
}

class JournalLine extends DataClass implements Insertable<JournalLine> {
  final int id;
  final int headerId;
  final int subsidiaryId;
  final int? detailedId;
  final int? detailedIdSecond;
  final BigInt debit;
  final BigInt credit;
  final String series;
  final String? memo;
  const JournalLine({
    required this.id,
    required this.headerId,
    required this.subsidiaryId,
    this.detailedId,
    this.detailedIdSecond,
    required this.debit,
    required this.credit,
    required this.series,
    this.memo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['header_id'] = Variable<int>(headerId);
    map['subsidiary_id'] = Variable<int>(subsidiaryId);
    if (!nullToAbsent || detailedId != null) {
      map['detailed_id'] = Variable<int>(detailedId);
    }
    if (!nullToAbsent || detailedIdSecond != null) {
      map['detailed_id_second'] = Variable<int>(detailedIdSecond);
    }
    map['debit'] = Variable<BigInt>(debit);
    map['credit'] = Variable<BigInt>(credit);
    map['series'] = Variable<String>(series);
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    return map;
  }

  JournalLinesCompanion toCompanion(bool nullToAbsent) {
    return JournalLinesCompanion(
      id: Value(id),
      headerId: Value(headerId),
      subsidiaryId: Value(subsidiaryId),
      detailedId: detailedId == null && nullToAbsent
          ? const Value.absent()
          : Value(detailedId),
      detailedIdSecond: detailedIdSecond == null && nullToAbsent
          ? const Value.absent()
          : Value(detailedIdSecond),
      debit: Value(debit),
      credit: Value(credit),
      series: Value(series),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
    );
  }

  factory JournalLine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalLine(
      id: serializer.fromJson<int>(json['id']),
      headerId: serializer.fromJson<int>(json['headerId']),
      subsidiaryId: serializer.fromJson<int>(json['subsidiaryId']),
      detailedId: serializer.fromJson<int?>(json['detailedId']),
      detailedIdSecond: serializer.fromJson<int?>(json['detailedIdSecond']),
      debit: serializer.fromJson<BigInt>(json['debit']),
      credit: serializer.fromJson<BigInt>(json['credit']),
      series: serializer.fromJson<String>(json['series']),
      memo: serializer.fromJson<String?>(json['memo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'headerId': serializer.toJson<int>(headerId),
      'subsidiaryId': serializer.toJson<int>(subsidiaryId),
      'detailedId': serializer.toJson<int?>(detailedId),
      'detailedIdSecond': serializer.toJson<int?>(detailedIdSecond),
      'debit': serializer.toJson<BigInt>(debit),
      'credit': serializer.toJson<BigInt>(credit),
      'series': serializer.toJson<String>(series),
      'memo': serializer.toJson<String?>(memo),
    };
  }

  JournalLine copyWith({
    int? id,
    int? headerId,
    int? subsidiaryId,
    Value<int?> detailedId = const Value.absent(),
    Value<int?> detailedIdSecond = const Value.absent(),
    BigInt? debit,
    BigInt? credit,
    String? series,
    Value<String?> memo = const Value.absent(),
  }) => JournalLine(
    id: id ?? this.id,
    headerId: headerId ?? this.headerId,
    subsidiaryId: subsidiaryId ?? this.subsidiaryId,
    detailedId: detailedId.present ? detailedId.value : this.detailedId,
    detailedIdSecond: detailedIdSecond.present
        ? detailedIdSecond.value
        : this.detailedIdSecond,
    debit: debit ?? this.debit,
    credit: credit ?? this.credit,
    series: series ?? this.series,
    memo: memo.present ? memo.value : this.memo,
  );
  JournalLine copyWithCompanion(JournalLinesCompanion data) {
    return JournalLine(
      id: data.id.present ? data.id.value : this.id,
      headerId: data.headerId.present ? data.headerId.value : this.headerId,
      subsidiaryId: data.subsidiaryId.present
          ? data.subsidiaryId.value
          : this.subsidiaryId,
      detailedId: data.detailedId.present
          ? data.detailedId.value
          : this.detailedId,
      detailedIdSecond: data.detailedIdSecond.present
          ? data.detailedIdSecond.value
          : this.detailedIdSecond,
      debit: data.debit.present ? data.debit.value : this.debit,
      credit: data.credit.present ? data.credit.value : this.credit,
      series: data.series.present ? data.series.value : this.series,
      memo: data.memo.present ? data.memo.value : this.memo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalLine(')
          ..write('id: $id, ')
          ..write('headerId: $headerId, ')
          ..write('subsidiaryId: $subsidiaryId, ')
          ..write('detailedId: $detailedId, ')
          ..write('detailedIdSecond: $detailedIdSecond, ')
          ..write('debit: $debit, ')
          ..write('credit: $credit, ')
          ..write('series: $series, ')
          ..write('memo: $memo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    headerId,
    subsidiaryId,
    detailedId,
    detailedIdSecond,
    debit,
    credit,
    series,
    memo,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalLine &&
          other.id == this.id &&
          other.headerId == this.headerId &&
          other.subsidiaryId == this.subsidiaryId &&
          other.detailedId == this.detailedId &&
          other.detailedIdSecond == this.detailedIdSecond &&
          other.debit == this.debit &&
          other.credit == this.credit &&
          other.series == this.series &&
          other.memo == this.memo);
}

class JournalLinesCompanion extends UpdateCompanion<JournalLine> {
  final Value<int> id;
  final Value<int> headerId;
  final Value<int> subsidiaryId;
  final Value<int?> detailedId;
  final Value<int?> detailedIdSecond;
  final Value<BigInt> debit;
  final Value<BigInt> credit;
  final Value<String> series;
  final Value<String?> memo;
  const JournalLinesCompanion({
    this.id = const Value.absent(),
    this.headerId = const Value.absent(),
    this.subsidiaryId = const Value.absent(),
    this.detailedId = const Value.absent(),
    this.detailedIdSecond = const Value.absent(),
    this.debit = const Value.absent(),
    this.credit = const Value.absent(),
    this.series = const Value.absent(),
    this.memo = const Value.absent(),
  });
  JournalLinesCompanion.insert({
    this.id = const Value.absent(),
    required int headerId,
    required int subsidiaryId,
    this.detailedId = const Value.absent(),
    this.detailedIdSecond = const Value.absent(),
    required BigInt debit,
    required BigInt credit,
    required String series,
    this.memo = const Value.absent(),
  }) : headerId = Value(headerId),
       subsidiaryId = Value(subsidiaryId),
       debit = Value(debit),
       credit = Value(credit),
       series = Value(series);
  static Insertable<JournalLine> custom({
    Expression<int>? id,
    Expression<int>? headerId,
    Expression<int>? subsidiaryId,
    Expression<int>? detailedId,
    Expression<int>? detailedIdSecond,
    Expression<BigInt>? debit,
    Expression<BigInt>? credit,
    Expression<String>? series,
    Expression<String>? memo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (headerId != null) 'header_id': headerId,
      if (subsidiaryId != null) 'subsidiary_id': subsidiaryId,
      if (detailedId != null) 'detailed_id': detailedId,
      if (detailedIdSecond != null) 'detailed_id_second': detailedIdSecond,
      if (debit != null) 'debit': debit,
      if (credit != null) 'credit': credit,
      if (series != null) 'series': series,
      if (memo != null) 'memo': memo,
    });
  }

  JournalLinesCompanion copyWith({
    Value<int>? id,
    Value<int>? headerId,
    Value<int>? subsidiaryId,
    Value<int?>? detailedId,
    Value<int?>? detailedIdSecond,
    Value<BigInt>? debit,
    Value<BigInt>? credit,
    Value<String>? series,
    Value<String?>? memo,
  }) {
    return JournalLinesCompanion(
      id: id ?? this.id,
      headerId: headerId ?? this.headerId,
      subsidiaryId: subsidiaryId ?? this.subsidiaryId,
      detailedId: detailedId ?? this.detailedId,
      detailedIdSecond: detailedIdSecond ?? this.detailedIdSecond,
      debit: debit ?? this.debit,
      credit: credit ?? this.credit,
      series: series ?? this.series,
      memo: memo ?? this.memo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (headerId.present) {
      map['header_id'] = Variable<int>(headerId.value);
    }
    if (subsidiaryId.present) {
      map['subsidiary_id'] = Variable<int>(subsidiaryId.value);
    }
    if (detailedId.present) {
      map['detailed_id'] = Variable<int>(detailedId.value);
    }
    if (detailedIdSecond.present) {
      map['detailed_id_second'] = Variable<int>(detailedIdSecond.value);
    }
    if (debit.present) {
      map['debit'] = Variable<BigInt>(debit.value);
    }
    if (credit.present) {
      map['credit'] = Variable<BigInt>(credit.value);
    }
    if (series.present) {
      map['series'] = Variable<String>(series.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalLinesCompanion(')
          ..write('id: $id, ')
          ..write('headerId: $headerId, ')
          ..write('subsidiaryId: $subsidiaryId, ')
          ..write('detailedId: $detailedId, ')
          ..write('detailedIdSecond: $detailedIdSecond, ')
          ..write('debit: $debit, ')
          ..write('credit: $credit, ')
          ..write('series: $series, ')
          ..write('memo: $memo')
          ..write(')'))
        .toString();
  }
}

class $TeamMembersTable extends TeamMembers
    with TableInfo<$TeamMembersTable, TeamMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIDMeta = const VerificationMeta('userID');
  @override
  late final GeneratedColumn<int> userID = GeneratedColumn<int>(
    'user_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _teamIDMeta = const VerificationMeta('teamID');
  @override
  late final GeneratedColumn<int> teamID = GeneratedColumn<int>(
    'team_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES teams (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sharePercentageMeta = const VerificationMeta(
    'sharePercentage',
  );
  @override
  late final GeneratedColumn<double> sharePercentage = GeneratedColumn<double>(
    'share_percentage',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createAtMeta = const VerificationMeta(
    'createAt',
  );
  @override
  late final GeneratedColumn<DateTime> createAt = GeneratedColumn<DateTime>(
    'create_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userID,
    teamID,
    sharePercentage,
    createAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'team_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeamMember> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_i_d')) {
      context.handle(
        _userIDMeta,
        userID.isAcceptableOrUnknown(data['user_i_d']!, _userIDMeta),
      );
    } else if (isInserting) {
      context.missing(_userIDMeta);
    }
    if (data.containsKey('team_i_d')) {
      context.handle(
        _teamIDMeta,
        teamID.isAcceptableOrUnknown(data['team_i_d']!, _teamIDMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIDMeta);
    }
    if (data.containsKey('share_percentage')) {
      context.handle(
        _sharePercentageMeta,
        sharePercentage.isAcceptableOrUnknown(
          data['share_percentage']!,
          _sharePercentageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sharePercentageMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TeamMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamMember(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_i_d'],
      )!,
      teamID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_i_d'],
      )!,
      sharePercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}share_percentage'],
      )!,
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
    );
  }

  @override
  $TeamMembersTable createAlias(String alias) {
    return $TeamMembersTable(attachedDatabase, alias);
  }
}

class TeamMember extends DataClass implements Insertable<TeamMember> {
  final int id;
  final int userID;
  final int teamID;
  final double sharePercentage;
  final DateTime createAt;
  const TeamMember({
    required this.id,
    required this.userID,
    required this.teamID,
    required this.sharePercentage,
    required this.createAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_i_d'] = Variable<int>(userID);
    map['team_i_d'] = Variable<int>(teamID);
    map['share_percentage'] = Variable<double>(sharePercentage);
    map['create_at'] = Variable<DateTime>(createAt);
    return map;
  }

  TeamMembersCompanion toCompanion(bool nullToAbsent) {
    return TeamMembersCompanion(
      id: Value(id),
      userID: Value(userID),
      teamID: Value(teamID),
      sharePercentage: Value(sharePercentage),
      createAt: Value(createAt),
    );
  }

  factory TeamMember.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamMember(
      id: serializer.fromJson<int>(json['id']),
      userID: serializer.fromJson<int>(json['userID']),
      teamID: serializer.fromJson<int>(json['teamID']),
      sharePercentage: serializer.fromJson<double>(json['sharePercentage']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userID': serializer.toJson<int>(userID),
      'teamID': serializer.toJson<int>(teamID),
      'sharePercentage': serializer.toJson<double>(sharePercentage),
      'createAt': serializer.toJson<DateTime>(createAt),
    };
  }

  TeamMember copyWith({
    int? id,
    int? userID,
    int? teamID,
    double? sharePercentage,
    DateTime? createAt,
  }) => TeamMember(
    id: id ?? this.id,
    userID: userID ?? this.userID,
    teamID: teamID ?? this.teamID,
    sharePercentage: sharePercentage ?? this.sharePercentage,
    createAt: createAt ?? this.createAt,
  );
  TeamMember copyWithCompanion(TeamMembersCompanion data) {
    return TeamMember(
      id: data.id.present ? data.id.value : this.id,
      userID: data.userID.present ? data.userID.value : this.userID,
      teamID: data.teamID.present ? data.teamID.value : this.teamID,
      sharePercentage: data.sharePercentage.present
          ? data.sharePercentage.value
          : this.sharePercentage,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamMember(')
          ..write('id: $id, ')
          ..write('userID: $userID, ')
          ..write('teamID: $teamID, ')
          ..write('sharePercentage: $sharePercentage, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userID, teamID, sharePercentage, createAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamMember &&
          other.id == this.id &&
          other.userID == this.userID &&
          other.teamID == this.teamID &&
          other.sharePercentage == this.sharePercentage &&
          other.createAt == this.createAt);
}

class TeamMembersCompanion extends UpdateCompanion<TeamMember> {
  final Value<int> id;
  final Value<int> userID;
  final Value<int> teamID;
  final Value<double> sharePercentage;
  final Value<DateTime> createAt;
  const TeamMembersCompanion({
    this.id = const Value.absent(),
    this.userID = const Value.absent(),
    this.teamID = const Value.absent(),
    this.sharePercentage = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  TeamMembersCompanion.insert({
    this.id = const Value.absent(),
    required int userID,
    required int teamID,
    required double sharePercentage,
    this.createAt = const Value.absent(),
  }) : userID = Value(userID),
       teamID = Value(teamID),
       sharePercentage = Value(sharePercentage);
  static Insertable<TeamMember> custom({
    Expression<int>? id,
    Expression<int>? userID,
    Expression<int>? teamID,
    Expression<double>? sharePercentage,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userID != null) 'user_i_d': userID,
      if (teamID != null) 'team_i_d': teamID,
      if (sharePercentage != null) 'share_percentage': sharePercentage,
      if (createAt != null) 'create_at': createAt,
    });
  }

  TeamMembersCompanion copyWith({
    Value<int>? id,
    Value<int>? userID,
    Value<int>? teamID,
    Value<double>? sharePercentage,
    Value<DateTime>? createAt,
  }) {
    return TeamMembersCompanion(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      teamID: teamID ?? this.teamID,
      sharePercentage: sharePercentage ?? this.sharePercentage,
      createAt: createAt ?? this.createAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userID.present) {
      map['user_i_d'] = Variable<int>(userID.value);
    }
    if (teamID.present) {
      map['team_i_d'] = Variable<int>(teamID.value);
    }
    if (sharePercentage.present) {
      map['share_percentage'] = Variable<double>(sharePercentage.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamMembersCompanion(')
          ..write('id: $id, ')
          ..write('userID: $userID, ')
          ..write('teamID: $teamID, ')
          ..write('sharePercentage: $sharePercentage, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }
}

class $MenuItemsTable extends MenuItems
    with TableInfo<$MenuItemsTable, MenuItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenuItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menu_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<MenuItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenuItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenuItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MenuItemsTable createAlias(String alias) {
    return $MenuItemsTable(attachedDatabase, alias);
  }
}

class MenuItem extends DataClass implements Insertable<MenuItem> {
  final int id;
  final String title;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MenuItem({
    required this.id,
    required this.title,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MenuItemsCompanion toCompanion(bool nullToAbsent) {
    return MenuItemsCompanion(
      id: Value(id),
      title: Value(title),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MenuItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenuItem(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MenuItem copyWith({
    int? id,
    String? title,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MenuItem(
    id: id ?? this.id,
    title: title ?? this.title,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MenuItem copyWithCompanion(MenuItemsCompanion data) {
    return MenuItem(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenuItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenuItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MenuItemsCompanion extends UpdateCompanion<MenuItem> {
  final Value<int> id;
  final Value<String> title;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MenuItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MenuItemsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<MenuItem> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MenuItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MenuItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenuItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EventOrdersTable extends EventOrders
    with TableInfo<$EventOrdersTable, EventOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIDMeta = const VerificationMeta('userID');
  @override
  late final GeneratedColumn<int> userID = GeneratedColumn<int>(
    'user_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eventIDMeta = const VerificationMeta(
    'eventID',
  );
  @override
  late final GeneratedColumn<int> eventID = GeneratedColumn<int>(
    'event_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _isDeliveredMeta = const VerificationMeta(
    'isDelivered',
  );
  @override
  late final GeneratedColumn<bool> isDelivered = GeneratedColumn<bool>(
    'is_delivered',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_delivered" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _menuItemsMeta = const VerificationMeta(
    'menuItems',
  );
  @override
  late final GeneratedColumn<String> menuItems = GeneratedColumn<String>(
    'menu_items',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userID,
    eventID,
    isDelivered,
    menuItems,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_i_d')) {
      context.handle(
        _userIDMeta,
        userID.isAcceptableOrUnknown(data['user_i_d']!, _userIDMeta),
      );
    } else if (isInserting) {
      context.missing(_userIDMeta);
    }
    if (data.containsKey('event_i_d')) {
      context.handle(
        _eventIDMeta,
        eventID.isAcceptableOrUnknown(data['event_i_d']!, _eventIDMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIDMeta);
    }
    if (data.containsKey('is_delivered')) {
      context.handle(
        _isDeliveredMeta,
        isDelivered.isAcceptableOrUnknown(
          data['is_delivered']!,
          _isDeliveredMeta,
        ),
      );
    }
    if (data.containsKey('menu_items')) {
      context.handle(
        _menuItemsMeta,
        menuItems.isAcceptableOrUnknown(data['menu_items']!, _menuItemsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventOrder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_i_d'],
      )!,
      eventID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_i_d'],
      )!,
      isDelivered: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_delivered'],
      )!,
      menuItems: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}menu_items'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EventOrdersTable createAlias(String alias) {
    return $EventOrdersTable(attachedDatabase, alias);
  }
}

class EventOrder extends DataClass implements Insertable<EventOrder> {
  final int id;
  final int userID;
  final int eventID;
  final bool isDelivered;
  final String? menuItems;
  final DateTime createdAt;
  final DateTime updatedAt;
  const EventOrder({
    required this.id,
    required this.userID,
    required this.eventID,
    required this.isDelivered,
    this.menuItems,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_i_d'] = Variable<int>(userID);
    map['event_i_d'] = Variable<int>(eventID);
    map['is_delivered'] = Variable<bool>(isDelivered);
    if (!nullToAbsent || menuItems != null) {
      map['menu_items'] = Variable<String>(menuItems);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EventOrdersCompanion toCompanion(bool nullToAbsent) {
    return EventOrdersCompanion(
      id: Value(id),
      userID: Value(userID),
      eventID: Value(eventID),
      isDelivered: Value(isDelivered),
      menuItems: menuItems == null && nullToAbsent
          ? const Value.absent()
          : Value(menuItems),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory EventOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventOrder(
      id: serializer.fromJson<int>(json['id']),
      userID: serializer.fromJson<int>(json['userID']),
      eventID: serializer.fromJson<int>(json['eventID']),
      isDelivered: serializer.fromJson<bool>(json['isDelivered']),
      menuItems: serializer.fromJson<String?>(json['menuItems']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userID': serializer.toJson<int>(userID),
      'eventID': serializer.toJson<int>(eventID),
      'isDelivered': serializer.toJson<bool>(isDelivered),
      'menuItems': serializer.toJson<String?>(menuItems),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  EventOrder copyWith({
    int? id,
    int? userID,
    int? eventID,
    bool? isDelivered,
    Value<String?> menuItems = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => EventOrder(
    id: id ?? this.id,
    userID: userID ?? this.userID,
    eventID: eventID ?? this.eventID,
    isDelivered: isDelivered ?? this.isDelivered,
    menuItems: menuItems.present ? menuItems.value : this.menuItems,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  EventOrder copyWithCompanion(EventOrdersCompanion data) {
    return EventOrder(
      id: data.id.present ? data.id.value : this.id,
      userID: data.userID.present ? data.userID.value : this.userID,
      eventID: data.eventID.present ? data.eventID.value : this.eventID,
      isDelivered: data.isDelivered.present
          ? data.isDelivered.value
          : this.isDelivered,
      menuItems: data.menuItems.present ? data.menuItems.value : this.menuItems,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventOrder(')
          ..write('id: $id, ')
          ..write('userID: $userID, ')
          ..write('eventID: $eventID, ')
          ..write('isDelivered: $isDelivered, ')
          ..write('menuItems: $menuItems, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userID,
    eventID,
    isDelivered,
    menuItems,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventOrder &&
          other.id == this.id &&
          other.userID == this.userID &&
          other.eventID == this.eventID &&
          other.isDelivered == this.isDelivered &&
          other.menuItems == this.menuItems &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EventOrdersCompanion extends UpdateCompanion<EventOrder> {
  final Value<int> id;
  final Value<int> userID;
  final Value<int> eventID;
  final Value<bool> isDelivered;
  final Value<String?> menuItems;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const EventOrdersCompanion({
    this.id = const Value.absent(),
    this.userID = const Value.absent(),
    this.eventID = const Value.absent(),
    this.isDelivered = const Value.absent(),
    this.menuItems = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  EventOrdersCompanion.insert({
    this.id = const Value.absent(),
    required int userID,
    required int eventID,
    this.isDelivered = const Value.absent(),
    this.menuItems = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : userID = Value(userID),
       eventID = Value(eventID);
  static Insertable<EventOrder> custom({
    Expression<int>? id,
    Expression<int>? userID,
    Expression<int>? eventID,
    Expression<bool>? isDelivered,
    Expression<String>? menuItems,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userID != null) 'user_i_d': userID,
      if (eventID != null) 'event_i_d': eventID,
      if (isDelivered != null) 'is_delivered': isDelivered,
      if (menuItems != null) 'menu_items': menuItems,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  EventOrdersCompanion copyWith({
    Value<int>? id,
    Value<int>? userID,
    Value<int>? eventID,
    Value<bool>? isDelivered,
    Value<String?>? menuItems,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return EventOrdersCompanion(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      eventID: eventID ?? this.eventID,
      isDelivered: isDelivered ?? this.isDelivered,
      menuItems: menuItems ?? this.menuItems,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userID.present) {
      map['user_i_d'] = Variable<int>(userID.value);
    }
    if (eventID.present) {
      map['event_i_d'] = Variable<int>(eventID.value);
    }
    if (isDelivered.present) {
      map['is_delivered'] = Variable<bool>(isDelivered.value);
    }
    if (menuItems.present) {
      map['menu_items'] = Variable<String>(menuItems.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventOrdersCompanion(')
          ..write('id: $id, ')
          ..write('userID: $userID, ')
          ..write('eventID: $eventID, ')
          ..write('isDelivered: $isDelivered, ')
          ..write('menuItems: $menuItems, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EventPartnerSharesTable extends EventPartnerShares
    with TableInfo<$EventPartnerSharesTable, EventPartnerShare> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventPartnerSharesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIDMeta = const VerificationMeta('userID');
  @override
  late final GeneratedColumn<int> userID = GeneratedColumn<int>(
    'user_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _eventIDMeta = const VerificationMeta(
    'eventID',
  );
  @override
  late final GeneratedColumn<int> eventID = GeneratedColumn<int>(
    'event_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _sharePercentageMeta = const VerificationMeta(
    'sharePercentage',
  );
  @override
  late final GeneratedColumn<double> sharePercentage = GeneratedColumn<double>(
    'share_percentage',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createAtMeta = const VerificationMeta(
    'createAt',
  );
  @override
  late final GeneratedColumn<DateTime> createAt = GeneratedColumn<DateTime>(
    'create_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDate,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userID,
    eventID,
    sharePercentage,
    createAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_partner_shares';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventPartnerShare> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_i_d')) {
      context.handle(
        _userIDMeta,
        userID.isAcceptableOrUnknown(data['user_i_d']!, _userIDMeta),
      );
    } else if (isInserting) {
      context.missing(_userIDMeta);
    }
    if (data.containsKey('event_i_d')) {
      context.handle(
        _eventIDMeta,
        eventID.isAcceptableOrUnknown(data['event_i_d']!, _eventIDMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIDMeta);
    }
    if (data.containsKey('share_percentage')) {
      context.handle(
        _sharePercentageMeta,
        sharePercentage.isAcceptableOrUnknown(
          data['share_percentage']!,
          _sharePercentageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sharePercentageMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(
        _createAtMeta,
        createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {eventID, userID},
  ];
  @override
  EventPartnerShare map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventPartnerShare(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_i_d'],
      )!,
      eventID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_i_d'],
      )!,
      sharePercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}share_percentage'],
      )!,
      createAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_at'],
      )!,
    );
  }

  @override
  $EventPartnerSharesTable createAlias(String alias) {
    return $EventPartnerSharesTable(attachedDatabase, alias);
  }
}

class EventPartnerShare extends DataClass
    implements Insertable<EventPartnerShare> {
  final int id;
  final int userID;
  final int eventID;
  final double sharePercentage;
  final DateTime createAt;
  const EventPartnerShare({
    required this.id,
    required this.userID,
    required this.eventID,
    required this.sharePercentage,
    required this.createAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_i_d'] = Variable<int>(userID);
    map['event_i_d'] = Variable<int>(eventID);
    map['share_percentage'] = Variable<double>(sharePercentage);
    map['create_at'] = Variable<DateTime>(createAt);
    return map;
  }

  EventPartnerSharesCompanion toCompanion(bool nullToAbsent) {
    return EventPartnerSharesCompanion(
      id: Value(id),
      userID: Value(userID),
      eventID: Value(eventID),
      sharePercentage: Value(sharePercentage),
      createAt: Value(createAt),
    );
  }

  factory EventPartnerShare.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventPartnerShare(
      id: serializer.fromJson<int>(json['id']),
      userID: serializer.fromJson<int>(json['userID']),
      eventID: serializer.fromJson<int>(json['eventID']),
      sharePercentage: serializer.fromJson<double>(json['sharePercentage']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userID': serializer.toJson<int>(userID),
      'eventID': serializer.toJson<int>(eventID),
      'sharePercentage': serializer.toJson<double>(sharePercentage),
      'createAt': serializer.toJson<DateTime>(createAt),
    };
  }

  EventPartnerShare copyWith({
    int? id,
    int? userID,
    int? eventID,
    double? sharePercentage,
    DateTime? createAt,
  }) => EventPartnerShare(
    id: id ?? this.id,
    userID: userID ?? this.userID,
    eventID: eventID ?? this.eventID,
    sharePercentage: sharePercentage ?? this.sharePercentage,
    createAt: createAt ?? this.createAt,
  );
  EventPartnerShare copyWithCompanion(EventPartnerSharesCompanion data) {
    return EventPartnerShare(
      id: data.id.present ? data.id.value : this.id,
      userID: data.userID.present ? data.userID.value : this.userID,
      eventID: data.eventID.present ? data.eventID.value : this.eventID,
      sharePercentage: data.sharePercentage.present
          ? data.sharePercentage.value
          : this.sharePercentage,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventPartnerShare(')
          ..write('id: $id, ')
          ..write('userID: $userID, ')
          ..write('eventID: $eventID, ')
          ..write('sharePercentage: $sharePercentage, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userID, eventID, sharePercentage, createAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventPartnerShare &&
          other.id == this.id &&
          other.userID == this.userID &&
          other.eventID == this.eventID &&
          other.sharePercentage == this.sharePercentage &&
          other.createAt == this.createAt);
}

class EventPartnerSharesCompanion extends UpdateCompanion<EventPartnerShare> {
  final Value<int> id;
  final Value<int> userID;
  final Value<int> eventID;
  final Value<double> sharePercentage;
  final Value<DateTime> createAt;
  const EventPartnerSharesCompanion({
    this.id = const Value.absent(),
    this.userID = const Value.absent(),
    this.eventID = const Value.absent(),
    this.sharePercentage = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  EventPartnerSharesCompanion.insert({
    this.id = const Value.absent(),
    required int userID,
    required int eventID,
    required double sharePercentage,
    this.createAt = const Value.absent(),
  }) : userID = Value(userID),
       eventID = Value(eventID),
       sharePercentage = Value(sharePercentage);
  static Insertable<EventPartnerShare> custom({
    Expression<int>? id,
    Expression<int>? userID,
    Expression<int>? eventID,
    Expression<double>? sharePercentage,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userID != null) 'user_i_d': userID,
      if (eventID != null) 'event_i_d': eventID,
      if (sharePercentage != null) 'share_percentage': sharePercentage,
      if (createAt != null) 'create_at': createAt,
    });
  }

  EventPartnerSharesCompanion copyWith({
    Value<int>? id,
    Value<int>? userID,
    Value<int>? eventID,
    Value<double>? sharePercentage,
    Value<DateTime>? createAt,
  }) {
    return EventPartnerSharesCompanion(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      eventID: eventID ?? this.eventID,
      sharePercentage: sharePercentage ?? this.sharePercentage,
      createAt: createAt ?? this.createAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userID.present) {
      map['user_i_d'] = Variable<int>(userID.value);
    }
    if (eventID.present) {
      map['event_i_d'] = Variable<int>(eventID.value);
    }
    if (sharePercentage.present) {
      map['share_percentage'] = Variable<double>(sharePercentage.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventPartnerSharesCompanion(')
          ..write('id: $id, ')
          ..write('userID: $userID, ')
          ..write('eventID: $eventID, ')
          ..write('sharePercentage: $sharePercentage, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }
}

class $EventRegistrationsTable extends EventRegistrations
    with TableInfo<$EventRegistrationsTable, EventRegistration> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventRegistrationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _eventIDMeta = const VerificationMeta(
    'eventID',
  );
  @override
  late final GeneratedColumn<int> eventID = GeneratedColumn<int>(
    'event_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _userIDMeta = const VerificationMeta('userID');
  @override
  late final GeneratedColumn<int> userID = GeneratedColumn<int>(
    'user_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE RESTRICT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RegistrationStatus, String>
  status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(RegistrationStatus.pending.name),
      ).withConverter<RegistrationStatus>(
        $EventRegistrationsTable.$converterstatus,
      );
  static const VerificationMeta _grossAmountMeta = const VerificationMeta(
    'grossAmount',
  );
  @override
  late final GeneratedColumn<BigInt> grossAmount = GeneratedColumn<BigInt>(
    'gross_amount',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountAmountMeta = const VerificationMeta(
    'discountAmount',
  );
  @override
  late final GeneratedColumn<BigInt> discountAmount = GeneratedColumn<BigInt>(
    'discount_amount',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _netAmountMeta = const VerificationMeta(
    'netAmount',
  );
  @override
  late final GeneratedColumn<BigInt> netAmount = GeneratedColumn<BigInt>(
    'net_amount',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _registeredAtMeta = const VerificationMeta(
    'registeredAt',
  );
  @override
  late final GeneratedColumn<DateTime> registeredAt = GeneratedColumn<DateTime>(
    'registered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventID,
    userID,
    status,
    grossAmount,
    discountAmount,
    netAmount,
    registeredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_registrations';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventRegistration> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_i_d')) {
      context.handle(
        _eventIDMeta,
        eventID.isAcceptableOrUnknown(data['event_i_d']!, _eventIDMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIDMeta);
    }
    if (data.containsKey('user_i_d')) {
      context.handle(
        _userIDMeta,
        userID.isAcceptableOrUnknown(data['user_i_d']!, _userIDMeta),
      );
    } else if (isInserting) {
      context.missing(_userIDMeta);
    }
    if (data.containsKey('gross_amount')) {
      context.handle(
        _grossAmountMeta,
        grossAmount.isAcceptableOrUnknown(
          data['gross_amount']!,
          _grossAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_grossAmountMeta);
    }
    if (data.containsKey('discount_amount')) {
      context.handle(
        _discountAmountMeta,
        discountAmount.isAcceptableOrUnknown(
          data['discount_amount']!,
          _discountAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_discountAmountMeta);
    }
    if (data.containsKey('net_amount')) {
      context.handle(
        _netAmountMeta,
        netAmount.isAcceptableOrUnknown(data['net_amount']!, _netAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_netAmountMeta);
    }
    if (data.containsKey('registered_at')) {
      context.handle(
        _registeredAtMeta,
        registeredAt.isAcceptableOrUnknown(
          data['registered_at']!,
          _registeredAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {eventID, userID},
  ];
  @override
  EventRegistration map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventRegistration(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eventID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_i_d'],
      )!,
      userID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_i_d'],
      )!,
      status: $EventRegistrationsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      grossAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}gross_amount'],
      )!,
      discountAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}discount_amount'],
      )!,
      netAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}net_amount'],
      )!,
      registeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}registered_at'],
      )!,
    );
  }

  @override
  $EventRegistrationsTable createAlias(String alias) {
    return $EventRegistrationsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RegistrationStatus, String, String>
  $converterstatus = const EnumNameConverter<RegistrationStatus>(
    RegistrationStatus.values,
  );
}

class EventRegistration extends DataClass
    implements Insertable<EventRegistration> {
  final int id;
  final int eventID;
  final int userID;
  final RegistrationStatus status;
  final BigInt grossAmount;
  final BigInt discountAmount;
  final BigInt netAmount;
  final DateTime registeredAt;
  const EventRegistration({
    required this.id,
    required this.eventID,
    required this.userID,
    required this.status,
    required this.grossAmount,
    required this.discountAmount,
    required this.netAmount,
    required this.registeredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_i_d'] = Variable<int>(eventID);
    map['user_i_d'] = Variable<int>(userID);
    {
      map['status'] = Variable<String>(
        $EventRegistrationsTable.$converterstatus.toSql(status),
      );
    }
    map['gross_amount'] = Variable<BigInt>(grossAmount);
    map['discount_amount'] = Variable<BigInt>(discountAmount);
    map['net_amount'] = Variable<BigInt>(netAmount);
    map['registered_at'] = Variable<DateTime>(registeredAt);
    return map;
  }

  EventRegistrationsCompanion toCompanion(bool nullToAbsent) {
    return EventRegistrationsCompanion(
      id: Value(id),
      eventID: Value(eventID),
      userID: Value(userID),
      status: Value(status),
      grossAmount: Value(grossAmount),
      discountAmount: Value(discountAmount),
      netAmount: Value(netAmount),
      registeredAt: Value(registeredAt),
    );
  }

  factory EventRegistration.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventRegistration(
      id: serializer.fromJson<int>(json['id']),
      eventID: serializer.fromJson<int>(json['eventID']),
      userID: serializer.fromJson<int>(json['userID']),
      status: $EventRegistrationsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      grossAmount: serializer.fromJson<BigInt>(json['grossAmount']),
      discountAmount: serializer.fromJson<BigInt>(json['discountAmount']),
      netAmount: serializer.fromJson<BigInt>(json['netAmount']),
      registeredAt: serializer.fromJson<DateTime>(json['registeredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventID': serializer.toJson<int>(eventID),
      'userID': serializer.toJson<int>(userID),
      'status': serializer.toJson<String>(
        $EventRegistrationsTable.$converterstatus.toJson(status),
      ),
      'grossAmount': serializer.toJson<BigInt>(grossAmount),
      'discountAmount': serializer.toJson<BigInt>(discountAmount),
      'netAmount': serializer.toJson<BigInt>(netAmount),
      'registeredAt': serializer.toJson<DateTime>(registeredAt),
    };
  }

  EventRegistration copyWith({
    int? id,
    int? eventID,
    int? userID,
    RegistrationStatus? status,
    BigInt? grossAmount,
    BigInt? discountAmount,
    BigInt? netAmount,
    DateTime? registeredAt,
  }) => EventRegistration(
    id: id ?? this.id,
    eventID: eventID ?? this.eventID,
    userID: userID ?? this.userID,
    status: status ?? this.status,
    grossAmount: grossAmount ?? this.grossAmount,
    discountAmount: discountAmount ?? this.discountAmount,
    netAmount: netAmount ?? this.netAmount,
    registeredAt: registeredAt ?? this.registeredAt,
  );
  EventRegistration copyWithCompanion(EventRegistrationsCompanion data) {
    return EventRegistration(
      id: data.id.present ? data.id.value : this.id,
      eventID: data.eventID.present ? data.eventID.value : this.eventID,
      userID: data.userID.present ? data.userID.value : this.userID,
      status: data.status.present ? data.status.value : this.status,
      grossAmount: data.grossAmount.present
          ? data.grossAmount.value
          : this.grossAmount,
      discountAmount: data.discountAmount.present
          ? data.discountAmount.value
          : this.discountAmount,
      netAmount: data.netAmount.present ? data.netAmount.value : this.netAmount,
      registeredAt: data.registeredAt.present
          ? data.registeredAt.value
          : this.registeredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventRegistration(')
          ..write('id: $id, ')
          ..write('eventID: $eventID, ')
          ..write('userID: $userID, ')
          ..write('status: $status, ')
          ..write('grossAmount: $grossAmount, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('netAmount: $netAmount, ')
          ..write('registeredAt: $registeredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventID,
    userID,
    status,
    grossAmount,
    discountAmount,
    netAmount,
    registeredAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventRegistration &&
          other.id == this.id &&
          other.eventID == this.eventID &&
          other.userID == this.userID &&
          other.status == this.status &&
          other.grossAmount == this.grossAmount &&
          other.discountAmount == this.discountAmount &&
          other.netAmount == this.netAmount &&
          other.registeredAt == this.registeredAt);
}

class EventRegistrationsCompanion extends UpdateCompanion<EventRegistration> {
  final Value<int> id;
  final Value<int> eventID;
  final Value<int> userID;
  final Value<RegistrationStatus> status;
  final Value<BigInt> grossAmount;
  final Value<BigInt> discountAmount;
  final Value<BigInt> netAmount;
  final Value<DateTime> registeredAt;
  const EventRegistrationsCompanion({
    this.id = const Value.absent(),
    this.eventID = const Value.absent(),
    this.userID = const Value.absent(),
    this.status = const Value.absent(),
    this.grossAmount = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.netAmount = const Value.absent(),
    this.registeredAt = const Value.absent(),
  });
  EventRegistrationsCompanion.insert({
    this.id = const Value.absent(),
    required int eventID,
    required int userID,
    this.status = const Value.absent(),
    required BigInt grossAmount,
    required BigInt discountAmount,
    required BigInt netAmount,
    this.registeredAt = const Value.absent(),
  }) : eventID = Value(eventID),
       userID = Value(userID),
       grossAmount = Value(grossAmount),
       discountAmount = Value(discountAmount),
       netAmount = Value(netAmount);
  static Insertable<EventRegistration> custom({
    Expression<int>? id,
    Expression<int>? eventID,
    Expression<int>? userID,
    Expression<String>? status,
    Expression<BigInt>? grossAmount,
    Expression<BigInt>? discountAmount,
    Expression<BigInt>? netAmount,
    Expression<DateTime>? registeredAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventID != null) 'event_i_d': eventID,
      if (userID != null) 'user_i_d': userID,
      if (status != null) 'status': status,
      if (grossAmount != null) 'gross_amount': grossAmount,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (netAmount != null) 'net_amount': netAmount,
      if (registeredAt != null) 'registered_at': registeredAt,
    });
  }

  EventRegistrationsCompanion copyWith({
    Value<int>? id,
    Value<int>? eventID,
    Value<int>? userID,
    Value<RegistrationStatus>? status,
    Value<BigInt>? grossAmount,
    Value<BigInt>? discountAmount,
    Value<BigInt>? netAmount,
    Value<DateTime>? registeredAt,
  }) {
    return EventRegistrationsCompanion(
      id: id ?? this.id,
      eventID: eventID ?? this.eventID,
      userID: userID ?? this.userID,
      status: status ?? this.status,
      grossAmount: grossAmount ?? this.grossAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      netAmount: netAmount ?? this.netAmount,
      registeredAt: registeredAt ?? this.registeredAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventID.present) {
      map['event_i_d'] = Variable<int>(eventID.value);
    }
    if (userID.present) {
      map['user_i_d'] = Variable<int>(userID.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $EventRegistrationsTable.$converterstatus.toSql(status.value),
      );
    }
    if (grossAmount.present) {
      map['gross_amount'] = Variable<BigInt>(grossAmount.value);
    }
    if (discountAmount.present) {
      map['discount_amount'] = Variable<BigInt>(discountAmount.value);
    }
    if (netAmount.present) {
      map['net_amount'] = Variable<BigInt>(netAmount.value);
    }
    if (registeredAt.present) {
      map['registered_at'] = Variable<DateTime>(registeredAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventRegistrationsCompanion(')
          ..write('id: $id, ')
          ..write('eventID: $eventID, ')
          ..write('userID: $userID, ')
          ..write('status: $status, ')
          ..write('grossAmount: $grossAmount, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('netAmount: $netAmount, ')
          ..write('registeredAt: $registeredAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountGroupsTable accountGroups = $AccountGroupsTable(this);
  late final $GeneralAccountsTable generalAccounts = $GeneralAccountsTable(
    this,
  );
  late final $SubsidiaryAccountsTable subsidiaryAccounts =
      $SubsidiaryAccountsTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $TeamsTable teams = $TeamsTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $BanksTable banks = $BanksTable(this);
  late final $DetailedAccountsTable detailedAccounts = $DetailedAccountsTable(
    this,
  );
  late final $JournalHeadersTable journalHeaders = $JournalHeadersTable(this);
  late final $JournalLinesTable journalLines = $JournalLinesTable(this);
  late final $TeamMembersTable teamMembers = $TeamMembersTable(this);
  late final $MenuItemsTable menuItems = $MenuItemsTable(this);
  late final $EventOrdersTable eventOrders = $EventOrdersTable(this);
  late final $EventPartnerSharesTable eventPartnerShares =
      $EventPartnerSharesTable(this);
  late final $EventRegistrationsTable eventRegistrations =
      $EventRegistrationsTable(this);
  late final UsersDao usersDao = UsersDao(this as AppDatabase);
  late final TeamsDao teamsDao = TeamsDao(this as AppDatabase);
  late final TeamMembersDao teamMembersDao = TeamMembersDao(
    this as AppDatabase,
  );
  late final MenuItemsDao menuItemsDao = MenuItemsDao(this as AppDatabase);
  late final BanksDao banksDao = BanksDao(this as AppDatabase);
  late final EventsDao eventsDao = EventsDao(this as AppDatabase);
  late final EventOrdersDao eventOrdersDao = EventOrdersDao(
    this as AppDatabase,
  );
  late final EventRegistrationsDao eventRegistrationsDao =
      EventRegistrationsDao(this as AppDatabase);
  late final DetailedAccountsDao detailedAccountsDao = DetailedAccountsDao(
    this as AppDatabase,
  );
  late final SubsidiaryAccountsDao subsidiaryAccountsDao =
      SubsidiaryAccountsDao(this as AppDatabase);
  late final EventPartnerSharesDao eventPartnerSharesDao =
      EventPartnerSharesDao(this as AppDatabase);
  late final JournalsDao journalsDao = JournalsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accountGroups,
    generalAccounts,
    subsidiaryAccounts,
    users,
    teams,
    events,
    banks,
    detailedAccounts,
    journalHeaders,
    journalLines,
    teamMembers,
    menuItems,
    eventOrders,
    eventPartnerShares,
    eventRegistrations,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'account_groups',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('general_accounts', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'general_accounts',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('subsidiary_accounts', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'teams',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'journal_headers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('journal_lines', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'journal_headers',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('journal_lines', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subsidiary_accounts',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('journal_lines', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'detailed_accounts',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('journal_lines', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'detailed_accounts',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('journal_lines', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('team_members', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'teams',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('team_members', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_orders', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_orders', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_registrations', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$AccountGroupsTableCreateCompanionBuilder =
    AccountGroupsCompanion Function({
      Value<int> id,
      required String code,
      required String name,
      required AccountGroupType type,
    });
typedef $$AccountGroupsTableUpdateCompanionBuilder =
    AccountGroupsCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> name,
      Value<AccountGroupType> type,
    });

final class $$AccountGroupsTableReferences
    extends BaseReferences<_$AppDatabase, $AccountGroupsTable, AccountGroup> {
  $$AccountGroupsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$GeneralAccountsTable, List<GeneralAccount>>
  _generalAccountsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.generalAccounts,
    aliasName: 'account_groups__id__general_accounts__group_i_d',
  );

  $$GeneralAccountsTableProcessedTableManager get generalAccountsRefs {
    final manager = $$GeneralAccountsTableTableManager(
      $_db,
      $_db.generalAccounts,
    ).filter((f) => f.groupID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _generalAccountsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AccountGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountGroupsTable> {
  $$AccountGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AccountGroupType, AccountGroupType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  Expression<bool> generalAccountsRefs(
    Expression<bool> Function($$GeneralAccountsTableFilterComposer f) f,
  ) {
    final $$GeneralAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.generalAccounts,
      getReferencedColumn: (t) => t.groupID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GeneralAccountsTableFilterComposer(
            $db: $db,
            $table: $db.generalAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountGroupsTable> {
  $$AccountGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountGroupsTable> {
  $$AccountGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AccountGroupType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  Expression<T> generalAccountsRefs<T extends Object>(
    Expression<T> Function($$GeneralAccountsTableAnnotationComposer a) f,
  ) {
    final $$GeneralAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.generalAccounts,
      getReferencedColumn: (t) => t.groupID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GeneralAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.generalAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountGroupsTable,
          AccountGroup,
          $$AccountGroupsTableFilterComposer,
          $$AccountGroupsTableOrderingComposer,
          $$AccountGroupsTableAnnotationComposer,
          $$AccountGroupsTableCreateCompanionBuilder,
          $$AccountGroupsTableUpdateCompanionBuilder,
          (AccountGroup, $$AccountGroupsTableReferences),
          AccountGroup,
          PrefetchHooks Function({bool generalAccountsRefs})
        > {
  $$AccountGroupsTableTableManager(_$AppDatabase db, $AccountGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<AccountGroupType> type = const Value.absent(),
              }) => AccountGroupsCompanion(
                id: id,
                code: code,
                name: name,
                type: type,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String name,
                required AccountGroupType type,
              }) => AccountGroupsCompanion.insert(
                id: id,
                code: code,
                name: name,
                type: type,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AccountGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({generalAccountsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (generalAccountsRefs) db.generalAccounts,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (generalAccountsRefs)
                    await $_getPrefetchedData<
                      AccountGroup,
                      $AccountGroupsTable,
                      GeneralAccount
                    >(
                      currentTable: table,
                      referencedTable: $$AccountGroupsTableReferences
                          ._generalAccountsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AccountGroupsTableReferences(
                            db,
                            table,
                            p0,
                          ).generalAccountsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.groupID == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AccountGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountGroupsTable,
      AccountGroup,
      $$AccountGroupsTableFilterComposer,
      $$AccountGroupsTableOrderingComposer,
      $$AccountGroupsTableAnnotationComposer,
      $$AccountGroupsTableCreateCompanionBuilder,
      $$AccountGroupsTableUpdateCompanionBuilder,
      (AccountGroup, $$AccountGroupsTableReferences),
      AccountGroup,
      PrefetchHooks Function({bool generalAccountsRefs})
    >;
typedef $$GeneralAccountsTableCreateCompanionBuilder =
    GeneralAccountsCompanion Function({
      Value<int> id,
      required String code,
      required String name,
      required int groupID,
      required GeneralAccountType type,
    });
typedef $$GeneralAccountsTableUpdateCompanionBuilder =
    GeneralAccountsCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> name,
      Value<int> groupID,
      Value<GeneralAccountType> type,
    });

final class $$GeneralAccountsTableReferences
    extends
        BaseReferences<_$AppDatabase, $GeneralAccountsTable, GeneralAccount> {
  $$GeneralAccountsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AccountGroupsTable _groupIDTable(_$AppDatabase db) => db.accountGroups
      .createAlias('general_accounts__group_i_d__account_groups__id');

  $$AccountGroupsTableProcessedTableManager get groupID {
    final $_column = $_itemColumn<int>('group_i_d')!;

    final manager = $$AccountGroupsTableTableManager(
      $_db,
      $_db.accountGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SubsidiaryAccountsTable, List<SubsidiaryAccount>>
  _subsidiaryAccountsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.subsidiaryAccounts,
        aliasName: 'general_accounts__id__subsidiary_accounts__general_id',
      );

  $$SubsidiaryAccountsTableProcessedTableManager get subsidiaryAccountsRefs {
    final manager = $$SubsidiaryAccountsTableTableManager(
      $_db,
      $_db.subsidiaryAccounts,
    ).filter((f) => f.generalId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _subsidiaryAccountsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GeneralAccountsTableFilterComposer
    extends Composer<_$AppDatabase, $GeneralAccountsTable> {
  $$GeneralAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GeneralAccountType, GeneralAccountType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$AccountGroupsTableFilterComposer get groupID {
    final $$AccountGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupID,
      referencedTable: $db.accountGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountGroupsTableFilterComposer(
            $db: $db,
            $table: $db.accountGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> subsidiaryAccountsRefs(
    Expression<bool> Function($$SubsidiaryAccountsTableFilterComposer f) f,
  ) {
    final $$SubsidiaryAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subsidiaryAccounts,
      getReferencedColumn: (t) => t.generalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubsidiaryAccountsTableFilterComposer(
            $db: $db,
            $table: $db.subsidiaryAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GeneralAccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $GeneralAccountsTable> {
  $$GeneralAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountGroupsTableOrderingComposer get groupID {
    final $$AccountGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupID,
      referencedTable: $db.accountGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.accountGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GeneralAccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GeneralAccountsTable> {
  $$GeneralAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GeneralAccountType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  $$AccountGroupsTableAnnotationComposer get groupID {
    final $$AccountGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupID,
      referencedTable: $db.accountGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.accountGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> subsidiaryAccountsRefs<T extends Object>(
    Expression<T> Function($$SubsidiaryAccountsTableAnnotationComposer a) f,
  ) {
    final $$SubsidiaryAccountsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.subsidiaryAccounts,
          getReferencedColumn: (t) => t.generalId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SubsidiaryAccountsTableAnnotationComposer(
                $db: $db,
                $table: $db.subsidiaryAccounts,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$GeneralAccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GeneralAccountsTable,
          GeneralAccount,
          $$GeneralAccountsTableFilterComposer,
          $$GeneralAccountsTableOrderingComposer,
          $$GeneralAccountsTableAnnotationComposer,
          $$GeneralAccountsTableCreateCompanionBuilder,
          $$GeneralAccountsTableUpdateCompanionBuilder,
          (GeneralAccount, $$GeneralAccountsTableReferences),
          GeneralAccount,
          PrefetchHooks Function({bool groupID, bool subsidiaryAccountsRefs})
        > {
  $$GeneralAccountsTableTableManager(
    _$AppDatabase db,
    $GeneralAccountsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GeneralAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GeneralAccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GeneralAccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> groupID = const Value.absent(),
                Value<GeneralAccountType> type = const Value.absent(),
              }) => GeneralAccountsCompanion(
                id: id,
                code: code,
                name: name,
                groupID: groupID,
                type: type,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String name,
                required int groupID,
                required GeneralAccountType type,
              }) => GeneralAccountsCompanion.insert(
                id: id,
                code: code,
                name: name,
                groupID: groupID,
                type: type,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GeneralAccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({groupID = false, subsidiaryAccountsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (subsidiaryAccountsRefs) db.subsidiaryAccounts,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (groupID) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.groupID,
                            referencedTable: $$GeneralAccountsTableReferences
                                ._groupIDTable(db),
                            referencedColumn: $$GeneralAccountsTableReferences
                                ._groupIDTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (subsidiaryAccountsRefs)
                        await $_getPrefetchedData<
                          GeneralAccount,
                          $GeneralAccountsTable,
                          SubsidiaryAccount
                        >(
                          currentTable: table,
                          referencedTable: $$GeneralAccountsTableReferences
                              ._subsidiaryAccountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GeneralAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).subsidiaryAccountsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.generalId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GeneralAccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GeneralAccountsTable,
      GeneralAccount,
      $$GeneralAccountsTableFilterComposer,
      $$GeneralAccountsTableOrderingComposer,
      $$GeneralAccountsTableAnnotationComposer,
      $$GeneralAccountsTableCreateCompanionBuilder,
      $$GeneralAccountsTableUpdateCompanionBuilder,
      (GeneralAccount, $$GeneralAccountsTableReferences),
      GeneralAccount,
      PrefetchHooks Function({bool groupID, bool subsidiaryAccountsRefs})
    >;
typedef $$SubsidiaryAccountsTableCreateCompanionBuilder =
    SubsidiaryAccountsCompanion Function({
      Value<int> id,
      required int generalId,
      required String code,
      required String name,
      required SubsidiaryAccountType type,
    });
typedef $$SubsidiaryAccountsTableUpdateCompanionBuilder =
    SubsidiaryAccountsCompanion Function({
      Value<int> id,
      Value<int> generalId,
      Value<String> code,
      Value<String> name,
      Value<SubsidiaryAccountType> type,
    });

final class $$SubsidiaryAccountsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SubsidiaryAccountsTable,
          SubsidiaryAccount
        > {
  $$SubsidiaryAccountsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GeneralAccountsTable _generalIdTable(_$AppDatabase db) => db
      .generalAccounts
      .createAlias('subsidiary_accounts__general_id__general_accounts__id');

  $$GeneralAccountsTableProcessedTableManager get generalId {
    final $_column = $_itemColumn<int>('general_id')!;

    final manager = $$GeneralAccountsTableTableManager(
      $_db,
      $_db.generalAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_generalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$JournalLinesTable, List<JournalLine>>
  _journalLinesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.journalLines,
    aliasName: 'subsidiary_accounts__id__journal_lines__subsidiary_id',
  );

  $$JournalLinesTableProcessedTableManager get journalLinesRefs {
    final manager = $$JournalLinesTableTableManager(
      $_db,
      $_db.journalLines,
    ).filter((f) => f.subsidiaryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_journalLinesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SubsidiaryAccountsTableFilterComposer
    extends Composer<_$AppDatabase, $SubsidiaryAccountsTable> {
  $$SubsidiaryAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    SubsidiaryAccountType,
    SubsidiaryAccountType,
    String
  >
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$GeneralAccountsTableFilterComposer get generalId {
    final $$GeneralAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.generalId,
      referencedTable: $db.generalAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GeneralAccountsTableFilterComposer(
            $db: $db,
            $table: $db.generalAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> journalLinesRefs(
    Expression<bool> Function($$JournalLinesTableFilterComposer f) f,
  ) {
    final $$JournalLinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalLines,
      getReferencedColumn: (t) => t.subsidiaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalLinesTableFilterComposer(
            $db: $db,
            $table: $db.journalLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubsidiaryAccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubsidiaryAccountsTable> {
  $$SubsidiaryAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  $$GeneralAccountsTableOrderingComposer get generalId {
    final $$GeneralAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.generalId,
      referencedTable: $db.generalAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GeneralAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.generalAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubsidiaryAccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubsidiaryAccountsTable> {
  $$SubsidiaryAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SubsidiaryAccountType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  $$GeneralAccountsTableAnnotationComposer get generalId {
    final $$GeneralAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.generalId,
      referencedTable: $db.generalAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GeneralAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.generalAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> journalLinesRefs<T extends Object>(
    Expression<T> Function($$JournalLinesTableAnnotationComposer a) f,
  ) {
    final $$JournalLinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalLines,
      getReferencedColumn: (t) => t.subsidiaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalLinesTableAnnotationComposer(
            $db: $db,
            $table: $db.journalLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubsidiaryAccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubsidiaryAccountsTable,
          SubsidiaryAccount,
          $$SubsidiaryAccountsTableFilterComposer,
          $$SubsidiaryAccountsTableOrderingComposer,
          $$SubsidiaryAccountsTableAnnotationComposer,
          $$SubsidiaryAccountsTableCreateCompanionBuilder,
          $$SubsidiaryAccountsTableUpdateCompanionBuilder,
          (SubsidiaryAccount, $$SubsidiaryAccountsTableReferences),
          SubsidiaryAccount,
          PrefetchHooks Function({bool generalId, bool journalLinesRefs})
        > {
  $$SubsidiaryAccountsTableTableManager(
    _$AppDatabase db,
    $SubsidiaryAccountsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubsidiaryAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubsidiaryAccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubsidiaryAccountsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> generalId = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<SubsidiaryAccountType> type = const Value.absent(),
              }) => SubsidiaryAccountsCompanion(
                id: id,
                generalId: generalId,
                code: code,
                name: name,
                type: type,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int generalId,
                required String code,
                required String name,
                required SubsidiaryAccountType type,
              }) => SubsidiaryAccountsCompanion.insert(
                id: id,
                generalId: generalId,
                code: code,
                name: name,
                type: type,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SubsidiaryAccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({generalId = false, journalLinesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (journalLinesRefs) db.journalLines,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (generalId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.generalId,
                            referencedTable: $$SubsidiaryAccountsTableReferences
                                ._generalIdTable(db),
                            referencedColumn:
                                $$SubsidiaryAccountsTableReferences
                                    ._generalIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (journalLinesRefs)
                        await $_getPrefetchedData<
                          SubsidiaryAccount,
                          $SubsidiaryAccountsTable,
                          JournalLine
                        >(
                          currentTable: table,
                          referencedTable: $$SubsidiaryAccountsTableReferences
                              ._journalLinesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubsidiaryAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).journalLinesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.subsidiaryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SubsidiaryAccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubsidiaryAccountsTable,
      SubsidiaryAccount,
      $$SubsidiaryAccountsTableFilterComposer,
      $$SubsidiaryAccountsTableOrderingComposer,
      $$SubsidiaryAccountsTableAnnotationComposer,
      $$SubsidiaryAccountsTableCreateCompanionBuilder,
      $$SubsidiaryAccountsTableUpdateCompanionBuilder,
      (SubsidiaryAccount, $$SubsidiaryAccountsTableReferences),
      SubsidiaryAccount,
      PrefetchHooks Function({bool generalId, bool journalLinesRefs})
    >;
typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  Value<String?> phoneNumber,
  Value<bool> isActive,
  Value<String?> profileImage,
  Value<String?> telegramId,
  Value<String?> instagramId,
  Value<DateTime?> birthday,
  required UserAccountRole role,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<String?> phoneNumber,
  Value<bool> isActive,
  Value<String?> profileImage,
  Value<String?> telegramId,
  Value<String?> instagramId,
  Value<DateTime?> birthday,
  Value<UserAccountRole> role,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DetailedAccountsTable, List<DetailedAccount>>
  _detailedAccountsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.detailedAccounts,
    aliasName: 'users__id__detailed_accounts__user_i_d',
  );

  $$DetailedAccountsTableProcessedTableManager get detailedAccountsRefs {
    final manager = $$DetailedAccountsTableTableManager(
      $_db,
      $_db.detailedAccounts,
    ).filter((f) => f.userID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _detailedAccountsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TeamMembersTable, List<TeamMember>>
  _teamMembersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.teamMembers,
    aliasName: 'users__id__team_members__user_i_d',
  );

  $$TeamMembersTableProcessedTableManager get teamMembersRefs {
    final manager = $$TeamMembersTableTableManager(
      $_db,
      $_db.teamMembers,
    ).filter((f) => f.userID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_teamMembersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventOrdersTable, List<EventOrder>>
  _eventOrdersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventOrders,
    aliasName: 'users__id__event_orders__user_i_d',
  );

  $$EventOrdersTableProcessedTableManager get eventOrdersRefs {
    final manager = $$EventOrdersTableTableManager(
      $_db,
      $_db.eventOrders,
    ).filter((f) => f.userID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventOrdersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventPartnerSharesTable, List<EventPartnerShare>>
  _eventPartnerSharesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.eventPartnerShares,
        aliasName: 'users__id__event_partner_shares__user_i_d',
      );

  $$EventPartnerSharesTableProcessedTableManager get eventPartnerSharesRefs {
    final manager = $$EventPartnerSharesTableTableManager(
      $_db,
      $_db.eventPartnerShares,
    ).filter((f) => f.userID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventPartnerSharesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventRegistrationsTable, List<EventRegistration>>
  _eventRegistrationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.eventRegistrations,
        aliasName: 'users__id__event_registrations__user_i_d',
      );

  $$EventRegistrationsTableProcessedTableManager get eventRegistrationsRefs {
    final manager = $$EventRegistrationsTableTableManager(
      $_db,
      $_db.eventRegistrations,
    ).filter((f) => f.userID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventRegistrationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telegramId => $composableBuilder(
    column: $table.telegramId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instagramId => $composableBuilder(
    column: $table.instagramId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<UserAccountRole, UserAccountRole, String>
  get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> detailedAccountsRefs(
    Expression<bool> Function($$DetailedAccountsTableFilterComposer f) f,
  ) {
    final $$DetailedAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.detailedAccounts,
      getReferencedColumn: (t) => t.userID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetailedAccountsTableFilterComposer(
            $db: $db,
            $table: $db.detailedAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> teamMembersRefs(
    Expression<bool> Function($$TeamMembersTableFilterComposer f) f,
  ) {
    final $$TeamMembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamMembers,
      getReferencedColumn: (t) => t.userID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamMembersTableFilterComposer(
            $db: $db,
            $table: $db.teamMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventOrdersRefs(
    Expression<bool> Function($$EventOrdersTableFilterComposer f) f,
  ) {
    final $$EventOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventOrders,
      getReferencedColumn: (t) => t.userID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventOrdersTableFilterComposer(
            $db: $db,
            $table: $db.eventOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventPartnerSharesRefs(
    Expression<bool> Function($$EventPartnerSharesTableFilterComposer f) f,
  ) {
    final $$EventPartnerSharesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventPartnerShares,
      getReferencedColumn: (t) => t.userID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventPartnerSharesTableFilterComposer(
            $db: $db,
            $table: $db.eventPartnerShares,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventRegistrationsRefs(
    Expression<bool> Function($$EventRegistrationsTableFilterComposer f) f,
  ) {
    final $$EventRegistrationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventRegistrations,
      getReferencedColumn: (t) => t.userID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventRegistrationsTableFilterComposer(
            $db: $db,
            $table: $db.eventRegistrations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telegramId => $composableBuilder(
    column: $table.telegramId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instagramId => $composableBuilder(
    column: $table.instagramId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get telegramId => $composableBuilder(
    column: $table.telegramId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instagramId => $composableBuilder(
    column: $table.instagramId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get birthday =>
      $composableBuilder(column: $table.birthday, builder: (column) => column);

  GeneratedColumnWithTypeConverter<UserAccountRole, String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> detailedAccountsRefs<T extends Object>(
    Expression<T> Function($$DetailedAccountsTableAnnotationComposer a) f,
  ) {
    final $$DetailedAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.detailedAccounts,
      getReferencedColumn: (t) => t.userID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetailedAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.detailedAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> teamMembersRefs<T extends Object>(
    Expression<T> Function($$TeamMembersTableAnnotationComposer a) f,
  ) {
    final $$TeamMembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamMembers,
      getReferencedColumn: (t) => t.userID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamMembersTableAnnotationComposer(
            $db: $db,
            $table: $db.teamMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventOrdersRefs<T extends Object>(
    Expression<T> Function($$EventOrdersTableAnnotationComposer a) f,
  ) {
    final $$EventOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventOrders,
      getReferencedColumn: (t) => t.userID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.eventOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventPartnerSharesRefs<T extends Object>(
    Expression<T> Function($$EventPartnerSharesTableAnnotationComposer a) f,
  ) {
    final $$EventPartnerSharesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.eventPartnerShares,
          getReferencedColumn: (t) => t.userID,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EventPartnerSharesTableAnnotationComposer(
                $db: $db,
                $table: $db.eventPartnerShares,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> eventRegistrationsRefs<T extends Object>(
    Expression<T> Function($$EventRegistrationsTableAnnotationComposer a) f,
  ) {
    final $$EventRegistrationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.eventRegistrations,
          getReferencedColumn: (t) => t.userID,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EventRegistrationsTableAnnotationComposer(
                $db: $db,
                $table: $db.eventRegistrations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({
            bool detailedAccountsRefs,
            bool teamMembersRefs,
            bool eventOrdersRefs,
            bool eventPartnerSharesRefs,
            bool eventRegistrationsRefs,
          })
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> profileImage = const Value.absent(),
                Value<String?> telegramId = const Value.absent(),
                Value<String?> instagramId = const Value.absent(),
                Value<DateTime?> birthday = const Value.absent(),
                Value<UserAccountRole> role = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                description: description,
                phoneNumber: phoneNumber,
                isActive: isActive,
                profileImage: profileImage,
                telegramId: telegramId,
                instagramId: instagramId,
                birthday: birthday,
                role: role,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> profileImage = const Value.absent(),
                Value<String?> telegramId = const Value.absent(),
                Value<String?> instagramId = const Value.absent(),
                Value<DateTime?> birthday = const Value.absent(),
                required UserAccountRole role,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                description: description,
                phoneNumber: phoneNumber,
                isActive: isActive,
                profileImage: profileImage,
                telegramId: telegramId,
                instagramId: instagramId,
                birthday: birthday,
                role: role,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                detailedAccountsRefs = false,
                teamMembersRefs = false,
                eventOrdersRefs = false,
                eventPartnerSharesRefs = false,
                eventRegistrationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (detailedAccountsRefs) db.detailedAccounts,
                    if (teamMembersRefs) db.teamMembers,
                    if (eventOrdersRefs) db.eventOrders,
                    if (eventPartnerSharesRefs) db.eventPartnerShares,
                    if (eventRegistrationsRefs) db.eventRegistrations,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (detailedAccountsRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          DetailedAccount
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._detailedAccountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).detailedAccountsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (teamMembersRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          TeamMember
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._teamMembersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).teamMembersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventOrdersRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          EventOrder
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._eventOrdersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).eventOrdersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventPartnerSharesRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          EventPartnerShare
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._eventPartnerSharesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).eventPartnerSharesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventRegistrationsRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          EventRegistration
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._eventRegistrationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).eventRegistrationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userID == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({
        bool detailedAccountsRefs,
        bool teamMembersRefs,
        bool eventOrdersRefs,
        bool eventPartnerSharesRefs,
        bool eventRegistrationsRefs,
      })
    >;
typedef $$TeamsTableCreateCompanionBuilder = TeamsCompanion Function({
  Value<int> id,
  required String title,
  Value<String?> description,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$TeamsTableUpdateCompanionBuilder = TeamsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String?> description,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$TeamsTableReferences
    extends BaseReferences<_$AppDatabase, $TeamsTable, Team> {
  $$TeamsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EventsTable, List<Event>> _eventsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.events,
    aliasName: 'teams__id__events__team_i_d',
  );

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.teamID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TeamMembersTable, List<TeamMember>>
  _teamMembersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.teamMembers,
    aliasName: 'teams__id__team_members__team_i_d',
  );

  $$TeamMembersTableProcessedTableManager get teamMembersRefs {
    final manager = $$TeamMembersTableTableManager(
      $_db,
      $_db.teamMembers,
    ).filter((f) => f.teamID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_teamMembersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TeamsTableFilterComposer extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> eventsRefs(
    Expression<bool> Function($$EventsTableFilterComposer f) f,
  ) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.teamID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> teamMembersRefs(
    Expression<bool> Function($$TeamMembersTableFilterComposer f) f,
  ) {
    final $$TeamMembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamMembers,
      getReferencedColumn: (t) => t.teamID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamMembersTableFilterComposer(
            $db: $db,
            $table: $db.teamMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeamsTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> eventsRefs<T extends Object>(
    Expression<T> Function($$EventsTableAnnotationComposer a) f,
  ) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.teamID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> teamMembersRefs<T extends Object>(
    Expression<T> Function($$TeamMembersTableAnnotationComposer a) f,
  ) {
    final $$TeamMembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamMembers,
      getReferencedColumn: (t) => t.teamID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamMembersTableAnnotationComposer(
            $db: $db,
            $table: $db.teamMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeamsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamsTable,
          Team,
          $$TeamsTableFilterComposer,
          $$TeamsTableOrderingComposer,
          $$TeamsTableAnnotationComposer,
          $$TeamsTableCreateCompanionBuilder,
          $$TeamsTableUpdateCompanionBuilder,
          (Team, $$TeamsTableReferences),
          Team,
          PrefetchHooks Function({bool eventsRefs, bool teamMembersRefs})
        > {
  $$TeamsTableTableManager(_$AppDatabase db, $TeamsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TeamsCompanion(
                id: id,
                title: title,
                description: description,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TeamsCompanion.insert(
                id: id,
                title: title,
                description: description,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TeamsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({eventsRefs = false, teamMembersRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventsRefs) db.events,
                    if (teamMembersRefs) db.teamMembers,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventsRefs)
                        await $_getPrefetchedData<Team, $TeamsTable, Event>(
                          currentTable: table,
                          referencedTable: $$TeamsTableReferences
                              ._eventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TeamsTableReferences(db, table, p0).eventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.teamID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (teamMembersRefs)
                        await $_getPrefetchedData<
                          Team,
                          $TeamsTable,
                          TeamMember
                        >(
                          currentTable: table,
                          referencedTable: $$TeamsTableReferences
                              ._teamMembersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TeamsTableReferences(
                                db,
                                table,
                                p0,
                              ).teamMembersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.teamID == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TeamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamsTable,
      Team,
      $$TeamsTableFilterComposer,
      $$TeamsTableOrderingComposer,
      $$TeamsTableAnnotationComposer,
      $$TeamsTableCreateCompanionBuilder,
      $$TeamsTableUpdateCompanionBuilder,
      (Team, $$TeamsTableReferences),
      Team,
      PrefetchHooks Function({bool eventsRefs, bool teamMembersRefs})
    >;
typedef $$EventsTableCreateCompanionBuilder = EventsCompanion Function({
  Value<int> id,
  required String title,
  required int teamID,
  Value<DateTime> date,
  Value<bool> isClosed,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});
typedef $$EventsTableUpdateCompanionBuilder = EventsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<int> teamID,
  Value<DateTime> date,
  Value<bool> isClosed,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});

final class $$EventsTableReferences
    extends BaseReferences<_$AppDatabase, $EventsTable, Event> {
  $$EventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TeamsTable _teamIDTable(_$AppDatabase db) =>
      db.teams.createAlias('events__team_i_d__teams__id');

  $$TeamsTableProcessedTableManager get teamID {
    final $_column = $_itemColumn<int>('team_i_d')!;

    final manager = $$TeamsTableTableManager(
      $_db,
      $_db.teams,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DetailedAccountsTable, List<DetailedAccount>>
  _detailedAccountsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.detailedAccounts,
    aliasName: 'events__id__detailed_accounts__event_i_d',
  );

  $$DetailedAccountsTableProcessedTableManager get detailedAccountsRefs {
    final manager = $$DetailedAccountsTableTableManager(
      $_db,
      $_db.detailedAccounts,
    ).filter((f) => f.eventID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _detailedAccountsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventOrdersTable, List<EventOrder>>
  _eventOrdersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventOrders,
    aliasName: 'events__id__event_orders__event_i_d',
  );

  $$EventOrdersTableProcessedTableManager get eventOrdersRefs {
    final manager = $$EventOrdersTableTableManager(
      $_db,
      $_db.eventOrders,
    ).filter((f) => f.eventID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventOrdersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventPartnerSharesTable, List<EventPartnerShare>>
  _eventPartnerSharesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.eventPartnerShares,
        aliasName: 'events__id__event_partner_shares__event_i_d',
      );

  $$EventPartnerSharesTableProcessedTableManager get eventPartnerSharesRefs {
    final manager = $$EventPartnerSharesTableTableManager(
      $_db,
      $_db.eventPartnerShares,
    ).filter((f) => f.eventID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventPartnerSharesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventRegistrationsTable, List<EventRegistration>>
  _eventRegistrationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.eventRegistrations,
        aliasName: 'events__id__event_registrations__event_i_d',
      );

  $$EventRegistrationsTableProcessedTableManager get eventRegistrationsRefs {
    final manager = $$EventRegistrationsTableTableManager(
      $_db,
      $_db.eventRegistrations,
    ).filter((f) => f.eventID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventRegistrationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EventsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isClosed => $composableBuilder(
    column: $table.isClosed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TeamsTableFilterComposer get teamID {
    final $$TeamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamID,
      referencedTable: $db.teams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamsTableFilterComposer(
            $db: $db,
            $table: $db.teams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> detailedAccountsRefs(
    Expression<bool> Function($$DetailedAccountsTableFilterComposer f) f,
  ) {
    final $$DetailedAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.detailedAccounts,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetailedAccountsTableFilterComposer(
            $db: $db,
            $table: $db.detailedAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventOrdersRefs(
    Expression<bool> Function($$EventOrdersTableFilterComposer f) f,
  ) {
    final $$EventOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventOrders,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventOrdersTableFilterComposer(
            $db: $db,
            $table: $db.eventOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventPartnerSharesRefs(
    Expression<bool> Function($$EventPartnerSharesTableFilterComposer f) f,
  ) {
    final $$EventPartnerSharesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventPartnerShares,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventPartnerSharesTableFilterComposer(
            $db: $db,
            $table: $db.eventPartnerShares,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventRegistrationsRefs(
    Expression<bool> Function($$EventRegistrationsTableFilterComposer f) f,
  ) {
    final $$EventRegistrationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventRegistrations,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventRegistrationsTableFilterComposer(
            $db: $db,
            $table: $db.eventRegistrations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isClosed => $composableBuilder(
    column: $table.isClosed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TeamsTableOrderingComposer get teamID {
    final $$TeamsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamID,
      referencedTable: $db.teams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamsTableOrderingComposer(
            $db: $db,
            $table: $db.teams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get isClosed =>
      $composableBuilder(column: $table.isClosed, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$TeamsTableAnnotationComposer get teamID {
    final $$TeamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamID,
      referencedTable: $db.teams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamsTableAnnotationComposer(
            $db: $db,
            $table: $db.teams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> detailedAccountsRefs<T extends Object>(
    Expression<T> Function($$DetailedAccountsTableAnnotationComposer a) f,
  ) {
    final $$DetailedAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.detailedAccounts,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetailedAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.detailedAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventOrdersRefs<T extends Object>(
    Expression<T> Function($$EventOrdersTableAnnotationComposer a) f,
  ) {
    final $$EventOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventOrders,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.eventOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventPartnerSharesRefs<T extends Object>(
    Expression<T> Function($$EventPartnerSharesTableAnnotationComposer a) f,
  ) {
    final $$EventPartnerSharesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.eventPartnerShares,
          getReferencedColumn: (t) => t.eventID,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EventPartnerSharesTableAnnotationComposer(
                $db: $db,
                $table: $db.eventPartnerShares,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> eventRegistrationsRefs<T extends Object>(
    Expression<T> Function($$EventRegistrationsTableAnnotationComposer a) f,
  ) {
    final $$EventRegistrationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.eventRegistrations,
          getReferencedColumn: (t) => t.eventID,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EventRegistrationsTableAnnotationComposer(
                $db: $db,
                $table: $db.eventRegistrations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventsTable,
          Event,
          $$EventsTableFilterComposer,
          $$EventsTableOrderingComposer,
          $$EventsTableAnnotationComposer,
          $$EventsTableCreateCompanionBuilder,
          $$EventsTableUpdateCompanionBuilder,
          (Event, $$EventsTableReferences),
          Event,
          PrefetchHooks Function({
            bool teamID,
            bool detailedAccountsRefs,
            bool eventOrdersRefs,
            bool eventPartnerSharesRefs,
            bool eventRegistrationsRefs,
          })
        > {
  $$EventsTableTableManager(_$AppDatabase db, $EventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> teamID = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<bool> isClosed = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EventsCompanion(
                id: id,
                title: title,
                teamID: teamID,
                date: date,
                isClosed: isClosed,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required int teamID,
                Value<DateTime> date = const Value.absent(),
                Value<bool> isClosed = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EventsCompanion.insert(
                id: id,
                title: title,
                teamID: teamID,
                date: date,
                isClosed: isClosed,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$EventsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                teamID = false,
                detailedAccountsRefs = false,
                eventOrdersRefs = false,
                eventPartnerSharesRefs = false,
                eventRegistrationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (detailedAccountsRefs) db.detailedAccounts,
                    if (eventOrdersRefs) db.eventOrders,
                    if (eventPartnerSharesRefs) db.eventPartnerShares,
                    if (eventRegistrationsRefs) db.eventRegistrations,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (teamID) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.teamID,
                            referencedTable: $$EventsTableReferences
                                ._teamIDTable(db),
                            referencedColumn: $$EventsTableReferences
                                ._teamIDTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (detailedAccountsRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          DetailedAccount
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._detailedAccountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).detailedAccountsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventOrdersRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          EventOrder
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._eventOrdersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventOrdersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventPartnerSharesRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          EventPartnerShare
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._eventPartnerSharesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventPartnerSharesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventRegistrationsRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          EventRegistration
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._eventRegistrationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventRegistrationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventID == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventsTable,
      Event,
      $$EventsTableFilterComposer,
      $$EventsTableOrderingComposer,
      $$EventsTableAnnotationComposer,
      $$EventsTableCreateCompanionBuilder,
      $$EventsTableUpdateCompanionBuilder,
      (Event, $$EventsTableReferences),
      Event,
      PrefetchHooks Function({
        bool teamID,
        bool detailedAccountsRefs,
        bool eventOrdersRefs,
        bool eventPartnerSharesRefs,
        bool eventRegistrationsRefs,
      })
    >;
typedef $$BanksTableCreateCompanionBuilder = BanksCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  Value<String?> number,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$BanksTableUpdateCompanionBuilder = BanksCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<String?> number,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$BanksTableReferences
    extends BaseReferences<_$AppDatabase, $BanksTable, Bank> {
  $$BanksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DetailedAccountsTable, List<DetailedAccount>>
  _detailedAccountsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.detailedAccounts,
    aliasName: 'banks__id__detailed_accounts__bank_i_d',
  );

  $$DetailedAccountsTableProcessedTableManager get detailedAccountsRefs {
    final manager = $$DetailedAccountsTableTableManager(
      $_db,
      $_db.detailedAccounts,
    ).filter((f) => f.bankID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _detailedAccountsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BanksTableFilterComposer extends Composer<_$AppDatabase, $BanksTable> {
  $$BanksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> detailedAccountsRefs(
    Expression<bool> Function($$DetailedAccountsTableFilterComposer f) f,
  ) {
    final $$DetailedAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.detailedAccounts,
      getReferencedColumn: (t) => t.bankID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetailedAccountsTableFilterComposer(
            $db: $db,
            $table: $db.detailedAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BanksTableOrderingComposer
    extends Composer<_$AppDatabase, $BanksTable> {
  $$BanksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BanksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BanksTable> {
  $$BanksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> detailedAccountsRefs<T extends Object>(
    Expression<T> Function($$DetailedAccountsTableAnnotationComposer a) f,
  ) {
    final $$DetailedAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.detailedAccounts,
      getReferencedColumn: (t) => t.bankID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetailedAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.detailedAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BanksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BanksTable,
          Bank,
          $$BanksTableFilterComposer,
          $$BanksTableOrderingComposer,
          $$BanksTableAnnotationComposer,
          $$BanksTableCreateCompanionBuilder,
          $$BanksTableUpdateCompanionBuilder,
          (Bank, $$BanksTableReferences),
          Bank,
          PrefetchHooks Function({bool detailedAccountsRefs})
        > {
  $$BanksTableTableManager(_$AppDatabase db, $BanksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BanksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BanksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BanksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> number = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BanksCompanion(
                id: id,
                name: name,
                description: description,
                number: number,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> number = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BanksCompanion.insert(
                id: id,
                name: name,
                description: description,
                number: number,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$BanksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({detailedAccountsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (detailedAccountsRefs) db.detailedAccounts,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (detailedAccountsRefs)
                    await $_getPrefetchedData<
                      Bank,
                      $BanksTable,
                      DetailedAccount
                    >(
                      currentTable: table,
                      referencedTable: $$BanksTableReferences
                          ._detailedAccountsRefsTable(db),
                      managerFromTypedResult: (p0) => $$BanksTableReferences(
                        db,
                        table,
                        p0,
                      ).detailedAccountsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.bankID == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BanksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BanksTable,
      Bank,
      $$BanksTableFilterComposer,
      $$BanksTableOrderingComposer,
      $$BanksTableAnnotationComposer,
      $$BanksTableCreateCompanionBuilder,
      $$BanksTableUpdateCompanionBuilder,
      (Bank, $$BanksTableReferences),
      Bank,
      PrefetchHooks Function({bool detailedAccountsRefs})
    >;
typedef $$DetailedAccountsTableCreateCompanionBuilder =
    DetailedAccountsCompanion Function({
      Value<int> id,
      required String code,
      required String name,
      Value<bool> isActive,
      required DetailedAccountType type,
      Value<int?> userID,
      Value<int?> eventID,
      Value<int?> bankID,
    });
typedef $$DetailedAccountsTableUpdateCompanionBuilder =
    DetailedAccountsCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> name,
      Value<bool> isActive,
      Value<DetailedAccountType> type,
      Value<int?> userID,
      Value<int?> eventID,
      Value<int?> bankID,
    });

final class $$DetailedAccountsTableReferences
    extends
        BaseReferences<_$AppDatabase, $DetailedAccountsTable, DetailedAccount> {
  $$DetailedAccountsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _userIDTable(_$AppDatabase db) =>
      db.users.createAlias('detailed_accounts__user_i_d__users__id');

  $$UsersTableProcessedTableManager? get userID {
    final $_column = $_itemColumn<int>('user_i_d');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EventsTable _eventIDTable(_$AppDatabase db) =>
      db.events.createAlias('detailed_accounts__event_i_d__events__id');

  $$EventsTableProcessedTableManager? get eventID {
    final $_column = $_itemColumn<int>('event_i_d');
    if ($_column == null) return null;
    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BanksTable _bankIDTable(_$AppDatabase db) =>
      db.banks.createAlias('detailed_accounts__bank_i_d__banks__id');

  $$BanksTableProcessedTableManager? get bankID {
    final $_column = $_itemColumn<int>('bank_i_d');
    if ($_column == null) return null;
    final manager = $$BanksTableTableManager(
      $_db,
      $_db.banks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bankIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DetailedAccountsTableFilterComposer
    extends Composer<_$AppDatabase, $DetailedAccountsTable> {
  $$DetailedAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    DetailedAccountType,
    DetailedAccountType,
    String
  >
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$UsersTableFilterComposer get userID {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userID,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableFilterComposer get eventID {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BanksTableFilterComposer get bankID {
    final $$BanksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankID,
      referencedTable: $db.banks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableFilterComposer(
            $db: $db,
            $table: $db.banks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DetailedAccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $DetailedAccountsTable> {
  $$DetailedAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userID {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userID,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableOrderingComposer get eventID {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BanksTableOrderingComposer get bankID {
    final $$BanksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankID,
      referencedTable: $db.banks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableOrderingComposer(
            $db: $db,
            $table: $db.banks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DetailedAccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DetailedAccountsTable> {
  $$DetailedAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DetailedAccountType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  $$UsersTableAnnotationComposer get userID {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userID,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableAnnotationComposer get eventID {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BanksTableAnnotationComposer get bankID {
    final $$BanksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankID,
      referencedTable: $db.banks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableAnnotationComposer(
            $db: $db,
            $table: $db.banks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DetailedAccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DetailedAccountsTable,
          DetailedAccount,
          $$DetailedAccountsTableFilterComposer,
          $$DetailedAccountsTableOrderingComposer,
          $$DetailedAccountsTableAnnotationComposer,
          $$DetailedAccountsTableCreateCompanionBuilder,
          $$DetailedAccountsTableUpdateCompanionBuilder,
          (DetailedAccount, $$DetailedAccountsTableReferences),
          DetailedAccount,
          PrefetchHooks Function({bool userID, bool eventID, bool bankID})
        > {
  $$DetailedAccountsTableTableManager(
    _$AppDatabase db,
    $DetailedAccountsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DetailedAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DetailedAccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DetailedAccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DetailedAccountType> type = const Value.absent(),
                Value<int?> userID = const Value.absent(),
                Value<int?> eventID = const Value.absent(),
                Value<int?> bankID = const Value.absent(),
              }) => DetailedAccountsCompanion(
                id: id,
                code: code,
                name: name,
                isActive: isActive,
                type: type,
                userID: userID,
                eventID: eventID,
                bankID: bankID,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String name,
                Value<bool> isActive = const Value.absent(),
                required DetailedAccountType type,
                Value<int?> userID = const Value.absent(),
                Value<int?> eventID = const Value.absent(),
                Value<int?> bankID = const Value.absent(),
              }) => DetailedAccountsCompanion.insert(
                id: id,
                code: code,
                name: name,
                isActive: isActive,
                type: type,
                userID: userID,
                eventID: eventID,
                bankID: bankID,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DetailedAccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({userID = false, eventID = false, bankID = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (userID) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.userID,
                            referencedTable: $$DetailedAccountsTableReferences
                                ._userIDTable(db),
                            referencedColumn: $$DetailedAccountsTableReferences
                                ._userIDTable(db)
                                .id,
                          ) as T;
                        }
                        if (eventID) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.eventID,
                            referencedTable: $$DetailedAccountsTableReferences
                                ._eventIDTable(db),
                            referencedColumn: $$DetailedAccountsTableReferences
                                ._eventIDTable(db)
                                .id,
                          ) as T;
                        }
                        if (bankID) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.bankID,
                            referencedTable: $$DetailedAccountsTableReferences
                                ._bankIDTable(db),
                            referencedColumn: $$DetailedAccountsTableReferences
                                ._bankIDTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$DetailedAccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DetailedAccountsTable,
      DetailedAccount,
      $$DetailedAccountsTableFilterComposer,
      $$DetailedAccountsTableOrderingComposer,
      $$DetailedAccountsTableAnnotationComposer,
      $$DetailedAccountsTableCreateCompanionBuilder,
      $$DetailedAccountsTableUpdateCompanionBuilder,
      (DetailedAccount, $$DetailedAccountsTableReferences),
      DetailedAccount,
      PrefetchHooks Function({bool userID, bool eventID, bool bankID})
    >;
typedef $$JournalHeadersTableCreateCompanionBuilder =
    JournalHeadersCompanion Function({
      Value<int> id,
      required String entryNumber,
      required DateTime entryDate,
      Value<String?> description,
      Value<JournalType> type,
      Value<DateTime> createdAt,
    });
typedef $$JournalHeadersTableUpdateCompanionBuilder =
    JournalHeadersCompanion Function({
      Value<int> id,
      Value<String> entryNumber,
      Value<DateTime> entryDate,
      Value<String?> description,
      Value<JournalType> type,
      Value<DateTime> createdAt,
    });

final class $$JournalHeadersTableReferences
    extends BaseReferences<_$AppDatabase, $JournalHeadersTable, JournalHeader> {
  $$JournalHeadersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$JournalLinesTable, List<JournalLine>>
  _journalLinesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.journalLines,
    aliasName: 'journal_headers__id__journal_lines__header_id',
  );

  $$JournalLinesTableProcessedTableManager get journalLinesRefs {
    final manager = $$JournalLinesTableTableManager(
      $_db,
      $_db.journalLines,
    ).filter((f) => f.headerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_journalLinesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$JournalHeadersTableFilterComposer
    extends Composer<_$AppDatabase, $JournalHeadersTable> {
  $$JournalHeadersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entryNumber => $composableBuilder(
    column: $table.entryNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get entryDate => $composableBuilder(
    column: $table.entryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<JournalType, JournalType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> journalLinesRefs(
    Expression<bool> Function($$JournalLinesTableFilterComposer f) f,
  ) {
    final $$JournalLinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalLines,
      getReferencedColumn: (t) => t.headerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalLinesTableFilterComposer(
            $db: $db,
            $table: $db.journalLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JournalHeadersTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalHeadersTable> {
  $$JournalHeadersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entryNumber => $composableBuilder(
    column: $table.entryNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get entryDate => $composableBuilder(
    column: $table.entryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JournalHeadersTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalHeadersTable> {
  $$JournalHeadersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entryNumber => $composableBuilder(
    column: $table.entryNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get entryDate =>
      $composableBuilder(column: $table.entryDate, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<JournalType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> journalLinesRefs<T extends Object>(
    Expression<T> Function($$JournalLinesTableAnnotationComposer a) f,
  ) {
    final $$JournalLinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalLines,
      getReferencedColumn: (t) => t.headerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalLinesTableAnnotationComposer(
            $db: $db,
            $table: $db.journalLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JournalHeadersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalHeadersTable,
          JournalHeader,
          $$JournalHeadersTableFilterComposer,
          $$JournalHeadersTableOrderingComposer,
          $$JournalHeadersTableAnnotationComposer,
          $$JournalHeadersTableCreateCompanionBuilder,
          $$JournalHeadersTableUpdateCompanionBuilder,
          (JournalHeader, $$JournalHeadersTableReferences),
          JournalHeader,
          PrefetchHooks Function({bool journalLinesRefs})
        > {
  $$JournalHeadersTableTableManager(
    _$AppDatabase db,
    $JournalHeadersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalHeadersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalHeadersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalHeadersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entryNumber = const Value.absent(),
                Value<DateTime> entryDate = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<JournalType> type = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => JournalHeadersCompanion(
                id: id,
                entryNumber: entryNumber,
                entryDate: entryDate,
                description: description,
                type: type,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entryNumber,
                required DateTime entryDate,
                Value<String?> description = const Value.absent(),
                Value<JournalType> type = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => JournalHeadersCompanion.insert(
                id: id,
                entryNumber: entryNumber,
                entryDate: entryDate,
                description: description,
                type: type,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$JournalHeadersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({journalLinesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (journalLinesRefs) db.journalLines],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (journalLinesRefs)
                    await $_getPrefetchedData<
                      JournalHeader,
                      $JournalHeadersTable,
                      JournalLine
                    >(
                      currentTable: table,
                      referencedTable: $$JournalHeadersTableReferences
                          ._journalLinesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$JournalHeadersTableReferences(
                            db,
                            table,
                            p0,
                          ).journalLinesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.headerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$JournalHeadersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalHeadersTable,
      JournalHeader,
      $$JournalHeadersTableFilterComposer,
      $$JournalHeadersTableOrderingComposer,
      $$JournalHeadersTableAnnotationComposer,
      $$JournalHeadersTableCreateCompanionBuilder,
      $$JournalHeadersTableUpdateCompanionBuilder,
      (JournalHeader, $$JournalHeadersTableReferences),
      JournalHeader,
      PrefetchHooks Function({bool journalLinesRefs})
    >;
typedef $$JournalLinesTableCreateCompanionBuilder =
    JournalLinesCompanion Function({
      Value<int> id,
      required int headerId,
      required int subsidiaryId,
      Value<int?> detailedId,
      Value<int?> detailedIdSecond,
      required BigInt debit,
      required BigInt credit,
      required String series,
      Value<String?> memo,
    });
typedef $$JournalLinesTableUpdateCompanionBuilder =
    JournalLinesCompanion Function({
      Value<int> id,
      Value<int> headerId,
      Value<int> subsidiaryId,
      Value<int?> detailedId,
      Value<int?> detailedIdSecond,
      Value<BigInt> debit,
      Value<BigInt> credit,
      Value<String> series,
      Value<String?> memo,
    });

final class $$JournalLinesTableReferences
    extends BaseReferences<_$AppDatabase, $JournalLinesTable, JournalLine> {
  $$JournalLinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $JournalHeadersTable _headerIdTable(_$AppDatabase db) => db
      .journalHeaders
      .createAlias('journal_lines__header_id__journal_headers__id');

  $$JournalHeadersTableProcessedTableManager get headerId {
    final $_column = $_itemColumn<int>('header_id')!;

    final manager = $$JournalHeadersTableTableManager(
      $_db,
      $_db.journalHeaders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_headerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SubsidiaryAccountsTable _subsidiaryIdTable(_$AppDatabase db) => db
      .subsidiaryAccounts
      .createAlias('journal_lines__subsidiary_id__subsidiary_accounts__id');

  $$SubsidiaryAccountsTableProcessedTableManager get subsidiaryId {
    final $_column = $_itemColumn<int>('subsidiary_id')!;

    final manager = $$SubsidiaryAccountsTableTableManager(
      $_db,
      $_db.subsidiaryAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subsidiaryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DetailedAccountsTable _detailedIdTable(_$AppDatabase db) => db
      .detailedAccounts
      .createAlias('journal_lines__detailed_id__detailed_accounts__id');

  $$DetailedAccountsTableProcessedTableManager? get detailedId {
    final $_column = $_itemColumn<int>('detailed_id');
    if ($_column == null) return null;
    final manager = $$DetailedAccountsTableTableManager(
      $_db,
      $_db.detailedAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_detailedIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DetailedAccountsTable _detailedIdSecondTable(_$AppDatabase db) => db
      .detailedAccounts
      .createAlias('journal_lines__detailed_id_second__detailed_accounts__id');

  $$DetailedAccountsTableProcessedTableManager? get detailedIdSecond {
    final $_column = $_itemColumn<int>('detailed_id_second');
    if ($_column == null) return null;
    final manager = $$DetailedAccountsTableTableManager(
      $_db,
      $_db.detailedAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_detailedIdSecondTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$JournalLinesTableFilterComposer
    extends Composer<_$AppDatabase, $JournalLinesTable> {
  $$JournalLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get debit => $composableBuilder(
    column: $table.debit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get credit => $composableBuilder(
    column: $table.credit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get series => $composableBuilder(
    column: $table.series,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memo => $composableBuilder(
    column: $table.memo,
    builder: (column) => ColumnFilters(column),
  );

  $$JournalHeadersTableFilterComposer get headerId {
    final $$JournalHeadersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headerId,
      referencedTable: $db.journalHeaders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalHeadersTableFilterComposer(
            $db: $db,
            $table: $db.journalHeaders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubsidiaryAccountsTableFilterComposer get subsidiaryId {
    final $$SubsidiaryAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subsidiaryId,
      referencedTable: $db.subsidiaryAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubsidiaryAccountsTableFilterComposer(
            $db: $db,
            $table: $db.subsidiaryAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DetailedAccountsTableFilterComposer get detailedId {
    final $$DetailedAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.detailedId,
      referencedTable: $db.detailedAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetailedAccountsTableFilterComposer(
            $db: $db,
            $table: $db.detailedAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DetailedAccountsTableFilterComposer get detailedIdSecond {
    final $$DetailedAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.detailedIdSecond,
      referencedTable: $db.detailedAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetailedAccountsTableFilterComposer(
            $db: $db,
            $table: $db.detailedAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalLinesTable> {
  $$JournalLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get debit => $composableBuilder(
    column: $table.debit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get credit => $composableBuilder(
    column: $table.credit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get series => $composableBuilder(
    column: $table.series,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memo => $composableBuilder(
    column: $table.memo,
    builder: (column) => ColumnOrderings(column),
  );

  $$JournalHeadersTableOrderingComposer get headerId {
    final $$JournalHeadersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headerId,
      referencedTable: $db.journalHeaders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalHeadersTableOrderingComposer(
            $db: $db,
            $table: $db.journalHeaders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubsidiaryAccountsTableOrderingComposer get subsidiaryId {
    final $$SubsidiaryAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subsidiaryId,
      referencedTable: $db.subsidiaryAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubsidiaryAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.subsidiaryAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DetailedAccountsTableOrderingComposer get detailedId {
    final $$DetailedAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.detailedId,
      referencedTable: $db.detailedAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetailedAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.detailedAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DetailedAccountsTableOrderingComposer get detailedIdSecond {
    final $$DetailedAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.detailedIdSecond,
      referencedTable: $db.detailedAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetailedAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.detailedAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalLinesTable> {
  $$JournalLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<BigInt> get debit =>
      $composableBuilder(column: $table.debit, builder: (column) => column);

  GeneratedColumn<BigInt> get credit =>
      $composableBuilder(column: $table.credit, builder: (column) => column);

  GeneratedColumn<String> get series =>
      $composableBuilder(column: $table.series, builder: (column) => column);

  GeneratedColumn<String> get memo =>
      $composableBuilder(column: $table.memo, builder: (column) => column);

  $$JournalHeadersTableAnnotationComposer get headerId {
    final $$JournalHeadersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headerId,
      referencedTable: $db.journalHeaders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalHeadersTableAnnotationComposer(
            $db: $db,
            $table: $db.journalHeaders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubsidiaryAccountsTableAnnotationComposer get subsidiaryId {
    final $$SubsidiaryAccountsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.subsidiaryId,
          referencedTable: $db.subsidiaryAccounts,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SubsidiaryAccountsTableAnnotationComposer(
                $db: $db,
                $table: $db.subsidiaryAccounts,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$DetailedAccountsTableAnnotationComposer get detailedId {
    final $$DetailedAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.detailedId,
      referencedTable: $db.detailedAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetailedAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.detailedAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DetailedAccountsTableAnnotationComposer get detailedIdSecond {
    final $$DetailedAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.detailedIdSecond,
      referencedTable: $db.detailedAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetailedAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.detailedAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalLinesTable,
          JournalLine,
          $$JournalLinesTableFilterComposer,
          $$JournalLinesTableOrderingComposer,
          $$JournalLinesTableAnnotationComposer,
          $$JournalLinesTableCreateCompanionBuilder,
          $$JournalLinesTableUpdateCompanionBuilder,
          (JournalLine, $$JournalLinesTableReferences),
          JournalLine,
          PrefetchHooks Function({
            bool headerId,
            bool subsidiaryId,
            bool detailedId,
            bool detailedIdSecond,
          })
        > {
  $$JournalLinesTableTableManager(_$AppDatabase db, $JournalLinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> headerId = const Value.absent(),
                Value<int> subsidiaryId = const Value.absent(),
                Value<int?> detailedId = const Value.absent(),
                Value<int?> detailedIdSecond = const Value.absent(),
                Value<BigInt> debit = const Value.absent(),
                Value<BigInt> credit = const Value.absent(),
                Value<String> series = const Value.absent(),
                Value<String?> memo = const Value.absent(),
              }) => JournalLinesCompanion(
                id: id,
                headerId: headerId,
                subsidiaryId: subsidiaryId,
                detailedId: detailedId,
                detailedIdSecond: detailedIdSecond,
                debit: debit,
                credit: credit,
                series: series,
                memo: memo,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int headerId,
                required int subsidiaryId,
                Value<int?> detailedId = const Value.absent(),
                Value<int?> detailedIdSecond = const Value.absent(),
                required BigInt debit,
                required BigInt credit,
                required String series,
                Value<String?> memo = const Value.absent(),
              }) => JournalLinesCompanion.insert(
                id: id,
                headerId: headerId,
                subsidiaryId: subsidiaryId,
                detailedId: detailedId,
                detailedIdSecond: detailedIdSecond,
                debit: debit,
                credit: credit,
                series: series,
                memo: memo,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$JournalLinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                headerId = false,
                subsidiaryId = false,
                detailedId = false,
                detailedIdSecond = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (headerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.headerId,
                            referencedTable: $$JournalLinesTableReferences
                                ._headerIdTable(db),
                            referencedColumn: $$JournalLinesTableReferences
                                ._headerIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (subsidiaryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.subsidiaryId,
                            referencedTable: $$JournalLinesTableReferences
                                ._subsidiaryIdTable(db),
                            referencedColumn: $$JournalLinesTableReferences
                                ._subsidiaryIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (detailedId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.detailedId,
                            referencedTable: $$JournalLinesTableReferences
                                ._detailedIdTable(db),
                            referencedColumn: $$JournalLinesTableReferences
                                ._detailedIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (detailedIdSecond) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.detailedIdSecond,
                            referencedTable: $$JournalLinesTableReferences
                                ._detailedIdSecondTable(db),
                            referencedColumn: $$JournalLinesTableReferences
                                ._detailedIdSecondTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$JournalLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalLinesTable,
      JournalLine,
      $$JournalLinesTableFilterComposer,
      $$JournalLinesTableOrderingComposer,
      $$JournalLinesTableAnnotationComposer,
      $$JournalLinesTableCreateCompanionBuilder,
      $$JournalLinesTableUpdateCompanionBuilder,
      (JournalLine, $$JournalLinesTableReferences),
      JournalLine,
      PrefetchHooks Function({
        bool headerId,
        bool subsidiaryId,
        bool detailedId,
        bool detailedIdSecond,
      })
    >;
typedef $$TeamMembersTableCreateCompanionBuilder =
    TeamMembersCompanion Function({
      Value<int> id,
      required int userID,
      required int teamID,
      required double sharePercentage,
      Value<DateTime> createAt,
    });
typedef $$TeamMembersTableUpdateCompanionBuilder =
    TeamMembersCompanion Function({
      Value<int> id,
      Value<int> userID,
      Value<int> teamID,
      Value<double> sharePercentage,
      Value<DateTime> createAt,
    });

final class $$TeamMembersTableReferences
    extends BaseReferences<_$AppDatabase, $TeamMembersTable, TeamMember> {
  $$TeamMembersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIDTable(_$AppDatabase db) =>
      db.users.createAlias('team_members__user_i_d__users__id');

  $$UsersTableProcessedTableManager get userID {
    final $_column = $_itemColumn<int>('user_i_d')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TeamsTable _teamIDTable(_$AppDatabase db) =>
      db.teams.createAlias('team_members__team_i_d__teams__id');

  $$TeamsTableProcessedTableManager get teamID {
    final $_column = $_itemColumn<int>('team_i_d')!;

    final manager = $$TeamsTableTableManager(
      $_db,
      $_db.teams,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TeamMembersTableFilterComposer
    extends Composer<_$AppDatabase, $TeamMembersTable> {
  $$TeamMembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sharePercentage => $composableBuilder(
    column: $table.sharePercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userID {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userID,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamsTableFilterComposer get teamID {
    final $$TeamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamID,
      referencedTable: $db.teams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamsTableFilterComposer(
            $db: $db,
            $table: $db.teams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TeamMembersTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamMembersTable> {
  $$TeamMembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sharePercentage => $composableBuilder(
    column: $table.sharePercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userID {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userID,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamsTableOrderingComposer get teamID {
    final $$TeamsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamID,
      referencedTable: $db.teams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamsTableOrderingComposer(
            $db: $db,
            $table: $db.teams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TeamMembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamMembersTable> {
  $$TeamMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get sharePercentage => $composableBuilder(
    column: $table.sharePercentage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userID {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userID,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamsTableAnnotationComposer get teamID {
    final $$TeamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamID,
      referencedTable: $db.teams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamsTableAnnotationComposer(
            $db: $db,
            $table: $db.teams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TeamMembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamMembersTable,
          TeamMember,
          $$TeamMembersTableFilterComposer,
          $$TeamMembersTableOrderingComposer,
          $$TeamMembersTableAnnotationComposer,
          $$TeamMembersTableCreateCompanionBuilder,
          $$TeamMembersTableUpdateCompanionBuilder,
          (TeamMember, $$TeamMembersTableReferences),
          TeamMember,
          PrefetchHooks Function({bool userID, bool teamID})
        > {
  $$TeamMembersTableTableManager(_$AppDatabase db, $TeamMembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamMembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamMembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamMembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userID = const Value.absent(),
                Value<int> teamID = const Value.absent(),
                Value<double> sharePercentage = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
              }) => TeamMembersCompanion(
                id: id,
                userID: userID,
                teamID: teamID,
                sharePercentage: sharePercentage,
                createAt: createAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userID,
                required int teamID,
                required double sharePercentage,
                Value<DateTime> createAt = const Value.absent(),
              }) => TeamMembersCompanion.insert(
                id: id,
                userID: userID,
                teamID: teamID,
                sharePercentage: sharePercentage,
                createAt: createAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TeamMembersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userID = false, teamID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userID) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userID,
                        referencedTable: $$TeamMembersTableReferences
                            ._userIDTable(db),
                        referencedColumn: $$TeamMembersTableReferences
                            ._userIDTable(db)
                            .id,
                      ) as T;
                    }
                    if (teamID) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.teamID,
                        referencedTable: $$TeamMembersTableReferences
                            ._teamIDTable(db),
                        referencedColumn: $$TeamMembersTableReferences
                            ._teamIDTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TeamMembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamMembersTable,
      TeamMember,
      $$TeamMembersTableFilterComposer,
      $$TeamMembersTableOrderingComposer,
      $$TeamMembersTableAnnotationComposer,
      $$TeamMembersTableCreateCompanionBuilder,
      $$TeamMembersTableUpdateCompanionBuilder,
      (TeamMember, $$TeamMembersTableReferences),
      TeamMember,
      PrefetchHooks Function({bool userID, bool teamID})
    >;
typedef $$MenuItemsTableCreateCompanionBuilder = MenuItemsCompanion Function({
  Value<int> id,
  required String title,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$MenuItemsTableUpdateCompanionBuilder = MenuItemsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$MenuItemsTableFilterComposer
    extends Composer<_$AppDatabase, $MenuItemsTable> {
  $$MenuItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MenuItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $MenuItemsTable> {
  $$MenuItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MenuItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenuItemsTable> {
  $$MenuItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MenuItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MenuItemsTable,
          MenuItem,
          $$MenuItemsTableFilterComposer,
          $$MenuItemsTableOrderingComposer,
          $$MenuItemsTableAnnotationComposer,
          $$MenuItemsTableCreateCompanionBuilder,
          $$MenuItemsTableUpdateCompanionBuilder,
          (MenuItem, BaseReferences<_$AppDatabase, $MenuItemsTable, MenuItem>),
          MenuItem,
          PrefetchHooks Function()
        > {
  $$MenuItemsTableTableManager(_$AppDatabase db, $MenuItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenuItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenuItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenuItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MenuItemsCompanion(
                id: id,
                title: title,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MenuItemsCompanion.insert(
                id: id,
                title: title,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MenuItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MenuItemsTable,
      MenuItem,
      $$MenuItemsTableFilterComposer,
      $$MenuItemsTableOrderingComposer,
      $$MenuItemsTableAnnotationComposer,
      $$MenuItemsTableCreateCompanionBuilder,
      $$MenuItemsTableUpdateCompanionBuilder,
      (MenuItem, BaseReferences<_$AppDatabase, $MenuItemsTable, MenuItem>),
      MenuItem,
      PrefetchHooks Function()
    >;
typedef $$EventOrdersTableCreateCompanionBuilder =
    EventOrdersCompanion Function({
      Value<int> id,
      required int userID,
      required int eventID,
      Value<bool> isDelivered,
      Value<String?> menuItems,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$EventOrdersTableUpdateCompanionBuilder =
    EventOrdersCompanion Function({
      Value<int> id,
      Value<int> userID,
      Value<int> eventID,
      Value<bool> isDelivered,
      Value<String?> menuItems,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$EventOrdersTableReferences
    extends BaseReferences<_$AppDatabase, $EventOrdersTable, EventOrder> {
  $$EventOrdersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIDTable(_$AppDatabase db) =>
      db.users.createAlias('event_orders__user_i_d__users__id');

  $$UsersTableProcessedTableManager get userID {
    final $_column = $_itemColumn<int>('user_i_d')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EventsTable _eventIDTable(_$AppDatabase db) =>
      db.events.createAlias('event_orders__event_i_d__events__id');

  $$EventsTableProcessedTableManager get eventID {
    final $_column = $_itemColumn<int>('event_i_d')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $EventOrdersTable> {
  $$EventOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDelivered => $composableBuilder(
    column: $table.isDelivered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get menuItems => $composableBuilder(
    column: $table.menuItems,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userID {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userID,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableFilterComposer get eventID {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $EventOrdersTable> {
  $$EventOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDelivered => $composableBuilder(
    column: $table.isDelivered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get menuItems => $composableBuilder(
    column: $table.menuItems,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userID {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userID,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableOrderingComposer get eventID {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventOrdersTable> {
  $$EventOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isDelivered => $composableBuilder(
    column: $table.isDelivered,
    builder: (column) => column,
  );

  GeneratedColumn<String> get menuItems =>
      $composableBuilder(column: $table.menuItems, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userID {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userID,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableAnnotationComposer get eventID {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventOrdersTable,
          EventOrder,
          $$EventOrdersTableFilterComposer,
          $$EventOrdersTableOrderingComposer,
          $$EventOrdersTableAnnotationComposer,
          $$EventOrdersTableCreateCompanionBuilder,
          $$EventOrdersTableUpdateCompanionBuilder,
          (EventOrder, $$EventOrdersTableReferences),
          EventOrder,
          PrefetchHooks Function({bool userID, bool eventID})
        > {
  $$EventOrdersTableTableManager(_$AppDatabase db, $EventOrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userID = const Value.absent(),
                Value<int> eventID = const Value.absent(),
                Value<bool> isDelivered = const Value.absent(),
                Value<String?> menuItems = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => EventOrdersCompanion(
                id: id,
                userID: userID,
                eventID: eventID,
                isDelivered: isDelivered,
                menuItems: menuItems,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userID,
                required int eventID,
                Value<bool> isDelivered = const Value.absent(),
                Value<String?> menuItems = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => EventOrdersCompanion.insert(
                id: id,
                userID: userID,
                eventID: eventID,
                isDelivered: isDelivered,
                menuItems: menuItems,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventOrdersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userID = false, eventID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userID) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userID,
                        referencedTable: $$EventOrdersTableReferences
                            ._userIDTable(db),
                        referencedColumn: $$EventOrdersTableReferences
                            ._userIDTable(db)
                            .id,
                      ) as T;
                    }
                    if (eventID) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.eventID,
                        referencedTable: $$EventOrdersTableReferences
                            ._eventIDTable(db),
                        referencedColumn: $$EventOrdersTableReferences
                            ._eventIDTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EventOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventOrdersTable,
      EventOrder,
      $$EventOrdersTableFilterComposer,
      $$EventOrdersTableOrderingComposer,
      $$EventOrdersTableAnnotationComposer,
      $$EventOrdersTableCreateCompanionBuilder,
      $$EventOrdersTableUpdateCompanionBuilder,
      (EventOrder, $$EventOrdersTableReferences),
      EventOrder,
      PrefetchHooks Function({bool userID, bool eventID})
    >;
typedef $$EventPartnerSharesTableCreateCompanionBuilder =
    EventPartnerSharesCompanion Function({
      Value<int> id,
      required int userID,
      required int eventID,
      required double sharePercentage,
      Value<DateTime> createAt,
    });
typedef $$EventPartnerSharesTableUpdateCompanionBuilder =
    EventPartnerSharesCompanion Function({
      Value<int> id,
      Value<int> userID,
      Value<int> eventID,
      Value<double> sharePercentage,
      Value<DateTime> createAt,
    });

final class $$EventPartnerSharesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $EventPartnerSharesTable,
          EventPartnerShare
        > {
  $$EventPartnerSharesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _userIDTable(_$AppDatabase db) =>
      db.users.createAlias('event_partner_shares__user_i_d__users__id');

  $$UsersTableProcessedTableManager get userID {
    final $_column = $_itemColumn<int>('user_i_d')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EventsTable _eventIDTable(_$AppDatabase db) =>
      db.events.createAlias('event_partner_shares__event_i_d__events__id');

  $$EventsTableProcessedTableManager get eventID {
    final $_column = $_itemColumn<int>('event_i_d')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventPartnerSharesTableFilterComposer
    extends Composer<_$AppDatabase, $EventPartnerSharesTable> {
  $$EventPartnerSharesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sharePercentage => $composableBuilder(
    column: $table.sharePercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userID {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userID,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableFilterComposer get eventID {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventPartnerSharesTableOrderingComposer
    extends Composer<_$AppDatabase, $EventPartnerSharesTable> {
  $$EventPartnerSharesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sharePercentage => $composableBuilder(
    column: $table.sharePercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createAt => $composableBuilder(
    column: $table.createAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userID {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userID,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableOrderingComposer get eventID {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventPartnerSharesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventPartnerSharesTable> {
  $$EventPartnerSharesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get sharePercentage => $composableBuilder(
    column: $table.sharePercentage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userID {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userID,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EventsTableAnnotationComposer get eventID {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventPartnerSharesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventPartnerSharesTable,
          EventPartnerShare,
          $$EventPartnerSharesTableFilterComposer,
          $$EventPartnerSharesTableOrderingComposer,
          $$EventPartnerSharesTableAnnotationComposer,
          $$EventPartnerSharesTableCreateCompanionBuilder,
          $$EventPartnerSharesTableUpdateCompanionBuilder,
          (EventPartnerShare, $$EventPartnerSharesTableReferences),
          EventPartnerShare,
          PrefetchHooks Function({bool userID, bool eventID})
        > {
  $$EventPartnerSharesTableTableManager(
    _$AppDatabase db,
    $EventPartnerSharesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventPartnerSharesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventPartnerSharesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventPartnerSharesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userID = const Value.absent(),
                Value<int> eventID = const Value.absent(),
                Value<double> sharePercentage = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
              }) => EventPartnerSharesCompanion(
                id: id,
                userID: userID,
                eventID: eventID,
                sharePercentage: sharePercentage,
                createAt: createAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userID,
                required int eventID,
                required double sharePercentage,
                Value<DateTime> createAt = const Value.absent(),
              }) => EventPartnerSharesCompanion.insert(
                id: id,
                userID: userID,
                eventID: eventID,
                sharePercentage: sharePercentage,
                createAt: createAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventPartnerSharesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userID = false, eventID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userID) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userID,
                        referencedTable: $$EventPartnerSharesTableReferences
                            ._userIDTable(db),
                        referencedColumn: $$EventPartnerSharesTableReferences
                            ._userIDTable(db)
                            .id,
                      ) as T;
                    }
                    if (eventID) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.eventID,
                        referencedTable: $$EventPartnerSharesTableReferences
                            ._eventIDTable(db),
                        referencedColumn: $$EventPartnerSharesTableReferences
                            ._eventIDTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EventPartnerSharesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventPartnerSharesTable,
      EventPartnerShare,
      $$EventPartnerSharesTableFilterComposer,
      $$EventPartnerSharesTableOrderingComposer,
      $$EventPartnerSharesTableAnnotationComposer,
      $$EventPartnerSharesTableCreateCompanionBuilder,
      $$EventPartnerSharesTableUpdateCompanionBuilder,
      (EventPartnerShare, $$EventPartnerSharesTableReferences),
      EventPartnerShare,
      PrefetchHooks Function({bool userID, bool eventID})
    >;
typedef $$EventRegistrationsTableCreateCompanionBuilder =
    EventRegistrationsCompanion Function({
      Value<int> id,
      required int eventID,
      required int userID,
      Value<RegistrationStatus> status,
      required BigInt grossAmount,
      required BigInt discountAmount,
      required BigInt netAmount,
      Value<DateTime> registeredAt,
    });
typedef $$EventRegistrationsTableUpdateCompanionBuilder =
    EventRegistrationsCompanion Function({
      Value<int> id,
      Value<int> eventID,
      Value<int> userID,
      Value<RegistrationStatus> status,
      Value<BigInt> grossAmount,
      Value<BigInt> discountAmount,
      Value<BigInt> netAmount,
      Value<DateTime> registeredAt,
    });

final class $$EventRegistrationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $EventRegistrationsTable,
          EventRegistration
        > {
  $$EventRegistrationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EventsTable _eventIDTable(_$AppDatabase db) =>
      db.events.createAlias('event_registrations__event_i_d__events__id');

  $$EventsTableProcessedTableManager get eventID {
    final $_column = $_itemColumn<int>('event_i_d')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _userIDTable(_$AppDatabase db) =>
      db.users.createAlias('event_registrations__user_i_d__users__id');

  $$UsersTableProcessedTableManager get userID {
    final $_column = $_itemColumn<int>('user_i_d')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventRegistrationsTableFilterComposer
    extends Composer<_$AppDatabase, $EventRegistrationsTable> {
  $$EventRegistrationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RegistrationStatus, RegistrationStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<BigInt> get grossAmount => $composableBuilder(
    column: $table.grossAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get netAmount => $composableBuilder(
    column: $table.netAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get registeredAt => $composableBuilder(
    column: $table.registeredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventID {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get userID {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userID,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventRegistrationsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventRegistrationsTable> {
  $$EventRegistrationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get grossAmount => $composableBuilder(
    column: $table.grossAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get netAmount => $composableBuilder(
    column: $table.netAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get registeredAt => $composableBuilder(
    column: $table.registeredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventID {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get userID {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userID,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventRegistrationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventRegistrationsTable> {
  $$EventRegistrationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RegistrationStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<BigInt> get grossAmount => $composableBuilder(
    column: $table.grossAmount,
    builder: (column) => column,
  );

  GeneratedColumn<BigInt> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => column,
  );

  GeneratedColumn<BigInt> get netAmount =>
      $composableBuilder(column: $table.netAmount, builder: (column) => column);

  GeneratedColumn<DateTime> get registeredAt => $composableBuilder(
    column: $table.registeredAt,
    builder: (column) => column,
  );

  $$EventsTableAnnotationComposer get eventID {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventID,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get userID {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userID,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventRegistrationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventRegistrationsTable,
          EventRegistration,
          $$EventRegistrationsTableFilterComposer,
          $$EventRegistrationsTableOrderingComposer,
          $$EventRegistrationsTableAnnotationComposer,
          $$EventRegistrationsTableCreateCompanionBuilder,
          $$EventRegistrationsTableUpdateCompanionBuilder,
          (EventRegistration, $$EventRegistrationsTableReferences),
          EventRegistration,
          PrefetchHooks Function({bool eventID, bool userID})
        > {
  $$EventRegistrationsTableTableManager(
    _$AppDatabase db,
    $EventRegistrationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventRegistrationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventRegistrationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventRegistrationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> eventID = const Value.absent(),
                Value<int> userID = const Value.absent(),
                Value<RegistrationStatus> status = const Value.absent(),
                Value<BigInt> grossAmount = const Value.absent(),
                Value<BigInt> discountAmount = const Value.absent(),
                Value<BigInt> netAmount = const Value.absent(),
                Value<DateTime> registeredAt = const Value.absent(),
              }) => EventRegistrationsCompanion(
                id: id,
                eventID: eventID,
                userID: userID,
                status: status,
                grossAmount: grossAmount,
                discountAmount: discountAmount,
                netAmount: netAmount,
                registeredAt: registeredAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eventID,
                required int userID,
                Value<RegistrationStatus> status = const Value.absent(),
                required BigInt grossAmount,
                required BigInt discountAmount,
                required BigInt netAmount,
                Value<DateTime> registeredAt = const Value.absent(),
              }) => EventRegistrationsCompanion.insert(
                id: id,
                eventID: eventID,
                userID: userID,
                status: status,
                grossAmount: grossAmount,
                discountAmount: discountAmount,
                netAmount: netAmount,
                registeredAt: registeredAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventRegistrationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventID = false, userID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventID) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.eventID,
                        referencedTable: $$EventRegistrationsTableReferences
                            ._eventIDTable(db),
                        referencedColumn: $$EventRegistrationsTableReferences
                            ._eventIDTable(db)
                            .id,
                      ) as T;
                    }
                    if (userID) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userID,
                        referencedTable: $$EventRegistrationsTableReferences
                            ._userIDTable(db),
                        referencedColumn: $$EventRegistrationsTableReferences
                            ._userIDTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EventRegistrationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventRegistrationsTable,
      EventRegistration,
      $$EventRegistrationsTableFilterComposer,
      $$EventRegistrationsTableOrderingComposer,
      $$EventRegistrationsTableAnnotationComposer,
      $$EventRegistrationsTableCreateCompanionBuilder,
      $$EventRegistrationsTableUpdateCompanionBuilder,
      (EventRegistration, $$EventRegistrationsTableReferences),
      EventRegistration,
      PrefetchHooks Function({bool eventID, bool userID})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountGroupsTableTableManager get accountGroups =>
      $$AccountGroupsTableTableManager(_db, _db.accountGroups);
  $$GeneralAccountsTableTableManager get generalAccounts =>
      $$GeneralAccountsTableTableManager(_db, _db.generalAccounts);
  $$SubsidiaryAccountsTableTableManager get subsidiaryAccounts =>
      $$SubsidiaryAccountsTableTableManager(_db, _db.subsidiaryAccounts);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db, _db.teams);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$BanksTableTableManager get banks =>
      $$BanksTableTableManager(_db, _db.banks);
  $$DetailedAccountsTableTableManager get detailedAccounts =>
      $$DetailedAccountsTableTableManager(_db, _db.detailedAccounts);
  $$JournalHeadersTableTableManager get journalHeaders =>
      $$JournalHeadersTableTableManager(_db, _db.journalHeaders);
  $$JournalLinesTableTableManager get journalLines =>
      $$JournalLinesTableTableManager(_db, _db.journalLines);
  $$TeamMembersTableTableManager get teamMembers =>
      $$TeamMembersTableTableManager(_db, _db.teamMembers);
  $$MenuItemsTableTableManager get menuItems =>
      $$MenuItemsTableTableManager(_db, _db.menuItems);
  $$EventOrdersTableTableManager get eventOrders =>
      $$EventOrdersTableTableManager(_db, _db.eventOrders);
  $$EventPartnerSharesTableTableManager get eventPartnerShares =>
      $$EventPartnerSharesTableTableManager(_db, _db.eventPartnerShares);
  $$EventRegistrationsTableTableManager get eventRegistrations =>
      $$EventRegistrationsTableTableManager(_db, _db.eventRegistrations);
}
