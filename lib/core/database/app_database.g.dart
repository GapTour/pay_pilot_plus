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
  static const VerificationMeta _isSystemDefaultMeta = const VerificationMeta(
    'isSystemDefault',
  );
  @override
  late final GeneratedColumn<bool> isSystemDefault = GeneratedColumn<bool>(
    'is_system_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, code, name, type, isSystemDefault];
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
    if (data.containsKey('is_system_default')) {
      context.handle(
        _isSystemDefaultMeta,
        isSystemDefault.isAcceptableOrUnknown(
          data['is_system_default']!,
          _isSystemDefaultMeta,
        ),
      );
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
      isSystemDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system_default'],
      )!,
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
  final bool isSystemDefault;
  const AccountGroup({
    required this.id,
    required this.code,
    required this.name,
    required this.type,
    required this.isSystemDefault,
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
    map['is_system_default'] = Variable<bool>(isSystemDefault);
    return map;
  }

  AccountGroupsCompanion toCompanion(bool nullToAbsent) {
    return AccountGroupsCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      type: Value(type),
      isSystemDefault: Value(isSystemDefault),
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
      isSystemDefault: serializer.fromJson<bool>(json['isSystemDefault']),
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
      'isSystemDefault': serializer.toJson<bool>(isSystemDefault),
    };
  }

  AccountGroup copyWith({
    int? id,
    String? code,
    String? name,
    AccountGroupType? type,
    bool? isSystemDefault,
  }) => AccountGroup(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    type: type ?? this.type,
    isSystemDefault: isSystemDefault ?? this.isSystemDefault,
  );
  AccountGroup copyWithCompanion(AccountGroupsCompanion data) {
    return AccountGroup(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      isSystemDefault: data.isSystemDefault.present
          ? data.isSystemDefault.value
          : this.isSystemDefault,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountGroup(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('isSystemDefault: $isSystemDefault')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, name, type, isSystemDefault);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountGroup &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.type == this.type &&
          other.isSystemDefault == this.isSystemDefault);
}

class AccountGroupsCompanion extends UpdateCompanion<AccountGroup> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<AccountGroupType> type;
  final Value<bool> isSystemDefault;
  const AccountGroupsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.isSystemDefault = const Value.absent(),
  });
  AccountGroupsCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    required AccountGroupType type,
    this.isSystemDefault = const Value.absent(),
  }) : code = Value(code),
       name = Value(name),
       type = Value(type);
  static Insertable<AccountGroup> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? type,
    Expression<bool>? isSystemDefault,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (isSystemDefault != null) 'is_system_default': isSystemDefault,
    });
  }

  AccountGroupsCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? name,
    Value<AccountGroupType>? type,
    Value<bool>? isSystemDefault,
  }) {
    return AccountGroupsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
      isSystemDefault: isSystemDefault ?? this.isSystemDefault,
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
    if (isSystemDefault.present) {
      map['is_system_default'] = Variable<bool>(isSystemDefault.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountGroupsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('isSystemDefault: $isSystemDefault')
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
  static const VerificationMeta _entranceFeeMeta = const VerificationMeta(
    'entranceFee',
  );
  @override
  late final GeneratedColumn<BigInt> entranceFee = GeneratedColumn<BigInt>(
    'entrance_fee',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snacksFeeMeta = const VerificationMeta(
    'snacksFee',
  );
  @override
  late final GeneratedColumn<BigInt> snacksFee = GeneratedColumn<BigInt>(
    'snacks_fee',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
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
    userID,
    entranceFee,
    snacksFee,
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
    if (data.containsKey('user_i_d')) {
      context.handle(
        _userIDMeta,
        userID.isAcceptableOrUnknown(data['user_i_d']!, _userIDMeta),
      );
    } else if (isInserting) {
      context.missing(_userIDMeta);
    }
    if (data.containsKey('entrance_fee')) {
      context.handle(
        _entranceFeeMeta,
        entranceFee.isAcceptableOrUnknown(
          data['entrance_fee']!,
          _entranceFeeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_entranceFeeMeta);
    }
    if (data.containsKey('snacks_fee')) {
      context.handle(
        _snacksFeeMeta,
        snacksFee.isAcceptableOrUnknown(data['snacks_fee']!, _snacksFeeMeta),
      );
    } else if (isInserting) {
      context.missing(_snacksFeeMeta);
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
      userID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_i_d'],
      )!,
      entranceFee: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}entrance_fee'],
      )!,
      snacksFee: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}snacks_fee'],
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
  final int userID;
  final BigInt entranceFee;
  final BigInt snacksFee;
  final DateTime date;
  final bool isClosed;
  final bool isActive;
  final DateTime createdAt;
  const Event({
    required this.id,
    required this.title,
    required this.teamID,
    required this.userID,
    required this.entranceFee,
    required this.snacksFee,
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
    map['user_i_d'] = Variable<int>(userID);
    map['entrance_fee'] = Variable<BigInt>(entranceFee);
    map['snacks_fee'] = Variable<BigInt>(snacksFee);
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
      userID: Value(userID),
      entranceFee: Value(entranceFee),
      snacksFee: Value(snacksFee),
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
      userID: serializer.fromJson<int>(json['userID']),
      entranceFee: serializer.fromJson<BigInt>(json['entranceFee']),
      snacksFee: serializer.fromJson<BigInt>(json['snacksFee']),
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
      'userID': serializer.toJson<int>(userID),
      'entranceFee': serializer.toJson<BigInt>(entranceFee),
      'snacksFee': serializer.toJson<BigInt>(snacksFee),
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
    int? userID,
    BigInt? entranceFee,
    BigInt? snacksFee,
    DateTime? date,
    bool? isClosed,
    bool? isActive,
    DateTime? createdAt,
  }) => Event(
    id: id ?? this.id,
    title: title ?? this.title,
    teamID: teamID ?? this.teamID,
    userID: userID ?? this.userID,
    entranceFee: entranceFee ?? this.entranceFee,
    snacksFee: snacksFee ?? this.snacksFee,
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
      userID: data.userID.present ? data.userID.value : this.userID,
      entranceFee: data.entranceFee.present
          ? data.entranceFee.value
          : this.entranceFee,
      snacksFee: data.snacksFee.present ? data.snacksFee.value : this.snacksFee,
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
          ..write('userID: $userID, ')
          ..write('entranceFee: $entranceFee, ')
          ..write('snacksFee: $snacksFee, ')
          ..write('date: $date, ')
          ..write('isClosed: $isClosed, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    teamID,
    userID,
    entranceFee,
    snacksFee,
    date,
    isClosed,
    isActive,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.title == this.title &&
          other.teamID == this.teamID &&
          other.userID == this.userID &&
          other.entranceFee == this.entranceFee &&
          other.snacksFee == this.snacksFee &&
          other.date == this.date &&
          other.isClosed == this.isClosed &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> teamID;
  final Value<int> userID;
  final Value<BigInt> entranceFee;
  final Value<BigInt> snacksFee;
  final Value<DateTime> date;
  final Value<bool> isClosed;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.teamID = const Value.absent(),
    this.userID = const Value.absent(),
    this.entranceFee = const Value.absent(),
    this.snacksFee = const Value.absent(),
    this.date = const Value.absent(),
    this.isClosed = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int teamID,
    required int userID,
    required BigInt entranceFee,
    required BigInt snacksFee,
    this.date = const Value.absent(),
    this.isClosed = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title),
       teamID = Value(teamID),
       userID = Value(userID),
       entranceFee = Value(entranceFee),
       snacksFee = Value(snacksFee);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? teamID,
    Expression<int>? userID,
    Expression<BigInt>? entranceFee,
    Expression<BigInt>? snacksFee,
    Expression<DateTime>? date,
    Expression<bool>? isClosed,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (teamID != null) 'team_i_d': teamID,
      if (userID != null) 'user_i_d': userID,
      if (entranceFee != null) 'entrance_fee': entranceFee,
      if (snacksFee != null) 'snacks_fee': snacksFee,
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
    Value<int>? userID,
    Value<BigInt>? entranceFee,
    Value<BigInt>? snacksFee,
    Value<DateTime>? date,
    Value<bool>? isClosed,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return EventsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      teamID: teamID ?? this.teamID,
      userID: userID ?? this.userID,
      entranceFee: entranceFee ?? this.entranceFee,
      snacksFee: snacksFee ?? this.snacksFee,
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
    if (userID.present) {
      map['user_i_d'] = Variable<int>(userID.value);
    }
    if (entranceFee.present) {
      map['entrance_fee'] = Variable<BigInt>(entranceFee.value);
    }
    if (snacksFee.present) {
      map['snacks_fee'] = Variable<BigInt>(snacksFee.value);
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
          ..write('userID: $userID, ')
          ..write('entranceFee: $entranceFee, ')
          ..write('snacksFee: $snacksFee, ')
          ..write('date: $date, ')
          ..write('isClosed: $isClosed, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
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

class $FundsTable extends Funds with TableInfo<$FundsTable, Fund> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FundsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _openingBalanceMeta = const VerificationMeta(
    'openingBalance',
  );
  @override
  late final GeneratedColumn<BigInt> openingBalance = GeneratedColumn<BigInt>(
    'opening_balance',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
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
    openingBalance,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'funds';
  @override
  VerificationContext validateIntegrity(
    Insertable<Fund> instance, {
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
    if (data.containsKey('opening_balance')) {
      context.handle(
        _openingBalanceMeta,
        openingBalance.isAcceptableOrUnknown(
          data['opening_balance']!,
          _openingBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openingBalanceMeta);
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
  Fund map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Fund(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      openingBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}opening_balance'],
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
  $FundsTable createAlias(String alias) {
    return $FundsTable(attachedDatabase, alias);
  }
}

class Fund extends DataClass implements Insertable<Fund> {
  final int id;
  final String title;
  final BigInt openingBalance;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Fund({
    required this.id,
    required this.title,
    required this.openingBalance,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['opening_balance'] = Variable<BigInt>(openingBalance);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FundsCompanion toCompanion(bool nullToAbsent) {
    return FundsCompanion(
      id: Value(id),
      title: Value(title),
      openingBalance: Value(openingBalance),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Fund.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Fund(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      openingBalance: serializer.fromJson<BigInt>(json['openingBalance']),
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
      'openingBalance': serializer.toJson<BigInt>(openingBalance),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Fund copyWith({
    int? id,
    String? title,
    BigInt? openingBalance,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Fund(
    id: id ?? this.id,
    title: title ?? this.title,
    openingBalance: openingBalance ?? this.openingBalance,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Fund copyWithCompanion(FundsCompanion data) {
    return Fund(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      openingBalance: data.openingBalance.present
          ? data.openingBalance.value
          : this.openingBalance,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Fund(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, openingBalance, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Fund &&
          other.id == this.id &&
          other.title == this.title &&
          other.openingBalance == this.openingBalance &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FundsCompanion extends UpdateCompanion<Fund> {
  final Value<int> id;
  final Value<String> title;
  final Value<BigInt> openingBalance;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const FundsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.openingBalance = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FundsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required BigInt openingBalance,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : title = Value(title),
       openingBalance = Value(openingBalance);
  static Insertable<Fund> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<BigInt>? openingBalance,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (openingBalance != null) 'opening_balance': openingBalance,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FundsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<BigInt>? openingBalance,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return FundsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      openingBalance: openingBalance ?? this.openingBalance,
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
    if (openingBalance.present) {
      map['opening_balance'] = Variable<BigInt>(openingBalance.value);
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
    return (StringBuffer('FundsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
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
  static const VerificationMeta _snacksAssignmentUserIDMeta =
      const VerificationMeta('snacksAssignmentUserID');
  @override
  late final GeneratedColumn<int> snacksAssignmentUserID = GeneratedColumn<int>(
    'snacks_assignment_user_i_d',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _snacksAssignmentFundIDMeta =
      const VerificationMeta('snacksAssignmentFundID');
  @override
  late final GeneratedColumn<int> snacksAssignmentFundID = GeneratedColumn<int>(
    'snacks_assignment_fund_i_d',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES funds (id) ON DELETE RESTRICT',
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
  @override
  late final GeneratedColumnWithTypeConverter<SnacksFeeAssignmentStatus, String>
  snacksFeeAssignmentStatus =
      GeneratedColumn<String>(
        'snacks_fee_assignment_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(SnacksFeeAssignmentStatus.unassign.name),
      ).withConverter<SnacksFeeAssignmentStatus>(
        $EventRegistrationsTable.$convertersnacksFeeAssignmentStatus,
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
  static const VerificationMeta _wasAbsentMeta = const VerificationMeta(
    'wasAbsent',
  );
  @override
  late final GeneratedColumn<bool> wasAbsent = GeneratedColumn<bool>(
    'was_absent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("was_absent" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
    snacksAssignmentUserID,
    snacksAssignmentFundID,
    status,
    snacksFeeAssignmentStatus,
    grossAmount,
    discountAmount,
    netAmount,
    wasAbsent,
    description,
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
    if (data.containsKey('snacks_assignment_user_i_d')) {
      context.handle(
        _snacksAssignmentUserIDMeta,
        snacksAssignmentUserID.isAcceptableOrUnknown(
          data['snacks_assignment_user_i_d']!,
          _snacksAssignmentUserIDMeta,
        ),
      );
    }
    if (data.containsKey('snacks_assignment_fund_i_d')) {
      context.handle(
        _snacksAssignmentFundIDMeta,
        snacksAssignmentFundID.isAcceptableOrUnknown(
          data['snacks_assignment_fund_i_d']!,
          _snacksAssignmentFundIDMeta,
        ),
      );
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
    if (data.containsKey('was_absent')) {
      context.handle(
        _wasAbsentMeta,
        wasAbsent.isAcceptableOrUnknown(data['was_absent']!, _wasAbsentMeta),
      );
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
      snacksAssignmentUserID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}snacks_assignment_user_i_d'],
      ),
      snacksAssignmentFundID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}snacks_assignment_fund_i_d'],
      ),
      status: $EventRegistrationsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      snacksFeeAssignmentStatus: $EventRegistrationsTable
          .$convertersnacksFeeAssignmentStatus
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}snacks_fee_assignment_status'],
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
      wasAbsent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}was_absent'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
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
  static JsonTypeConverter2<SnacksFeeAssignmentStatus, String, String>
  $convertersnacksFeeAssignmentStatus =
      const EnumNameConverter<SnacksFeeAssignmentStatus>(
        SnacksFeeAssignmentStatus.values,
      );
}

class EventRegistration extends DataClass
    implements Insertable<EventRegistration> {
  final int id;
  final int eventID;
  final int userID;
  final int? snacksAssignmentUserID;
  final int? snacksAssignmentFundID;
  final RegistrationStatus status;
  final SnacksFeeAssignmentStatus snacksFeeAssignmentStatus;
  final BigInt grossAmount;
  final BigInt discountAmount;
  final BigInt netAmount;
  final bool wasAbsent;
  final String? description;
  final DateTime registeredAt;
  const EventRegistration({
    required this.id,
    required this.eventID,
    required this.userID,
    this.snacksAssignmentUserID,
    this.snacksAssignmentFundID,
    required this.status,
    required this.snacksFeeAssignmentStatus,
    required this.grossAmount,
    required this.discountAmount,
    required this.netAmount,
    required this.wasAbsent,
    this.description,
    required this.registeredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_i_d'] = Variable<int>(eventID);
    map['user_i_d'] = Variable<int>(userID);
    if (!nullToAbsent || snacksAssignmentUserID != null) {
      map['snacks_assignment_user_i_d'] = Variable<int>(snacksAssignmentUserID);
    }
    if (!nullToAbsent || snacksAssignmentFundID != null) {
      map['snacks_assignment_fund_i_d'] = Variable<int>(snacksAssignmentFundID);
    }
    {
      map['status'] = Variable<String>(
        $EventRegistrationsTable.$converterstatus.toSql(status),
      );
    }
    {
      map['snacks_fee_assignment_status'] = Variable<String>(
        $EventRegistrationsTable.$convertersnacksFeeAssignmentStatus.toSql(
          snacksFeeAssignmentStatus,
        ),
      );
    }
    map['gross_amount'] = Variable<BigInt>(grossAmount);
    map['discount_amount'] = Variable<BigInt>(discountAmount);
    map['net_amount'] = Variable<BigInt>(netAmount);
    map['was_absent'] = Variable<bool>(wasAbsent);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['registered_at'] = Variable<DateTime>(registeredAt);
    return map;
  }

  EventRegistrationsCompanion toCompanion(bool nullToAbsent) {
    return EventRegistrationsCompanion(
      id: Value(id),
      eventID: Value(eventID),
      userID: Value(userID),
      snacksAssignmentUserID: snacksAssignmentUserID == null && nullToAbsent
          ? const Value.absent()
          : Value(snacksAssignmentUserID),
      snacksAssignmentFundID: snacksAssignmentFundID == null && nullToAbsent
          ? const Value.absent()
          : Value(snacksAssignmentFundID),
      status: Value(status),
      snacksFeeAssignmentStatus: Value(snacksFeeAssignmentStatus),
      grossAmount: Value(grossAmount),
      discountAmount: Value(discountAmount),
      netAmount: Value(netAmount),
      wasAbsent: Value(wasAbsent),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
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
      snacksAssignmentUserID: serializer.fromJson<int?>(
        json['snacksAssignmentUserID'],
      ),
      snacksAssignmentFundID: serializer.fromJson<int?>(
        json['snacksAssignmentFundID'],
      ),
      status: $EventRegistrationsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      snacksFeeAssignmentStatus: $EventRegistrationsTable
          .$convertersnacksFeeAssignmentStatus
          .fromJson(
            serializer.fromJson<String>(json['snacksFeeAssignmentStatus']),
          ),
      grossAmount: serializer.fromJson<BigInt>(json['grossAmount']),
      discountAmount: serializer.fromJson<BigInt>(json['discountAmount']),
      netAmount: serializer.fromJson<BigInt>(json['netAmount']),
      wasAbsent: serializer.fromJson<bool>(json['wasAbsent']),
      description: serializer.fromJson<String?>(json['description']),
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
      'snacksAssignmentUserID': serializer.toJson<int?>(snacksAssignmentUserID),
      'snacksAssignmentFundID': serializer.toJson<int?>(snacksAssignmentFundID),
      'status': serializer.toJson<String>(
        $EventRegistrationsTable.$converterstatus.toJson(status),
      ),
      'snacksFeeAssignmentStatus': serializer.toJson<String>(
        $EventRegistrationsTable.$convertersnacksFeeAssignmentStatus.toJson(
          snacksFeeAssignmentStatus,
        ),
      ),
      'grossAmount': serializer.toJson<BigInt>(grossAmount),
      'discountAmount': serializer.toJson<BigInt>(discountAmount),
      'netAmount': serializer.toJson<BigInt>(netAmount),
      'wasAbsent': serializer.toJson<bool>(wasAbsent),
      'description': serializer.toJson<String?>(description),
      'registeredAt': serializer.toJson<DateTime>(registeredAt),
    };
  }

  EventRegistration copyWith({
    int? id,
    int? eventID,
    int? userID,
    Value<int?> snacksAssignmentUserID = const Value.absent(),
    Value<int?> snacksAssignmentFundID = const Value.absent(),
    RegistrationStatus? status,
    SnacksFeeAssignmentStatus? snacksFeeAssignmentStatus,
    BigInt? grossAmount,
    BigInt? discountAmount,
    BigInt? netAmount,
    bool? wasAbsent,
    Value<String?> description = const Value.absent(),
    DateTime? registeredAt,
  }) => EventRegistration(
    id: id ?? this.id,
    eventID: eventID ?? this.eventID,
    userID: userID ?? this.userID,
    snacksAssignmentUserID: snacksAssignmentUserID.present
        ? snacksAssignmentUserID.value
        : this.snacksAssignmentUserID,
    snacksAssignmentFundID: snacksAssignmentFundID.present
        ? snacksAssignmentFundID.value
        : this.snacksAssignmentFundID,
    status: status ?? this.status,
    snacksFeeAssignmentStatus:
        snacksFeeAssignmentStatus ?? this.snacksFeeAssignmentStatus,
    grossAmount: grossAmount ?? this.grossAmount,
    discountAmount: discountAmount ?? this.discountAmount,
    netAmount: netAmount ?? this.netAmount,
    wasAbsent: wasAbsent ?? this.wasAbsent,
    description: description.present ? description.value : this.description,
    registeredAt: registeredAt ?? this.registeredAt,
  );
  EventRegistration copyWithCompanion(EventRegistrationsCompanion data) {
    return EventRegistration(
      id: data.id.present ? data.id.value : this.id,
      eventID: data.eventID.present ? data.eventID.value : this.eventID,
      userID: data.userID.present ? data.userID.value : this.userID,
      snacksAssignmentUserID: data.snacksAssignmentUserID.present
          ? data.snacksAssignmentUserID.value
          : this.snacksAssignmentUserID,
      snacksAssignmentFundID: data.snacksAssignmentFundID.present
          ? data.snacksAssignmentFundID.value
          : this.snacksAssignmentFundID,
      status: data.status.present ? data.status.value : this.status,
      snacksFeeAssignmentStatus: data.snacksFeeAssignmentStatus.present
          ? data.snacksFeeAssignmentStatus.value
          : this.snacksFeeAssignmentStatus,
      grossAmount: data.grossAmount.present
          ? data.grossAmount.value
          : this.grossAmount,
      discountAmount: data.discountAmount.present
          ? data.discountAmount.value
          : this.discountAmount,
      netAmount: data.netAmount.present ? data.netAmount.value : this.netAmount,
      wasAbsent: data.wasAbsent.present ? data.wasAbsent.value : this.wasAbsent,
      description: data.description.present
          ? data.description.value
          : this.description,
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
          ..write('snacksAssignmentUserID: $snacksAssignmentUserID, ')
          ..write('snacksAssignmentFundID: $snacksAssignmentFundID, ')
          ..write('status: $status, ')
          ..write('snacksFeeAssignmentStatus: $snacksFeeAssignmentStatus, ')
          ..write('grossAmount: $grossAmount, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('netAmount: $netAmount, ')
          ..write('wasAbsent: $wasAbsent, ')
          ..write('description: $description, ')
          ..write('registeredAt: $registeredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventID,
    userID,
    snacksAssignmentUserID,
    snacksAssignmentFundID,
    status,
    snacksFeeAssignmentStatus,
    grossAmount,
    discountAmount,
    netAmount,
    wasAbsent,
    description,
    registeredAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventRegistration &&
          other.id == this.id &&
          other.eventID == this.eventID &&
          other.userID == this.userID &&
          other.snacksAssignmentUserID == this.snacksAssignmentUserID &&
          other.snacksAssignmentFundID == this.snacksAssignmentFundID &&
          other.status == this.status &&
          other.snacksFeeAssignmentStatus == this.snacksFeeAssignmentStatus &&
          other.grossAmount == this.grossAmount &&
          other.discountAmount == this.discountAmount &&
          other.netAmount == this.netAmount &&
          other.wasAbsent == this.wasAbsent &&
          other.description == this.description &&
          other.registeredAt == this.registeredAt);
}

class EventRegistrationsCompanion extends UpdateCompanion<EventRegistration> {
  final Value<int> id;
  final Value<int> eventID;
  final Value<int> userID;
  final Value<int?> snacksAssignmentUserID;
  final Value<int?> snacksAssignmentFundID;
  final Value<RegistrationStatus> status;
  final Value<SnacksFeeAssignmentStatus> snacksFeeAssignmentStatus;
  final Value<BigInt> grossAmount;
  final Value<BigInt> discountAmount;
  final Value<BigInt> netAmount;
  final Value<bool> wasAbsent;
  final Value<String?> description;
  final Value<DateTime> registeredAt;
  const EventRegistrationsCompanion({
    this.id = const Value.absent(),
    this.eventID = const Value.absent(),
    this.userID = const Value.absent(),
    this.snacksAssignmentUserID = const Value.absent(),
    this.snacksAssignmentFundID = const Value.absent(),
    this.status = const Value.absent(),
    this.snacksFeeAssignmentStatus = const Value.absent(),
    this.grossAmount = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.netAmount = const Value.absent(),
    this.wasAbsent = const Value.absent(),
    this.description = const Value.absent(),
    this.registeredAt = const Value.absent(),
  });
  EventRegistrationsCompanion.insert({
    this.id = const Value.absent(),
    required int eventID,
    required int userID,
    this.snacksAssignmentUserID = const Value.absent(),
    this.snacksAssignmentFundID = const Value.absent(),
    this.status = const Value.absent(),
    this.snacksFeeAssignmentStatus = const Value.absent(),
    required BigInt grossAmount,
    required BigInt discountAmount,
    required BigInt netAmount,
    this.wasAbsent = const Value.absent(),
    this.description = const Value.absent(),
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
    Expression<int>? snacksAssignmentUserID,
    Expression<int>? snacksAssignmentFundID,
    Expression<String>? status,
    Expression<String>? snacksFeeAssignmentStatus,
    Expression<BigInt>? grossAmount,
    Expression<BigInt>? discountAmount,
    Expression<BigInt>? netAmount,
    Expression<bool>? wasAbsent,
    Expression<String>? description,
    Expression<DateTime>? registeredAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventID != null) 'event_i_d': eventID,
      if (userID != null) 'user_i_d': userID,
      if (snacksAssignmentUserID != null)
        'snacks_assignment_user_i_d': snacksAssignmentUserID,
      if (snacksAssignmentFundID != null)
        'snacks_assignment_fund_i_d': snacksAssignmentFundID,
      if (status != null) 'status': status,
      if (snacksFeeAssignmentStatus != null)
        'snacks_fee_assignment_status': snacksFeeAssignmentStatus,
      if (grossAmount != null) 'gross_amount': grossAmount,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (netAmount != null) 'net_amount': netAmount,
      if (wasAbsent != null) 'was_absent': wasAbsent,
      if (description != null) 'description': description,
      if (registeredAt != null) 'registered_at': registeredAt,
    });
  }

  EventRegistrationsCompanion copyWith({
    Value<int>? id,
    Value<int>? eventID,
    Value<int>? userID,
    Value<int?>? snacksAssignmentUserID,
    Value<int?>? snacksAssignmentFundID,
    Value<RegistrationStatus>? status,
    Value<SnacksFeeAssignmentStatus>? snacksFeeAssignmentStatus,
    Value<BigInt>? grossAmount,
    Value<BigInt>? discountAmount,
    Value<BigInt>? netAmount,
    Value<bool>? wasAbsent,
    Value<String?>? description,
    Value<DateTime>? registeredAt,
  }) {
    return EventRegistrationsCompanion(
      id: id ?? this.id,
      eventID: eventID ?? this.eventID,
      userID: userID ?? this.userID,
      snacksAssignmentUserID:
          snacksAssignmentUserID ?? this.snacksAssignmentUserID,
      snacksAssignmentFundID:
          snacksAssignmentFundID ?? this.snacksAssignmentFundID,
      status: status ?? this.status,
      snacksFeeAssignmentStatus:
          snacksFeeAssignmentStatus ?? this.snacksFeeAssignmentStatus,
      grossAmount: grossAmount ?? this.grossAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      netAmount: netAmount ?? this.netAmount,
      wasAbsent: wasAbsent ?? this.wasAbsent,
      description: description ?? this.description,
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
    if (snacksAssignmentUserID.present) {
      map['snacks_assignment_user_i_d'] = Variable<int>(
        snacksAssignmentUserID.value,
      );
    }
    if (snacksAssignmentFundID.present) {
      map['snacks_assignment_fund_i_d'] = Variable<int>(
        snacksAssignmentFundID.value,
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $EventRegistrationsTable.$converterstatus.toSql(status.value),
      );
    }
    if (snacksFeeAssignmentStatus.present) {
      map['snacks_fee_assignment_status'] = Variable<String>(
        $EventRegistrationsTable.$convertersnacksFeeAssignmentStatus.toSql(
          snacksFeeAssignmentStatus.value,
        ),
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
    if (wasAbsent.present) {
      map['was_absent'] = Variable<bool>(wasAbsent.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
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
          ..write('snacksAssignmentUserID: $snacksAssignmentUserID, ')
          ..write('snacksAssignmentFundID: $snacksAssignmentFundID, ')
          ..write('status: $status, ')
          ..write('snacksFeeAssignmentStatus: $snacksFeeAssignmentStatus, ')
          ..write('grossAmount: $grossAmount, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('netAmount: $netAmount, ')
          ..write('wasAbsent: $wasAbsent, ')
          ..write('description: $description, ')
          ..write('registeredAt: $registeredAt')
          ..write(')'))
        .toString();
  }
}

class $FundAllocationsTable extends FundAllocations
    with TableInfo<$FundAllocationsTable, FundAllocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FundAllocationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fundIDMeta = const VerificationMeta('fundID');
  @override
  late final GeneratedColumn<int> fundID = GeneratedColumn<int>(
    'fund_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES funds (id) ON DELETE RESTRICT',
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
    fundID,
    eventID,
    sharePercentage,
    createAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fund_allocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<FundAllocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fund_i_d')) {
      context.handle(
        _fundIDMeta,
        fundID.isAcceptableOrUnknown(data['fund_i_d']!, _fundIDMeta),
      );
    } else if (isInserting) {
      context.missing(_fundIDMeta);
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
    {eventID, fundID},
  ];
  @override
  FundAllocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FundAllocation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fundID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fund_i_d'],
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
  $FundAllocationsTable createAlias(String alias) {
    return $FundAllocationsTable(attachedDatabase, alias);
  }
}

class FundAllocation extends DataClass implements Insertable<FundAllocation> {
  final int id;
  final int fundID;
  final int eventID;
  final double sharePercentage;
  final DateTime createAt;
  const FundAllocation({
    required this.id,
    required this.fundID,
    required this.eventID,
    required this.sharePercentage,
    required this.createAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fund_i_d'] = Variable<int>(fundID);
    map['event_i_d'] = Variable<int>(eventID);
    map['share_percentage'] = Variable<double>(sharePercentage);
    map['create_at'] = Variable<DateTime>(createAt);
    return map;
  }

  FundAllocationsCompanion toCompanion(bool nullToAbsent) {
    return FundAllocationsCompanion(
      id: Value(id),
      fundID: Value(fundID),
      eventID: Value(eventID),
      sharePercentage: Value(sharePercentage),
      createAt: Value(createAt),
    );
  }

  factory FundAllocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FundAllocation(
      id: serializer.fromJson<int>(json['id']),
      fundID: serializer.fromJson<int>(json['fundID']),
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
      'fundID': serializer.toJson<int>(fundID),
      'eventID': serializer.toJson<int>(eventID),
      'sharePercentage': serializer.toJson<double>(sharePercentage),
      'createAt': serializer.toJson<DateTime>(createAt),
    };
  }

  FundAllocation copyWith({
    int? id,
    int? fundID,
    int? eventID,
    double? sharePercentage,
    DateTime? createAt,
  }) => FundAllocation(
    id: id ?? this.id,
    fundID: fundID ?? this.fundID,
    eventID: eventID ?? this.eventID,
    sharePercentage: sharePercentage ?? this.sharePercentage,
    createAt: createAt ?? this.createAt,
  );
  FundAllocation copyWithCompanion(FundAllocationsCompanion data) {
    return FundAllocation(
      id: data.id.present ? data.id.value : this.id,
      fundID: data.fundID.present ? data.fundID.value : this.fundID,
      eventID: data.eventID.present ? data.eventID.value : this.eventID,
      sharePercentage: data.sharePercentage.present
          ? data.sharePercentage.value
          : this.sharePercentage,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FundAllocation(')
          ..write('id: $id, ')
          ..write('fundID: $fundID, ')
          ..write('eventID: $eventID, ')
          ..write('sharePercentage: $sharePercentage, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, fundID, eventID, sharePercentage, createAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FundAllocation &&
          other.id == this.id &&
          other.fundID == this.fundID &&
          other.eventID == this.eventID &&
          other.sharePercentage == this.sharePercentage &&
          other.createAt == this.createAt);
}

class FundAllocationsCompanion extends UpdateCompanion<FundAllocation> {
  final Value<int> id;
  final Value<int> fundID;
  final Value<int> eventID;
  final Value<double> sharePercentage;
  final Value<DateTime> createAt;
  const FundAllocationsCompanion({
    this.id = const Value.absent(),
    this.fundID = const Value.absent(),
    this.eventID = const Value.absent(),
    this.sharePercentage = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  FundAllocationsCompanion.insert({
    this.id = const Value.absent(),
    required int fundID,
    required int eventID,
    required double sharePercentage,
    this.createAt = const Value.absent(),
  }) : fundID = Value(fundID),
       eventID = Value(eventID),
       sharePercentage = Value(sharePercentage);
  static Insertable<FundAllocation> custom({
    Expression<int>? id,
    Expression<int>? fundID,
    Expression<int>? eventID,
    Expression<double>? sharePercentage,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fundID != null) 'fund_i_d': fundID,
      if (eventID != null) 'event_i_d': eventID,
      if (sharePercentage != null) 'share_percentage': sharePercentage,
      if (createAt != null) 'create_at': createAt,
    });
  }

  FundAllocationsCompanion copyWith({
    Value<int>? id,
    Value<int>? fundID,
    Value<int>? eventID,
    Value<double>? sharePercentage,
    Value<DateTime>? createAt,
  }) {
    return FundAllocationsCompanion(
      id: id ?? this.id,
      fundID: fundID ?? this.fundID,
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
    if (fundID.present) {
      map['fund_i_d'] = Variable<int>(fundID.value);
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
    return (StringBuffer('FundAllocationsCompanion(')
          ..write('id: $id, ')
          ..write('fundID: $fundID, ')
          ..write('eventID: $eventID, ')
          ..write('sharePercentage: $sharePercentage, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }
}

class $FundBalancesTable extends FundBalances
    with TableInfo<$FundBalancesTable, FundBalance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FundBalancesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fundIDMeta = const VerificationMeta('fundID');
  @override
  late final GeneratedColumn<int> fundID = GeneratedColumn<int>(
    'fund_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES funds (id) ON DELETE CASCADE',
    ),
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
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
    'memo',
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
    fundID,
    series,
    debit,
    credit,
    date,
    memo,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fund_balances';
  @override
  VerificationContext validateIntegrity(
    Insertable<FundBalance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fund_i_d')) {
      context.handle(
        _fundIDMeta,
        fundID.isAcceptableOrUnknown(data['fund_i_d']!, _fundIDMeta),
      );
    } else if (isInserting) {
      context.missing(_fundIDMeta);
    }
    if (data.containsKey('series')) {
      context.handle(
        _seriesMeta,
        series.isAcceptableOrUnknown(data['series']!, _seriesMeta),
      );
    } else if (isInserting) {
      context.missing(_seriesMeta);
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
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('memo')) {
      context.handle(
        _memoMeta,
        memo.isAcceptableOrUnknown(data['memo']!, _memoMeta),
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
  FundBalance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FundBalance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fundID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fund_i_d'],
      )!,
      series: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}series'],
      )!,
      debit: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}debit'],
      )!,
      credit: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}credit'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      memo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}memo'],
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
  $FundBalancesTable createAlias(String alias) {
    return $FundBalancesTable(attachedDatabase, alias);
  }
}

class FundBalance extends DataClass implements Insertable<FundBalance> {
  final int id;
  final int fundID;
  final String series;
  final BigInt debit;
  final BigInt credit;
  final DateTime date;
  final String? memo;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FundBalance({
    required this.id,
    required this.fundID,
    required this.series,
    required this.debit,
    required this.credit,
    required this.date,
    this.memo,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fund_i_d'] = Variable<int>(fundID);
    map['series'] = Variable<String>(series);
    map['debit'] = Variable<BigInt>(debit);
    map['credit'] = Variable<BigInt>(credit);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FundBalancesCompanion toCompanion(bool nullToAbsent) {
    return FundBalancesCompanion(
      id: Value(id),
      fundID: Value(fundID),
      series: Value(series),
      debit: Value(debit),
      credit: Value(credit),
      date: Value(date),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FundBalance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FundBalance(
      id: serializer.fromJson<int>(json['id']),
      fundID: serializer.fromJson<int>(json['fundID']),
      series: serializer.fromJson<String>(json['series']),
      debit: serializer.fromJson<BigInt>(json['debit']),
      credit: serializer.fromJson<BigInt>(json['credit']),
      date: serializer.fromJson<DateTime>(json['date']),
      memo: serializer.fromJson<String?>(json['memo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fundID': serializer.toJson<int>(fundID),
      'series': serializer.toJson<String>(series),
      'debit': serializer.toJson<BigInt>(debit),
      'credit': serializer.toJson<BigInt>(credit),
      'date': serializer.toJson<DateTime>(date),
      'memo': serializer.toJson<String?>(memo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FundBalance copyWith({
    int? id,
    int? fundID,
    String? series,
    BigInt? debit,
    BigInt? credit,
    DateTime? date,
    Value<String?> memo = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FundBalance(
    id: id ?? this.id,
    fundID: fundID ?? this.fundID,
    series: series ?? this.series,
    debit: debit ?? this.debit,
    credit: credit ?? this.credit,
    date: date ?? this.date,
    memo: memo.present ? memo.value : this.memo,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FundBalance copyWithCompanion(FundBalancesCompanion data) {
    return FundBalance(
      id: data.id.present ? data.id.value : this.id,
      fundID: data.fundID.present ? data.fundID.value : this.fundID,
      series: data.series.present ? data.series.value : this.series,
      debit: data.debit.present ? data.debit.value : this.debit,
      credit: data.credit.present ? data.credit.value : this.credit,
      date: data.date.present ? data.date.value : this.date,
      memo: data.memo.present ? data.memo.value : this.memo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FundBalance(')
          ..write('id: $id, ')
          ..write('fundID: $fundID, ')
          ..write('series: $series, ')
          ..write('debit: $debit, ')
          ..write('credit: $credit, ')
          ..write('date: $date, ')
          ..write('memo: $memo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fundID,
    series,
    debit,
    credit,
    date,
    memo,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FundBalance &&
          other.id == this.id &&
          other.fundID == this.fundID &&
          other.series == this.series &&
          other.debit == this.debit &&
          other.credit == this.credit &&
          other.date == this.date &&
          other.memo == this.memo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FundBalancesCompanion extends UpdateCompanion<FundBalance> {
  final Value<int> id;
  final Value<int> fundID;
  final Value<String> series;
  final Value<BigInt> debit;
  final Value<BigInt> credit;
  final Value<DateTime> date;
  final Value<String?> memo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const FundBalancesCompanion({
    this.id = const Value.absent(),
    this.fundID = const Value.absent(),
    this.series = const Value.absent(),
    this.debit = const Value.absent(),
    this.credit = const Value.absent(),
    this.date = const Value.absent(),
    this.memo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FundBalancesCompanion.insert({
    this.id = const Value.absent(),
    required int fundID,
    required String series,
    required BigInt debit,
    required BigInt credit,
    this.date = const Value.absent(),
    this.memo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : fundID = Value(fundID),
       series = Value(series),
       debit = Value(debit),
       credit = Value(credit);
  static Insertable<FundBalance> custom({
    Expression<int>? id,
    Expression<int>? fundID,
    Expression<String>? series,
    Expression<BigInt>? debit,
    Expression<BigInt>? credit,
    Expression<DateTime>? date,
    Expression<String>? memo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fundID != null) 'fund_i_d': fundID,
      if (series != null) 'series': series,
      if (debit != null) 'debit': debit,
      if (credit != null) 'credit': credit,
      if (date != null) 'date': date,
      if (memo != null) 'memo': memo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FundBalancesCompanion copyWith({
    Value<int>? id,
    Value<int>? fundID,
    Value<String>? series,
    Value<BigInt>? debit,
    Value<BigInt>? credit,
    Value<DateTime>? date,
    Value<String?>? memo,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return FundBalancesCompanion(
      id: id ?? this.id,
      fundID: fundID ?? this.fundID,
      series: series ?? this.series,
      debit: debit ?? this.debit,
      credit: credit ?? this.credit,
      date: date ?? this.date,
      memo: memo ?? this.memo,
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
    if (fundID.present) {
      map['fund_i_d'] = Variable<int>(fundID.value);
    }
    if (series.present) {
      map['series'] = Variable<String>(series.value);
    }
    if (debit.present) {
      map['debit'] = Variable<BigInt>(debit.value);
    }
    if (credit.present) {
      map['credit'] = Variable<BigInt>(credit.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
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
    return (StringBuffer('FundBalancesCompanion(')
          ..write('id: $id, ')
          ..write('fundID: $fundID, ')
          ..write('series: $series, ')
          ..write('debit: $debit, ')
          ..write('credit: $credit, ')
          ..write('date: $date, ')
          ..write('memo: $memo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
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
  static const VerificationMeta _completeCodeMeta = const VerificationMeta(
    'completeCode',
  );
  @override
  late final GeneratedColumn<String> completeCode = GeneratedColumn<String>(
    'complete_code',
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
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountGroupIdMeta = const VerificationMeta(
    'accountGroupId',
  );
  @override
  late final GeneratedColumn<int> accountGroupId = GeneratedColumn<int>(
    'account_group_id',
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
  static const VerificationMeta _isSystemDefaultMeta = const VerificationMeta(
    'isSystemDefault',
  );
  @override
  late final GeneratedColumn<bool> isSystemDefault = GeneratedColumn<bool>(
    'is_system_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    completeCode,
    name,
    accountGroupId,
    type,
    isSystemDefault,
  ];
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
    if (data.containsKey('complete_code')) {
      context.handle(
        _completeCodeMeta,
        completeCode.isAcceptableOrUnknown(
          data['complete_code']!,
          _completeCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completeCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('account_group_id')) {
      context.handle(
        _accountGroupIdMeta,
        accountGroupId.isAcceptableOrUnknown(
          data['account_group_id']!,
          _accountGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accountGroupIdMeta);
    }
    if (data.containsKey('is_system_default')) {
      context.handle(
        _isSystemDefaultMeta,
        isSystemDefault.isAcceptableOrUnknown(
          data['is_system_default']!,
          _isSystemDefaultMeta,
        ),
      );
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
      completeCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}complete_code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      accountGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_group_id'],
      )!,
      type: $GeneralAccountsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      isSystemDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system_default'],
      )!,
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
  final String completeCode;
  final String name;
  final int accountGroupId;
  final GeneralAccountType type;
  final bool isSystemDefault;
  const GeneralAccount({
    required this.id,
    required this.code,
    required this.completeCode,
    required this.name,
    required this.accountGroupId,
    required this.type,
    required this.isSystemDefault,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['complete_code'] = Variable<String>(completeCode);
    map['name'] = Variable<String>(name);
    map['account_group_id'] = Variable<int>(accountGroupId);
    {
      map['type'] = Variable<String>(
        $GeneralAccountsTable.$convertertype.toSql(type),
      );
    }
    map['is_system_default'] = Variable<bool>(isSystemDefault);
    return map;
  }

  GeneralAccountsCompanion toCompanion(bool nullToAbsent) {
    return GeneralAccountsCompanion(
      id: Value(id),
      code: Value(code),
      completeCode: Value(completeCode),
      name: Value(name),
      accountGroupId: Value(accountGroupId),
      type: Value(type),
      isSystemDefault: Value(isSystemDefault),
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
      completeCode: serializer.fromJson<String>(json['completeCode']),
      name: serializer.fromJson<String>(json['name']),
      accountGroupId: serializer.fromJson<int>(json['accountGroupId']),
      type: $GeneralAccountsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      isSystemDefault: serializer.fromJson<bool>(json['isSystemDefault']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'completeCode': serializer.toJson<String>(completeCode),
      'name': serializer.toJson<String>(name),
      'accountGroupId': serializer.toJson<int>(accountGroupId),
      'type': serializer.toJson<String>(
        $GeneralAccountsTable.$convertertype.toJson(type),
      ),
      'isSystemDefault': serializer.toJson<bool>(isSystemDefault),
    };
  }

  GeneralAccount copyWith({
    int? id,
    String? code,
    String? completeCode,
    String? name,
    int? accountGroupId,
    GeneralAccountType? type,
    bool? isSystemDefault,
  }) => GeneralAccount(
    id: id ?? this.id,
    code: code ?? this.code,
    completeCode: completeCode ?? this.completeCode,
    name: name ?? this.name,
    accountGroupId: accountGroupId ?? this.accountGroupId,
    type: type ?? this.type,
    isSystemDefault: isSystemDefault ?? this.isSystemDefault,
  );
  GeneralAccount copyWithCompanion(GeneralAccountsCompanion data) {
    return GeneralAccount(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      completeCode: data.completeCode.present
          ? data.completeCode.value
          : this.completeCode,
      name: data.name.present ? data.name.value : this.name,
      accountGroupId: data.accountGroupId.present
          ? data.accountGroupId.value
          : this.accountGroupId,
      type: data.type.present ? data.type.value : this.type,
      isSystemDefault: data.isSystemDefault.present
          ? data.isSystemDefault.value
          : this.isSystemDefault,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GeneralAccount(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('completeCode: $completeCode, ')
          ..write('name: $name, ')
          ..write('accountGroupId: $accountGroupId, ')
          ..write('type: $type, ')
          ..write('isSystemDefault: $isSystemDefault')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    completeCode,
    name,
    accountGroupId,
    type,
    isSystemDefault,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GeneralAccount &&
          other.id == this.id &&
          other.code == this.code &&
          other.completeCode == this.completeCode &&
          other.name == this.name &&
          other.accountGroupId == this.accountGroupId &&
          other.type == this.type &&
          other.isSystemDefault == this.isSystemDefault);
}

class GeneralAccountsCompanion extends UpdateCompanion<GeneralAccount> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> completeCode;
  final Value<String> name;
  final Value<int> accountGroupId;
  final Value<GeneralAccountType> type;
  final Value<bool> isSystemDefault;
  const GeneralAccountsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.completeCode = const Value.absent(),
    this.name = const Value.absent(),
    this.accountGroupId = const Value.absent(),
    this.type = const Value.absent(),
    this.isSystemDefault = const Value.absent(),
  });
  GeneralAccountsCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String completeCode,
    required String name,
    required int accountGroupId,
    required GeneralAccountType type,
    this.isSystemDefault = const Value.absent(),
  }) : code = Value(code),
       completeCode = Value(completeCode),
       name = Value(name),
       accountGroupId = Value(accountGroupId),
       type = Value(type);
  static Insertable<GeneralAccount> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? completeCode,
    Expression<String>? name,
    Expression<int>? accountGroupId,
    Expression<String>? type,
    Expression<bool>? isSystemDefault,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (completeCode != null) 'complete_code': completeCode,
      if (name != null) 'name': name,
      if (accountGroupId != null) 'account_group_id': accountGroupId,
      if (type != null) 'type': type,
      if (isSystemDefault != null) 'is_system_default': isSystemDefault,
    });
  }

  GeneralAccountsCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? completeCode,
    Value<String>? name,
    Value<int>? accountGroupId,
    Value<GeneralAccountType>? type,
    Value<bool>? isSystemDefault,
  }) {
    return GeneralAccountsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      completeCode: completeCode ?? this.completeCode,
      name: name ?? this.name,
      accountGroupId: accountGroupId ?? this.accountGroupId,
      type: type ?? this.type,
      isSystemDefault: isSystemDefault ?? this.isSystemDefault,
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
    if (completeCode.present) {
      map['complete_code'] = Variable<String>(completeCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (accountGroupId.present) {
      map['account_group_id'] = Variable<int>(accountGroupId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $GeneralAccountsTable.$convertertype.toSql(type.value),
      );
    }
    if (isSystemDefault.present) {
      map['is_system_default'] = Variable<bool>(isSystemDefault.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GeneralAccountsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('completeCode: $completeCode, ')
          ..write('name: $name, ')
          ..write('accountGroupId: $accountGroupId, ')
          ..write('type: $type, ')
          ..write('isSystemDefault: $isSystemDefault')
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
  static const VerificationMeta _accountGroupIdMeta = const VerificationMeta(
    'accountGroupId',
  );
  @override
  late final GeneratedColumn<int> accountGroupId = GeneratedColumn<int>(
    'account_group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES account_groups (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _generalAccountIdMeta = const VerificationMeta(
    'generalAccountId',
  );
  @override
  late final GeneratedColumn<int> generalAccountId = GeneratedColumn<int>(
    'general_account_id',
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
  static const VerificationMeta _completeCodeMeta = const VerificationMeta(
    'completeCode',
  );
  @override
  late final GeneratedColumn<String> completeCode = GeneratedColumn<String>(
    'complete_code',
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
  static const VerificationMeta _isSystemDefaultMeta = const VerificationMeta(
    'isSystemDefault',
  );
  @override
  late final GeneratedColumn<bool> isSystemDefault = GeneratedColumn<bool>(
    'is_system_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountGroupId,
    generalAccountId,
    code,
    completeCode,
    name,
    type,
    isSystemDefault,
  ];
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
    if (data.containsKey('account_group_id')) {
      context.handle(
        _accountGroupIdMeta,
        accountGroupId.isAcceptableOrUnknown(
          data['account_group_id']!,
          _accountGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accountGroupIdMeta);
    }
    if (data.containsKey('general_account_id')) {
      context.handle(
        _generalAccountIdMeta,
        generalAccountId.isAcceptableOrUnknown(
          data['general_account_id']!,
          _generalAccountIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generalAccountIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('complete_code')) {
      context.handle(
        _completeCodeMeta,
        completeCode.isAcceptableOrUnknown(
          data['complete_code']!,
          _completeCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completeCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_system_default')) {
      context.handle(
        _isSystemDefaultMeta,
        isSystemDefault.isAcceptableOrUnknown(
          data['is_system_default']!,
          _isSystemDefaultMeta,
        ),
      );
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
      accountGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_group_id'],
      )!,
      generalAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}general_account_id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      completeCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}complete_code'],
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
      isSystemDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system_default'],
      )!,
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
  final int accountGroupId;
  final int generalAccountId;
  final String code;
  final String completeCode;
  final String name;
  final SubsidiaryAccountType type;
  final bool isSystemDefault;
  const SubsidiaryAccount({
    required this.id,
    required this.accountGroupId,
    required this.generalAccountId,
    required this.code,
    required this.completeCode,
    required this.name,
    required this.type,
    required this.isSystemDefault,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_group_id'] = Variable<int>(accountGroupId);
    map['general_account_id'] = Variable<int>(generalAccountId);
    map['code'] = Variable<String>(code);
    map['complete_code'] = Variable<String>(completeCode);
    map['name'] = Variable<String>(name);
    {
      map['type'] = Variable<String>(
        $SubsidiaryAccountsTable.$convertertype.toSql(type),
      );
    }
    map['is_system_default'] = Variable<bool>(isSystemDefault);
    return map;
  }

  SubsidiaryAccountsCompanion toCompanion(bool nullToAbsent) {
    return SubsidiaryAccountsCompanion(
      id: Value(id),
      accountGroupId: Value(accountGroupId),
      generalAccountId: Value(generalAccountId),
      code: Value(code),
      completeCode: Value(completeCode),
      name: Value(name),
      type: Value(type),
      isSystemDefault: Value(isSystemDefault),
    );
  }

  factory SubsidiaryAccount.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubsidiaryAccount(
      id: serializer.fromJson<int>(json['id']),
      accountGroupId: serializer.fromJson<int>(json['accountGroupId']),
      generalAccountId: serializer.fromJson<int>(json['generalAccountId']),
      code: serializer.fromJson<String>(json['code']),
      completeCode: serializer.fromJson<String>(json['completeCode']),
      name: serializer.fromJson<String>(json['name']),
      type: $SubsidiaryAccountsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      isSystemDefault: serializer.fromJson<bool>(json['isSystemDefault']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountGroupId': serializer.toJson<int>(accountGroupId),
      'generalAccountId': serializer.toJson<int>(generalAccountId),
      'code': serializer.toJson<String>(code),
      'completeCode': serializer.toJson<String>(completeCode),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(
        $SubsidiaryAccountsTable.$convertertype.toJson(type),
      ),
      'isSystemDefault': serializer.toJson<bool>(isSystemDefault),
    };
  }

  SubsidiaryAccount copyWith({
    int? id,
    int? accountGroupId,
    int? generalAccountId,
    String? code,
    String? completeCode,
    String? name,
    SubsidiaryAccountType? type,
    bool? isSystemDefault,
  }) => SubsidiaryAccount(
    id: id ?? this.id,
    accountGroupId: accountGroupId ?? this.accountGroupId,
    generalAccountId: generalAccountId ?? this.generalAccountId,
    code: code ?? this.code,
    completeCode: completeCode ?? this.completeCode,
    name: name ?? this.name,
    type: type ?? this.type,
    isSystemDefault: isSystemDefault ?? this.isSystemDefault,
  );
  SubsidiaryAccount copyWithCompanion(SubsidiaryAccountsCompanion data) {
    return SubsidiaryAccount(
      id: data.id.present ? data.id.value : this.id,
      accountGroupId: data.accountGroupId.present
          ? data.accountGroupId.value
          : this.accountGroupId,
      generalAccountId: data.generalAccountId.present
          ? data.generalAccountId.value
          : this.generalAccountId,
      code: data.code.present ? data.code.value : this.code,
      completeCode: data.completeCode.present
          ? data.completeCode.value
          : this.completeCode,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      isSystemDefault: data.isSystemDefault.present
          ? data.isSystemDefault.value
          : this.isSystemDefault,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubsidiaryAccount(')
          ..write('id: $id, ')
          ..write('accountGroupId: $accountGroupId, ')
          ..write('generalAccountId: $generalAccountId, ')
          ..write('code: $code, ')
          ..write('completeCode: $completeCode, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('isSystemDefault: $isSystemDefault')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountGroupId,
    generalAccountId,
    code,
    completeCode,
    name,
    type,
    isSystemDefault,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubsidiaryAccount &&
          other.id == this.id &&
          other.accountGroupId == this.accountGroupId &&
          other.generalAccountId == this.generalAccountId &&
          other.code == this.code &&
          other.completeCode == this.completeCode &&
          other.name == this.name &&
          other.type == this.type &&
          other.isSystemDefault == this.isSystemDefault);
}

class SubsidiaryAccountsCompanion extends UpdateCompanion<SubsidiaryAccount> {
  final Value<int> id;
  final Value<int> accountGroupId;
  final Value<int> generalAccountId;
  final Value<String> code;
  final Value<String> completeCode;
  final Value<String> name;
  final Value<SubsidiaryAccountType> type;
  final Value<bool> isSystemDefault;
  const SubsidiaryAccountsCompanion({
    this.id = const Value.absent(),
    this.accountGroupId = const Value.absent(),
    this.generalAccountId = const Value.absent(),
    this.code = const Value.absent(),
    this.completeCode = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.isSystemDefault = const Value.absent(),
  });
  SubsidiaryAccountsCompanion.insert({
    this.id = const Value.absent(),
    required int accountGroupId,
    required int generalAccountId,
    required String code,
    required String completeCode,
    required String name,
    required SubsidiaryAccountType type,
    this.isSystemDefault = const Value.absent(),
  }) : accountGroupId = Value(accountGroupId),
       generalAccountId = Value(generalAccountId),
       code = Value(code),
       completeCode = Value(completeCode),
       name = Value(name),
       type = Value(type);
  static Insertable<SubsidiaryAccount> custom({
    Expression<int>? id,
    Expression<int>? accountGroupId,
    Expression<int>? generalAccountId,
    Expression<String>? code,
    Expression<String>? completeCode,
    Expression<String>? name,
    Expression<String>? type,
    Expression<bool>? isSystemDefault,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountGroupId != null) 'account_group_id': accountGroupId,
      if (generalAccountId != null) 'general_account_id': generalAccountId,
      if (code != null) 'code': code,
      if (completeCode != null) 'complete_code': completeCode,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (isSystemDefault != null) 'is_system_default': isSystemDefault,
    });
  }

  SubsidiaryAccountsCompanion copyWith({
    Value<int>? id,
    Value<int>? accountGroupId,
    Value<int>? generalAccountId,
    Value<String>? code,
    Value<String>? completeCode,
    Value<String>? name,
    Value<SubsidiaryAccountType>? type,
    Value<bool>? isSystemDefault,
  }) {
    return SubsidiaryAccountsCompanion(
      id: id ?? this.id,
      accountGroupId: accountGroupId ?? this.accountGroupId,
      generalAccountId: generalAccountId ?? this.generalAccountId,
      code: code ?? this.code,
      completeCode: completeCode ?? this.completeCode,
      name: name ?? this.name,
      type: type ?? this.type,
      isSystemDefault: isSystemDefault ?? this.isSystemDefault,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountGroupId.present) {
      map['account_group_id'] = Variable<int>(accountGroupId.value);
    }
    if (generalAccountId.present) {
      map['general_account_id'] = Variable<int>(generalAccountId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (completeCode.present) {
      map['complete_code'] = Variable<String>(completeCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $SubsidiaryAccountsTable.$convertertype.toSql(type.value),
      );
    }
    if (isSystemDefault.present) {
      map['is_system_default'] = Variable<bool>(isSystemDefault.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubsidiaryAccountsCompanion(')
          ..write('id: $id, ')
          ..write('accountGroupId: $accountGroupId, ')
          ..write('generalAccountId: $generalAccountId, ')
          ..write('code: $code, ')
          ..write('completeCode: $completeCode, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('isSystemDefault: $isSystemDefault')
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
  static const VerificationMeta _firstDetailedIdMeta = const VerificationMeta(
    'firstDetailedId',
  );
  @override
  late final GeneratedColumn<int> firstDetailedId = GeneratedColumn<int>(
    'first_detailed_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES detailed_accounts (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _secondDetailedIdMeta = const VerificationMeta(
    'secondDetailedId',
  );
  @override
  late final GeneratedColumn<int> secondDetailedId = GeneratedColumn<int>(
    'second_detailed_id',
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
  static const VerificationMeta _noticeMemoMeta = const VerificationMeta(
    'noticeMemo',
  );
  @override
  late final GeneratedColumn<String> noticeMemo = GeneratedColumn<String>(
    'notice_memo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _hasSourceMeta = const VerificationMeta(
    'hasSource',
  );
  @override
  late final GeneratedColumn<bool> hasSource = GeneratedColumn<bool>(
    'has_source',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_source" IN (0, 1))',
    ),
    defaultValue: Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    headerId,
    subsidiaryId,
    firstDetailedId,
    secondDetailedId,
    debit,
    credit,
    series,
    memo,
    noticeMemo,
    date,
    hasSource,
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
    if (data.containsKey('first_detailed_id')) {
      context.handle(
        _firstDetailedIdMeta,
        firstDetailedId.isAcceptableOrUnknown(
          data['first_detailed_id']!,
          _firstDetailedIdMeta,
        ),
      );
    }
    if (data.containsKey('second_detailed_id')) {
      context.handle(
        _secondDetailedIdMeta,
        secondDetailedId.isAcceptableOrUnknown(
          data['second_detailed_id']!,
          _secondDetailedIdMeta,
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
    if (data.containsKey('notice_memo')) {
      context.handle(
        _noticeMemoMeta,
        noticeMemo.isAcceptableOrUnknown(data['notice_memo']!, _noticeMemoMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('has_source')) {
      context.handle(
        _hasSourceMeta,
        hasSource.isAcceptableOrUnknown(data['has_source']!, _hasSourceMeta),
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
      firstDetailedId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}first_detailed_id'],
      ),
      secondDetailedId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}second_detailed_id'],
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
      noticeMemo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notice_memo'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      hasSource: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_source'],
      )!,
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
  final int? firstDetailedId;
  final int? secondDetailedId;
  final BigInt debit;
  final BigInt credit;
  final String series;
  final String? memo;
  final String? noticeMemo;
  final DateTime date;
  final bool hasSource;
  const JournalLine({
    required this.id,
    required this.headerId,
    required this.subsidiaryId,
    this.firstDetailedId,
    this.secondDetailedId,
    required this.debit,
    required this.credit,
    required this.series,
    this.memo,
    this.noticeMemo,
    required this.date,
    required this.hasSource,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['header_id'] = Variable<int>(headerId);
    map['subsidiary_id'] = Variable<int>(subsidiaryId);
    if (!nullToAbsent || firstDetailedId != null) {
      map['first_detailed_id'] = Variable<int>(firstDetailedId);
    }
    if (!nullToAbsent || secondDetailedId != null) {
      map['second_detailed_id'] = Variable<int>(secondDetailedId);
    }
    map['debit'] = Variable<BigInt>(debit);
    map['credit'] = Variable<BigInt>(credit);
    map['series'] = Variable<String>(series);
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    if (!nullToAbsent || noticeMemo != null) {
      map['notice_memo'] = Variable<String>(noticeMemo);
    }
    map['date'] = Variable<DateTime>(date);
    map['has_source'] = Variable<bool>(hasSource);
    return map;
  }

  JournalLinesCompanion toCompanion(bool nullToAbsent) {
    return JournalLinesCompanion(
      id: Value(id),
      headerId: Value(headerId),
      subsidiaryId: Value(subsidiaryId),
      firstDetailedId: firstDetailedId == null && nullToAbsent
          ? const Value.absent()
          : Value(firstDetailedId),
      secondDetailedId: secondDetailedId == null && nullToAbsent
          ? const Value.absent()
          : Value(secondDetailedId),
      debit: Value(debit),
      credit: Value(credit),
      series: Value(series),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      noticeMemo: noticeMemo == null && nullToAbsent
          ? const Value.absent()
          : Value(noticeMemo),
      date: Value(date),
      hasSource: Value(hasSource),
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
      firstDetailedId: serializer.fromJson<int?>(json['firstDetailedId']),
      secondDetailedId: serializer.fromJson<int?>(json['secondDetailedId']),
      debit: serializer.fromJson<BigInt>(json['debit']),
      credit: serializer.fromJson<BigInt>(json['credit']),
      series: serializer.fromJson<String>(json['series']),
      memo: serializer.fromJson<String?>(json['memo']),
      noticeMemo: serializer.fromJson<String?>(json['noticeMemo']),
      date: serializer.fromJson<DateTime>(json['date']),
      hasSource: serializer.fromJson<bool>(json['hasSource']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'headerId': serializer.toJson<int>(headerId),
      'subsidiaryId': serializer.toJson<int>(subsidiaryId),
      'firstDetailedId': serializer.toJson<int?>(firstDetailedId),
      'secondDetailedId': serializer.toJson<int?>(secondDetailedId),
      'debit': serializer.toJson<BigInt>(debit),
      'credit': serializer.toJson<BigInt>(credit),
      'series': serializer.toJson<String>(series),
      'memo': serializer.toJson<String?>(memo),
      'noticeMemo': serializer.toJson<String?>(noticeMemo),
      'date': serializer.toJson<DateTime>(date),
      'hasSource': serializer.toJson<bool>(hasSource),
    };
  }

  JournalLine copyWith({
    int? id,
    int? headerId,
    int? subsidiaryId,
    Value<int?> firstDetailedId = const Value.absent(),
    Value<int?> secondDetailedId = const Value.absent(),
    BigInt? debit,
    BigInt? credit,
    String? series,
    Value<String?> memo = const Value.absent(),
    Value<String?> noticeMemo = const Value.absent(),
    DateTime? date,
    bool? hasSource,
  }) => JournalLine(
    id: id ?? this.id,
    headerId: headerId ?? this.headerId,
    subsidiaryId: subsidiaryId ?? this.subsidiaryId,
    firstDetailedId: firstDetailedId.present
        ? firstDetailedId.value
        : this.firstDetailedId,
    secondDetailedId: secondDetailedId.present
        ? secondDetailedId.value
        : this.secondDetailedId,
    debit: debit ?? this.debit,
    credit: credit ?? this.credit,
    series: series ?? this.series,
    memo: memo.present ? memo.value : this.memo,
    noticeMemo: noticeMemo.present ? noticeMemo.value : this.noticeMemo,
    date: date ?? this.date,
    hasSource: hasSource ?? this.hasSource,
  );
  JournalLine copyWithCompanion(JournalLinesCompanion data) {
    return JournalLine(
      id: data.id.present ? data.id.value : this.id,
      headerId: data.headerId.present ? data.headerId.value : this.headerId,
      subsidiaryId: data.subsidiaryId.present
          ? data.subsidiaryId.value
          : this.subsidiaryId,
      firstDetailedId: data.firstDetailedId.present
          ? data.firstDetailedId.value
          : this.firstDetailedId,
      secondDetailedId: data.secondDetailedId.present
          ? data.secondDetailedId.value
          : this.secondDetailedId,
      debit: data.debit.present ? data.debit.value : this.debit,
      credit: data.credit.present ? data.credit.value : this.credit,
      series: data.series.present ? data.series.value : this.series,
      memo: data.memo.present ? data.memo.value : this.memo,
      noticeMemo: data.noticeMemo.present
          ? data.noticeMemo.value
          : this.noticeMemo,
      date: data.date.present ? data.date.value : this.date,
      hasSource: data.hasSource.present ? data.hasSource.value : this.hasSource,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalLine(')
          ..write('id: $id, ')
          ..write('headerId: $headerId, ')
          ..write('subsidiaryId: $subsidiaryId, ')
          ..write('firstDetailedId: $firstDetailedId, ')
          ..write('secondDetailedId: $secondDetailedId, ')
          ..write('debit: $debit, ')
          ..write('credit: $credit, ')
          ..write('series: $series, ')
          ..write('memo: $memo, ')
          ..write('noticeMemo: $noticeMemo, ')
          ..write('date: $date, ')
          ..write('hasSource: $hasSource')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    headerId,
    subsidiaryId,
    firstDetailedId,
    secondDetailedId,
    debit,
    credit,
    series,
    memo,
    noticeMemo,
    date,
    hasSource,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalLine &&
          other.id == this.id &&
          other.headerId == this.headerId &&
          other.subsidiaryId == this.subsidiaryId &&
          other.firstDetailedId == this.firstDetailedId &&
          other.secondDetailedId == this.secondDetailedId &&
          other.debit == this.debit &&
          other.credit == this.credit &&
          other.series == this.series &&
          other.memo == this.memo &&
          other.noticeMemo == this.noticeMemo &&
          other.date == this.date &&
          other.hasSource == this.hasSource);
}

class JournalLinesCompanion extends UpdateCompanion<JournalLine> {
  final Value<int> id;
  final Value<int> headerId;
  final Value<int> subsidiaryId;
  final Value<int?> firstDetailedId;
  final Value<int?> secondDetailedId;
  final Value<BigInt> debit;
  final Value<BigInt> credit;
  final Value<String> series;
  final Value<String?> memo;
  final Value<String?> noticeMemo;
  final Value<DateTime> date;
  final Value<bool> hasSource;
  const JournalLinesCompanion({
    this.id = const Value.absent(),
    this.headerId = const Value.absent(),
    this.subsidiaryId = const Value.absent(),
    this.firstDetailedId = const Value.absent(),
    this.secondDetailedId = const Value.absent(),
    this.debit = const Value.absent(),
    this.credit = const Value.absent(),
    this.series = const Value.absent(),
    this.memo = const Value.absent(),
    this.noticeMemo = const Value.absent(),
    this.date = const Value.absent(),
    this.hasSource = const Value.absent(),
  });
  JournalLinesCompanion.insert({
    this.id = const Value.absent(),
    required int headerId,
    required int subsidiaryId,
    this.firstDetailedId = const Value.absent(),
    this.secondDetailedId = const Value.absent(),
    required BigInt debit,
    required BigInt credit,
    required String series,
    this.memo = const Value.absent(),
    this.noticeMemo = const Value.absent(),
    this.date = const Value.absent(),
    this.hasSource = const Value.absent(),
  }) : headerId = Value(headerId),
       subsidiaryId = Value(subsidiaryId),
       debit = Value(debit),
       credit = Value(credit),
       series = Value(series);
  static Insertable<JournalLine> custom({
    Expression<int>? id,
    Expression<int>? headerId,
    Expression<int>? subsidiaryId,
    Expression<int>? firstDetailedId,
    Expression<int>? secondDetailedId,
    Expression<BigInt>? debit,
    Expression<BigInt>? credit,
    Expression<String>? series,
    Expression<String>? memo,
    Expression<String>? noticeMemo,
    Expression<DateTime>? date,
    Expression<bool>? hasSource,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (headerId != null) 'header_id': headerId,
      if (subsidiaryId != null) 'subsidiary_id': subsidiaryId,
      if (firstDetailedId != null) 'first_detailed_id': firstDetailedId,
      if (secondDetailedId != null) 'second_detailed_id': secondDetailedId,
      if (debit != null) 'debit': debit,
      if (credit != null) 'credit': credit,
      if (series != null) 'series': series,
      if (memo != null) 'memo': memo,
      if (noticeMemo != null) 'notice_memo': noticeMemo,
      if (date != null) 'date': date,
      if (hasSource != null) 'has_source': hasSource,
    });
  }

  JournalLinesCompanion copyWith({
    Value<int>? id,
    Value<int>? headerId,
    Value<int>? subsidiaryId,
    Value<int?>? firstDetailedId,
    Value<int?>? secondDetailedId,
    Value<BigInt>? debit,
    Value<BigInt>? credit,
    Value<String>? series,
    Value<String?>? memo,
    Value<String?>? noticeMemo,
    Value<DateTime>? date,
    Value<bool>? hasSource,
  }) {
    return JournalLinesCompanion(
      id: id ?? this.id,
      headerId: headerId ?? this.headerId,
      subsidiaryId: subsidiaryId ?? this.subsidiaryId,
      firstDetailedId: firstDetailedId ?? this.firstDetailedId,
      secondDetailedId: secondDetailedId ?? this.secondDetailedId,
      debit: debit ?? this.debit,
      credit: credit ?? this.credit,
      series: series ?? this.series,
      memo: memo ?? this.memo,
      noticeMemo: noticeMemo ?? this.noticeMemo,
      date: date ?? this.date,
      hasSource: hasSource ?? this.hasSource,
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
    if (firstDetailedId.present) {
      map['first_detailed_id'] = Variable<int>(firstDetailedId.value);
    }
    if (secondDetailedId.present) {
      map['second_detailed_id'] = Variable<int>(secondDetailedId.value);
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
    if (noticeMemo.present) {
      map['notice_memo'] = Variable<String>(noticeMemo.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (hasSource.present) {
      map['has_source'] = Variable<bool>(hasSource.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalLinesCompanion(')
          ..write('id: $id, ')
          ..write('headerId: $headerId, ')
          ..write('subsidiaryId: $subsidiaryId, ')
          ..write('firstDetailedId: $firstDetailedId, ')
          ..write('secondDetailedId: $secondDetailedId, ')
          ..write('debit: $debit, ')
          ..write('credit: $credit, ')
          ..write('series: $series, ')
          ..write('memo: $memo, ')
          ..write('noticeMemo: $noticeMemo, ')
          ..write('date: $date, ')
          ..write('hasSource: $hasSource')
          ..write(')'))
        .toString();
  }
}

class $MemberAllocationsTable extends MemberAllocations
    with TableInfo<$MemberAllocationsTable, MemberAllocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemberAllocationsTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'member_allocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemberAllocation> instance, {
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
  MemberAllocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemberAllocation(
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
  $MemberAllocationsTable createAlias(String alias) {
    return $MemberAllocationsTable(attachedDatabase, alias);
  }
}

class MemberAllocation extends DataClass
    implements Insertable<MemberAllocation> {
  final int id;
  final int userID;
  final int eventID;
  final double sharePercentage;
  final DateTime createAt;
  const MemberAllocation({
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

  MemberAllocationsCompanion toCompanion(bool nullToAbsent) {
    return MemberAllocationsCompanion(
      id: Value(id),
      userID: Value(userID),
      eventID: Value(eventID),
      sharePercentage: Value(sharePercentage),
      createAt: Value(createAt),
    );
  }

  factory MemberAllocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemberAllocation(
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

  MemberAllocation copyWith({
    int? id,
    int? userID,
    int? eventID,
    double? sharePercentage,
    DateTime? createAt,
  }) => MemberAllocation(
    id: id ?? this.id,
    userID: userID ?? this.userID,
    eventID: eventID ?? this.eventID,
    sharePercentage: sharePercentage ?? this.sharePercentage,
    createAt: createAt ?? this.createAt,
  );
  MemberAllocation copyWithCompanion(MemberAllocationsCompanion data) {
    return MemberAllocation(
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
    return (StringBuffer('MemberAllocation(')
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
      (other is MemberAllocation &&
          other.id == this.id &&
          other.userID == this.userID &&
          other.eventID == this.eventID &&
          other.sharePercentage == this.sharePercentage &&
          other.createAt == this.createAt);
}

class MemberAllocationsCompanion extends UpdateCompanion<MemberAllocation> {
  final Value<int> id;
  final Value<int> userID;
  final Value<int> eventID;
  final Value<double> sharePercentage;
  final Value<DateTime> createAt;
  const MemberAllocationsCompanion({
    this.id = const Value.absent(),
    this.userID = const Value.absent(),
    this.eventID = const Value.absent(),
    this.sharePercentage = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  MemberAllocationsCompanion.insert({
    this.id = const Value.absent(),
    required int userID,
    required int eventID,
    required double sharePercentage,
    this.createAt = const Value.absent(),
  }) : userID = Value(userID),
       eventID = Value(eventID),
       sharePercentage = Value(sharePercentage);
  static Insertable<MemberAllocation> custom({
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

  MemberAllocationsCompanion copyWith({
    Value<int>? id,
    Value<int>? userID,
    Value<int>? eventID,
    Value<double>? sharePercentage,
    Value<DateTime>? createAt,
  }) {
    return MemberAllocationsCompanion(
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
    return (StringBuffer('MemberAllocationsCompanion(')
          ..write('id: $id, ')
          ..write('userID: $userID, ')
          ..write('eventID: $eventID, ')
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

class $TeamFundsTable extends TeamFunds
    with TableInfo<$TeamFundsTable, TeamFund> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamFundsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fundIDMeta = const VerificationMeta('fundID');
  @override
  late final GeneratedColumn<int> fundID = GeneratedColumn<int>(
    'fund_i_d',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES funds (id) ON DELETE CASCADE',
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
    fundID,
    teamID,
    sharePercentage,
    createAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'team_funds';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeamFund> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fund_i_d')) {
      context.handle(
        _fundIDMeta,
        fundID.isAcceptableOrUnknown(data['fund_i_d']!, _fundIDMeta),
      );
    } else if (isInserting) {
      context.missing(_fundIDMeta);
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
  TeamFund map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamFund(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fundID: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fund_i_d'],
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
  $TeamFundsTable createAlias(String alias) {
    return $TeamFundsTable(attachedDatabase, alias);
  }
}

class TeamFund extends DataClass implements Insertable<TeamFund> {
  final int id;
  final int fundID;
  final int teamID;
  final double sharePercentage;
  final DateTime createAt;
  const TeamFund({
    required this.id,
    required this.fundID,
    required this.teamID,
    required this.sharePercentage,
    required this.createAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fund_i_d'] = Variable<int>(fundID);
    map['team_i_d'] = Variable<int>(teamID);
    map['share_percentage'] = Variable<double>(sharePercentage);
    map['create_at'] = Variable<DateTime>(createAt);
    return map;
  }

  TeamFundsCompanion toCompanion(bool nullToAbsent) {
    return TeamFundsCompanion(
      id: Value(id),
      fundID: Value(fundID),
      teamID: Value(teamID),
      sharePercentage: Value(sharePercentage),
      createAt: Value(createAt),
    );
  }

  factory TeamFund.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamFund(
      id: serializer.fromJson<int>(json['id']),
      fundID: serializer.fromJson<int>(json['fundID']),
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
      'fundID': serializer.toJson<int>(fundID),
      'teamID': serializer.toJson<int>(teamID),
      'sharePercentage': serializer.toJson<double>(sharePercentage),
      'createAt': serializer.toJson<DateTime>(createAt),
    };
  }

  TeamFund copyWith({
    int? id,
    int? fundID,
    int? teamID,
    double? sharePercentage,
    DateTime? createAt,
  }) => TeamFund(
    id: id ?? this.id,
    fundID: fundID ?? this.fundID,
    teamID: teamID ?? this.teamID,
    sharePercentage: sharePercentage ?? this.sharePercentage,
    createAt: createAt ?? this.createAt,
  );
  TeamFund copyWithCompanion(TeamFundsCompanion data) {
    return TeamFund(
      id: data.id.present ? data.id.value : this.id,
      fundID: data.fundID.present ? data.fundID.value : this.fundID,
      teamID: data.teamID.present ? data.teamID.value : this.teamID,
      sharePercentage: data.sharePercentage.present
          ? data.sharePercentage.value
          : this.sharePercentage,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamFund(')
          ..write('id: $id, ')
          ..write('fundID: $fundID, ')
          ..write('teamID: $teamID, ')
          ..write('sharePercentage: $sharePercentage, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, fundID, teamID, sharePercentage, createAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamFund &&
          other.id == this.id &&
          other.fundID == this.fundID &&
          other.teamID == this.teamID &&
          other.sharePercentage == this.sharePercentage &&
          other.createAt == this.createAt);
}

class TeamFundsCompanion extends UpdateCompanion<TeamFund> {
  final Value<int> id;
  final Value<int> fundID;
  final Value<int> teamID;
  final Value<double> sharePercentage;
  final Value<DateTime> createAt;
  const TeamFundsCompanion({
    this.id = const Value.absent(),
    this.fundID = const Value.absent(),
    this.teamID = const Value.absent(),
    this.sharePercentage = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  TeamFundsCompanion.insert({
    this.id = const Value.absent(),
    required int fundID,
    required int teamID,
    required double sharePercentage,
    this.createAt = const Value.absent(),
  }) : fundID = Value(fundID),
       teamID = Value(teamID),
       sharePercentage = Value(sharePercentage);
  static Insertable<TeamFund> custom({
    Expression<int>? id,
    Expression<int>? fundID,
    Expression<int>? teamID,
    Expression<double>? sharePercentage,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fundID != null) 'fund_i_d': fundID,
      if (teamID != null) 'team_i_d': teamID,
      if (sharePercentage != null) 'share_percentage': sharePercentage,
      if (createAt != null) 'create_at': createAt,
    });
  }

  TeamFundsCompanion copyWith({
    Value<int>? id,
    Value<int>? fundID,
    Value<int>? teamID,
    Value<double>? sharePercentage,
    Value<DateTime>? createAt,
  }) {
    return TeamFundsCompanion(
      id: id ?? this.id,
      fundID: fundID ?? this.fundID,
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
    if (fundID.present) {
      map['fund_i_d'] = Variable<int>(fundID.value);
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
    return (StringBuffer('TeamFundsCompanion(')
          ..write('id: $id, ')
          ..write('fundID: $fundID, ')
          ..write('teamID: $teamID, ')
          ..write('sharePercentage: $sharePercentage, ')
          ..write('createAt: $createAt')
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountGroupsTable accountGroups = $AccountGroupsTable(this);
  late final $BanksTable banks = $BanksTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $TeamsTable teams = $TeamsTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $DetailedAccountsTable detailedAccounts = $DetailedAccountsTable(
    this,
  );
  late final $EventOrdersTable eventOrders = $EventOrdersTable(this);
  late final $FundsTable funds = $FundsTable(this);
  late final $EventRegistrationsTable eventRegistrations =
      $EventRegistrationsTable(this);
  late final $FundAllocationsTable fundAllocations = $FundAllocationsTable(
    this,
  );
  late final $FundBalancesTable fundBalances = $FundBalancesTable(this);
  late final $GeneralAccountsTable generalAccounts = $GeneralAccountsTable(
    this,
  );
  late final $JournalHeadersTable journalHeaders = $JournalHeadersTable(this);
  late final $SubsidiaryAccountsTable subsidiaryAccounts =
      $SubsidiaryAccountsTable(this);
  late final $JournalLinesTable journalLines = $JournalLinesTable(this);
  late final $MemberAllocationsTable memberAllocations =
      $MemberAllocationsTable(this);
  late final $MenuItemsTable menuItems = $MenuItemsTable(this);
  late final $TeamFundsTable teamFunds = $TeamFundsTable(this);
  late final $TeamMembersTable teamMembers = $TeamMembersTable(this);
  late final AccountsChartDao accountsChartDao = AccountsChartDao(
    this as AppDatabase,
  );
  late final BanksDao banksDao = BanksDao(this as AppDatabase);
  late final DetailedAccountsDao detailedAccountsDao = DetailedAccountsDao(
    this as AppDatabase,
  );
  late final EventOrdersDao eventOrdersDao = EventOrdersDao(
    this as AppDatabase,
  );
  late final EventRegistrationsDao eventRegistrationsDao =
      EventRegistrationsDao(this as AppDatabase);
  late final EventsDao eventsDao = EventsDao(this as AppDatabase);
  late final FundAllocationsDao fundAllocationsDao = FundAllocationsDao(
    this as AppDatabase,
  );
  late final FundBalancesDao fundBalancesDao = FundBalancesDao(
    this as AppDatabase,
  );
  late final FundsDao fundsDao = FundsDao(this as AppDatabase);
  late final JournalsDao journalsDao = JournalsDao(this as AppDatabase);
  late final MemberAllocationsDao memberAllocationsDao = MemberAllocationsDao(
    this as AppDatabase,
  );
  late final MenuItemsDao menuItemsDao = MenuItemsDao(this as AppDatabase);
  late final SubsidiaryAccountsDao subsidiaryAccountsDao =
      SubsidiaryAccountsDao(this as AppDatabase);
  late final TeamFundsDao teamFundsDao = TeamFundsDao(this as AppDatabase);
  late final TeamMembersDao teamMembersDao = TeamMembersDao(
    this as AppDatabase,
  );
  late final TeamsDao teamsDao = TeamsDao(this as AppDatabase);
  late final UsersDao usersDao = UsersDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accountGroups,
    banks,
    users,
    teams,
    events,
    detailedAccounts,
    eventOrders,
    funds,
    eventRegistrations,
    fundAllocations,
    fundBalances,
    generalAccounts,
    journalHeaders,
    subsidiaryAccounts,
    journalLines,
    memberAllocations,
    menuItems,
    teamFunds,
    teamMembers,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'teams',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('events', kind: UpdateKind.delete)],
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
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'funds',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fund_balances', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'account_groups',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('general_accounts', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'account_groups',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('subsidiary_accounts', kind: UpdateKind.update)],
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
        'funds',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('team_funds', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'teams',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('team_funds', kind: UpdateKind.delete)],
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
  ]);
}

typedef $$AccountGroupsTableCreateCompanionBuilder =
    AccountGroupsCompanion Function({
      Value<int> id,
      required String code,
      required String name,
      required AccountGroupType type,
      Value<bool> isSystemDefault,
    });
typedef $$AccountGroupsTableUpdateCompanionBuilder =
    AccountGroupsCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> name,
      Value<AccountGroupType> type,
      Value<bool> isSystemDefault,
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
    aliasName: 'account_groups__id__general_accounts__account_group_id',
  );

  $$GeneralAccountsTableProcessedTableManager get generalAccountsRefs {
    final manager = $$GeneralAccountsTableTableManager(
      $_db,
      $_db.generalAccounts,
    ).filter((f) => f.accountGroupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _generalAccountsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SubsidiaryAccountsTable, List<SubsidiaryAccount>>
  _subsidiaryAccountsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.subsidiaryAccounts,
        aliasName: 'account_groups__id__subsidiary_accounts__account_group_id',
      );

  $$SubsidiaryAccountsTableProcessedTableManager get subsidiaryAccountsRefs {
    final manager = $$SubsidiaryAccountsTableTableManager(
      $_db,
      $_db.subsidiaryAccounts,
    ).filter((f) => f.accountGroupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _subsidiaryAccountsRefsTable($_db),
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

  ColumnFilters<bool> get isSystemDefault => $composableBuilder(
    column: $table.isSystemDefault,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> generalAccountsRefs(
    Expression<bool> Function($$GeneralAccountsTableFilterComposer f) f,
  ) {
    final $$GeneralAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.generalAccounts,
      getReferencedColumn: (t) => t.accountGroupId,
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

  Expression<bool> subsidiaryAccountsRefs(
    Expression<bool> Function($$SubsidiaryAccountsTableFilterComposer f) f,
  ) {
    final $$SubsidiaryAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subsidiaryAccounts,
      getReferencedColumn: (t) => t.accountGroupId,
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

  ColumnOrderings<bool> get isSystemDefault => $composableBuilder(
    column: $table.isSystemDefault,
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

  GeneratedColumn<bool> get isSystemDefault => $composableBuilder(
    column: $table.isSystemDefault,
    builder: (column) => column,
  );

  Expression<T> generalAccountsRefs<T extends Object>(
    Expression<T> Function($$GeneralAccountsTableAnnotationComposer a) f,
  ) {
    final $$GeneralAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.generalAccounts,
      getReferencedColumn: (t) => t.accountGroupId,
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

  Expression<T> subsidiaryAccountsRefs<T extends Object>(
    Expression<T> Function($$SubsidiaryAccountsTableAnnotationComposer a) f,
  ) {
    final $$SubsidiaryAccountsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.subsidiaryAccounts,
          getReferencedColumn: (t) => t.accountGroupId,
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
          PrefetchHooks Function({
            bool generalAccountsRefs,
            bool subsidiaryAccountsRefs,
          })
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
                Value<bool> isSystemDefault = const Value.absent(),
              }) => AccountGroupsCompanion(
                id: id,
                code: code,
                name: name,
                type: type,
                isSystemDefault: isSystemDefault,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String name,
                required AccountGroupType type,
                Value<bool> isSystemDefault = const Value.absent(),
              }) => AccountGroupsCompanion.insert(
                id: id,
                code: code,
                name: name,
                type: type,
                isSystemDefault: isSystemDefault,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AccountGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({generalAccountsRefs = false, subsidiaryAccountsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (generalAccountsRefs) db.generalAccounts,
                    if (subsidiaryAccountsRefs) db.subsidiaryAccounts,
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
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountGroupId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (subsidiaryAccountsRefs)
                        await $_getPrefetchedData<
                          AccountGroup,
                          $AccountGroupsTable,
                          SubsidiaryAccount
                        >(
                          currentTable: table,
                          referencedTable: $$AccountGroupsTableReferences
                              ._subsidiaryAccountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountGroupsTableReferences(
                                db,
                                table,
                                p0,
                              ).subsidiaryAccountsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountGroupId == item.id,
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
      PrefetchHooks Function({
        bool generalAccountsRefs,
        bool subsidiaryAccountsRefs,
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

  static MultiTypedResultKey<$EventsTable, List<Event>> _eventsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.events,
    aliasName: 'users__id__events__user_i_d',
  );

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.userID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

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

  static MultiTypedResultKey<$EventRegistrationsTable, List<EventRegistration>>
  _userIDTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventRegistrations,
    aliasName: 'users__id__event_registrations__user_i_d',
  );

  $$EventRegistrationsTableProcessedTableManager get userID {
    final manager = $$EventRegistrationsTableTableManager(
      $_db,
      $_db.eventRegistrations,
    ).filter((f) => f.userID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userIDTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventRegistrationsTable, List<EventRegistration>>
  _snacksAssignmentUserIDTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.eventRegistrations,
        aliasName: 'users__id__event_registrations__snacks_assignment_user_i_d',
      );

  $$EventRegistrationsTableProcessedTableManager get snacksAssignmentUserID {
    final manager =
        $$EventRegistrationsTableTableManager(
          $_db,
          $_db.eventRegistrations,
        ).filter(
          (f) =>
              f.snacksAssignmentUserID.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _snacksAssignmentUserIDTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MemberAllocationsTable, List<MemberAllocation>>
  _memberAllocationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.memberAllocations,
        aliasName: 'users__id__member_allocations__user_i_d',
      );

  $$MemberAllocationsTableProcessedTableManager get memberAllocationsRefs {
    final manager = $$MemberAllocationsTableTableManager(
      $_db,
      $_db.memberAllocations,
    ).filter((f) => f.userID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _memberAllocationsRefsTable($_db),
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

  Expression<bool> eventsRefs(
    Expression<bool> Function($$EventsTableFilterComposer f) f,
  ) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.userID,
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

  Expression<bool> userID(
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

  Expression<bool> snacksAssignmentUserID(
    Expression<bool> Function($$EventRegistrationsTableFilterComposer f) f,
  ) {
    final $$EventRegistrationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventRegistrations,
      getReferencedColumn: (t) => t.snacksAssignmentUserID,
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

  Expression<bool> memberAllocationsRefs(
    Expression<bool> Function($$MemberAllocationsTableFilterComposer f) f,
  ) {
    final $$MemberAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.memberAllocations,
      getReferencedColumn: (t) => t.userID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemberAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.memberAllocations,
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

  Expression<T> eventsRefs<T extends Object>(
    Expression<T> Function($$EventsTableAnnotationComposer a) f,
  ) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.userID,
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

  Expression<T> userID<T extends Object>(
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

  Expression<T> snacksAssignmentUserID<T extends Object>(
    Expression<T> Function($$EventRegistrationsTableAnnotationComposer a) f,
  ) {
    final $$EventRegistrationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.eventRegistrations,
          getReferencedColumn: (t) => t.snacksAssignmentUserID,
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

  Expression<T> memberAllocationsRefs<T extends Object>(
    Expression<T> Function($$MemberAllocationsTableAnnotationComposer a) f,
  ) {
    final $$MemberAllocationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.memberAllocations,
          getReferencedColumn: (t) => t.userID,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MemberAllocationsTableAnnotationComposer(
                $db: $db,
                $table: $db.memberAllocations,
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
            bool eventsRefs,
            bool detailedAccountsRefs,
            bool eventOrdersRefs,
            bool userID,
            bool snacksAssignmentUserID,
            bool memberAllocationsRefs,
            bool teamMembersRefs,
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
                eventsRefs = false,
                detailedAccountsRefs = false,
                eventOrdersRefs = false,
                userID = false,
                snacksAssignmentUserID = false,
                memberAllocationsRefs = false,
                teamMembersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventsRefs) db.events,
                    if (detailedAccountsRefs) db.detailedAccounts,
                    if (eventOrdersRefs) db.eventOrders,
                    if (userID) db.eventRegistrations,
                    if (snacksAssignmentUserID) db.eventRegistrations,
                    if (memberAllocationsRefs) db.memberAllocations,
                    if (teamMembersRefs) db.teamMembers,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventsRefs)
                        await $_getPrefetchedData<User, $UsersTable, Event>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._eventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(db, table, p0).eventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userID == item.id,
                              ),
                          typedResults: items,
                        ),
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
                      if (userID)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          EventRegistration
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences._userIDTable(
                            db,
                          ),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(db, table, p0).userID,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (snacksAssignmentUserID)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          EventRegistration
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._snacksAssignmentUserIDTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).snacksAssignmentUserID,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.snacksAssignmentUserID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (memberAllocationsRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          MemberAllocation
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._memberAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).memberAllocationsRefs,
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
        bool eventsRefs,
        bool detailedAccountsRefs,
        bool eventOrdersRefs,
        bool userID,
        bool snacksAssignmentUserID,
        bool memberAllocationsRefs,
        bool teamMembersRefs,
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

  static MultiTypedResultKey<$TeamFundsTable, List<TeamFund>>
  _teamFundsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.teamFunds,
    aliasName: 'teams__id__team_funds__team_i_d',
  );

  $$TeamFundsTableProcessedTableManager get teamFundsRefs {
    final manager = $$TeamFundsTableTableManager(
      $_db,
      $_db.teamFunds,
    ).filter((f) => f.teamID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_teamFundsRefsTable($_db));
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

  Expression<bool> teamFundsRefs(
    Expression<bool> Function($$TeamFundsTableFilterComposer f) f,
  ) {
    final $$TeamFundsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamFunds,
      getReferencedColumn: (t) => t.teamID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamFundsTableFilterComposer(
            $db: $db,
            $table: $db.teamFunds,
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

  Expression<T> teamFundsRefs<T extends Object>(
    Expression<T> Function($$TeamFundsTableAnnotationComposer a) f,
  ) {
    final $$TeamFundsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamFunds,
      getReferencedColumn: (t) => t.teamID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamFundsTableAnnotationComposer(
            $db: $db,
            $table: $db.teamFunds,
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
          PrefetchHooks Function({
            bool eventsRefs,
            bool teamFundsRefs,
            bool teamMembersRefs,
          })
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
              ({
                eventsRefs = false,
                teamFundsRefs = false,
                teamMembersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventsRefs) db.events,
                    if (teamFundsRefs) db.teamFunds,
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
                      if (teamFundsRefs)
                        await $_getPrefetchedData<Team, $TeamsTable, TeamFund>(
                          currentTable: table,
                          referencedTable: $$TeamsTableReferences
                              ._teamFundsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TeamsTableReferences(
                                db,
                                table,
                                p0,
                              ).teamFundsRefs,
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
      PrefetchHooks Function({
        bool eventsRefs,
        bool teamFundsRefs,
        bool teamMembersRefs,
      })
    >;
typedef $$EventsTableCreateCompanionBuilder = EventsCompanion Function({
  Value<int> id,
  required String title,
  required int teamID,
  required int userID,
  required BigInt entranceFee,
  required BigInt snacksFee,
  Value<DateTime> date,
  Value<bool> isClosed,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});
typedef $$EventsTableUpdateCompanionBuilder = EventsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<int> teamID,
  Value<int> userID,
  Value<BigInt> entranceFee,
  Value<BigInt> snacksFee,
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

  static $UsersTable _userIDTable(_$AppDatabase db) =>
      db.users.createAlias('events__user_i_d__users__id');

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

  static MultiTypedResultKey<$FundAllocationsTable, List<FundAllocation>>
  _fundAllocationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fundAllocations,
    aliasName: 'events__id__fund_allocations__event_i_d',
  );

  $$FundAllocationsTableProcessedTableManager get fundAllocationsRefs {
    final manager = $$FundAllocationsTableTableManager(
      $_db,
      $_db.fundAllocations,
    ).filter((f) => f.eventID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _fundAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MemberAllocationsTable, List<MemberAllocation>>
  _memberAllocationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.memberAllocations,
        aliasName: 'events__id__member_allocations__event_i_d',
      );

  $$MemberAllocationsTableProcessedTableManager get memberAllocationsRefs {
    final manager = $$MemberAllocationsTableTableManager(
      $_db,
      $_db.memberAllocations,
    ).filter((f) => f.eventID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _memberAllocationsRefsTable($_db),
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

  ColumnFilters<BigInt> get entranceFee => $composableBuilder(
    column: $table.entranceFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get snacksFee => $composableBuilder(
    column: $table.snacksFee,
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

  Expression<bool> fundAllocationsRefs(
    Expression<bool> Function($$FundAllocationsTableFilterComposer f) f,
  ) {
    final $$FundAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fundAllocations,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.fundAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> memberAllocationsRefs(
    Expression<bool> Function($$MemberAllocationsTableFilterComposer f) f,
  ) {
    final $$MemberAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.memberAllocations,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemberAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.memberAllocations,
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

  ColumnOrderings<BigInt> get entranceFee => $composableBuilder(
    column: $table.entranceFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get snacksFee => $composableBuilder(
    column: $table.snacksFee,
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

  GeneratedColumn<BigInt> get entranceFee => $composableBuilder(
    column: $table.entranceFee,
    builder: (column) => column,
  );

  GeneratedColumn<BigInt> get snacksFee =>
      $composableBuilder(column: $table.snacksFee, builder: (column) => column);

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

  Expression<T> fundAllocationsRefs<T extends Object>(
    Expression<T> Function($$FundAllocationsTableAnnotationComposer a) f,
  ) {
    final $$FundAllocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fundAllocations,
      getReferencedColumn: (t) => t.eventID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundAllocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.fundAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> memberAllocationsRefs<T extends Object>(
    Expression<T> Function($$MemberAllocationsTableAnnotationComposer a) f,
  ) {
    final $$MemberAllocationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.memberAllocations,
          getReferencedColumn: (t) => t.eventID,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MemberAllocationsTableAnnotationComposer(
                $db: $db,
                $table: $db.memberAllocations,
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
            bool userID,
            bool detailedAccountsRefs,
            bool eventOrdersRefs,
            bool eventRegistrationsRefs,
            bool fundAllocationsRefs,
            bool memberAllocationsRefs,
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
                Value<int> userID = const Value.absent(),
                Value<BigInt> entranceFee = const Value.absent(),
                Value<BigInt> snacksFee = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<bool> isClosed = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EventsCompanion(
                id: id,
                title: title,
                teamID: teamID,
                userID: userID,
                entranceFee: entranceFee,
                snacksFee: snacksFee,
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
                required int userID,
                required BigInt entranceFee,
                required BigInt snacksFee,
                Value<DateTime> date = const Value.absent(),
                Value<bool> isClosed = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EventsCompanion.insert(
                id: id,
                title: title,
                teamID: teamID,
                userID: userID,
                entranceFee: entranceFee,
                snacksFee: snacksFee,
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
                userID = false,
                detailedAccountsRefs = false,
                eventOrdersRefs = false,
                eventRegistrationsRefs = false,
                fundAllocationsRefs = false,
                memberAllocationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (detailedAccountsRefs) db.detailedAccounts,
                    if (eventOrdersRefs) db.eventOrders,
                    if (eventRegistrationsRefs) db.eventRegistrations,
                    if (fundAllocationsRefs) db.fundAllocations,
                    if (memberAllocationsRefs) db.memberAllocations,
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
                        if (userID) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.userID,
                            referencedTable: $$EventsTableReferences
                                ._userIDTable(db),
                            referencedColumn: $$EventsTableReferences
                                ._userIDTable(db)
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
                      if (fundAllocationsRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          FundAllocation
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._fundAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).fundAllocationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (memberAllocationsRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          MemberAllocation
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._memberAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).memberAllocationsRefs,
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
        bool userID,
        bool detailedAccountsRefs,
        bool eventOrdersRefs,
        bool eventRegistrationsRefs,
        bool fundAllocationsRefs,
        bool memberAllocationsRefs,
      })
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

  static MultiTypedResultKey<$JournalLinesTable, List<JournalLine>>
  _firstDetailedIdTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.journalLines,
    aliasName: 'detailed_accounts__id__journal_lines__first_detailed_id',
  );

  $$JournalLinesTableProcessedTableManager get firstDetailedId {
    final manager = $$JournalLinesTableTableManager(
      $_db,
      $_db.journalLines,
    ).filter((f) => f.firstDetailedId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_firstDetailedIdTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$JournalLinesTable, List<JournalLine>>
  _secondDetailedIdTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.journalLines,
    aliasName: 'detailed_accounts__id__journal_lines__second_detailed_id',
  );

  $$JournalLinesTableProcessedTableManager get secondDetailedId {
    final manager = $$JournalLinesTableTableManager(
      $_db,
      $_db.journalLines,
    ).filter((f) => f.secondDetailedId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_secondDetailedIdTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
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

  Expression<bool> firstDetailedId(
    Expression<bool> Function($$JournalLinesTableFilterComposer f) f,
  ) {
    final $$JournalLinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalLines,
      getReferencedColumn: (t) => t.firstDetailedId,
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

  Expression<bool> secondDetailedId(
    Expression<bool> Function($$JournalLinesTableFilterComposer f) f,
  ) {
    final $$JournalLinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalLines,
      getReferencedColumn: (t) => t.secondDetailedId,
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

  Expression<T> firstDetailedId<T extends Object>(
    Expression<T> Function($$JournalLinesTableAnnotationComposer a) f,
  ) {
    final $$JournalLinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalLines,
      getReferencedColumn: (t) => t.firstDetailedId,
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

  Expression<T> secondDetailedId<T extends Object>(
    Expression<T> Function($$JournalLinesTableAnnotationComposer a) f,
  ) {
    final $$JournalLinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalLines,
      getReferencedColumn: (t) => t.secondDetailedId,
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
          PrefetchHooks Function({
            bool userID,
            bool eventID,
            bool bankID,
            bool firstDetailedId,
            bool secondDetailedId,
          })
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
              ({
                userID = false,
                eventID = false,
                bankID = false,
                firstDetailedId = false,
                secondDetailedId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (firstDetailedId) db.journalLines,
                    if (secondDetailedId) db.journalLines,
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
                    return [
                      if (firstDetailedId)
                        await $_getPrefetchedData<
                          DetailedAccount,
                          $DetailedAccountsTable,
                          JournalLine
                        >(
                          currentTable: table,
                          referencedTable: $$DetailedAccountsTableReferences
                              ._firstDetailedIdTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DetailedAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).firstDetailedId,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.firstDetailedId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (secondDetailedId)
                        await $_getPrefetchedData<
                          DetailedAccount,
                          $DetailedAccountsTable,
                          JournalLine
                        >(
                          currentTable: table,
                          referencedTable: $$DetailedAccountsTableReferences
                              ._secondDetailedIdTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DetailedAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).secondDetailedId,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.secondDetailedId == item.id,
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
      PrefetchHooks Function({
        bool userID,
        bool eventID,
        bool bankID,
        bool firstDetailedId,
        bool secondDetailedId,
      })
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
typedef $$FundsTableCreateCompanionBuilder = FundsCompanion Function({
  Value<int> id,
  required String title,
  required BigInt openingBalance,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$FundsTableUpdateCompanionBuilder = FundsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<BigInt> openingBalance,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$FundsTableReferences
    extends BaseReferences<_$AppDatabase, $FundsTable, Fund> {
  $$FundsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EventRegistrationsTable, List<EventRegistration>>
  _eventRegistrationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.eventRegistrations,
        aliasName: 'funds__id__event_registrations__snacks_assignment_fund_i_d',
      );

  $$EventRegistrationsTableProcessedTableManager get eventRegistrationsRefs {
    final manager =
        $$EventRegistrationsTableTableManager(
          $_db,
          $_db.eventRegistrations,
        ).filter(
          (f) =>
              f.snacksAssignmentFundID.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _eventRegistrationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FundAllocationsTable, List<FundAllocation>>
  _fundAllocationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fundAllocations,
    aliasName: 'funds__id__fund_allocations__fund_i_d',
  );

  $$FundAllocationsTableProcessedTableManager get fundAllocationsRefs {
    final manager = $$FundAllocationsTableTableManager(
      $_db,
      $_db.fundAllocations,
    ).filter((f) => f.fundID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _fundAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FundBalancesTable, List<FundBalance>>
  _fundBalancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fundBalances,
    aliasName: 'funds__id__fund_balances__fund_i_d',
  );

  $$FundBalancesTableProcessedTableManager get fundBalancesRefs {
    final manager = $$FundBalancesTableTableManager(
      $_db,
      $_db.fundBalances,
    ).filter((f) => f.fundID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fundBalancesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TeamFundsTable, List<TeamFund>>
  _teamFundsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.teamFunds,
    aliasName: 'funds__id__team_funds__fund_i_d',
  );

  $$TeamFundsTableProcessedTableManager get teamFundsRefs {
    final manager = $$TeamFundsTableTableManager(
      $_db,
      $_db.teamFunds,
    ).filter((f) => f.fundID.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_teamFundsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FundsTableFilterComposer extends Composer<_$AppDatabase, $FundsTable> {
  $$FundsTableFilterComposer({
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

  ColumnFilters<BigInt> get openingBalance => $composableBuilder(
    column: $table.openingBalance,
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

  Expression<bool> eventRegistrationsRefs(
    Expression<bool> Function($$EventRegistrationsTableFilterComposer f) f,
  ) {
    final $$EventRegistrationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventRegistrations,
      getReferencedColumn: (t) => t.snacksAssignmentFundID,
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

  Expression<bool> fundAllocationsRefs(
    Expression<bool> Function($$FundAllocationsTableFilterComposer f) f,
  ) {
    final $$FundAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fundAllocations,
      getReferencedColumn: (t) => t.fundID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.fundAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fundBalancesRefs(
    Expression<bool> Function($$FundBalancesTableFilterComposer f) f,
  ) {
    final $$FundBalancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fundBalances,
      getReferencedColumn: (t) => t.fundID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundBalancesTableFilterComposer(
            $db: $db,
            $table: $db.fundBalances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> teamFundsRefs(
    Expression<bool> Function($$TeamFundsTableFilterComposer f) f,
  ) {
    final $$TeamFundsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamFunds,
      getReferencedColumn: (t) => t.fundID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamFundsTableFilterComposer(
            $db: $db,
            $table: $db.teamFunds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FundsTableOrderingComposer
    extends Composer<_$AppDatabase, $FundsTable> {
  $$FundsTableOrderingComposer({
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

  ColumnOrderings<BigInt> get openingBalance => $composableBuilder(
    column: $table.openingBalance,
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

class $$FundsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FundsTable> {
  $$FundsTableAnnotationComposer({
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

  GeneratedColumn<BigInt> get openingBalance => $composableBuilder(
    column: $table.openingBalance,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> eventRegistrationsRefs<T extends Object>(
    Expression<T> Function($$EventRegistrationsTableAnnotationComposer a) f,
  ) {
    final $$EventRegistrationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.eventRegistrations,
          getReferencedColumn: (t) => t.snacksAssignmentFundID,
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

  Expression<T> fundAllocationsRefs<T extends Object>(
    Expression<T> Function($$FundAllocationsTableAnnotationComposer a) f,
  ) {
    final $$FundAllocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fundAllocations,
      getReferencedColumn: (t) => t.fundID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundAllocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.fundAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fundBalancesRefs<T extends Object>(
    Expression<T> Function($$FundBalancesTableAnnotationComposer a) f,
  ) {
    final $$FundBalancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fundBalances,
      getReferencedColumn: (t) => t.fundID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundBalancesTableAnnotationComposer(
            $db: $db,
            $table: $db.fundBalances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> teamFundsRefs<T extends Object>(
    Expression<T> Function($$TeamFundsTableAnnotationComposer a) f,
  ) {
    final $$TeamFundsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamFunds,
      getReferencedColumn: (t) => t.fundID,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamFundsTableAnnotationComposer(
            $db: $db,
            $table: $db.teamFunds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FundsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FundsTable,
          Fund,
          $$FundsTableFilterComposer,
          $$FundsTableOrderingComposer,
          $$FundsTableAnnotationComposer,
          $$FundsTableCreateCompanionBuilder,
          $$FundsTableUpdateCompanionBuilder,
          (Fund, $$FundsTableReferences),
          Fund,
          PrefetchHooks Function({
            bool eventRegistrationsRefs,
            bool fundAllocationsRefs,
            bool fundBalancesRefs,
            bool teamFundsRefs,
          })
        > {
  $$FundsTableTableManager(_$AppDatabase db, $FundsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FundsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FundsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FundsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<BigInt> openingBalance = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FundsCompanion(
                id: id,
                title: title,
                openingBalance: openingBalance,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required BigInt openingBalance,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FundsCompanion.insert(
                id: id,
                title: title,
                openingBalance: openingBalance,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$FundsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                eventRegistrationsRefs = false,
                fundAllocationsRefs = false,
                fundBalancesRefs = false,
                teamFundsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventRegistrationsRefs) db.eventRegistrations,
                    if (fundAllocationsRefs) db.fundAllocations,
                    if (fundBalancesRefs) db.fundBalances,
                    if (teamFundsRefs) db.teamFunds,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventRegistrationsRefs)
                        await $_getPrefetchedData<
                          Fund,
                          $FundsTable,
                          EventRegistration
                        >(
                          currentTable: table,
                          referencedTable: $$FundsTableReferences
                              ._eventRegistrationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FundsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventRegistrationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.snacksAssignmentFundID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fundAllocationsRefs)
                        await $_getPrefetchedData<
                          Fund,
                          $FundsTable,
                          FundAllocation
                        >(
                          currentTable: table,
                          referencedTable: $$FundsTableReferences
                              ._fundAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FundsTableReferences(
                                db,
                                table,
                                p0,
                              ).fundAllocationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fundID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fundBalancesRefs)
                        await $_getPrefetchedData<
                          Fund,
                          $FundsTable,
                          FundBalance
                        >(
                          currentTable: table,
                          referencedTable: $$FundsTableReferences
                              ._fundBalancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FundsTableReferences(
                                db,
                                table,
                                p0,
                              ).fundBalancesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fundID == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (teamFundsRefs)
                        await $_getPrefetchedData<Fund, $FundsTable, TeamFund>(
                          currentTable: table,
                          referencedTable: $$FundsTableReferences
                              ._teamFundsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FundsTableReferences(
                                db,
                                table,
                                p0,
                              ).teamFundsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fundID == item.id,
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

typedef $$FundsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FundsTable,
      Fund,
      $$FundsTableFilterComposer,
      $$FundsTableOrderingComposer,
      $$FundsTableAnnotationComposer,
      $$FundsTableCreateCompanionBuilder,
      $$FundsTableUpdateCompanionBuilder,
      (Fund, $$FundsTableReferences),
      Fund,
      PrefetchHooks Function({
        bool eventRegistrationsRefs,
        bool fundAllocationsRefs,
        bool fundBalancesRefs,
        bool teamFundsRefs,
      })
    >;
typedef $$EventRegistrationsTableCreateCompanionBuilder =
    EventRegistrationsCompanion Function({
      Value<int> id,
      required int eventID,
      required int userID,
      Value<int?> snacksAssignmentUserID,
      Value<int?> snacksAssignmentFundID,
      Value<RegistrationStatus> status,
      Value<SnacksFeeAssignmentStatus> snacksFeeAssignmentStatus,
      required BigInt grossAmount,
      required BigInt discountAmount,
      required BigInt netAmount,
      Value<bool> wasAbsent,
      Value<String?> description,
      Value<DateTime> registeredAt,
    });
typedef $$EventRegistrationsTableUpdateCompanionBuilder =
    EventRegistrationsCompanion Function({
      Value<int> id,
      Value<int> eventID,
      Value<int> userID,
      Value<int?> snacksAssignmentUserID,
      Value<int?> snacksAssignmentFundID,
      Value<RegistrationStatus> status,
      Value<SnacksFeeAssignmentStatus> snacksFeeAssignmentStatus,
      Value<BigInt> grossAmount,
      Value<BigInt> discountAmount,
      Value<BigInt> netAmount,
      Value<bool> wasAbsent,
      Value<String?> description,
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

  static $UsersTable _snacksAssignmentUserIDTable(_$AppDatabase db) =>
      db.users.createAlias(
        'event_registrations__snacks_assignment_user_i_d__users__id',
      );

  $$UsersTableProcessedTableManager? get snacksAssignmentUserID {
    final $_column = $_itemColumn<int>('snacks_assignment_user_i_d');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _snacksAssignmentUserIDTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FundsTable _snacksAssignmentFundIDTable(_$AppDatabase db) =>
      db.funds.createAlias(
        'event_registrations__snacks_assignment_fund_i_d__funds__id',
      );

  $$FundsTableProcessedTableManager? get snacksAssignmentFundID {
    final $_column = $_itemColumn<int>('snacks_assignment_fund_i_d');
    if ($_column == null) return null;
    final manager = $$FundsTableTableManager(
      $_db,
      $_db.funds,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _snacksAssignmentFundIDTable($_db),
    );
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

  ColumnWithTypeConverterFilters<
    SnacksFeeAssignmentStatus,
    SnacksFeeAssignmentStatus,
    String
  >
  get snacksFeeAssignmentStatus => $composableBuilder(
    column: $table.snacksFeeAssignmentStatus,
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

  ColumnFilters<bool> get wasAbsent => $composableBuilder(
    column: $table.wasAbsent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
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

  $$UsersTableFilterComposer get snacksAssignmentUserID {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.snacksAssignmentUserID,
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

  $$FundsTableFilterComposer get snacksAssignmentFundID {
    final $$FundsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.snacksAssignmentFundID,
      referencedTable: $db.funds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundsTableFilterComposer(
            $db: $db,
            $table: $db.funds,
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

  ColumnOrderings<String> get snacksFeeAssignmentStatus => $composableBuilder(
    column: $table.snacksFeeAssignmentStatus,
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

  ColumnOrderings<bool> get wasAbsent => $composableBuilder(
    column: $table.wasAbsent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
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

  $$UsersTableOrderingComposer get snacksAssignmentUserID {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.snacksAssignmentUserID,
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

  $$FundsTableOrderingComposer get snacksAssignmentFundID {
    final $$FundsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.snacksAssignmentFundID,
      referencedTable: $db.funds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundsTableOrderingComposer(
            $db: $db,
            $table: $db.funds,
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

  GeneratedColumnWithTypeConverter<SnacksFeeAssignmentStatus, String>
  get snacksFeeAssignmentStatus => $composableBuilder(
    column: $table.snacksFeeAssignmentStatus,
    builder: (column) => column,
  );

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

  GeneratedColumn<bool> get wasAbsent =>
      $composableBuilder(column: $table.wasAbsent, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

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

  $$UsersTableAnnotationComposer get snacksAssignmentUserID {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.snacksAssignmentUserID,
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

  $$FundsTableAnnotationComposer get snacksAssignmentFundID {
    final $$FundsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.snacksAssignmentFundID,
      referencedTable: $db.funds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundsTableAnnotationComposer(
            $db: $db,
            $table: $db.funds,
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
          PrefetchHooks Function({
            bool eventID,
            bool userID,
            bool snacksAssignmentUserID,
            bool snacksAssignmentFundID,
          })
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
                Value<int?> snacksAssignmentUserID = const Value.absent(),
                Value<int?> snacksAssignmentFundID = const Value.absent(),
                Value<RegistrationStatus> status = const Value.absent(),
                Value<SnacksFeeAssignmentStatus> snacksFeeAssignmentStatus =
                    const Value.absent(),
                Value<BigInt> grossAmount = const Value.absent(),
                Value<BigInt> discountAmount = const Value.absent(),
                Value<BigInt> netAmount = const Value.absent(),
                Value<bool> wasAbsent = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> registeredAt = const Value.absent(),
              }) => EventRegistrationsCompanion(
                id: id,
                eventID: eventID,
                userID: userID,
                snacksAssignmentUserID: snacksAssignmentUserID,
                snacksAssignmentFundID: snacksAssignmentFundID,
                status: status,
                snacksFeeAssignmentStatus: snacksFeeAssignmentStatus,
                grossAmount: grossAmount,
                discountAmount: discountAmount,
                netAmount: netAmount,
                wasAbsent: wasAbsent,
                description: description,
                registeredAt: registeredAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eventID,
                required int userID,
                Value<int?> snacksAssignmentUserID = const Value.absent(),
                Value<int?> snacksAssignmentFundID = const Value.absent(),
                Value<RegistrationStatus> status = const Value.absent(),
                Value<SnacksFeeAssignmentStatus> snacksFeeAssignmentStatus =
                    const Value.absent(),
                required BigInt grossAmount,
                required BigInt discountAmount,
                required BigInt netAmount,
                Value<bool> wasAbsent = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> registeredAt = const Value.absent(),
              }) => EventRegistrationsCompanion.insert(
                id: id,
                eventID: eventID,
                userID: userID,
                snacksAssignmentUserID: snacksAssignmentUserID,
                snacksAssignmentFundID: snacksAssignmentFundID,
                status: status,
                snacksFeeAssignmentStatus: snacksFeeAssignmentStatus,
                grossAmount: grossAmount,
                discountAmount: discountAmount,
                netAmount: netAmount,
                wasAbsent: wasAbsent,
                description: description,
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
          prefetchHooksCallback:
              ({
                eventID = false,
                userID = false,
                snacksAssignmentUserID = false,
                snacksAssignmentFundID = false,
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
                        if (eventID) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.eventID,
                            referencedTable: $$EventRegistrationsTableReferences
                                ._eventIDTable(db),
                            referencedColumn:
                                $$EventRegistrationsTableReferences
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
                            referencedColumn:
                                $$EventRegistrationsTableReferences
                                    ._userIDTable(db)
                                    .id,
                          ) as T;
                        }
                        if (snacksAssignmentUserID) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.snacksAssignmentUserID,
                            referencedTable: $$EventRegistrationsTableReferences
                                ._snacksAssignmentUserIDTable(db),
                            referencedColumn:
                                $$EventRegistrationsTableReferences
                                    ._snacksAssignmentUserIDTable(db)
                                    .id,
                          ) as T;
                        }
                        if (snacksAssignmentFundID) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.snacksAssignmentFundID,
                            referencedTable: $$EventRegistrationsTableReferences
                                ._snacksAssignmentFundIDTable(db),
                            referencedColumn:
                                $$EventRegistrationsTableReferences
                                    ._snacksAssignmentFundIDTable(db)
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
      PrefetchHooks Function({
        bool eventID,
        bool userID,
        bool snacksAssignmentUserID,
        bool snacksAssignmentFundID,
      })
    >;
typedef $$FundAllocationsTableCreateCompanionBuilder =
    FundAllocationsCompanion Function({
      Value<int> id,
      required int fundID,
      required int eventID,
      required double sharePercentage,
      Value<DateTime> createAt,
    });
typedef $$FundAllocationsTableUpdateCompanionBuilder =
    FundAllocationsCompanion Function({
      Value<int> id,
      Value<int> fundID,
      Value<int> eventID,
      Value<double> sharePercentage,
      Value<DateTime> createAt,
    });

final class $$FundAllocationsTableReferences
    extends
        BaseReferences<_$AppDatabase, $FundAllocationsTable, FundAllocation> {
  $$FundAllocationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FundsTable _fundIDTable(_$AppDatabase db) =>
      db.funds.createAlias('fund_allocations__fund_i_d__funds__id');

  $$FundsTableProcessedTableManager get fundID {
    final $_column = $_itemColumn<int>('fund_i_d')!;

    final manager = $$FundsTableTableManager(
      $_db,
      $_db.funds,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fundIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EventsTable _eventIDTable(_$AppDatabase db) =>
      db.events.createAlias('fund_allocations__event_i_d__events__id');

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

class $$FundAllocationsTableFilterComposer
    extends Composer<_$AppDatabase, $FundAllocationsTable> {
  $$FundAllocationsTableFilterComposer({
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

  $$FundsTableFilterComposer get fundID {
    final $$FundsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fundID,
      referencedTable: $db.funds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundsTableFilterComposer(
            $db: $db,
            $table: $db.funds,
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

class $$FundAllocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $FundAllocationsTable> {
  $$FundAllocationsTableOrderingComposer({
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

  $$FundsTableOrderingComposer get fundID {
    final $$FundsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fundID,
      referencedTable: $db.funds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundsTableOrderingComposer(
            $db: $db,
            $table: $db.funds,
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

class $$FundAllocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FundAllocationsTable> {
  $$FundAllocationsTableAnnotationComposer({
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

  $$FundsTableAnnotationComposer get fundID {
    final $$FundsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fundID,
      referencedTable: $db.funds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundsTableAnnotationComposer(
            $db: $db,
            $table: $db.funds,
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

class $$FundAllocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FundAllocationsTable,
          FundAllocation,
          $$FundAllocationsTableFilterComposer,
          $$FundAllocationsTableOrderingComposer,
          $$FundAllocationsTableAnnotationComposer,
          $$FundAllocationsTableCreateCompanionBuilder,
          $$FundAllocationsTableUpdateCompanionBuilder,
          (FundAllocation, $$FundAllocationsTableReferences),
          FundAllocation,
          PrefetchHooks Function({bool fundID, bool eventID})
        > {
  $$FundAllocationsTableTableManager(
    _$AppDatabase db,
    $FundAllocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FundAllocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FundAllocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FundAllocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fundID = const Value.absent(),
                Value<int> eventID = const Value.absent(),
                Value<double> sharePercentage = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
              }) => FundAllocationsCompanion(
                id: id,
                fundID: fundID,
                eventID: eventID,
                sharePercentage: sharePercentage,
                createAt: createAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fundID,
                required int eventID,
                required double sharePercentage,
                Value<DateTime> createAt = const Value.absent(),
              }) => FundAllocationsCompanion.insert(
                id: id,
                fundID: fundID,
                eventID: eventID,
                sharePercentage: sharePercentage,
                createAt: createAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FundAllocationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fundID = false, eventID = false}) {
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
                    if (fundID) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.fundID,
                        referencedTable: $$FundAllocationsTableReferences
                            ._fundIDTable(db),
                        referencedColumn: $$FundAllocationsTableReferences
                            ._fundIDTable(db)
                            .id,
                      ) as T;
                    }
                    if (eventID) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.eventID,
                        referencedTable: $$FundAllocationsTableReferences
                            ._eventIDTable(db),
                        referencedColumn: $$FundAllocationsTableReferences
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

typedef $$FundAllocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FundAllocationsTable,
      FundAllocation,
      $$FundAllocationsTableFilterComposer,
      $$FundAllocationsTableOrderingComposer,
      $$FundAllocationsTableAnnotationComposer,
      $$FundAllocationsTableCreateCompanionBuilder,
      $$FundAllocationsTableUpdateCompanionBuilder,
      (FundAllocation, $$FundAllocationsTableReferences),
      FundAllocation,
      PrefetchHooks Function({bool fundID, bool eventID})
    >;
typedef $$FundBalancesTableCreateCompanionBuilder =
    FundBalancesCompanion Function({
      Value<int> id,
      required int fundID,
      required String series,
      required BigInt debit,
      required BigInt credit,
      Value<DateTime> date,
      Value<String?> memo,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$FundBalancesTableUpdateCompanionBuilder =
    FundBalancesCompanion Function({
      Value<int> id,
      Value<int> fundID,
      Value<String> series,
      Value<BigInt> debit,
      Value<BigInt> credit,
      Value<DateTime> date,
      Value<String?> memo,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$FundBalancesTableReferences
    extends BaseReferences<_$AppDatabase, $FundBalancesTable, FundBalance> {
  $$FundBalancesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FundsTable _fundIDTable(_$AppDatabase db) =>
      db.funds.createAlias('fund_balances__fund_i_d__funds__id');

  $$FundsTableProcessedTableManager get fundID {
    final $_column = $_itemColumn<int>('fund_i_d')!;

    final manager = $$FundsTableTableManager(
      $_db,
      $_db.funds,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fundIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FundBalancesTableFilterComposer
    extends Composer<_$AppDatabase, $FundBalancesTable> {
  $$FundBalancesTableFilterComposer({
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

  ColumnFilters<String> get series => $composableBuilder(
    column: $table.series,
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

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memo => $composableBuilder(
    column: $table.memo,
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

  $$FundsTableFilterComposer get fundID {
    final $$FundsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fundID,
      referencedTable: $db.funds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundsTableFilterComposer(
            $db: $db,
            $table: $db.funds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FundBalancesTableOrderingComposer
    extends Composer<_$AppDatabase, $FundBalancesTable> {
  $$FundBalancesTableOrderingComposer({
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

  ColumnOrderings<String> get series => $composableBuilder(
    column: $table.series,
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

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memo => $composableBuilder(
    column: $table.memo,
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

  $$FundsTableOrderingComposer get fundID {
    final $$FundsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fundID,
      referencedTable: $db.funds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundsTableOrderingComposer(
            $db: $db,
            $table: $db.funds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FundBalancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FundBalancesTable> {
  $$FundBalancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get series =>
      $composableBuilder(column: $table.series, builder: (column) => column);

  GeneratedColumn<BigInt> get debit =>
      $composableBuilder(column: $table.debit, builder: (column) => column);

  GeneratedColumn<BigInt> get credit =>
      $composableBuilder(column: $table.credit, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get memo =>
      $composableBuilder(column: $table.memo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FundsTableAnnotationComposer get fundID {
    final $$FundsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fundID,
      referencedTable: $db.funds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundsTableAnnotationComposer(
            $db: $db,
            $table: $db.funds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FundBalancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FundBalancesTable,
          FundBalance,
          $$FundBalancesTableFilterComposer,
          $$FundBalancesTableOrderingComposer,
          $$FundBalancesTableAnnotationComposer,
          $$FundBalancesTableCreateCompanionBuilder,
          $$FundBalancesTableUpdateCompanionBuilder,
          (FundBalance, $$FundBalancesTableReferences),
          FundBalance,
          PrefetchHooks Function({bool fundID})
        > {
  $$FundBalancesTableTableManager(_$AppDatabase db, $FundBalancesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FundBalancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FundBalancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FundBalancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fundID = const Value.absent(),
                Value<String> series = const Value.absent(),
                Value<BigInt> debit = const Value.absent(),
                Value<BigInt> credit = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> memo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FundBalancesCompanion(
                id: id,
                fundID: fundID,
                series: series,
                debit: debit,
                credit: credit,
                date: date,
                memo: memo,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fundID,
                required String series,
                required BigInt debit,
                required BigInt credit,
                Value<DateTime> date = const Value.absent(),
                Value<String?> memo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FundBalancesCompanion.insert(
                id: id,
                fundID: fundID,
                series: series,
                debit: debit,
                credit: credit,
                date: date,
                memo: memo,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FundBalancesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fundID = false}) {
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
                    if (fundID) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.fundID,
                        referencedTable: $$FundBalancesTableReferences
                            ._fundIDTable(db),
                        referencedColumn: $$FundBalancesTableReferences
                            ._fundIDTable(db)
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

typedef $$FundBalancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FundBalancesTable,
      FundBalance,
      $$FundBalancesTableFilterComposer,
      $$FundBalancesTableOrderingComposer,
      $$FundBalancesTableAnnotationComposer,
      $$FundBalancesTableCreateCompanionBuilder,
      $$FundBalancesTableUpdateCompanionBuilder,
      (FundBalance, $$FundBalancesTableReferences),
      FundBalance,
      PrefetchHooks Function({bool fundID})
    >;
typedef $$GeneralAccountsTableCreateCompanionBuilder =
    GeneralAccountsCompanion Function({
      Value<int> id,
      required String code,
      required String completeCode,
      required String name,
      required int accountGroupId,
      required GeneralAccountType type,
      Value<bool> isSystemDefault,
    });
typedef $$GeneralAccountsTableUpdateCompanionBuilder =
    GeneralAccountsCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> completeCode,
      Value<String> name,
      Value<int> accountGroupId,
      Value<GeneralAccountType> type,
      Value<bool> isSystemDefault,
    });

final class $$GeneralAccountsTableReferences
    extends
        BaseReferences<_$AppDatabase, $GeneralAccountsTable, GeneralAccount> {
  $$GeneralAccountsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AccountGroupsTable _accountGroupIdTable(_$AppDatabase db) => db
      .accountGroups
      .createAlias('general_accounts__account_group_id__account_groups__id');

  $$AccountGroupsTableProcessedTableManager get accountGroupId {
    final $_column = $_itemColumn<int>('account_group_id')!;

    final manager = $$AccountGroupsTableTableManager(
      $_db,
      $_db.accountGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SubsidiaryAccountsTable, List<SubsidiaryAccount>>
  _subsidiaryAccountsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.subsidiaryAccounts,
        aliasName:
            'general_accounts__id__subsidiary_accounts__general_account_id',
      );

  $$SubsidiaryAccountsTableProcessedTableManager get subsidiaryAccountsRefs {
    final manager = $$SubsidiaryAccountsTableTableManager(
      $_db,
      $_db.subsidiaryAccounts,
    ).filter((f) => f.generalAccountId.id.sqlEquals($_itemColumn<int>('id')!));

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

  ColumnFilters<String> get completeCode => $composableBuilder(
    column: $table.completeCode,
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

  ColumnFilters<bool> get isSystemDefault => $composableBuilder(
    column: $table.isSystemDefault,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountGroupsTableFilterComposer get accountGroupId {
    final $$AccountGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountGroupId,
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
      getReferencedColumn: (t) => t.generalAccountId,
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

  ColumnOrderings<String> get completeCode => $composableBuilder(
    column: $table.completeCode,
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

  ColumnOrderings<bool> get isSystemDefault => $composableBuilder(
    column: $table.isSystemDefault,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountGroupsTableOrderingComposer get accountGroupId {
    final $$AccountGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountGroupId,
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

  GeneratedColumn<String> get completeCode => $composableBuilder(
    column: $table.completeCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GeneralAccountType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isSystemDefault => $composableBuilder(
    column: $table.isSystemDefault,
    builder: (column) => column,
  );

  $$AccountGroupsTableAnnotationComposer get accountGroupId {
    final $$AccountGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountGroupId,
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
          getReferencedColumn: (t) => t.generalAccountId,
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
          PrefetchHooks Function({
            bool accountGroupId,
            bool subsidiaryAccountsRefs,
          })
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
                Value<String> completeCode = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> accountGroupId = const Value.absent(),
                Value<GeneralAccountType> type = const Value.absent(),
                Value<bool> isSystemDefault = const Value.absent(),
              }) => GeneralAccountsCompanion(
                id: id,
                code: code,
                completeCode: completeCode,
                name: name,
                accountGroupId: accountGroupId,
                type: type,
                isSystemDefault: isSystemDefault,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String completeCode,
                required String name,
                required int accountGroupId,
                required GeneralAccountType type,
                Value<bool> isSystemDefault = const Value.absent(),
              }) => GeneralAccountsCompanion.insert(
                id: id,
                code: code,
                completeCode: completeCode,
                name: name,
                accountGroupId: accountGroupId,
                type: type,
                isSystemDefault: isSystemDefault,
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
              ({accountGroupId = false, subsidiaryAccountsRefs = false}) {
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
                        if (accountGroupId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountGroupId,
                            referencedTable: $$GeneralAccountsTableReferences
                                ._accountGroupIdTable(db),
                            referencedColumn: $$GeneralAccountsTableReferences
                                ._accountGroupIdTable(db)
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
                                (e) => e.generalAccountId == item.id,
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
      PrefetchHooks Function({bool accountGroupId, bool subsidiaryAccountsRefs})
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
typedef $$SubsidiaryAccountsTableCreateCompanionBuilder =
    SubsidiaryAccountsCompanion Function({
      Value<int> id,
      required int accountGroupId,
      required int generalAccountId,
      required String code,
      required String completeCode,
      required String name,
      required SubsidiaryAccountType type,
      Value<bool> isSystemDefault,
    });
typedef $$SubsidiaryAccountsTableUpdateCompanionBuilder =
    SubsidiaryAccountsCompanion Function({
      Value<int> id,
      Value<int> accountGroupId,
      Value<int> generalAccountId,
      Value<String> code,
      Value<String> completeCode,
      Value<String> name,
      Value<SubsidiaryAccountType> type,
      Value<bool> isSystemDefault,
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

  static $AccountGroupsTable _accountGroupIdTable(_$AppDatabase db) => db
      .accountGroups
      .createAlias('subsidiary_accounts__account_group_id__account_groups__id');

  $$AccountGroupsTableProcessedTableManager get accountGroupId {
    final $_column = $_itemColumn<int>('account_group_id')!;

    final manager = $$AccountGroupsTableTableManager(
      $_db,
      $_db.accountGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GeneralAccountsTable _generalAccountIdTable(_$AppDatabase db) =>
      db.generalAccounts.createAlias(
        'subsidiary_accounts__general_account_id__general_accounts__id',
      );

  $$GeneralAccountsTableProcessedTableManager get generalAccountId {
    final $_column = $_itemColumn<int>('general_account_id')!;

    final manager = $$GeneralAccountsTableTableManager(
      $_db,
      $_db.generalAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_generalAccountIdTable($_db));
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

  ColumnFilters<String> get completeCode => $composableBuilder(
    column: $table.completeCode,
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

  ColumnFilters<bool> get isSystemDefault => $composableBuilder(
    column: $table.isSystemDefault,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountGroupsTableFilterComposer get accountGroupId {
    final $$AccountGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountGroupId,
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

  $$GeneralAccountsTableFilterComposer get generalAccountId {
    final $$GeneralAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.generalAccountId,
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

  ColumnOrderings<String> get completeCode => $composableBuilder(
    column: $table.completeCode,
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

  ColumnOrderings<bool> get isSystemDefault => $composableBuilder(
    column: $table.isSystemDefault,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountGroupsTableOrderingComposer get accountGroupId {
    final $$AccountGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountGroupId,
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

  $$GeneralAccountsTableOrderingComposer get generalAccountId {
    final $$GeneralAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.generalAccountId,
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

  GeneratedColumn<String> get completeCode => $composableBuilder(
    column: $table.completeCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SubsidiaryAccountType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isSystemDefault => $composableBuilder(
    column: $table.isSystemDefault,
    builder: (column) => column,
  );

  $$AccountGroupsTableAnnotationComposer get accountGroupId {
    final $$AccountGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountGroupId,
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

  $$GeneralAccountsTableAnnotationComposer get generalAccountId {
    final $$GeneralAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.generalAccountId,
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
          PrefetchHooks Function({
            bool accountGroupId,
            bool generalAccountId,
            bool journalLinesRefs,
          })
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
                Value<int> accountGroupId = const Value.absent(),
                Value<int> generalAccountId = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> completeCode = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<SubsidiaryAccountType> type = const Value.absent(),
                Value<bool> isSystemDefault = const Value.absent(),
              }) => SubsidiaryAccountsCompanion(
                id: id,
                accountGroupId: accountGroupId,
                generalAccountId: generalAccountId,
                code: code,
                completeCode: completeCode,
                name: name,
                type: type,
                isSystemDefault: isSystemDefault,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int accountGroupId,
                required int generalAccountId,
                required String code,
                required String completeCode,
                required String name,
                required SubsidiaryAccountType type,
                Value<bool> isSystemDefault = const Value.absent(),
              }) => SubsidiaryAccountsCompanion.insert(
                id: id,
                accountGroupId: accountGroupId,
                generalAccountId: generalAccountId,
                code: code,
                completeCode: completeCode,
                name: name,
                type: type,
                isSystemDefault: isSystemDefault,
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
              ({
                accountGroupId = false,
                generalAccountId = false,
                journalLinesRefs = false,
              }) {
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
                        if (accountGroupId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountGroupId,
                            referencedTable: $$SubsidiaryAccountsTableReferences
                                ._accountGroupIdTable(db),
                            referencedColumn:
                                $$SubsidiaryAccountsTableReferences
                                    ._accountGroupIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (generalAccountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.generalAccountId,
                            referencedTable: $$SubsidiaryAccountsTableReferences
                                ._generalAccountIdTable(db),
                            referencedColumn:
                                $$SubsidiaryAccountsTableReferences
                                    ._generalAccountIdTable(db)
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
      PrefetchHooks Function({
        bool accountGroupId,
        bool generalAccountId,
        bool journalLinesRefs,
      })
    >;
typedef $$JournalLinesTableCreateCompanionBuilder =
    JournalLinesCompanion Function({
      Value<int> id,
      required int headerId,
      required int subsidiaryId,
      Value<int?> firstDetailedId,
      Value<int?> secondDetailedId,
      required BigInt debit,
      required BigInt credit,
      required String series,
      Value<String?> memo,
      Value<String?> noticeMemo,
      Value<DateTime> date,
      Value<bool> hasSource,
    });
typedef $$JournalLinesTableUpdateCompanionBuilder =
    JournalLinesCompanion Function({
      Value<int> id,
      Value<int> headerId,
      Value<int> subsidiaryId,
      Value<int?> firstDetailedId,
      Value<int?> secondDetailedId,
      Value<BigInt> debit,
      Value<BigInt> credit,
      Value<String> series,
      Value<String?> memo,
      Value<String?> noticeMemo,
      Value<DateTime> date,
      Value<bool> hasSource,
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

  static $DetailedAccountsTable _firstDetailedIdTable(_$AppDatabase db) => db
      .detailedAccounts
      .createAlias('journal_lines__first_detailed_id__detailed_accounts__id');

  $$DetailedAccountsTableProcessedTableManager? get firstDetailedId {
    final $_column = $_itemColumn<int>('first_detailed_id');
    if ($_column == null) return null;
    final manager = $$DetailedAccountsTableTableManager(
      $_db,
      $_db.detailedAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_firstDetailedIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DetailedAccountsTable _secondDetailedIdTable(_$AppDatabase db) => db
      .detailedAccounts
      .createAlias('journal_lines__second_detailed_id__detailed_accounts__id');

  $$DetailedAccountsTableProcessedTableManager? get secondDetailedId {
    final $_column = $_itemColumn<int>('second_detailed_id');
    if ($_column == null) return null;
    final manager = $$DetailedAccountsTableTableManager(
      $_db,
      $_db.detailedAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_secondDetailedIdTable($_db));
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

  ColumnFilters<String> get noticeMemo => $composableBuilder(
    column: $table.noticeMemo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasSource => $composableBuilder(
    column: $table.hasSource,
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

  $$DetailedAccountsTableFilterComposer get firstDetailedId {
    final $$DetailedAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.firstDetailedId,
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

  $$DetailedAccountsTableFilterComposer get secondDetailedId {
    final $$DetailedAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.secondDetailedId,
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

  ColumnOrderings<String> get noticeMemo => $composableBuilder(
    column: $table.noticeMemo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasSource => $composableBuilder(
    column: $table.hasSource,
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

  $$DetailedAccountsTableOrderingComposer get firstDetailedId {
    final $$DetailedAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.firstDetailedId,
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

  $$DetailedAccountsTableOrderingComposer get secondDetailedId {
    final $$DetailedAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.secondDetailedId,
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

  GeneratedColumn<String> get noticeMemo => $composableBuilder(
    column: $table.noticeMemo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get hasSource =>
      $composableBuilder(column: $table.hasSource, builder: (column) => column);

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

  $$DetailedAccountsTableAnnotationComposer get firstDetailedId {
    final $$DetailedAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.firstDetailedId,
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

  $$DetailedAccountsTableAnnotationComposer get secondDetailedId {
    final $$DetailedAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.secondDetailedId,
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
            bool firstDetailedId,
            bool secondDetailedId,
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
                Value<int?> firstDetailedId = const Value.absent(),
                Value<int?> secondDetailedId = const Value.absent(),
                Value<BigInt> debit = const Value.absent(),
                Value<BigInt> credit = const Value.absent(),
                Value<String> series = const Value.absent(),
                Value<String?> memo = const Value.absent(),
                Value<String?> noticeMemo = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<bool> hasSource = const Value.absent(),
              }) => JournalLinesCompanion(
                id: id,
                headerId: headerId,
                subsidiaryId: subsidiaryId,
                firstDetailedId: firstDetailedId,
                secondDetailedId: secondDetailedId,
                debit: debit,
                credit: credit,
                series: series,
                memo: memo,
                noticeMemo: noticeMemo,
                date: date,
                hasSource: hasSource,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int headerId,
                required int subsidiaryId,
                Value<int?> firstDetailedId = const Value.absent(),
                Value<int?> secondDetailedId = const Value.absent(),
                required BigInt debit,
                required BigInt credit,
                required String series,
                Value<String?> memo = const Value.absent(),
                Value<String?> noticeMemo = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<bool> hasSource = const Value.absent(),
              }) => JournalLinesCompanion.insert(
                id: id,
                headerId: headerId,
                subsidiaryId: subsidiaryId,
                firstDetailedId: firstDetailedId,
                secondDetailedId: secondDetailedId,
                debit: debit,
                credit: credit,
                series: series,
                memo: memo,
                noticeMemo: noticeMemo,
                date: date,
                hasSource: hasSource,
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
                firstDetailedId = false,
                secondDetailedId = false,
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
                        if (firstDetailedId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.firstDetailedId,
                            referencedTable: $$JournalLinesTableReferences
                                ._firstDetailedIdTable(db),
                            referencedColumn: $$JournalLinesTableReferences
                                ._firstDetailedIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (secondDetailedId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.secondDetailedId,
                            referencedTable: $$JournalLinesTableReferences
                                ._secondDetailedIdTable(db),
                            referencedColumn: $$JournalLinesTableReferences
                                ._secondDetailedIdTable(db)
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
        bool firstDetailedId,
        bool secondDetailedId,
      })
    >;
typedef $$MemberAllocationsTableCreateCompanionBuilder =
    MemberAllocationsCompanion Function({
      Value<int> id,
      required int userID,
      required int eventID,
      required double sharePercentage,
      Value<DateTime> createAt,
    });
typedef $$MemberAllocationsTableUpdateCompanionBuilder =
    MemberAllocationsCompanion Function({
      Value<int> id,
      Value<int> userID,
      Value<int> eventID,
      Value<double> sharePercentage,
      Value<DateTime> createAt,
    });

final class $$MemberAllocationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MemberAllocationsTable,
          MemberAllocation
        > {
  $$MemberAllocationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _userIDTable(_$AppDatabase db) =>
      db.users.createAlias('member_allocations__user_i_d__users__id');

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
      db.events.createAlias('member_allocations__event_i_d__events__id');

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

class $$MemberAllocationsTableFilterComposer
    extends Composer<_$AppDatabase, $MemberAllocationsTable> {
  $$MemberAllocationsTableFilterComposer({
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

class $$MemberAllocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $MemberAllocationsTable> {
  $$MemberAllocationsTableOrderingComposer({
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

class $$MemberAllocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MemberAllocationsTable> {
  $$MemberAllocationsTableAnnotationComposer({
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

class $$MemberAllocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MemberAllocationsTable,
          MemberAllocation,
          $$MemberAllocationsTableFilterComposer,
          $$MemberAllocationsTableOrderingComposer,
          $$MemberAllocationsTableAnnotationComposer,
          $$MemberAllocationsTableCreateCompanionBuilder,
          $$MemberAllocationsTableUpdateCompanionBuilder,
          (MemberAllocation, $$MemberAllocationsTableReferences),
          MemberAllocation,
          PrefetchHooks Function({bool userID, bool eventID})
        > {
  $$MemberAllocationsTableTableManager(
    _$AppDatabase db,
    $MemberAllocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MemberAllocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MemberAllocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MemberAllocationsTableAnnotationComposer(
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
              }) => MemberAllocationsCompanion(
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
              }) => MemberAllocationsCompanion.insert(
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
                  $$MemberAllocationsTableReferences(db, table, e),
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
                        referencedTable: $$MemberAllocationsTableReferences
                            ._userIDTable(db),
                        referencedColumn: $$MemberAllocationsTableReferences
                            ._userIDTable(db)
                            .id,
                      ) as T;
                    }
                    if (eventID) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.eventID,
                        referencedTable: $$MemberAllocationsTableReferences
                            ._eventIDTable(db),
                        referencedColumn: $$MemberAllocationsTableReferences
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

typedef $$MemberAllocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MemberAllocationsTable,
      MemberAllocation,
      $$MemberAllocationsTableFilterComposer,
      $$MemberAllocationsTableOrderingComposer,
      $$MemberAllocationsTableAnnotationComposer,
      $$MemberAllocationsTableCreateCompanionBuilder,
      $$MemberAllocationsTableUpdateCompanionBuilder,
      (MemberAllocation, $$MemberAllocationsTableReferences),
      MemberAllocation,
      PrefetchHooks Function({bool userID, bool eventID})
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
typedef $$TeamFundsTableCreateCompanionBuilder = TeamFundsCompanion Function({
  Value<int> id,
  required int fundID,
  required int teamID,
  required double sharePercentage,
  Value<DateTime> createAt,
});
typedef $$TeamFundsTableUpdateCompanionBuilder = TeamFundsCompanion Function({
  Value<int> id,
  Value<int> fundID,
  Value<int> teamID,
  Value<double> sharePercentage,
  Value<DateTime> createAt,
});

final class $$TeamFundsTableReferences
    extends BaseReferences<_$AppDatabase, $TeamFundsTable, TeamFund> {
  $$TeamFundsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FundsTable _fundIDTable(_$AppDatabase db) =>
      db.funds.createAlias('team_funds__fund_i_d__funds__id');

  $$FundsTableProcessedTableManager get fundID {
    final $_column = $_itemColumn<int>('fund_i_d')!;

    final manager = $$FundsTableTableManager(
      $_db,
      $_db.funds,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fundIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TeamsTable _teamIDTable(_$AppDatabase db) =>
      db.teams.createAlias('team_funds__team_i_d__teams__id');

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

class $$TeamFundsTableFilterComposer
    extends Composer<_$AppDatabase, $TeamFundsTable> {
  $$TeamFundsTableFilterComposer({
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

  $$FundsTableFilterComposer get fundID {
    final $$FundsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fundID,
      referencedTable: $db.funds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundsTableFilterComposer(
            $db: $db,
            $table: $db.funds,
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

class $$TeamFundsTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamFundsTable> {
  $$TeamFundsTableOrderingComposer({
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

  $$FundsTableOrderingComposer get fundID {
    final $$FundsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fundID,
      referencedTable: $db.funds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundsTableOrderingComposer(
            $db: $db,
            $table: $db.funds,
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

class $$TeamFundsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamFundsTable> {
  $$TeamFundsTableAnnotationComposer({
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

  $$FundsTableAnnotationComposer get fundID {
    final $$FundsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fundID,
      referencedTable: $db.funds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FundsTableAnnotationComposer(
            $db: $db,
            $table: $db.funds,
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

class $$TeamFundsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamFundsTable,
          TeamFund,
          $$TeamFundsTableFilterComposer,
          $$TeamFundsTableOrderingComposer,
          $$TeamFundsTableAnnotationComposer,
          $$TeamFundsTableCreateCompanionBuilder,
          $$TeamFundsTableUpdateCompanionBuilder,
          (TeamFund, $$TeamFundsTableReferences),
          TeamFund,
          PrefetchHooks Function({bool fundID, bool teamID})
        > {
  $$TeamFundsTableTableManager(_$AppDatabase db, $TeamFundsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamFundsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamFundsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamFundsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fundID = const Value.absent(),
                Value<int> teamID = const Value.absent(),
                Value<double> sharePercentage = const Value.absent(),
                Value<DateTime> createAt = const Value.absent(),
              }) => TeamFundsCompanion(
                id: id,
                fundID: fundID,
                teamID: teamID,
                sharePercentage: sharePercentage,
                createAt: createAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fundID,
                required int teamID,
                required double sharePercentage,
                Value<DateTime> createAt = const Value.absent(),
              }) => TeamFundsCompanion.insert(
                id: id,
                fundID: fundID,
                teamID: teamID,
                sharePercentage: sharePercentage,
                createAt: createAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TeamFundsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fundID = false, teamID = false}) {
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
                    if (fundID) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.fundID,
                        referencedTable: $$TeamFundsTableReferences
                            ._fundIDTable(db),
                        referencedColumn: $$TeamFundsTableReferences
                            ._fundIDTable(db)
                            .id,
                      ) as T;
                    }
                    if (teamID) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.teamID,
                        referencedTable: $$TeamFundsTableReferences
                            ._teamIDTable(db),
                        referencedColumn: $$TeamFundsTableReferences
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

typedef $$TeamFundsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamFundsTable,
      TeamFund,
      $$TeamFundsTableFilterComposer,
      $$TeamFundsTableOrderingComposer,
      $$TeamFundsTableAnnotationComposer,
      $$TeamFundsTableCreateCompanionBuilder,
      $$TeamFundsTableUpdateCompanionBuilder,
      (TeamFund, $$TeamFundsTableReferences),
      TeamFund,
      PrefetchHooks Function({bool fundID, bool teamID})
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountGroupsTableTableManager get accountGroups =>
      $$AccountGroupsTableTableManager(_db, _db.accountGroups);
  $$BanksTableTableManager get banks =>
      $$BanksTableTableManager(_db, _db.banks);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db, _db.teams);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$DetailedAccountsTableTableManager get detailedAccounts =>
      $$DetailedAccountsTableTableManager(_db, _db.detailedAccounts);
  $$EventOrdersTableTableManager get eventOrders =>
      $$EventOrdersTableTableManager(_db, _db.eventOrders);
  $$FundsTableTableManager get funds =>
      $$FundsTableTableManager(_db, _db.funds);
  $$EventRegistrationsTableTableManager get eventRegistrations =>
      $$EventRegistrationsTableTableManager(_db, _db.eventRegistrations);
  $$FundAllocationsTableTableManager get fundAllocations =>
      $$FundAllocationsTableTableManager(_db, _db.fundAllocations);
  $$FundBalancesTableTableManager get fundBalances =>
      $$FundBalancesTableTableManager(_db, _db.fundBalances);
  $$GeneralAccountsTableTableManager get generalAccounts =>
      $$GeneralAccountsTableTableManager(_db, _db.generalAccounts);
  $$JournalHeadersTableTableManager get journalHeaders =>
      $$JournalHeadersTableTableManager(_db, _db.journalHeaders);
  $$SubsidiaryAccountsTableTableManager get subsidiaryAccounts =>
      $$SubsidiaryAccountsTableTableManager(_db, _db.subsidiaryAccounts);
  $$JournalLinesTableTableManager get journalLines =>
      $$JournalLinesTableTableManager(_db, _db.journalLines);
  $$MemberAllocationsTableTableManager get memberAllocations =>
      $$MemberAllocationsTableTableManager(_db, _db.memberAllocations);
  $$MenuItemsTableTableManager get menuItems =>
      $$MenuItemsTableTableManager(_db, _db.menuItems);
  $$TeamFundsTableTableManager get teamFunds =>
      $$TeamFundsTableTableManager(_db, _db.teamFunds);
  $$TeamMembersTableTableManager get teamMembers =>
      $$TeamMembersTableTableManager(_db, _db.teamMembers);
}
