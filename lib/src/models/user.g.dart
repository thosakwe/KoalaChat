// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

@generatedSerializable
class User extends _User {
  User(
      {this.id,
      @required this.username,
      @required this.password,
      this.group,
      this.createdAt,
      this.updatedAt});

  @override
  final String id;

  @override
  final String username;

  @override
  final String password;

  @override
  final userGroup group;

  @override
  final DateTime createdAt;

  @override
  final DateTime updatedAt;

  User copyWith(
      {String id,
      String username,
      String password,
      userGroup group,
      DateTime createdAt,
      DateTime updatedAt}) {
    return User(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        group: group ?? this.group,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  bool operator ==(other) {
    return other is _User &&
        other.id == id &&
        other.username == username &&
        other.password == password &&
        other.group == group &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return hashObjects([id, username, password, group, createdAt, updatedAt]);
  }

  @override
  String toString() {
    return "User(id=$id, username=$username, password=$password, group=$group, createdAt=$createdAt, updatedAt=$updatedAt)";
  }

  Map<String, dynamic> toJson() {
    return UserSerializer.toMap(this);
  }
}

// **************************************************************************
// SerializerGenerator
// **************************************************************************

const UserSerializer userSerializer = UserSerializer();

class UserEncoder extends Converter<User, Map> {
  const UserEncoder();

  @override
  Map convert(User model) => UserSerializer.toMap(model);
}

class UserDecoder extends Converter<Map, User> {
  const UserDecoder();

  @override
  User convert(Map map) => UserSerializer.fromMap(map);
}

class UserSerializer extends Codec<User, Map> {
  const UserSerializer();

  @override
  get encoder => const UserEncoder();
  @override
  get decoder => const UserDecoder();
  static User fromMap(Map map) {
    if (map['username'] == null) {
      throw FormatException("Missing required field 'username' on User.");
    }

    if (map['password'] == null) {
      throw FormatException("Missing required field 'password' on User.");
    }

    return User(
        id: map['id'] as String,
        username: map['username'] as String,
        password: map['password'] as String,
        group: map['group'] is userGroup
            ? (map['group'] as userGroup)
            : (map['group'] is int
                ? userGroup.values[map['group'] as int]
                : null),
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null);
  }

  static Map<String, dynamic> toMap(_User model) {
    if (model == null) {
      return null;
    }
    if (model.username == null) {
      throw FormatException("Missing required field 'username' on User.");
    }

    if (model.password == null) {
      throw FormatException("Missing required field 'password' on User.");
    }

    return {
      'id': model.id,
      'username': model.username,
      'password': model.password,
      'group':
          model.group == null ? null : userGroup.values.indexOf(model.group),
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String()
    };
  }
}

abstract class UserFields {
  static const List<String> allFields = <String>[
    id,
    username,
    password,
    group,
    createdAt,
    updatedAt
  ];

  static const String id = 'id';

  static const String username = 'username';

  static const String password = 'password';

  static const String group = 'group';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';
}
