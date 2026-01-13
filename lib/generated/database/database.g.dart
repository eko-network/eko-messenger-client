// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../database/database.dart';

// ignore_for_file: type=lint
class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<int> deviceId = GeneratedColumn<int>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordMeta = const VerificationMeta('record');
  @override
  late final GeneratedColumn<Uint8List> record = GeneratedColumn<Uint8List>(
    'record',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [name, deviceId, record];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Session> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('record')) {
      context.handle(
        _recordMeta,
        record.isAcceptableOrUnknown(data['record']!, _recordMeta),
      );
    } else if (isInserting) {
      context.missing(_recordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {deviceId};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}device_id'],
      )!,
      record: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}record'],
      )!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final String name;
  final int deviceId;
  final Uint8List record;
  const Session({
    required this.name,
    required this.deviceId,
    required this.record,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['device_id'] = Variable<int>(deviceId);
    map['record'] = Variable<Uint8List>(record);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      name: Value(name),
      deviceId: Value(deviceId),
      record: Value(record),
    );
  }

  factory Session.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      name: serializer.fromJson<String>(json['name']),
      deviceId: serializer.fromJson<int>(json['deviceId']),
      record: serializer.fromJson<Uint8List>(json['record']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'deviceId': serializer.toJson<int>(deviceId),
      'record': serializer.toJson<Uint8List>(record),
    };
  }

  Session copyWith({String? name, int? deviceId, Uint8List? record}) => Session(
    name: name ?? this.name,
    deviceId: deviceId ?? this.deviceId,
    record: record ?? this.record,
  );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      name: data.name.present ? data.name.value : this.name,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      record: data.record.present ? data.record.value : this.record,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('name: $name, ')
          ..write('deviceId: $deviceId, ')
          ..write('record: $record')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(name, deviceId, $driftBlobEquality.hash(record));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.name == this.name &&
          other.deviceId == this.deviceId &&
          $driftBlobEquality.equals(other.record, this.record));
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<String> name;
  final Value<int> deviceId;
  final Value<Uint8List> record;
  const SessionsCompanion({
    this.name = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.record = const Value.absent(),
  });
  SessionsCompanion.insert({
    required String name,
    this.deviceId = const Value.absent(),
    required Uint8List record,
  }) : name = Value(name),
       record = Value(record);
  static Insertable<Session> custom({
    Expression<String>? name,
    Expression<int>? deviceId,
    Expression<Uint8List>? record,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (deviceId != null) 'device_id': deviceId,
      if (record != null) 'record': record,
    });
  }

  SessionsCompanion copyWith({
    Value<String>? name,
    Value<int>? deviceId,
    Value<Uint8List>? record,
  }) {
    return SessionsCompanion(
      name: name ?? this.name,
      deviceId: deviceId ?? this.deviceId,
      record: record ?? this.record,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<int>(deviceId.value);
    }
    if (record.present) {
      map['record'] = Variable<Uint8List>(record.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('name: $name, ')
          ..write('deviceId: $deviceId, ')
          ..write('record: $record')
          ..write(')'))
        .toString();
  }
}

class $PreKeysTable extends PreKeys with TableInfo<$PreKeysTable, PreKey> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreKeysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyIdMeta = const VerificationMeta('keyId');
  @override
  late final GeneratedColumn<int> keyId = GeneratedColumn<int>(
    'key_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordMeta = const VerificationMeta('record');
  @override
  late final GeneratedColumn<Uint8List> record = GeneratedColumn<Uint8List>(
    'record',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [keyId, record];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pre_keys';
  @override
  VerificationContext validateIntegrity(
    Insertable<PreKey> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key_id')) {
      context.handle(
        _keyIdMeta,
        keyId.isAcceptableOrUnknown(data['key_id']!, _keyIdMeta),
      );
    }
    if (data.containsKey('record')) {
      context.handle(
        _recordMeta,
        record.isAcceptableOrUnknown(data['record']!, _recordMeta),
      );
    } else if (isInserting) {
      context.missing(_recordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {keyId};
  @override
  PreKey map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PreKey(
      keyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}key_id'],
      )!,
      record: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}record'],
      )!,
    );
  }

  @override
  $PreKeysTable createAlias(String alias) {
    return $PreKeysTable(attachedDatabase, alias);
  }
}

class PreKey extends DataClass implements Insertable<PreKey> {
  final int keyId;
  final Uint8List record;
  const PreKey({required this.keyId, required this.record});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key_id'] = Variable<int>(keyId);
    map['record'] = Variable<Uint8List>(record);
    return map;
  }

  PreKeysCompanion toCompanion(bool nullToAbsent) {
    return PreKeysCompanion(keyId: Value(keyId), record: Value(record));
  }

  factory PreKey.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PreKey(
      keyId: serializer.fromJson<int>(json['keyId']),
      record: serializer.fromJson<Uint8List>(json['record']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'keyId': serializer.toJson<int>(keyId),
      'record': serializer.toJson<Uint8List>(record),
    };
  }

  PreKey copyWith({int? keyId, Uint8List? record}) =>
      PreKey(keyId: keyId ?? this.keyId, record: record ?? this.record);
  PreKey copyWithCompanion(PreKeysCompanion data) {
    return PreKey(
      keyId: data.keyId.present ? data.keyId.value : this.keyId,
      record: data.record.present ? data.record.value : this.record,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PreKey(')
          ..write('keyId: $keyId, ')
          ..write('record: $record')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(keyId, $driftBlobEquality.hash(record));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PreKey &&
          other.keyId == this.keyId &&
          $driftBlobEquality.equals(other.record, this.record));
}

class PreKeysCompanion extends UpdateCompanion<PreKey> {
  final Value<int> keyId;
  final Value<Uint8List> record;
  const PreKeysCompanion({
    this.keyId = const Value.absent(),
    this.record = const Value.absent(),
  });
  PreKeysCompanion.insert({
    this.keyId = const Value.absent(),
    required Uint8List record,
  }) : record = Value(record);
  static Insertable<PreKey> custom({
    Expression<int>? keyId,
    Expression<Uint8List>? record,
  }) {
    return RawValuesInsertable({
      if (keyId != null) 'key_id': keyId,
      if (record != null) 'record': record,
    });
  }

  PreKeysCompanion copyWith({Value<int>? keyId, Value<Uint8List>? record}) {
    return PreKeysCompanion(
      keyId: keyId ?? this.keyId,
      record: record ?? this.record,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (keyId.present) {
      map['key_id'] = Variable<int>(keyId.value);
    }
    if (record.present) {
      map['record'] = Variable<Uint8List>(record.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreKeysCompanion(')
          ..write('keyId: $keyId, ')
          ..write('record: $record')
          ..write(')'))
        .toString();
  }
}

class $SignedPreKeysTable extends SignedPreKeys
    with TableInfo<$SignedPreKeysTable, SignedPreKey> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SignedPreKeysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordMeta = const VerificationMeta('record');
  @override
  late final GeneratedColumn<Uint8List> record = GeneratedColumn<Uint8List>(
    'record',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, record];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'signed_pre_keys';
  @override
  VerificationContext validateIntegrity(
    Insertable<SignedPreKey> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('record')) {
      context.handle(
        _recordMeta,
        record.isAcceptableOrUnknown(data['record']!, _recordMeta),
      );
    } else if (isInserting) {
      context.missing(_recordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SignedPreKey map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SignedPreKey(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      record: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}record'],
      )!,
    );
  }

  @override
  $SignedPreKeysTable createAlias(String alias) {
    return $SignedPreKeysTable(attachedDatabase, alias);
  }
}

class SignedPreKey extends DataClass implements Insertable<SignedPreKey> {
  final int id;
  final Uint8List record;
  const SignedPreKey({required this.id, required this.record});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['record'] = Variable<Uint8List>(record);
    return map;
  }

  SignedPreKeysCompanion toCompanion(bool nullToAbsent) {
    return SignedPreKeysCompanion(id: Value(id), record: Value(record));
  }

  factory SignedPreKey.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SignedPreKey(
      id: serializer.fromJson<int>(json['id']),
      record: serializer.fromJson<Uint8List>(json['record']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'record': serializer.toJson<Uint8List>(record),
    };
  }

  SignedPreKey copyWith({int? id, Uint8List? record}) =>
      SignedPreKey(id: id ?? this.id, record: record ?? this.record);
  SignedPreKey copyWithCompanion(SignedPreKeysCompanion data) {
    return SignedPreKey(
      id: data.id.present ? data.id.value : this.id,
      record: data.record.present ? data.record.value : this.record,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SignedPreKey(')
          ..write('id: $id, ')
          ..write('record: $record')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, $driftBlobEquality.hash(record));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignedPreKey &&
          other.id == this.id &&
          $driftBlobEquality.equals(other.record, this.record));
}

class SignedPreKeysCompanion extends UpdateCompanion<SignedPreKey> {
  final Value<int> id;
  final Value<Uint8List> record;
  const SignedPreKeysCompanion({
    this.id = const Value.absent(),
    this.record = const Value.absent(),
  });
  SignedPreKeysCompanion.insert({
    this.id = const Value.absent(),
    required Uint8List record,
  }) : record = Value(record);
  static Insertable<SignedPreKey> custom({
    Expression<int>? id,
    Expression<Uint8List>? record,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (record != null) 'record': record,
    });
  }

  SignedPreKeysCompanion copyWith({Value<int>? id, Value<Uint8List>? record}) {
    return SignedPreKeysCompanion(
      id: id ?? this.id,
      record: record ?? this.record,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (record.present) {
      map['record'] = Variable<Uint8List>(record.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SignedPreKeysCompanion(')
          ..write('id: $id, ')
          ..write('record: $record')
          ..write(')'))
        .toString();
  }
}

class $IdentitiesTable extends Identities
    with TableInfo<$IdentitiesTable, Identity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IdentitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<int> deviceId = GeneratedColumn<int>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _identityKeyMeta = const VerificationMeta(
    'identityKey',
  );
  @override
  late final GeneratedColumn<Uint8List> identityKey =
      GeneratedColumn<Uint8List>(
        'identity_key',
        aliasedName,
        false,
        type: DriftSqlType.blob,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _trustedMeta = const VerificationMeta(
    'trusted',
  );
  @override
  late final GeneratedColumn<bool> trusted = GeneratedColumn<bool>(
    'trusted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("trusted" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [name, deviceId, identityKey, trusted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'identities';
  @override
  VerificationContext validateIntegrity(
    Insertable<Identity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('identity_key')) {
      context.handle(
        _identityKeyMeta,
        identityKey.isAcceptableOrUnknown(
          data['identity_key']!,
          _identityKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_identityKeyMeta);
    }
    if (data.containsKey('trusted')) {
      context.handle(
        _trustedMeta,
        trusted.isAcceptableOrUnknown(data['trusted']!, _trustedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {deviceId};
  @override
  Identity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Identity(
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}device_id'],
      )!,
      identityKey: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}identity_key'],
      )!,
      trusted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}trusted'],
      )!,
    );
  }

  @override
  $IdentitiesTable createAlias(String alias) {
    return $IdentitiesTable(attachedDatabase, alias);
  }
}

class Identity extends DataClass implements Insertable<Identity> {
  final String name;
  final int deviceId;
  final Uint8List identityKey;
  final bool trusted;
  const Identity({
    required this.name,
    required this.deviceId,
    required this.identityKey,
    required this.trusted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['device_id'] = Variable<int>(deviceId);
    map['identity_key'] = Variable<Uint8List>(identityKey);
    map['trusted'] = Variable<bool>(trusted);
    return map;
  }

  IdentitiesCompanion toCompanion(bool nullToAbsent) {
    return IdentitiesCompanion(
      name: Value(name),
      deviceId: Value(deviceId),
      identityKey: Value(identityKey),
      trusted: Value(trusted),
    );
  }

  factory Identity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Identity(
      name: serializer.fromJson<String>(json['name']),
      deviceId: serializer.fromJson<int>(json['deviceId']),
      identityKey: serializer.fromJson<Uint8List>(json['identityKey']),
      trusted: serializer.fromJson<bool>(json['trusted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'deviceId': serializer.toJson<int>(deviceId),
      'identityKey': serializer.toJson<Uint8List>(identityKey),
      'trusted': serializer.toJson<bool>(trusted),
    };
  }

  Identity copyWith({
    String? name,
    int? deviceId,
    Uint8List? identityKey,
    bool? trusted,
  }) => Identity(
    name: name ?? this.name,
    deviceId: deviceId ?? this.deviceId,
    identityKey: identityKey ?? this.identityKey,
    trusted: trusted ?? this.trusted,
  );
  Identity copyWithCompanion(IdentitiesCompanion data) {
    return Identity(
      name: data.name.present ? data.name.value : this.name,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      identityKey: data.identityKey.present
          ? data.identityKey.value
          : this.identityKey,
      trusted: data.trusted.present ? data.trusted.value : this.trusted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Identity(')
          ..write('name: $name, ')
          ..write('deviceId: $deviceId, ')
          ..write('identityKey: $identityKey, ')
          ..write('trusted: $trusted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    name,
    deviceId,
    $driftBlobEquality.hash(identityKey),
    trusted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Identity &&
          other.name == this.name &&
          other.deviceId == this.deviceId &&
          $driftBlobEquality.equals(other.identityKey, this.identityKey) &&
          other.trusted == this.trusted);
}

class IdentitiesCompanion extends UpdateCompanion<Identity> {
  final Value<String> name;
  final Value<int> deviceId;
  final Value<Uint8List> identityKey;
  final Value<bool> trusted;
  const IdentitiesCompanion({
    this.name = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.identityKey = const Value.absent(),
    this.trusted = const Value.absent(),
  });
  IdentitiesCompanion.insert({
    required String name,
    this.deviceId = const Value.absent(),
    required Uint8List identityKey,
    this.trusted = const Value.absent(),
  }) : name = Value(name),
       identityKey = Value(identityKey);
  static Insertable<Identity> custom({
    Expression<String>? name,
    Expression<int>? deviceId,
    Expression<Uint8List>? identityKey,
    Expression<bool>? trusted,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (deviceId != null) 'device_id': deviceId,
      if (identityKey != null) 'identity_key': identityKey,
      if (trusted != null) 'trusted': trusted,
    });
  }

  IdentitiesCompanion copyWith({
    Value<String>? name,
    Value<int>? deviceId,
    Value<Uint8List>? identityKey,
    Value<bool>? trusted,
  }) {
    return IdentitiesCompanion(
      name: name ?? this.name,
      deviceId: deviceId ?? this.deviceId,
      identityKey: identityKey ?? this.identityKey,
      trusted: trusted ?? this.trusted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<int>(deviceId.value);
    }
    if (identityKey.present) {
      map['identity_key'] = Variable<Uint8List>(identityKey.value);
    }
    if (trusted.present) {
      map['trusted'] = Variable<bool>(trusted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IdentitiesCompanion(')
          ..write('name: $name, ')
          ..write('deviceId: $deviceId, ')
          ..write('identityKey: $identityKey, ')
          ..write('trusted: $trusted')
          ..write(')'))
        .toString();
  }
}

class $LocalIdentityTable extends LocalIdentity
    with TableInfo<$LocalIdentityTable, LocalIdentityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalIdentityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _identityKeyPairMeta = const VerificationMeta(
    'identityKeyPair',
  );
  @override
  late final GeneratedColumn<Uint8List> identityKeyPair =
      GeneratedColumn<Uint8List>(
        'identity_key_pair',
        aliasedName,
        false,
        type: DriftSqlType.blob,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _registrationIdMeta = const VerificationMeta(
    'registrationId',
  );
  @override
  late final GeneratedColumn<int> registrationId = GeneratedColumn<int>(
    'registration_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, identityKeyPair, registrationId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_identity';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalIdentityData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('identity_key_pair')) {
      context.handle(
        _identityKeyPairMeta,
        identityKeyPair.isAcceptableOrUnknown(
          data['identity_key_pair']!,
          _identityKeyPairMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_identityKeyPairMeta);
    }
    if (data.containsKey('registration_id')) {
      context.handle(
        _registrationIdMeta,
        registrationId.isAcceptableOrUnknown(
          data['registration_id']!,
          _registrationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_registrationIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalIdentityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalIdentityData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      identityKeyPair: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}identity_key_pair'],
      )!,
      registrationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}registration_id'],
      )!,
    );
  }

  @override
  $LocalIdentityTable createAlias(String alias) {
    return $LocalIdentityTable(attachedDatabase, alias);
  }
}

class LocalIdentityData extends DataClass
    implements Insertable<LocalIdentityData> {
  final int id;
  final Uint8List identityKeyPair;
  final int registrationId;
  const LocalIdentityData({
    required this.id,
    required this.identityKeyPair,
    required this.registrationId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['identity_key_pair'] = Variable<Uint8List>(identityKeyPair);
    map['registration_id'] = Variable<int>(registrationId);
    return map;
  }

  LocalIdentityCompanion toCompanion(bool nullToAbsent) {
    return LocalIdentityCompanion(
      id: Value(id),
      identityKeyPair: Value(identityKeyPair),
      registrationId: Value(registrationId),
    );
  }

  factory LocalIdentityData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalIdentityData(
      id: serializer.fromJson<int>(json['id']),
      identityKeyPair: serializer.fromJson<Uint8List>(json['identityKeyPair']),
      registrationId: serializer.fromJson<int>(json['registrationId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'identityKeyPair': serializer.toJson<Uint8List>(identityKeyPair),
      'registrationId': serializer.toJson<int>(registrationId),
    };
  }

  LocalIdentityData copyWith({
    int? id,
    Uint8List? identityKeyPair,
    int? registrationId,
  }) => LocalIdentityData(
    id: id ?? this.id,
    identityKeyPair: identityKeyPair ?? this.identityKeyPair,
    registrationId: registrationId ?? this.registrationId,
  );
  LocalIdentityData copyWithCompanion(LocalIdentityCompanion data) {
    return LocalIdentityData(
      id: data.id.present ? data.id.value : this.id,
      identityKeyPair: data.identityKeyPair.present
          ? data.identityKeyPair.value
          : this.identityKeyPair,
      registrationId: data.registrationId.present
          ? data.registrationId.value
          : this.registrationId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalIdentityData(')
          ..write('id: $id, ')
          ..write('identityKeyPair: $identityKeyPair, ')
          ..write('registrationId: $registrationId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, $driftBlobEquality.hash(identityKeyPair), registrationId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalIdentityData &&
          other.id == this.id &&
          $driftBlobEquality.equals(
            other.identityKeyPair,
            this.identityKeyPair,
          ) &&
          other.registrationId == this.registrationId);
}

class LocalIdentityCompanion extends UpdateCompanion<LocalIdentityData> {
  final Value<int> id;
  final Value<Uint8List> identityKeyPair;
  final Value<int> registrationId;
  const LocalIdentityCompanion({
    this.id = const Value.absent(),
    this.identityKeyPair = const Value.absent(),
    this.registrationId = const Value.absent(),
  });
  LocalIdentityCompanion.insert({
    this.id = const Value.absent(),
    required Uint8List identityKeyPair,
    required int registrationId,
  }) : identityKeyPair = Value(identityKeyPair),
       registrationId = Value(registrationId);
  static Insertable<LocalIdentityData> custom({
    Expression<int>? id,
    Expression<Uint8List>? identityKeyPair,
    Expression<int>? registrationId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (identityKeyPair != null) 'identity_key_pair': identityKeyPair,
      if (registrationId != null) 'registration_id': registrationId,
    });
  }

  LocalIdentityCompanion copyWith({
    Value<int>? id,
    Value<Uint8List>? identityKeyPair,
    Value<int>? registrationId,
  }) {
    return LocalIdentityCompanion(
      id: id ?? this.id,
      identityKeyPair: identityKeyPair ?? this.identityKeyPair,
      registrationId: registrationId ?? this.registrationId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (identityKeyPair.present) {
      map['identity_key_pair'] = Variable<Uint8List>(identityKeyPair.value);
    }
    if (registrationId.present) {
      map['registration_id'] = Variable<int>(registrationId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalIdentityCompanion(')
          ..write('id: $id, ')
          ..write('identityKeyPair: $identityKeyPair, ')
          ..write('registrationId: $registrationId')
          ..write(')'))
        .toString();
  }
}

class $CapabilitiesTable extends Capabilities
    with TableInfo<$CapabilitiesTable, Capability> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CapabilitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  capabilities =
      GeneratedColumn<String>(
        'capabilities',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Map<String, dynamic>>(
        $CapabilitiesTable.$convertercapabilities,
      );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, capabilities, time];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'capabilities';
  @override
  VerificationContext validateIntegrity(
    Insertable<Capability> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Capability map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Capability(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      capabilities: $CapabilitiesTable.$convertercapabilities.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}capabilities'],
        )!,
      ),
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time'],
      )!,
    );
  }

  @override
  $CapabilitiesTable createAlias(String alias) {
    return $CapabilitiesTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String> $convertercapabilities =
      const JsonValueConverter();
}

class Capability extends DataClass implements Insertable<Capability> {
  final int id;
  final Map<String, dynamic> capabilities;
  final DateTime time;
  const Capability({
    required this.id,
    required this.capabilities,
    required this.time,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['capabilities'] = Variable<String>(
        $CapabilitiesTable.$convertercapabilities.toSql(capabilities),
      );
    }
    map['time'] = Variable<DateTime>(time);
    return map;
  }

  CapabilitiesCompanion toCompanion(bool nullToAbsent) {
    return CapabilitiesCompanion(
      id: Value(id),
      capabilities: Value(capabilities),
      time: Value(time),
    );
  }

  factory Capability.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Capability(
      id: serializer.fromJson<int>(json['id']),
      capabilities: serializer.fromJson<Map<String, dynamic>>(
        json['capabilities'],
      ),
      time: serializer.fromJson<DateTime>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'capabilities': serializer.toJson<Map<String, dynamic>>(capabilities),
      'time': serializer.toJson<DateTime>(time),
    };
  }

  Capability copyWith({
    int? id,
    Map<String, dynamic>? capabilities,
    DateTime? time,
  }) => Capability(
    id: id ?? this.id,
    capabilities: capabilities ?? this.capabilities,
    time: time ?? this.time,
  );
  Capability copyWithCompanion(CapabilitiesCompanion data) {
    return Capability(
      id: data.id.present ? data.id.value : this.id,
      capabilities: data.capabilities.present
          ? data.capabilities.value
          : this.capabilities,
      time: data.time.present ? data.time.value : this.time,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Capability(')
          ..write('id: $id, ')
          ..write('capabilities: $capabilities, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, capabilities, time);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Capability &&
          other.id == this.id &&
          other.capabilities == this.capabilities &&
          other.time == this.time);
}

class CapabilitiesCompanion extends UpdateCompanion<Capability> {
  final Value<int> id;
  final Value<Map<String, dynamic>> capabilities;
  final Value<DateTime> time;
  const CapabilitiesCompanion({
    this.id = const Value.absent(),
    this.capabilities = const Value.absent(),
    this.time = const Value.absent(),
  });
  CapabilitiesCompanion.insert({
    this.id = const Value.absent(),
    required Map<String, dynamic> capabilities,
    this.time = const Value.absent(),
  }) : capabilities = Value(capabilities);
  static Insertable<Capability> custom({
    Expression<int>? id,
    Expression<String>? capabilities,
    Expression<DateTime>? time,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (capabilities != null) 'capabilities': capabilities,
      if (time != null) 'time': time,
    });
  }

  CapabilitiesCompanion copyWith({
    Value<int>? id,
    Value<Map<String, dynamic>>? capabilities,
    Value<DateTime>? time,
  }) {
    return CapabilitiesCompanion(
      id: id ?? this.id,
      capabilities: capabilities ?? this.capabilities,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (capabilities.present) {
      map['capabilities'] = Variable<String>(
        $CapabilitiesTable.$convertercapabilities.toSql(capabilities.value),
      );
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CapabilitiesCompanion(')
          ..write('id: $id, ')
          ..write('capabilities: $capabilities, ')
          ..write('time: $time')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id];
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
    } else if (isInserting) {
      context.missing(_idMeta);
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
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  const User({required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(id: Value(id));
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(id: serializer.fromJson<String>(json['id']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'id': serializer.toJson<String>(id)};
  }

  User copyWith({String? id}) => User(id: id ?? this.id);
  User copyWithCompanion(UsersCompanion data) {
    return User(id: data.id.present ? data.id.value : this.id);
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is User && other.id == this.id);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({required String id, this.rowid = const Value.absent()})
    : id = Value(id);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({Value<String>? id, Value<int>? rowid}) {
    return UsersCompanion(id: id ?? this.id, rowid: rowid ?? this.rowid);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserDevicesTable extends UserDevices
    with TableInfo<$UserDevicesTable, UserDevice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserDevicesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<int> deviceId = GeneratedColumn<int>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, deviceId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_devices';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserDevice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserDevice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserDevice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $UserDevicesTable createAlias(String alias) {
    return $UserDevicesTable(attachedDatabase, alias);
  }
}

class UserDevice extends DataClass implements Insertable<UserDevice> {
  final int id;
  final String userId;
  final int deviceId;
  const UserDevice({
    required this.id,
    required this.userId,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['device_id'] = Variable<int>(deviceId);
    return map;
  }

  UserDevicesCompanion toCompanion(bool nullToAbsent) {
    return UserDevicesCompanion(
      id: Value(id),
      userId: Value(userId),
      deviceId: Value(deviceId),
    );
  }

  factory UserDevice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserDevice(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      deviceId: serializer.fromJson<int>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'deviceId': serializer.toJson<int>(deviceId),
    };
  }

  UserDevice copyWith({int? id, String? userId, int? deviceId}) => UserDevice(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    deviceId: deviceId ?? this.deviceId,
  );
  UserDevice copyWithCompanion(UserDevicesCompanion data) {
    return UserDevice(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserDevice(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, deviceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDevice &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.deviceId == this.deviceId);
}

class UserDevicesCompanion extends UpdateCompanion<UserDevice> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> deviceId;
  const UserDevicesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  UserDevicesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int deviceId,
  }) : userId = Value(userId),
       deviceId = Value(deviceId);
  static Insertable<UserDevice> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  UserDevicesCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<int>? deviceId,
  }) {
    return UserDevicesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<int>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserDevicesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $AuthInfoTableTable extends AuthInfoTable
    with TableInfo<$AuthInfoTableTable, AuthInfoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuthInfoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _didMeta = const VerificationMeta('did');
  @override
  late final GeneratedColumn<int> did = GeneratedColumn<int>(
    'did',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accessTokenMeta = const VerificationMeta(
    'accessToken',
  );
  @override
  late final GeneratedColumn<String> accessToken = GeneratedColumn<String>(
    'access_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refreshTokenMeta = const VerificationMeta(
    'refreshToken',
  );
  @override
  late final GeneratedColumn<String> refreshToken = GeneratedColumn<String>(
    'refresh_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actorJsonMeta = const VerificationMeta(
    'actorJson',
  );
  @override
  late final GeneratedColumn<String> actorJson = GeneratedColumn<String>(
    'actor_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverUrlMeta = const VerificationMeta(
    'serverUrl',
  );
  @override
  late final GeneratedColumn<String> serverUrl = GeneratedColumn<String>(
    'server_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    did,
    accessToken,
    refreshToken,
    expiresAt,
    actorJson,
    serverUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'auth_info_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuthInfoTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('did')) {
      context.handle(
        _didMeta,
        did.isAcceptableOrUnknown(data['did']!, _didMeta),
      );
    } else if (isInserting) {
      context.missing(_didMeta);
    }
    if (data.containsKey('access_token')) {
      context.handle(
        _accessTokenMeta,
        accessToken.isAcceptableOrUnknown(
          data['access_token']!,
          _accessTokenMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accessTokenMeta);
    }
    if (data.containsKey('refresh_token')) {
      context.handle(
        _refreshTokenMeta,
        refreshToken.isAcceptableOrUnknown(
          data['refresh_token']!,
          _refreshTokenMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_refreshTokenMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('actor_json')) {
      context.handle(
        _actorJsonMeta,
        actorJson.isAcceptableOrUnknown(data['actor_json']!, _actorJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_actorJsonMeta);
    }
    if (data.containsKey('server_url')) {
      context.handle(
        _serverUrlMeta,
        serverUrl.isAcceptableOrUnknown(data['server_url']!, _serverUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_serverUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuthInfoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuthInfoTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      did: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}did'],
      )!,
      accessToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}access_token'],
      )!,
      refreshToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}refresh_token'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      )!,
      actorJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor_json'],
      )!,
      serverUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_url'],
      )!,
    );
  }

  @override
  $AuthInfoTableTable createAlias(String alias) {
    return $AuthInfoTableTable(attachedDatabase, alias);
  }
}

class AuthInfoTableData extends DataClass
    implements Insertable<AuthInfoTableData> {
  final int id;
  final int did;
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;
  final String actorJson;
  final String serverUrl;
  const AuthInfoTableData({
    required this.id,
    required this.did,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    required this.actorJson,
    required this.serverUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['did'] = Variable<int>(did);
    map['access_token'] = Variable<String>(accessToken);
    map['refresh_token'] = Variable<String>(refreshToken);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    map['actor_json'] = Variable<String>(actorJson);
    map['server_url'] = Variable<String>(serverUrl);
    return map;
  }

  AuthInfoTableCompanion toCompanion(bool nullToAbsent) {
    return AuthInfoTableCompanion(
      id: Value(id),
      did: Value(did),
      accessToken: Value(accessToken),
      refreshToken: Value(refreshToken),
      expiresAt: Value(expiresAt),
      actorJson: Value(actorJson),
      serverUrl: Value(serverUrl),
    );
  }

  factory AuthInfoTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuthInfoTableData(
      id: serializer.fromJson<int>(json['id']),
      did: serializer.fromJson<int>(json['did']),
      accessToken: serializer.fromJson<String>(json['accessToken']),
      refreshToken: serializer.fromJson<String>(json['refreshToken']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
      actorJson: serializer.fromJson<String>(json['actorJson']),
      serverUrl: serializer.fromJson<String>(json['serverUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'did': serializer.toJson<int>(did),
      'accessToken': serializer.toJson<String>(accessToken),
      'refreshToken': serializer.toJson<String>(refreshToken),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
      'actorJson': serializer.toJson<String>(actorJson),
      'serverUrl': serializer.toJson<String>(serverUrl),
    };
  }

  AuthInfoTableData copyWith({
    int? id,
    int? did,
    String? accessToken,
    String? refreshToken,
    DateTime? expiresAt,
    String? actorJson,
    String? serverUrl,
  }) => AuthInfoTableData(
    id: id ?? this.id,
    did: did ?? this.did,
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
    expiresAt: expiresAt ?? this.expiresAt,
    actorJson: actorJson ?? this.actorJson,
    serverUrl: serverUrl ?? this.serverUrl,
  );
  AuthInfoTableData copyWithCompanion(AuthInfoTableCompanion data) {
    return AuthInfoTableData(
      id: data.id.present ? data.id.value : this.id,
      did: data.did.present ? data.did.value : this.did,
      accessToken: data.accessToken.present
          ? data.accessToken.value
          : this.accessToken,
      refreshToken: data.refreshToken.present
          ? data.refreshToken.value
          : this.refreshToken,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      actorJson: data.actorJson.present ? data.actorJson.value : this.actorJson,
      serverUrl: data.serverUrl.present ? data.serverUrl.value : this.serverUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuthInfoTableData(')
          ..write('id: $id, ')
          ..write('did: $did, ')
          ..write('accessToken: $accessToken, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('actorJson: $actorJson, ')
          ..write('serverUrl: $serverUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    did,
    accessToken,
    refreshToken,
    expiresAt,
    actorJson,
    serverUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthInfoTableData &&
          other.id == this.id &&
          other.did == this.did &&
          other.accessToken == this.accessToken &&
          other.refreshToken == this.refreshToken &&
          other.expiresAt == this.expiresAt &&
          other.actorJson == this.actorJson &&
          other.serverUrl == this.serverUrl);
}

class AuthInfoTableCompanion extends UpdateCompanion<AuthInfoTableData> {
  final Value<int> id;
  final Value<int> did;
  final Value<String> accessToken;
  final Value<String> refreshToken;
  final Value<DateTime> expiresAt;
  final Value<String> actorJson;
  final Value<String> serverUrl;
  const AuthInfoTableCompanion({
    this.id = const Value.absent(),
    this.did = const Value.absent(),
    this.accessToken = const Value.absent(),
    this.refreshToken = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.actorJson = const Value.absent(),
    this.serverUrl = const Value.absent(),
  });
  AuthInfoTableCompanion.insert({
    this.id = const Value.absent(),
    required int did,
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
    required String actorJson,
    required String serverUrl,
  }) : did = Value(did),
       accessToken = Value(accessToken),
       refreshToken = Value(refreshToken),
       expiresAt = Value(expiresAt),
       actorJson = Value(actorJson),
       serverUrl = Value(serverUrl);
  static Insertable<AuthInfoTableData> custom({
    Expression<int>? id,
    Expression<int>? did,
    Expression<String>? accessToken,
    Expression<String>? refreshToken,
    Expression<DateTime>? expiresAt,
    Expression<String>? actorJson,
    Expression<String>? serverUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (did != null) 'did': did,
      if (accessToken != null) 'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (actorJson != null) 'actor_json': actorJson,
      if (serverUrl != null) 'server_url': serverUrl,
    });
  }

  AuthInfoTableCompanion copyWith({
    Value<int>? id,
    Value<int>? did,
    Value<String>? accessToken,
    Value<String>? refreshToken,
    Value<DateTime>? expiresAt,
    Value<String>? actorJson,
    Value<String>? serverUrl,
  }) {
    return AuthInfoTableCompanion(
      id: id ?? this.id,
      did: did ?? this.did,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
      actorJson: actorJson ?? this.actorJson,
      serverUrl: serverUrl ?? this.serverUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (did.present) {
      map['did'] = Variable<int>(did.value);
    }
    if (accessToken.present) {
      map['access_token'] = Variable<String>(accessToken.value);
    }
    if (refreshToken.present) {
      map['refresh_token'] = Variable<String>(refreshToken.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (actorJson.present) {
      map['actor_json'] = Variable<String>(actorJson.value);
    }
    if (serverUrl.present) {
      map['server_url'] = Variable<String>(serverUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthInfoTableCompanion(')
          ..write('id: $id, ')
          ..write('did: $did, ')
          ..write('accessToken: $accessToken, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('actorJson: $actorJson, ')
          ..write('serverUrl: $serverUrl')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<UuidValue, String> id =
      GeneratedColumn<String>(
        'id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<UuidValue>($MessagesTable.$converterid);
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String> to =
      GeneratedColumn<String>(
        'to',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Uri>($MessagesTable.$converterto);
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String> from =
      GeneratedColumn<String>(
        'from',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Uri>($MessagesTable.$converterfrom);
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<UuidValue?, String> inReplyTo =
      GeneratedColumn<String>(
        'in_reply_to',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<UuidValue?>($MessagesTable.$converterinReplyTon);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MessageStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<MessageStatus>($MessagesTable.$converterstatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    to,
    from,
    content,
    inReplyTo,
    time,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Message> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id: $MessagesTable.$converterid.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}id'],
        )!,
      ),
      to: $MessagesTable.$converterto.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}to'],
        )!,
      ),
      from: $MessagesTable.$converterfrom.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}from'],
        )!,
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      inReplyTo: $MessagesTable.$converterinReplyTon.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}in_reply_to'],
        ),
      ),
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time'],
      )!,
      status: $MessagesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }

  static TypeConverter<UuidValue, String> $converterid =
      const UuidValueConverter();
  static TypeConverter<Uri, String> $converterto = const UriTypeConverter();
  static TypeConverter<Uri, String> $converterfrom = const UriTypeConverter();
  static TypeConverter<UuidValue, String> $converterinReplyTo =
      const UuidValueConverter();
  static TypeConverter<UuidValue?, String?> $converterinReplyTon =
      NullAwareTypeConverter.wrap($converterinReplyTo);
  static JsonTypeConverter2<MessageStatus, int, int> $converterstatus =
      const EnumIndexConverter<MessageStatus>(MessageStatus.values);
}

class Message extends DataClass implements Insertable<Message> {
  final UuidValue id;
  final Uri to;
  final Uri from;
  final String? content;
  final UuidValue? inReplyTo;
  final DateTime time;
  final MessageStatus status;
  const Message({
    required this.id,
    required this.to,
    required this.from,
    this.content,
    this.inReplyTo,
    required this.time,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['id'] = Variable<String>($MessagesTable.$converterid.toSql(id));
    }
    {
      map['to'] = Variable<String>($MessagesTable.$converterto.toSql(to));
    }
    {
      map['from'] = Variable<String>($MessagesTable.$converterfrom.toSql(from));
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || inReplyTo != null) {
      map['in_reply_to'] = Variable<String>(
        $MessagesTable.$converterinReplyTon.toSql(inReplyTo),
      );
    }
    map['time'] = Variable<DateTime>(time);
    {
      map['status'] = Variable<int>(
        $MessagesTable.$converterstatus.toSql(status),
      );
    }
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      to: Value(to),
      from: Value(from),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      inReplyTo: inReplyTo == null && nullToAbsent
          ? const Value.absent()
          : Value(inReplyTo),
      time: Value(time),
      status: Value(status),
    );
  }

  factory Message.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<UuidValue>(json['id']),
      to: serializer.fromJson<Uri>(json['to']),
      from: serializer.fromJson<Uri>(json['from']),
      content: serializer.fromJson<String?>(json['content']),
      inReplyTo: serializer.fromJson<UuidValue?>(json['inReplyTo']),
      time: serializer.fromJson<DateTime>(json['time']),
      status: $MessagesTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<UuidValue>(id),
      'to': serializer.toJson<Uri>(to),
      'from': serializer.toJson<Uri>(from),
      'content': serializer.toJson<String?>(content),
      'inReplyTo': serializer.toJson<UuidValue?>(inReplyTo),
      'time': serializer.toJson<DateTime>(time),
      'status': serializer.toJson<int>(
        $MessagesTable.$converterstatus.toJson(status),
      ),
    };
  }

  Message copyWith({
    UuidValue? id,
    Uri? to,
    Uri? from,
    Value<String?> content = const Value.absent(),
    Value<UuidValue?> inReplyTo = const Value.absent(),
    DateTime? time,
    MessageStatus? status,
  }) => Message(
    id: id ?? this.id,
    to: to ?? this.to,
    from: from ?? this.from,
    content: content.present ? content.value : this.content,
    inReplyTo: inReplyTo.present ? inReplyTo.value : this.inReplyTo,
    time: time ?? this.time,
    status: status ?? this.status,
  );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      id: data.id.present ? data.id.value : this.id,
      to: data.to.present ? data.to.value : this.to,
      from: data.from.present ? data.from.value : this.from,
      content: data.content.present ? data.content.value : this.content,
      inReplyTo: data.inReplyTo.present ? data.inReplyTo.value : this.inReplyTo,
      time: data.time.present ? data.time.value : this.time,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('to: $to, ')
          ..write('from: $from, ')
          ..write('content: $content, ')
          ..write('inReplyTo: $inReplyTo, ')
          ..write('time: $time, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, to, from, content, inReplyTo, time, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.to == this.to &&
          other.from == this.from &&
          other.content == this.content &&
          other.inReplyTo == this.inReplyTo &&
          other.time == this.time &&
          other.status == this.status);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<UuidValue> id;
  final Value<Uri> to;
  final Value<Uri> from;
  final Value<String?> content;
  final Value<UuidValue?> inReplyTo;
  final Value<DateTime> time;
  final Value<MessageStatus> status;
  final Value<int> rowid;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.to = const Value.absent(),
    this.from = const Value.absent(),
    this.content = const Value.absent(),
    this.inReplyTo = const Value.absent(),
    this.time = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagesCompanion.insert({
    required UuidValue id,
    required Uri to,
    required Uri from,
    this.content = const Value.absent(),
    this.inReplyTo = const Value.absent(),
    required DateTime time,
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       to = Value(to),
       from = Value(from),
       time = Value(time);
  static Insertable<Message> custom({
    Expression<String>? id,
    Expression<String>? to,
    Expression<String>? from,
    Expression<String>? content,
    Expression<String>? inReplyTo,
    Expression<DateTime>? time,
    Expression<int>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (to != null) 'to': to,
      if (from != null) 'from': from,
      if (content != null) 'content': content,
      if (inReplyTo != null) 'in_reply_to': inReplyTo,
      if (time != null) 'time': time,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagesCompanion copyWith({
    Value<UuidValue>? id,
    Value<Uri>? to,
    Value<Uri>? from,
    Value<String?>? content,
    Value<UuidValue?>? inReplyTo,
    Value<DateTime>? time,
    Value<MessageStatus>? status,
    Value<int>? rowid,
  }) {
    return MessagesCompanion(
      id: id ?? this.id,
      to: to ?? this.to,
      from: from ?? this.from,
      content: content ?? this.content,
      inReplyTo: inReplyTo ?? this.inReplyTo,
      time: time ?? this.time,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>($MessagesTable.$converterid.toSql(id.value));
    }
    if (to.present) {
      map['to'] = Variable<String>($MessagesTable.$converterto.toSql(to.value));
    }
    if (from.present) {
      map['from'] = Variable<String>(
        $MessagesTable.$converterfrom.toSql(from.value),
      );
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (inReplyTo.present) {
      map['in_reply_to'] = Variable<String>(
        $MessagesTable.$converterinReplyTon.toSql(inReplyTo.value),
      );
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $MessagesTable.$converterstatus.toSql(status.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('to: $to, ')
          ..write('from: $from, ')
          ..write('content: $content, ')
          ..write('inReplyTo: $inReplyTo, ')
          ..write('time: $time, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Person> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String> id =
      GeneratedColumn<String>(
        'id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Uri>($ContactsTable.$converterid);
  static const VerificationMeta _preferredUsernameMeta = const VerificationMeta(
    'preferredUsername',
  );
  @override
  late final GeneratedColumn<String> preferredUsername =
      GeneratedColumn<String>(
        'preferred_username',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String> inbox =
      GeneratedColumn<String>(
        'inbox',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Uri>($ContactsTable.$converterinbox);
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String> outbox =
      GeneratedColumn<String>(
        'outbox',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Uri>($ContactsTable.$converteroutbox);
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String> keyBundle =
      GeneratedColumn<String>(
        'key_bundle',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Uri>($ContactsTable.$converterkeyBundle);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    preferredUsername,
    inbox,
    outbox,
    keyBundle,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Person> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('preferred_username')) {
      context.handle(
        _preferredUsernameMeta,
        preferredUsername.isAcceptableOrUnknown(
          data['preferred_username']!,
          _preferredUsernameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_preferredUsernameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Person map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Person(
      id: $ContactsTable.$converterid.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}id'],
        )!,
      ),
      inbox: $ContactsTable.$converterinbox.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}inbox'],
        )!,
      ),
      outbox: $ContactsTable.$converteroutbox.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}outbox'],
        )!,
      ),
      keyBundle: $ContactsTable.$converterkeyBundle.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}key_bundle'],
        )!,
      ),
      preferredUsername: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_username'],
      )!,
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }

  static TypeConverter<Uri, String> $converterid = const UriTypeConverter();
  static TypeConverter<Uri, String> $converterinbox = const UriTypeConverter();
  static TypeConverter<Uri, String> $converteroutbox = const UriTypeConverter();
  static TypeConverter<Uri, String> $converterkeyBundle =
      const UriTypeConverter();
}

class ContactsCompanion extends UpdateCompanion<Person> {
  final Value<Uri> id;
  final Value<String> preferredUsername;
  final Value<Uri> inbox;
  final Value<Uri> outbox;
  final Value<Uri> keyBundle;
  final Value<int> rowid;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.preferredUsername = const Value.absent(),
    this.inbox = const Value.absent(),
    this.outbox = const Value.absent(),
    this.keyBundle = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContactsCompanion.insert({
    required Uri id,
    required String preferredUsername,
    required Uri inbox,
    required Uri outbox,
    required Uri keyBundle,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       preferredUsername = Value(preferredUsername),
       inbox = Value(inbox),
       outbox = Value(outbox),
       keyBundle = Value(keyBundle);
  static Insertable<Person> custom({
    Expression<String>? id,
    Expression<String>? preferredUsername,
    Expression<String>? inbox,
    Expression<String>? outbox,
    Expression<String>? keyBundle,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (preferredUsername != null) 'preferred_username': preferredUsername,
      if (inbox != null) 'inbox': inbox,
      if (outbox != null) 'outbox': outbox,
      if (keyBundle != null) 'key_bundle': keyBundle,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContactsCompanion copyWith({
    Value<Uri>? id,
    Value<String>? preferredUsername,
    Value<Uri>? inbox,
    Value<Uri>? outbox,
    Value<Uri>? keyBundle,
    Value<int>? rowid,
  }) {
    return ContactsCompanion(
      id: id ?? this.id,
      preferredUsername: preferredUsername ?? this.preferredUsername,
      inbox: inbox ?? this.inbox,
      outbox: outbox ?? this.outbox,
      keyBundle: keyBundle ?? this.keyBundle,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>($ContactsTable.$converterid.toSql(id.value));
    }
    if (preferredUsername.present) {
      map['preferred_username'] = Variable<String>(preferredUsername.value);
    }
    if (inbox.present) {
      map['inbox'] = Variable<String>(
        $ContactsTable.$converterinbox.toSql(inbox.value),
      );
    }
    if (outbox.present) {
      map['outbox'] = Variable<String>(
        $ContactsTable.$converteroutbox.toSql(outbox.value),
      );
    }
    if (keyBundle.present) {
      map['key_bundle'] = Variable<String>(
        $ContactsTable.$converterkeyBundle.toSql(keyBundle.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('preferredUsername: $preferredUsername, ')
          ..write('inbox: $inbox, ')
          ..write('outbox: $outbox, ')
          ..write('keyBundle: $keyBundle, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConversationsTable extends Conversations
    with TableInfo<$ConversationsTable, Conversation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationsTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String> participant =
      GeneratedColumn<String>(
        'participant',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES contacts (id) ON DELETE CASCADE',
        ),
      ).withConverter<Uri>($ConversationsTable.$converterparticipant);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [participant, id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Conversation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Conversation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Conversation(
      participant: $ConversationsTable.$converterparticipant.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}participant'],
        )!,
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
    );
  }

  @override
  $ConversationsTable createAlias(String alias) {
    return $ConversationsTable(attachedDatabase, alias);
  }

  static TypeConverter<Uri, String> $converterparticipant =
      const UriTypeConverter();
}

class Conversation extends DataClass implements Insertable<Conversation> {
  final Uri participant;
  final int id;
  const Conversation({required this.participant, required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['participant'] = Variable<String>(
        $ConversationsTable.$converterparticipant.toSql(participant),
      );
    }
    map['id'] = Variable<int>(id);
    return map;
  }

  ConversationsCompanion toCompanion(bool nullToAbsent) {
    return ConversationsCompanion(
      participant: Value(participant),
      id: Value(id),
    );
  }

  factory Conversation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Conversation(
      participant: serializer.fromJson<Uri>(json['participant']),
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'participant': serializer.toJson<Uri>(participant),
      'id': serializer.toJson<int>(id),
    };
  }

  Conversation copyWith({Uri? participant, int? id}) => Conversation(
    participant: participant ?? this.participant,
    id: id ?? this.id,
  );
  Conversation copyWithCompanion(ConversationsCompanion data) {
    return Conversation(
      participant: data.participant.present
          ? data.participant.value
          : this.participant,
      id: data.id.present ? data.id.value : this.id,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Conversation(')
          ..write('participant: $participant, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(participant, id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Conversation &&
          other.participant == this.participant &&
          other.id == this.id);
}

class ConversationsCompanion extends UpdateCompanion<Conversation> {
  final Value<Uri> participant;
  final Value<int> id;
  const ConversationsCompanion({
    this.participant = const Value.absent(),
    this.id = const Value.absent(),
  });
  ConversationsCompanion.insert({
    required Uri participant,
    this.id = const Value.absent(),
  }) : participant = Value(participant);
  static Insertable<Conversation> custom({
    Expression<String>? participant,
    Expression<int>? id,
  }) {
    return RawValuesInsertable({
      if (participant != null) 'participant': participant,
      if (id != null) 'id': id,
    });
  }

  ConversationsCompanion copyWith({Value<Uri>? participant, Value<int>? id}) {
    return ConversationsCompanion(
      participant: participant ?? this.participant,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (participant.present) {
      map['participant'] = Variable<String>(
        $ConversationsTable.$converterparticipant.toSql(participant.value),
      );
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationsCompanion(')
          ..write('participant: $participant, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $PreKeysTable preKeys = $PreKeysTable(this);
  late final $SignedPreKeysTable signedPreKeys = $SignedPreKeysTable(this);
  late final $IdentitiesTable identities = $IdentitiesTable(this);
  late final $LocalIdentityTable localIdentity = $LocalIdentityTable(this);
  late final $CapabilitiesTable capabilities = $CapabilitiesTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $UserDevicesTable userDevices = $UserDevicesTable(this);
  late final $AuthInfoTableTable authInfoTable = $AuthInfoTableTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $ConversationsTable conversations = $ConversationsTable(this);
  late final MessagesDao messagesDao = MessagesDao(this as AppDatabase);
  late final ContactsDao contactsDao = ContactsDao(this as AppDatabase);
  late final ConversationsDao conversationsDao = ConversationsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sessions,
    preKeys,
    signedPreKeys,
    identities,
    localIdentity,
    capabilities,
    users,
    userDevices,
    authInfoTable,
    messages,
    contacts,
    conversations,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'contacts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('conversations', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$SessionsTableCreateCompanionBuilder =
    SessionsCompanion Function({
      required String name,
      Value<int> deviceId,
      required Uint8List record,
    });
typedef $$SessionsTableUpdateCompanionBuilder =
    SessionsCompanion Function({
      Value<String> name,
      Value<int> deviceId,
      Value<Uint8List> record,
    });

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get record => $composableBuilder(
    column: $table.record,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get record => $composableBuilder(
    column: $table.record,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<Uint8List> get record =>
      $composableBuilder(column: $table.record, builder: (column) => column);
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTable,
          Session,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (Session, BaseReferences<_$AppDatabase, $SessionsTable, Session>),
          Session,
          PrefetchHooks Function()
        > {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> name = const Value.absent(),
                Value<int> deviceId = const Value.absent(),
                Value<Uint8List> record = const Value.absent(),
              }) => SessionsCompanion(
                name: name,
                deviceId: deviceId,
                record: record,
              ),
          createCompanionCallback:
              ({
                required String name,
                Value<int> deviceId = const Value.absent(),
                required Uint8List record,
              }) => SessionsCompanion.insert(
                name: name,
                deviceId: deviceId,
                record: record,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTable,
      Session,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (Session, BaseReferences<_$AppDatabase, $SessionsTable, Session>),
      Session,
      PrefetchHooks Function()
    >;
typedef $$PreKeysTableCreateCompanionBuilder =
    PreKeysCompanion Function({Value<int> keyId, required Uint8List record});
typedef $$PreKeysTableUpdateCompanionBuilder =
    PreKeysCompanion Function({Value<int> keyId, Value<Uint8List> record});

class $$PreKeysTableFilterComposer
    extends Composer<_$AppDatabase, $PreKeysTable> {
  $$PreKeysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get keyId => $composableBuilder(
    column: $table.keyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get record => $composableBuilder(
    column: $table.record,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PreKeysTableOrderingComposer
    extends Composer<_$AppDatabase, $PreKeysTable> {
  $$PreKeysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get keyId => $composableBuilder(
    column: $table.keyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get record => $composableBuilder(
    column: $table.record,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PreKeysTableAnnotationComposer
    extends Composer<_$AppDatabase, $PreKeysTable> {
  $$PreKeysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get keyId =>
      $composableBuilder(column: $table.keyId, builder: (column) => column);

  GeneratedColumn<Uint8List> get record =>
      $composableBuilder(column: $table.record, builder: (column) => column);
}

class $$PreKeysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PreKeysTable,
          PreKey,
          $$PreKeysTableFilterComposer,
          $$PreKeysTableOrderingComposer,
          $$PreKeysTableAnnotationComposer,
          $$PreKeysTableCreateCompanionBuilder,
          $$PreKeysTableUpdateCompanionBuilder,
          (PreKey, BaseReferences<_$AppDatabase, $PreKeysTable, PreKey>),
          PreKey,
          PrefetchHooks Function()
        > {
  $$PreKeysTableTableManager(_$AppDatabase db, $PreKeysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PreKeysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PreKeysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PreKeysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> keyId = const Value.absent(),
                Value<Uint8List> record = const Value.absent(),
              }) => PreKeysCompanion(keyId: keyId, record: record),
          createCompanionCallback:
              ({
                Value<int> keyId = const Value.absent(),
                required Uint8List record,
              }) => PreKeysCompanion.insert(keyId: keyId, record: record),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PreKeysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PreKeysTable,
      PreKey,
      $$PreKeysTableFilterComposer,
      $$PreKeysTableOrderingComposer,
      $$PreKeysTableAnnotationComposer,
      $$PreKeysTableCreateCompanionBuilder,
      $$PreKeysTableUpdateCompanionBuilder,
      (PreKey, BaseReferences<_$AppDatabase, $PreKeysTable, PreKey>),
      PreKey,
      PrefetchHooks Function()
    >;
typedef $$SignedPreKeysTableCreateCompanionBuilder =
    SignedPreKeysCompanion Function({Value<int> id, required Uint8List record});
typedef $$SignedPreKeysTableUpdateCompanionBuilder =
    SignedPreKeysCompanion Function({Value<int> id, Value<Uint8List> record});

class $$SignedPreKeysTableFilterComposer
    extends Composer<_$AppDatabase, $SignedPreKeysTable> {
  $$SignedPreKeysTableFilterComposer({
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

  ColumnFilters<Uint8List> get record => $composableBuilder(
    column: $table.record,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SignedPreKeysTableOrderingComposer
    extends Composer<_$AppDatabase, $SignedPreKeysTable> {
  $$SignedPreKeysTableOrderingComposer({
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

  ColumnOrderings<Uint8List> get record => $composableBuilder(
    column: $table.record,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SignedPreKeysTableAnnotationComposer
    extends Composer<_$AppDatabase, $SignedPreKeysTable> {
  $$SignedPreKeysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<Uint8List> get record =>
      $composableBuilder(column: $table.record, builder: (column) => column);
}

class $$SignedPreKeysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SignedPreKeysTable,
          SignedPreKey,
          $$SignedPreKeysTableFilterComposer,
          $$SignedPreKeysTableOrderingComposer,
          $$SignedPreKeysTableAnnotationComposer,
          $$SignedPreKeysTableCreateCompanionBuilder,
          $$SignedPreKeysTableUpdateCompanionBuilder,
          (
            SignedPreKey,
            BaseReferences<_$AppDatabase, $SignedPreKeysTable, SignedPreKey>,
          ),
          SignedPreKey,
          PrefetchHooks Function()
        > {
  $$SignedPreKeysTableTableManager(_$AppDatabase db, $SignedPreKeysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SignedPreKeysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SignedPreKeysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SignedPreKeysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Uint8List> record = const Value.absent(),
              }) => SignedPreKeysCompanion(id: id, record: record),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required Uint8List record,
              }) => SignedPreKeysCompanion.insert(id: id, record: record),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SignedPreKeysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SignedPreKeysTable,
      SignedPreKey,
      $$SignedPreKeysTableFilterComposer,
      $$SignedPreKeysTableOrderingComposer,
      $$SignedPreKeysTableAnnotationComposer,
      $$SignedPreKeysTableCreateCompanionBuilder,
      $$SignedPreKeysTableUpdateCompanionBuilder,
      (
        SignedPreKey,
        BaseReferences<_$AppDatabase, $SignedPreKeysTable, SignedPreKey>,
      ),
      SignedPreKey,
      PrefetchHooks Function()
    >;
typedef $$IdentitiesTableCreateCompanionBuilder =
    IdentitiesCompanion Function({
      required String name,
      Value<int> deviceId,
      required Uint8List identityKey,
      Value<bool> trusted,
    });
typedef $$IdentitiesTableUpdateCompanionBuilder =
    IdentitiesCompanion Function({
      Value<String> name,
      Value<int> deviceId,
      Value<Uint8List> identityKey,
      Value<bool> trusted,
    });

class $$IdentitiesTableFilterComposer
    extends Composer<_$AppDatabase, $IdentitiesTable> {
  $$IdentitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get trusted => $composableBuilder(
    column: $table.trusted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IdentitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $IdentitiesTable> {
  $$IdentitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get trusted => $composableBuilder(
    column: $table.trusted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IdentitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $IdentitiesTable> {
  $$IdentitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<Uint8List> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get trusted =>
      $composableBuilder(column: $table.trusted, builder: (column) => column);
}

class $$IdentitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IdentitiesTable,
          Identity,
          $$IdentitiesTableFilterComposer,
          $$IdentitiesTableOrderingComposer,
          $$IdentitiesTableAnnotationComposer,
          $$IdentitiesTableCreateCompanionBuilder,
          $$IdentitiesTableUpdateCompanionBuilder,
          (Identity, BaseReferences<_$AppDatabase, $IdentitiesTable, Identity>),
          Identity,
          PrefetchHooks Function()
        > {
  $$IdentitiesTableTableManager(_$AppDatabase db, $IdentitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IdentitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IdentitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IdentitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> name = const Value.absent(),
                Value<int> deviceId = const Value.absent(),
                Value<Uint8List> identityKey = const Value.absent(),
                Value<bool> trusted = const Value.absent(),
              }) => IdentitiesCompanion(
                name: name,
                deviceId: deviceId,
                identityKey: identityKey,
                trusted: trusted,
              ),
          createCompanionCallback:
              ({
                required String name,
                Value<int> deviceId = const Value.absent(),
                required Uint8List identityKey,
                Value<bool> trusted = const Value.absent(),
              }) => IdentitiesCompanion.insert(
                name: name,
                deviceId: deviceId,
                identityKey: identityKey,
                trusted: trusted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IdentitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IdentitiesTable,
      Identity,
      $$IdentitiesTableFilterComposer,
      $$IdentitiesTableOrderingComposer,
      $$IdentitiesTableAnnotationComposer,
      $$IdentitiesTableCreateCompanionBuilder,
      $$IdentitiesTableUpdateCompanionBuilder,
      (Identity, BaseReferences<_$AppDatabase, $IdentitiesTable, Identity>),
      Identity,
      PrefetchHooks Function()
    >;
typedef $$LocalIdentityTableCreateCompanionBuilder =
    LocalIdentityCompanion Function({
      Value<int> id,
      required Uint8List identityKeyPair,
      required int registrationId,
    });
typedef $$LocalIdentityTableUpdateCompanionBuilder =
    LocalIdentityCompanion Function({
      Value<int> id,
      Value<Uint8List> identityKeyPair,
      Value<int> registrationId,
    });

class $$LocalIdentityTableFilterComposer
    extends Composer<_$AppDatabase, $LocalIdentityTable> {
  $$LocalIdentityTableFilterComposer({
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

  ColumnFilters<Uint8List> get identityKeyPair => $composableBuilder(
    column: $table.identityKeyPair,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get registrationId => $composableBuilder(
    column: $table.registrationId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalIdentityTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalIdentityTable> {
  $$LocalIdentityTableOrderingComposer({
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

  ColumnOrderings<Uint8List> get identityKeyPair => $composableBuilder(
    column: $table.identityKeyPair,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get registrationId => $composableBuilder(
    column: $table.registrationId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalIdentityTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalIdentityTable> {
  $$LocalIdentityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<Uint8List> get identityKeyPair => $composableBuilder(
    column: $table.identityKeyPair,
    builder: (column) => column,
  );

  GeneratedColumn<int> get registrationId => $composableBuilder(
    column: $table.registrationId,
    builder: (column) => column,
  );
}

class $$LocalIdentityTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalIdentityTable,
          LocalIdentityData,
          $$LocalIdentityTableFilterComposer,
          $$LocalIdentityTableOrderingComposer,
          $$LocalIdentityTableAnnotationComposer,
          $$LocalIdentityTableCreateCompanionBuilder,
          $$LocalIdentityTableUpdateCompanionBuilder,
          (
            LocalIdentityData,
            BaseReferences<
              _$AppDatabase,
              $LocalIdentityTable,
              LocalIdentityData
            >,
          ),
          LocalIdentityData,
          PrefetchHooks Function()
        > {
  $$LocalIdentityTableTableManager(_$AppDatabase db, $LocalIdentityTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalIdentityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalIdentityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalIdentityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Uint8List> identityKeyPair = const Value.absent(),
                Value<int> registrationId = const Value.absent(),
              }) => LocalIdentityCompanion(
                id: id,
                identityKeyPair: identityKeyPair,
                registrationId: registrationId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required Uint8List identityKeyPair,
                required int registrationId,
              }) => LocalIdentityCompanion.insert(
                id: id,
                identityKeyPair: identityKeyPair,
                registrationId: registrationId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalIdentityTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalIdentityTable,
      LocalIdentityData,
      $$LocalIdentityTableFilterComposer,
      $$LocalIdentityTableOrderingComposer,
      $$LocalIdentityTableAnnotationComposer,
      $$LocalIdentityTableCreateCompanionBuilder,
      $$LocalIdentityTableUpdateCompanionBuilder,
      (
        LocalIdentityData,
        BaseReferences<_$AppDatabase, $LocalIdentityTable, LocalIdentityData>,
      ),
      LocalIdentityData,
      PrefetchHooks Function()
    >;
typedef $$CapabilitiesTableCreateCompanionBuilder =
    CapabilitiesCompanion Function({
      Value<int> id,
      required Map<String, dynamic> capabilities,
      Value<DateTime> time,
    });
typedef $$CapabilitiesTableUpdateCompanionBuilder =
    CapabilitiesCompanion Function({
      Value<int> id,
      Value<Map<String, dynamic>> capabilities,
      Value<DateTime> time,
    });

class $$CapabilitiesTableFilterComposer
    extends Composer<_$AppDatabase, $CapabilitiesTable> {
  $$CapabilitiesTableFilterComposer({
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

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>,
    Map<String, dynamic>,
    String
  >
  get capabilities => $composableBuilder(
    column: $table.capabilities,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CapabilitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $CapabilitiesTable> {
  $$CapabilitiesTableOrderingComposer({
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

  ColumnOrderings<String> get capabilities => $composableBuilder(
    column: $table.capabilities,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CapabilitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CapabilitiesTable> {
  $$CapabilitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  get capabilities => $composableBuilder(
    column: $table.capabilities,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);
}

class $$CapabilitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CapabilitiesTable,
          Capability,
          $$CapabilitiesTableFilterComposer,
          $$CapabilitiesTableOrderingComposer,
          $$CapabilitiesTableAnnotationComposer,
          $$CapabilitiesTableCreateCompanionBuilder,
          $$CapabilitiesTableUpdateCompanionBuilder,
          (
            Capability,
            BaseReferences<_$AppDatabase, $CapabilitiesTable, Capability>,
          ),
          Capability,
          PrefetchHooks Function()
        > {
  $$CapabilitiesTableTableManager(_$AppDatabase db, $CapabilitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CapabilitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CapabilitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CapabilitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Map<String, dynamic>> capabilities = const Value.absent(),
                Value<DateTime> time = const Value.absent(),
              }) => CapabilitiesCompanion(
                id: id,
                capabilities: capabilities,
                time: time,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required Map<String, dynamic> capabilities,
                Value<DateTime> time = const Value.absent(),
              }) => CapabilitiesCompanion.insert(
                id: id,
                capabilities: capabilities,
                time: time,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CapabilitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CapabilitiesTable,
      Capability,
      $$CapabilitiesTableFilterComposer,
      $$CapabilitiesTableOrderingComposer,
      $$CapabilitiesTableAnnotationComposer,
      $$CapabilitiesTableCreateCompanionBuilder,
      $$CapabilitiesTableUpdateCompanionBuilder,
      (
        Capability,
        BaseReferences<_$AppDatabase, $CapabilitiesTable, Capability>,
      ),
      Capability,
      PrefetchHooks Function()
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({required String id, Value<int> rowid});
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({Value<String> id, Value<int> rowid});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserDevicesTable, List<UserDevice>>
  _userDevicesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userDevices,
    aliasName: $_aliasNameGenerator(db.users.id, db.userDevices.userId),
  );

  $$UserDevicesTableProcessedTableManager get userDevicesRefs {
    final manager = $$UserDevicesTableTableManager(
      $_db,
      $_db.userDevices,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userDevicesRefsTable($_db));
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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userDevicesRefs(
    Expression<bool> Function($$UserDevicesTableFilterComposer f) f,
  ) {
    final $$UserDevicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userDevices,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserDevicesTableFilterComposer(
            $db: $db,
            $table: $db.userDevices,
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  Expression<T> userDevicesRefs<T extends Object>(
    Expression<T> Function($$UserDevicesTableAnnotationComposer a) f,
  ) {
    final $$UserDevicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userDevices,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserDevicesTableAnnotationComposer(
            $db: $db,
            $table: $db.userDevices,
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
          PrefetchHooks Function({bool userDevicesRefs})
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
                Value<String> id = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(id: id, rowid: rowid),
          createCompanionCallback:
              ({required String id, Value<int> rowid = const Value.absent()}) =>
                  UsersCompanion.insert(id: id, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({userDevicesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (userDevicesRefs) db.userDevices],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userDevicesRefs)
                    await $_getPrefetchedData<User, $UsersTable, UserDevice>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences
                          ._userDevicesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UsersTableReferences(db, table, p0).userDevicesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
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
      PrefetchHooks Function({bool userDevicesRefs})
    >;
typedef $$UserDevicesTableCreateCompanionBuilder =
    UserDevicesCompanion Function({
      Value<int> id,
      required String userId,
      required int deviceId,
    });
typedef $$UserDevicesTableUpdateCompanionBuilder =
    UserDevicesCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<int> deviceId,
    });

final class $$UserDevicesTableReferences
    extends BaseReferences<_$AppDatabase, $UserDevicesTable, UserDevice> {
  $$UserDevicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.userDevices.userId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserDevicesTableFilterComposer
    extends Composer<_$AppDatabase, $UserDevicesTable> {
  $$UserDevicesTableFilterComposer({
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

  ColumnFilters<int> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
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

class $$UserDevicesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserDevicesTable> {
  $$UserDevicesTableOrderingComposer({
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

  ColumnOrderings<int> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
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

class $$UserDevicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserDevicesTable> {
  $$UserDevicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
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

class $$UserDevicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserDevicesTable,
          UserDevice,
          $$UserDevicesTableFilterComposer,
          $$UserDevicesTableOrderingComposer,
          $$UserDevicesTableAnnotationComposer,
          $$UserDevicesTableCreateCompanionBuilder,
          $$UserDevicesTableUpdateCompanionBuilder,
          (UserDevice, $$UserDevicesTableReferences),
          UserDevice,
          PrefetchHooks Function({bool userId})
        > {
  $$UserDevicesTableTableManager(_$AppDatabase db, $UserDevicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserDevicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserDevicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserDevicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> deviceId = const Value.absent(),
              }) => UserDevicesCompanion(
                id: id,
                userId: userId,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required int deviceId,
              }) => UserDevicesCompanion.insert(
                id: id,
                userId: userId,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserDevicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
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
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable: $$UserDevicesTableReferences
                                    ._userIdTable(db),
                                referencedColumn: $$UserDevicesTableReferences
                                    ._userIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $$UserDevicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserDevicesTable,
      UserDevice,
      $$UserDevicesTableFilterComposer,
      $$UserDevicesTableOrderingComposer,
      $$UserDevicesTableAnnotationComposer,
      $$UserDevicesTableCreateCompanionBuilder,
      $$UserDevicesTableUpdateCompanionBuilder,
      (UserDevice, $$UserDevicesTableReferences),
      UserDevice,
      PrefetchHooks Function({bool userId})
    >;
typedef $$AuthInfoTableTableCreateCompanionBuilder =
    AuthInfoTableCompanion Function({
      Value<int> id,
      required int did,
      required String accessToken,
      required String refreshToken,
      required DateTime expiresAt,
      required String actorJson,
      required String serverUrl,
    });
typedef $$AuthInfoTableTableUpdateCompanionBuilder =
    AuthInfoTableCompanion Function({
      Value<int> id,
      Value<int> did,
      Value<String> accessToken,
      Value<String> refreshToken,
      Value<DateTime> expiresAt,
      Value<String> actorJson,
      Value<String> serverUrl,
    });

class $$AuthInfoTableTableFilterComposer
    extends Composer<_$AppDatabase, $AuthInfoTableTable> {
  $$AuthInfoTableTableFilterComposer({
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

  ColumnFilters<int> get did => $composableBuilder(
    column: $table.did,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accessToken => $composableBuilder(
    column: $table.accessToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refreshToken => $composableBuilder(
    column: $table.refreshToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actorJson => $composableBuilder(
    column: $table.actorJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverUrl => $composableBuilder(
    column: $table.serverUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuthInfoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AuthInfoTableTable> {
  $$AuthInfoTableTableOrderingComposer({
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

  ColumnOrderings<int> get did => $composableBuilder(
    column: $table.did,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accessToken => $composableBuilder(
    column: $table.accessToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refreshToken => $composableBuilder(
    column: $table.refreshToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actorJson => $composableBuilder(
    column: $table.actorJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverUrl => $composableBuilder(
    column: $table.serverUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuthInfoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuthInfoTableTable> {
  $$AuthInfoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get did =>
      $composableBuilder(column: $table.did, builder: (column) => column);

  GeneratedColumn<String> get accessToken => $composableBuilder(
    column: $table.accessToken,
    builder: (column) => column,
  );

  GeneratedColumn<String> get refreshToken => $composableBuilder(
    column: $table.refreshToken,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<String> get actorJson =>
      $composableBuilder(column: $table.actorJson, builder: (column) => column);

  GeneratedColumn<String> get serverUrl =>
      $composableBuilder(column: $table.serverUrl, builder: (column) => column);
}

class $$AuthInfoTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuthInfoTableTable,
          AuthInfoTableData,
          $$AuthInfoTableTableFilterComposer,
          $$AuthInfoTableTableOrderingComposer,
          $$AuthInfoTableTableAnnotationComposer,
          $$AuthInfoTableTableCreateCompanionBuilder,
          $$AuthInfoTableTableUpdateCompanionBuilder,
          (
            AuthInfoTableData,
            BaseReferences<
              _$AppDatabase,
              $AuthInfoTableTable,
              AuthInfoTableData
            >,
          ),
          AuthInfoTableData,
          PrefetchHooks Function()
        > {
  $$AuthInfoTableTableTableManager(_$AppDatabase db, $AuthInfoTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuthInfoTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuthInfoTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuthInfoTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> did = const Value.absent(),
                Value<String> accessToken = const Value.absent(),
                Value<String> refreshToken = const Value.absent(),
                Value<DateTime> expiresAt = const Value.absent(),
                Value<String> actorJson = const Value.absent(),
                Value<String> serverUrl = const Value.absent(),
              }) => AuthInfoTableCompanion(
                id: id,
                did: did,
                accessToken: accessToken,
                refreshToken: refreshToken,
                expiresAt: expiresAt,
                actorJson: actorJson,
                serverUrl: serverUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int did,
                required String accessToken,
                required String refreshToken,
                required DateTime expiresAt,
                required String actorJson,
                required String serverUrl,
              }) => AuthInfoTableCompanion.insert(
                id: id,
                did: did,
                accessToken: accessToken,
                refreshToken: refreshToken,
                expiresAt: expiresAt,
                actorJson: actorJson,
                serverUrl: serverUrl,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuthInfoTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuthInfoTableTable,
      AuthInfoTableData,
      $$AuthInfoTableTableFilterComposer,
      $$AuthInfoTableTableOrderingComposer,
      $$AuthInfoTableTableAnnotationComposer,
      $$AuthInfoTableTableCreateCompanionBuilder,
      $$AuthInfoTableTableUpdateCompanionBuilder,
      (
        AuthInfoTableData,
        BaseReferences<_$AppDatabase, $AuthInfoTableTable, AuthInfoTableData>,
      ),
      AuthInfoTableData,
      PrefetchHooks Function()
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      required UuidValue id,
      required Uri to,
      required Uri from,
      Value<String?> content,
      Value<UuidValue?> inReplyTo,
      required DateTime time,
      Value<MessageStatus> status,
      Value<int> rowid,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<UuidValue> id,
      Value<Uri> to,
      Value<Uri> from,
      Value<String?> content,
      Value<UuidValue?> inReplyTo,
      Value<DateTime> time,
      Value<MessageStatus> status,
      Value<int> rowid,
    });

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<UuidValue, UuidValue, String> get id =>
      $composableBuilder(
        column: $table.id,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Uri, Uri, String> get to => $composableBuilder(
    column: $table.to,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<Uri, Uri, String> get from =>
      $composableBuilder(
        column: $table.from,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<UuidValue?, UuidValue, String> get inReplyTo =>
      $composableBuilder(
        column: $table.inReplyTo,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MessageStatus, MessageStatus, int>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get to => $composableBuilder(
    column: $table.to,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get from => $composableBuilder(
    column: $table.from,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inReplyTo => $composableBuilder(
    column: $table.inReplyTo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<UuidValue, String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Uri, String> get to =>
      $composableBuilder(column: $table.to, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Uri, String> get from =>
      $composableBuilder(column: $table.from, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumnWithTypeConverter<UuidValue?, String> get inReplyTo =>
      $composableBuilder(column: $table.inReplyTo, builder: (column) => column);

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MessageStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$MessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessagesTable,
          Message,
          $$MessagesTableFilterComposer,
          $$MessagesTableOrderingComposer,
          $$MessagesTableAnnotationComposer,
          $$MessagesTableCreateCompanionBuilder,
          $$MessagesTableUpdateCompanionBuilder,
          (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
          Message,
          PrefetchHooks Function()
        > {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<UuidValue> id = const Value.absent(),
                Value<Uri> to = const Value.absent(),
                Value<Uri> from = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<UuidValue?> inReplyTo = const Value.absent(),
                Value<DateTime> time = const Value.absent(),
                Value<MessageStatus> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion(
                id: id,
                to: to,
                from: from,
                content: content,
                inReplyTo: inReplyTo,
                time: time,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required UuidValue id,
                required Uri to,
                required Uri from,
                Value<String?> content = const Value.absent(),
                Value<UuidValue?> inReplyTo = const Value.absent(),
                required DateTime time,
                Value<MessageStatus> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion.insert(
                id: id,
                to: to,
                from: from,
                content: content,
                inReplyTo: inReplyTo,
                time: time,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessagesTable,
      Message,
      $$MessagesTableFilterComposer,
      $$MessagesTableOrderingComposer,
      $$MessagesTableAnnotationComposer,
      $$MessagesTableCreateCompanionBuilder,
      $$MessagesTableUpdateCompanionBuilder,
      (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
      Message,
      PrefetchHooks Function()
    >;
typedef $$ContactsTableCreateCompanionBuilder =
    ContactsCompanion Function({
      required Uri id,
      required String preferredUsername,
      required Uri inbox,
      required Uri outbox,
      required Uri keyBundle,
      Value<int> rowid,
    });
typedef $$ContactsTableUpdateCompanionBuilder =
    ContactsCompanion Function({
      Value<Uri> id,
      Value<String> preferredUsername,
      Value<Uri> inbox,
      Value<Uri> outbox,
      Value<Uri> keyBundle,
      Value<int> rowid,
    });

final class $$ContactsTableReferences
    extends BaseReferences<_$AppDatabase, $ContactsTable, Person> {
  $$ContactsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ConversationsTable, List<Conversation>>
  _conversationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.conversations,
    aliasName: $_aliasNameGenerator(
      db.contacts.id,
      db.conversations.participant,
    ),
  );

  $$ConversationsTableProcessedTableManager get conversationsRefs {
    final manager = $$ConversationsTableTableManager(
      $_db,
      $_db.conversations,
    ).filter((f) => f.participant.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_conversationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ContactsTableFilterComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<Uri, Uri, String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get preferredUsername => $composableBuilder(
    column: $table.preferredUsername,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Uri, Uri, String> get inbox =>
      $composableBuilder(
        column: $table.inbox,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Uri, Uri, String> get outbox =>
      $composableBuilder(
        column: $table.outbox,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Uri, Uri, String> get keyBundle =>
      $composableBuilder(
        column: $table.keyBundle,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  Expression<bool> conversationsRefs(
    Expression<bool> Function($$ConversationsTableFilterComposer f) f,
  ) {
    final $$ConversationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.conversations,
      getReferencedColumn: (t) => t.participant,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConversationsTableFilterComposer(
            $db: $db,
            $table: $db.conversations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredUsername => $composableBuilder(
    column: $table.preferredUsername,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inbox => $composableBuilder(
    column: $table.inbox,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outbox => $composableBuilder(
    column: $table.outbox,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keyBundle => $composableBuilder(
    column: $table.keyBundle,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<Uri, String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get preferredUsername => $composableBuilder(
    column: $table.preferredUsername,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Uri, String> get inbox =>
      $composableBuilder(column: $table.inbox, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Uri, String> get outbox =>
      $composableBuilder(column: $table.outbox, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Uri, String> get keyBundle =>
      $composableBuilder(column: $table.keyBundle, builder: (column) => column);

  Expression<T> conversationsRefs<T extends Object>(
    Expression<T> Function($$ConversationsTableAnnotationComposer a) f,
  ) {
    final $$ConversationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.conversations,
      getReferencedColumn: (t) => t.participant,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConversationsTableAnnotationComposer(
            $db: $db,
            $table: $db.conversations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContactsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContactsTable,
          Person,
          $$ContactsTableFilterComposer,
          $$ContactsTableOrderingComposer,
          $$ContactsTableAnnotationComposer,
          $$ContactsTableCreateCompanionBuilder,
          $$ContactsTableUpdateCompanionBuilder,
          (Person, $$ContactsTableReferences),
          Person,
          PrefetchHooks Function({bool conversationsRefs})
        > {
  $$ContactsTableTableManager(_$AppDatabase db, $ContactsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<Uri> id = const Value.absent(),
                Value<String> preferredUsername = const Value.absent(),
                Value<Uri> inbox = const Value.absent(),
                Value<Uri> outbox = const Value.absent(),
                Value<Uri> keyBundle = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContactsCompanion(
                id: id,
                preferredUsername: preferredUsername,
                inbox: inbox,
                outbox: outbox,
                keyBundle: keyBundle,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required Uri id,
                required String preferredUsername,
                required Uri inbox,
                required Uri outbox,
                required Uri keyBundle,
                Value<int> rowid = const Value.absent(),
              }) => ContactsCompanion.insert(
                id: id,
                preferredUsername: preferredUsername,
                inbox: inbox,
                outbox: outbox,
                keyBundle: keyBundle,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContactsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({conversationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (conversationsRefs) db.conversations,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (conversationsRefs)
                    await $_getPrefetchedData<
                      Person,
                      $ContactsTable,
                      Conversation
                    >(
                      currentTable: table,
                      referencedTable: $$ContactsTableReferences
                          ._conversationsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ContactsTableReferences(
                        db,
                        table,
                        p0,
                      ).conversationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.participant == item.id,
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

typedef $$ContactsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContactsTable,
      Person,
      $$ContactsTableFilterComposer,
      $$ContactsTableOrderingComposer,
      $$ContactsTableAnnotationComposer,
      $$ContactsTableCreateCompanionBuilder,
      $$ContactsTableUpdateCompanionBuilder,
      (Person, $$ContactsTableReferences),
      Person,
      PrefetchHooks Function({bool conversationsRefs})
    >;
typedef $$ConversationsTableCreateCompanionBuilder =
    ConversationsCompanion Function({required Uri participant, Value<int> id});
typedef $$ConversationsTableUpdateCompanionBuilder =
    ConversationsCompanion Function({Value<Uri> participant, Value<int> id});

final class $$ConversationsTableReferences
    extends BaseReferences<_$AppDatabase, $ConversationsTable, Conversation> {
  $$ConversationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ContactsTable _participantTable(_$AppDatabase db) =>
      db.contacts.createAlias(
        $_aliasNameGenerator(db.conversations.participant, db.contacts.id),
      );

  $$ContactsTableProcessedTableManager get participant {
    final $_column = $_itemColumn<String>('participant')!;

    final manager = $$ContactsTableTableManager(
      $_db,
      $_db.contacts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_participantTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ConversationsTableFilterComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableFilterComposer({
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

  $$ContactsTableFilterComposer get participant {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.participant,
      referencedTable: $db.contacts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContactsTableFilterComposer(
            $db: $db,
            $table: $db.contacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConversationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableOrderingComposer({
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

  $$ContactsTableOrderingComposer get participant {
    final $$ContactsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.participant,
      referencedTable: $db.contacts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContactsTableOrderingComposer(
            $db: $db,
            $table: $db.contacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConversationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$ContactsTableAnnotationComposer get participant {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.participant,
      referencedTable: $db.contacts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContactsTableAnnotationComposer(
            $db: $db,
            $table: $db.contacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConversationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConversationsTable,
          Conversation,
          $$ConversationsTableFilterComposer,
          $$ConversationsTableOrderingComposer,
          $$ConversationsTableAnnotationComposer,
          $$ConversationsTableCreateCompanionBuilder,
          $$ConversationsTableUpdateCompanionBuilder,
          (Conversation, $$ConversationsTableReferences),
          Conversation,
          PrefetchHooks Function({bool participant})
        > {
  $$ConversationsTableTableManager(_$AppDatabase db, $ConversationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConversationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConversationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConversationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<Uri> participant = const Value.absent(),
                Value<int> id = const Value.absent(),
              }) => ConversationsCompanion(participant: participant, id: id),
          createCompanionCallback:
              ({
                required Uri participant,
                Value<int> id = const Value.absent(),
              }) => ConversationsCompanion.insert(
                participant: participant,
                id: id,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ConversationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({participant = false}) {
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
                    if (participant) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.participant,
                                referencedTable: $$ConversationsTableReferences
                                    ._participantTable(db),
                                referencedColumn: $$ConversationsTableReferences
                                    ._participantTable(db)
                                    .id,
                              )
                              as T;
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

typedef $$ConversationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConversationsTable,
      Conversation,
      $$ConversationsTableFilterComposer,
      $$ConversationsTableOrderingComposer,
      $$ConversationsTableAnnotationComposer,
      $$ConversationsTableCreateCompanionBuilder,
      $$ConversationsTableUpdateCompanionBuilder,
      (Conversation, $$ConversationsTableReferences),
      Conversation,
      PrefetchHooks Function({bool participant})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$PreKeysTableTableManager get preKeys =>
      $$PreKeysTableTableManager(_db, _db.preKeys);
  $$SignedPreKeysTableTableManager get signedPreKeys =>
      $$SignedPreKeysTableTableManager(_db, _db.signedPreKeys);
  $$IdentitiesTableTableManager get identities =>
      $$IdentitiesTableTableManager(_db, _db.identities);
  $$LocalIdentityTableTableManager get localIdentity =>
      $$LocalIdentityTableTableManager(_db, _db.localIdentity);
  $$CapabilitiesTableTableManager get capabilities =>
      $$CapabilitiesTableTableManager(_db, _db.capabilities);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$UserDevicesTableTableManager get userDevices =>
      $$UserDevicesTableTableManager(_db, _db.userDevices);
  $$AuthInfoTableTableTableManager get authInfoTable =>
      $$AuthInfoTableTableTableManager(_db, _db.authInfoTable);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
  $$ConversationsTableTableManager get conversations =>
      $$ConversationsTableTableManager(_db, _db.conversations);
}
