// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AuthSessionsTable extends AuthSessions
    with TableInfo<$AuthSessionsTable, AuthSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuthSessionsTable(this.attachedDatabase, [this._alias]);
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accessToken,
    refreshToken,
    serverUrl,
    expiresAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'auth_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuthSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('server_url')) {
      context.handle(
        _serverUrlMeta,
        serverUrl.isAcceptableOrUnknown(data['server_url']!, _serverUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_serverUrlMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuthSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuthSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accessToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}access_token'],
      )!,
      refreshToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}refresh_token'],
      )!,
      serverUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_url'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      )!,
    );
  }

  @override
  $AuthSessionsTable createAlias(String alias) {
    return $AuthSessionsTable(attachedDatabase, alias);
  }
}

class AuthSession extends DataClass implements Insertable<AuthSession> {
  final int id;
  final String accessToken;
  final String refreshToken;
  final String serverUrl;
  final DateTime expiresAt;
  const AuthSession({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
    required this.serverUrl,
    required this.expiresAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['access_token'] = Variable<String>(accessToken);
    map['refresh_token'] = Variable<String>(refreshToken);
    map['server_url'] = Variable<String>(serverUrl);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    return map;
  }

  AuthSessionsCompanion toCompanion(bool nullToAbsent) {
    return AuthSessionsCompanion(
      id: Value(id),
      accessToken: Value(accessToken),
      refreshToken: Value(refreshToken),
      serverUrl: Value(serverUrl),
      expiresAt: Value(expiresAt),
    );
  }

  factory AuthSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuthSession(
      id: serializer.fromJson<int>(json['id']),
      accessToken: serializer.fromJson<String>(json['accessToken']),
      refreshToken: serializer.fromJson<String>(json['refreshToken']),
      serverUrl: serializer.fromJson<String>(json['serverUrl']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accessToken': serializer.toJson<String>(accessToken),
      'refreshToken': serializer.toJson<String>(refreshToken),
      'serverUrl': serializer.toJson<String>(serverUrl),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
    };
  }

  AuthSession copyWith({
    int? id,
    String? accessToken,
    String? refreshToken,
    String? serverUrl,
    DateTime? expiresAt,
  }) => AuthSession(
    id: id ?? this.id,
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
    serverUrl: serverUrl ?? this.serverUrl,
    expiresAt: expiresAt ?? this.expiresAt,
  );
  AuthSession copyWithCompanion(AuthSessionsCompanion data) {
    return AuthSession(
      id: data.id.present ? data.id.value : this.id,
      accessToken: data.accessToken.present
          ? data.accessToken.value
          : this.accessToken,
      refreshToken: data.refreshToken.present
          ? data.refreshToken.value
          : this.refreshToken,
      serverUrl: data.serverUrl.present ? data.serverUrl.value : this.serverUrl,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuthSession(')
          ..write('id: $id, ')
          ..write('accessToken: $accessToken, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('serverUrl: $serverUrl, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, accessToken, refreshToken, serverUrl, expiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthSession &&
          other.id == this.id &&
          other.accessToken == this.accessToken &&
          other.refreshToken == this.refreshToken &&
          other.serverUrl == this.serverUrl &&
          other.expiresAt == this.expiresAt);
}

class AuthSessionsCompanion extends UpdateCompanion<AuthSession> {
  final Value<int> id;
  final Value<String> accessToken;
  final Value<String> refreshToken;
  final Value<String> serverUrl;
  final Value<DateTime> expiresAt;
  const AuthSessionsCompanion({
    this.id = const Value.absent(),
    this.accessToken = const Value.absent(),
    this.refreshToken = const Value.absent(),
    this.serverUrl = const Value.absent(),
    this.expiresAt = const Value.absent(),
  });
  AuthSessionsCompanion.insert({
    this.id = const Value.absent(),
    required String accessToken,
    required String refreshToken,
    required String serverUrl,
    required DateTime expiresAt,
  }) : accessToken = Value(accessToken),
       refreshToken = Value(refreshToken),
       serverUrl = Value(serverUrl),
       expiresAt = Value(expiresAt);
  static Insertable<AuthSession> custom({
    Expression<int>? id,
    Expression<String>? accessToken,
    Expression<String>? refreshToken,
    Expression<String>? serverUrl,
    Expression<DateTime>? expiresAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accessToken != null) 'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (serverUrl != null) 'server_url': serverUrl,
      if (expiresAt != null) 'expires_at': expiresAt,
    });
  }

  AuthSessionsCompanion copyWith({
    Value<int>? id,
    Value<String>? accessToken,
    Value<String>? refreshToken,
    Value<String>? serverUrl,
    Value<DateTime>? expiresAt,
  }) {
    return AuthSessionsCompanion(
      id: id ?? this.id,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      serverUrl: serverUrl ?? this.serverUrl,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accessToken.present) {
      map['access_token'] = Variable<String>(accessToken.value);
    }
    if (refreshToken.present) {
      map['refresh_token'] = Variable<String>(refreshToken.value);
    }
    if (serverUrl.present) {
      map['server_url'] = Variable<String>(serverUrl.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthSessionsCompanion(')
          ..write('id: $id, ')
          ..write('accessToken: $accessToken, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('serverUrl: $serverUrl, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }
}

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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AuthSessionsTable authSessions = $AuthSessionsTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $PreKeysTable preKeys = $PreKeysTable(this);
  late final $SignedPreKeysTable signedPreKeys = $SignedPreKeysTable(this);
  late final $IdentitiesTable identities = $IdentitiesTable(this);
  late final $LocalIdentityTable localIdentity = $LocalIdentityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    authSessions,
    sessions,
    preKeys,
    signedPreKeys,
    identities,
    localIdentity,
  ];
}

typedef $$AuthSessionsTableCreateCompanionBuilder =
    AuthSessionsCompanion Function({
      Value<int> id,
      required String accessToken,
      required String refreshToken,
      required String serverUrl,
      required DateTime expiresAt,
    });
typedef $$AuthSessionsTableUpdateCompanionBuilder =
    AuthSessionsCompanion Function({
      Value<int> id,
      Value<String> accessToken,
      Value<String> refreshToken,
      Value<String> serverUrl,
      Value<DateTime> expiresAt,
    });

class $$AuthSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $AuthSessionsTable> {
  $$AuthSessionsTableFilterComposer({
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

  ColumnFilters<String> get accessToken => $composableBuilder(
    column: $table.accessToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refreshToken => $composableBuilder(
    column: $table.refreshToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverUrl => $composableBuilder(
    column: $table.serverUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuthSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuthSessionsTable> {
  $$AuthSessionsTableOrderingComposer({
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

  ColumnOrderings<String> get accessToken => $composableBuilder(
    column: $table.accessToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refreshToken => $composableBuilder(
    column: $table.refreshToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverUrl => $composableBuilder(
    column: $table.serverUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuthSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuthSessionsTable> {
  $$AuthSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get accessToken => $composableBuilder(
    column: $table.accessToken,
    builder: (column) => column,
  );

  GeneratedColumn<String> get refreshToken => $composableBuilder(
    column: $table.refreshToken,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverUrl =>
      $composableBuilder(column: $table.serverUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);
}

class $$AuthSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuthSessionsTable,
          AuthSession,
          $$AuthSessionsTableFilterComposer,
          $$AuthSessionsTableOrderingComposer,
          $$AuthSessionsTableAnnotationComposer,
          $$AuthSessionsTableCreateCompanionBuilder,
          $$AuthSessionsTableUpdateCompanionBuilder,
          (
            AuthSession,
            BaseReferences<_$AppDatabase, $AuthSessionsTable, AuthSession>,
          ),
          AuthSession,
          PrefetchHooks Function()
        > {
  $$AuthSessionsTableTableManager(_$AppDatabase db, $AuthSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuthSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuthSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuthSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> accessToken = const Value.absent(),
                Value<String> refreshToken = const Value.absent(),
                Value<String> serverUrl = const Value.absent(),
                Value<DateTime> expiresAt = const Value.absent(),
              }) => AuthSessionsCompanion(
                id: id,
                accessToken: accessToken,
                refreshToken: refreshToken,
                serverUrl: serverUrl,
                expiresAt: expiresAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String accessToken,
                required String refreshToken,
                required String serverUrl,
                required DateTime expiresAt,
              }) => AuthSessionsCompanion.insert(
                id: id,
                accessToken: accessToken,
                refreshToken: refreshToken,
                serverUrl: serverUrl,
                expiresAt: expiresAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuthSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuthSessionsTable,
      AuthSession,
      $$AuthSessionsTableFilterComposer,
      $$AuthSessionsTableOrderingComposer,
      $$AuthSessionsTableAnnotationComposer,
      $$AuthSessionsTableCreateCompanionBuilder,
      $$AuthSessionsTableUpdateCompanionBuilder,
      (
        AuthSession,
        BaseReferences<_$AppDatabase, $AuthSessionsTable, AuthSession>,
      ),
      AuthSession,
      PrefetchHooks Function()
    >;
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AuthSessionsTableTableManager get authSessions =>
      $$AuthSessionsTableTableManager(_db, _db.authSessions);
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
}
