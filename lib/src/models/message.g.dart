// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

@generatedSerializable
class Message extends _Message {
  Message(
      {this.id,
      @required this.userid,
      @required this.message,
      this.createdAt,
      this.updatedAt});

  @override
  final String id;

  @override
  final String userid;

  @override
  final String message;

  @override
  final DateTime createdAt;

  @override
  final DateTime updatedAt;

  Message copyWith(
      {String id,
      String userid,
      String message,
      DateTime createdAt,
      DateTime updatedAt}) {
    return new Message(
        id: id ?? this.id,
        userid: userid ?? this.userid,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  bool operator ==(other) {
    return other is _Message &&
        other.id == id &&
        other.userid == userid &&
        other.message == message &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return hashObjects([id, userid, message, createdAt, updatedAt]);
  }

  @override
  String toString() {
    return "Message(id=$id, userid=$userid, message=$message, createdAt=$createdAt, updatedAt=$updatedAt)";
  }

  Map<String, dynamic> toJson() {
    return MessageSerializer.toMap(this);
  }
}

// **************************************************************************
// SerializerGenerator
// **************************************************************************

const MessageSerializer messageSerializer = const MessageSerializer();

class MessageEncoder extends Converter<Message, Map> {
  const MessageEncoder();

  @override
  Map convert(Message model) => MessageSerializer.toMap(model);
}

class MessageDecoder extends Converter<Map, Message> {
  const MessageDecoder();

  @override
  Message convert(Map map) => MessageSerializer.fromMap(map);
}

class MessageSerializer extends Codec<Message, Map> {
  const MessageSerializer();

  @override
  get encoder => const MessageEncoder();
  @override
  get decoder => const MessageDecoder();
  static Message fromMap(Map map) {
    if (map['userid'] == null) {
      throw new FormatException("Missing required field 'userid' on Message.");
    }

    if (map['message'] == null) {
      throw new FormatException("Missing required field 'message' on Message.");
    }

    return new Message(
        id: map['id'] as String,
        userid: map['userid'] as String,
        message: map['message'] as String,
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

  static Map<String, dynamic> toMap(_Message model) {
    if (model == null) {
      return null;
    }
    if (model.userid == null) {
      throw new FormatException("Missing required field 'userid' on Message.");
    }

    if (model.message == null) {
      throw new FormatException("Missing required field 'message' on Message.");
    }

    return {
      'id': model.id,
      'userid': model.userid,
      'message': model.message,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String()
    };
  }
}

abstract class MessageFields {
  static const List<String> allFields = <String>[
    id,
    userid,
    message,
    createdAt,
    updatedAt
  ];

  static const String id = 'id';

  static const String userid = 'userid';

  static const String message = 'message';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';
}
