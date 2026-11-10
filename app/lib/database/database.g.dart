// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ConversationsTable extends Conversations
    with TableInfo<$ConversationsTable, Conversation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationsTable(this.attachedDatabase, [this._alias]);
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
    requiredDuringInsert: false,
    defaultValue: const Constant('New Conversation'),
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contextMeta = const VerificationMeta(
    'context',
  );
  @override
  late final GeneratedColumn<String> context = GeneratedColumn<String>(
    'context',
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPinnedMeta = const VerificationMeta(
    'isPinned',
  );
  @override
  late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>(
    'is_pinned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pinned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _messageCountMeta = const VerificationMeta(
    'messageCount',
  );
  @override
  late final GeneratedColumn<int> messageCount = GeneratedColumn<int>(
    'message_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    mode,
    context,
    createdAt,
    updatedAt,
    isPinned,
    messageCount,
  ];
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
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    }
    if (data.containsKey('context')) {
      context.handle(
        _contextMeta,
        this.context.isAcceptableOrUnknown(data['context']!, _contextMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_pinned')) {
      context.handle(
        _isPinnedMeta,
        isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta),
      );
    }
    if (data.containsKey('message_count')) {
      context.handle(
        _messageCountMeta,
        messageCount.isAcceptableOrUnknown(
          data['message_count']!,
          _messageCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Conversation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Conversation(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      ),
      context: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      isPinned:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_pinned'],
          )!,
      messageCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}message_count'],
          )!,
    );
  }

  @override
  $ConversationsTable createAlias(String alias) {
    return $ConversationsTable(attachedDatabase, alias);
  }
}

class Conversation extends DataClass implements Insertable<Conversation> {
  final int id;
  final String title;
  final String? mode;
  final String? context;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPinned;
  final int messageCount;
  const Conversation({
    required this.id,
    required this.title,
    this.mode,
    this.context,
    required this.createdAt,
    required this.updatedAt,
    required this.isPinned,
    required this.messageCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || mode != null) {
      map['mode'] = Variable<String>(mode);
    }
    if (!nullToAbsent || context != null) {
      map['context'] = Variable<String>(context);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_pinned'] = Variable<bool>(isPinned);
    map['message_count'] = Variable<int>(messageCount);
    return map;
  }

  ConversationsCompanion toCompanion(bool nullToAbsent) {
    return ConversationsCompanion(
      id: Value(id),
      title: Value(title),
      mode: mode == null && nullToAbsent ? const Value.absent() : Value(mode),
      context:
          context == null && nullToAbsent
              ? const Value.absent()
              : Value(context),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isPinned: Value(isPinned),
      messageCount: Value(messageCount),
    );
  }

  factory Conversation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Conversation(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      mode: serializer.fromJson<String?>(json['mode']),
      context: serializer.fromJson<String?>(json['context']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      messageCount: serializer.fromJson<int>(json['messageCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'mode': serializer.toJson<String?>(mode),
      'context': serializer.toJson<String?>(context),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isPinned': serializer.toJson<bool>(isPinned),
      'messageCount': serializer.toJson<int>(messageCount),
    };
  }

  Conversation copyWith({
    int? id,
    String? title,
    Value<String?> mode = const Value.absent(),
    Value<String?> context = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPinned,
    int? messageCount,
  }) => Conversation(
    id: id ?? this.id,
    title: title ?? this.title,
    mode: mode.present ? mode.value : this.mode,
    context: context.present ? context.value : this.context,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isPinned: isPinned ?? this.isPinned,
    messageCount: messageCount ?? this.messageCount,
  );
  Conversation copyWithCompanion(ConversationsCompanion data) {
    return Conversation(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      mode: data.mode.present ? data.mode.value : this.mode,
      context: data.context.present ? data.context.value : this.context,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
      messageCount:
          data.messageCount.present
              ? data.messageCount.value
              : this.messageCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Conversation(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('mode: $mode, ')
          ..write('context: $context, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isPinned: $isPinned, ')
          ..write('messageCount: $messageCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    mode,
    context,
    createdAt,
    updatedAt,
    isPinned,
    messageCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Conversation &&
          other.id == this.id &&
          other.title == this.title &&
          other.mode == this.mode &&
          other.context == this.context &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isPinned == this.isPinned &&
          other.messageCount == this.messageCount);
}

class ConversationsCompanion extends UpdateCompanion<Conversation> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> mode;
  final Value<String?> context;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isPinned;
  final Value<int> messageCount;
  const ConversationsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.mode = const Value.absent(),
    this.context = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.messageCount = const Value.absent(),
  });
  ConversationsCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.mode = const Value.absent(),
    this.context = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isPinned = const Value.absent(),
    this.messageCount = const Value.absent(),
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Conversation> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? mode,
    Expression<String>? context,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isPinned,
    Expression<int>? messageCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (mode != null) 'mode': mode,
      if (context != null) 'context': context,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isPinned != null) 'is_pinned': isPinned,
      if (messageCount != null) 'message_count': messageCount,
    });
  }

  ConversationsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? mode,
    Value<String?>? context,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isPinned,
    Value<int>? messageCount,
  }) {
    return ConversationsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      mode: mode ?? this.mode,
      context: context ?? this.context,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPinned: isPinned ?? this.isPinned,
      messageCount: messageCount ?? this.messageCount,
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
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (context.present) {
      map['context'] = Variable<String>(context.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (messageCount.present) {
      map['message_count'] = Variable<int>(messageCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('mode: $mode, ')
          ..write('context: $context, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isPinned: $isPinned, ')
          ..write('messageCount: $messageCount')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<int> conversationId = GeneratedColumn<int>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES conversations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEditedMeta = const VerificationMeta(
    'isEdited',
  );
  @override
  late final GeneratedColumn<bool> isEdited = GeneratedColumn<bool>(
    'is_edited',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_edited" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isBookmarkedMeta = const VerificationMeta(
    'isBookmarked',
  );
  @override
  late final GeneratedColumn<bool> isBookmarked = GeneratedColumn<bool>(
    'is_bookmarked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_bookmarked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _tokenCountMeta = const VerificationMeta(
    'tokenCount',
  );
  @override
  late final GeneratedColumn<int> tokenCount = GeneratedColumn<int>(
    'token_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    conversationId,
    role,
    content,
    createdAt,
    isEdited,
    isBookmarked,
    tokenCount,
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_edited')) {
      context.handle(
        _isEditedMeta,
        isEdited.isAcceptableOrUnknown(data['is_edited']!, _isEditedMeta),
      );
    }
    if (data.containsKey('is_bookmarked')) {
      context.handle(
        _isBookmarkedMeta,
        isBookmarked.isAcceptableOrUnknown(
          data['is_bookmarked']!,
          _isBookmarkedMeta,
        ),
      );
    }
    if (data.containsKey('token_count')) {
      context.handle(
        _tokenCountMeta,
        tokenCount.isAcceptableOrUnknown(data['token_count']!, _tokenCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      conversationId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}conversation_id'],
          )!,
      role:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}role'],
          )!,
      content:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}content'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      isEdited:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_edited'],
          )!,
      isBookmarked:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_bookmarked'],
          )!,
      tokenCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}token_count'],
      ),
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final int id;
  final int conversationId;
  final String role;
  final String content;
  final DateTime createdAt;
  final bool isEdited;
  final bool isBookmarked;
  final int? tokenCount;
  const Message({
    required this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    required this.createdAt,
    required this.isEdited,
    required this.isBookmarked,
    this.tokenCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['conversation_id'] = Variable<int>(conversationId);
    map['role'] = Variable<String>(role);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_edited'] = Variable<bool>(isEdited);
    map['is_bookmarked'] = Variable<bool>(isBookmarked);
    if (!nullToAbsent || tokenCount != null) {
      map['token_count'] = Variable<int>(tokenCount);
    }
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      role: Value(role),
      content: Value(content),
      createdAt: Value(createdAt),
      isEdited: Value(isEdited),
      isBookmarked: Value(isBookmarked),
      tokenCount:
          tokenCount == null && nullToAbsent
              ? const Value.absent()
              : Value(tokenCount),
    );
  }

  factory Message.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<int>(json['id']),
      conversationId: serializer.fromJson<int>(json['conversationId']),
      role: serializer.fromJson<String>(json['role']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isEdited: serializer.fromJson<bool>(json['isEdited']),
      isBookmarked: serializer.fromJson<bool>(json['isBookmarked']),
      tokenCount: serializer.fromJson<int?>(json['tokenCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'conversationId': serializer.toJson<int>(conversationId),
      'role': serializer.toJson<String>(role),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isEdited': serializer.toJson<bool>(isEdited),
      'isBookmarked': serializer.toJson<bool>(isBookmarked),
      'tokenCount': serializer.toJson<int?>(tokenCount),
    };
  }

  Message copyWith({
    int? id,
    int? conversationId,
    String? role,
    String? content,
    DateTime? createdAt,
    bool? isEdited,
    bool? isBookmarked,
    Value<int?> tokenCount = const Value.absent(),
  }) => Message(
    id: id ?? this.id,
    conversationId: conversationId ?? this.conversationId,
    role: role ?? this.role,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    isEdited: isEdited ?? this.isEdited,
    isBookmarked: isBookmarked ?? this.isBookmarked,
    tokenCount: tokenCount.present ? tokenCount.value : this.tokenCount,
  );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      id: data.id.present ? data.id.value : this.id,
      conversationId:
          data.conversationId.present
              ? data.conversationId.value
              : this.conversationId,
      role: data.role.present ? data.role.value : this.role,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isEdited: data.isEdited.present ? data.isEdited.value : this.isEdited,
      isBookmarked:
          data.isBookmarked.present
              ? data.isBookmarked.value
              : this.isBookmarked,
      tokenCount:
          data.tokenCount.present ? data.tokenCount.value : this.tokenCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('isEdited: $isEdited, ')
          ..write('isBookmarked: $isBookmarked, ')
          ..write('tokenCount: $tokenCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    conversationId,
    role,
    content,
    createdAt,
    isEdited,
    isBookmarked,
    tokenCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.conversationId == this.conversationId &&
          other.role == this.role &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.isEdited == this.isEdited &&
          other.isBookmarked == this.isBookmarked &&
          other.tokenCount == this.tokenCount);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<int> id;
  final Value<int> conversationId;
  final Value<String> role;
  final Value<String> content;
  final Value<DateTime> createdAt;
  final Value<bool> isEdited;
  final Value<bool> isBookmarked;
  final Value<int?> tokenCount;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.role = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isEdited = const Value.absent(),
    this.isBookmarked = const Value.absent(),
    this.tokenCount = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.id = const Value.absent(),
    required int conversationId,
    required String role,
    required String content,
    required DateTime createdAt,
    this.isEdited = const Value.absent(),
    this.isBookmarked = const Value.absent(),
    this.tokenCount = const Value.absent(),
  }) : conversationId = Value(conversationId),
       role = Value(role),
       content = Value(content),
       createdAt = Value(createdAt);
  static Insertable<Message> custom({
    Expression<int>? id,
    Expression<int>? conversationId,
    Expression<String>? role,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<bool>? isEdited,
    Expression<bool>? isBookmarked,
    Expression<int>? tokenCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conversationId != null) 'conversation_id': conversationId,
      if (role != null) 'role': role,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (isEdited != null) 'is_edited': isEdited,
      if (isBookmarked != null) 'is_bookmarked': isBookmarked,
      if (tokenCount != null) 'token_count': tokenCount,
    });
  }

  MessagesCompanion copyWith({
    Value<int>? id,
    Value<int>? conversationId,
    Value<String>? role,
    Value<String>? content,
    Value<DateTime>? createdAt,
    Value<bool>? isEdited,
    Value<bool>? isBookmarked,
    Value<int?>? tokenCount,
  }) {
    return MessagesCompanion(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      role: role ?? this.role,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      isEdited: isEdited ?? this.isEdited,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      tokenCount: tokenCount ?? this.tokenCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<int>(conversationId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isEdited.present) {
      map['is_edited'] = Variable<bool>(isEdited.value);
    }
    if (isBookmarked.present) {
      map['is_bookmarked'] = Variable<bool>(isBookmarked.value);
    }
    if (tokenCount.present) {
      map['token_count'] = Variable<int>(tokenCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('isEdited: $isEdited, ')
          ..write('isBookmarked: $isBookmarked, ')
          ..write('tokenCount: $tokenCount')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _folderMeta = const VerificationMeta('folder');
  @override
  late final GeneratedColumn<String> folder = GeneratedColumn<String>(
    'folder',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _classLevelMeta = const VerificationMeta(
    'classLevel',
  );
  @override
  late final GeneratedColumn<String> classLevel = GeneratedColumn<String>(
    'class_level',
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPinnedMeta = const VerificationMeta(
    'isPinned',
  );
  @override
  late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>(
    'is_pinned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pinned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    content,
    folder,
    subject,
    classLevel,
    createdAt,
    updatedAt,
    isPinned,
    tags,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Note> instance, {
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
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('folder')) {
      context.handle(
        _folderMeta,
        folder.isAcceptableOrUnknown(data['folder']!, _folderMeta),
      );
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    }
    if (data.containsKey('class_level')) {
      context.handle(
        _classLevelMeta,
        classLevel.isAcceptableOrUnknown(data['class_level']!, _classLevelMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_pinned')) {
      context.handle(
        _isPinnedMeta,
        isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      content:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}content'],
          )!,
      folder: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}folder'],
      ),
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      ),
      classLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_level'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      isPinned:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_pinned'],
          )!,
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      ),
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final int id;
  final String title;
  final String content;
  final String? folder;
  final String? subject;
  final String? classLevel;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPinned;
  final String? tags;
  const Note({
    required this.id,
    required this.title,
    required this.content,
    this.folder,
    this.subject,
    this.classLevel,
    required this.createdAt,
    required this.updatedAt,
    required this.isPinned,
    this.tags,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || folder != null) {
      map['folder'] = Variable<String>(folder);
    }
    if (!nullToAbsent || subject != null) {
      map['subject'] = Variable<String>(subject);
    }
    if (!nullToAbsent || classLevel != null) {
      map['class_level'] = Variable<String>(classLevel);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_pinned'] = Variable<bool>(isPinned);
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      folder:
          folder == null && nullToAbsent ? const Value.absent() : Value(folder),
      subject:
          subject == null && nullToAbsent
              ? const Value.absent()
              : Value(subject),
      classLevel:
          classLevel == null && nullToAbsent
              ? const Value.absent()
              : Value(classLevel),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isPinned: Value(isPinned),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
    );
  }

  factory Note.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      folder: serializer.fromJson<String?>(json['folder']),
      subject: serializer.fromJson<String?>(json['subject']),
      classLevel: serializer.fromJson<String?>(json['classLevel']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      tags: serializer.fromJson<String?>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'folder': serializer.toJson<String?>(folder),
      'subject': serializer.toJson<String?>(subject),
      'classLevel': serializer.toJson<String?>(classLevel),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isPinned': serializer.toJson<bool>(isPinned),
      'tags': serializer.toJson<String?>(tags),
    };
  }

  Note copyWith({
    int? id,
    String? title,
    String? content,
    Value<String?> folder = const Value.absent(),
    Value<String?> subject = const Value.absent(),
    Value<String?> classLevel = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPinned,
    Value<String?> tags = const Value.absent(),
  }) => Note(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    folder: folder.present ? folder.value : this.folder,
    subject: subject.present ? subject.value : this.subject,
    classLevel: classLevel.present ? classLevel.value : this.classLevel,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isPinned: isPinned ?? this.isPinned,
    tags: tags.present ? tags.value : this.tags,
  );
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      folder: data.folder.present ? data.folder.value : this.folder,
      subject: data.subject.present ? data.subject.value : this.subject,
      classLevel:
          data.classLevel.present ? data.classLevel.value : this.classLevel,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('folder: $folder, ')
          ..write('subject: $subject, ')
          ..write('classLevel: $classLevel, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isPinned: $isPinned, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    content,
    folder,
    subject,
    classLevel,
    createdAt,
    updatedAt,
    isPinned,
    tags,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.folder == this.folder &&
          other.subject == this.subject &&
          other.classLevel == this.classLevel &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isPinned == this.isPinned &&
          other.tags == this.tags);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<String?> folder;
  final Value<String?> subject;
  final Value<String?> classLevel;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isPinned;
  final Value<String?> tags;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.folder = const Value.absent(),
    this.subject = const Value.absent(),
    this.classLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.tags = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String content,
    this.folder = const Value.absent(),
    this.subject = const Value.absent(),
    this.classLevel = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isPinned = const Value.absent(),
    this.tags = const Value.absent(),
  }) : title = Value(title),
       content = Value(content),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Note> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? folder,
    Expression<String>? subject,
    Expression<String>? classLevel,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isPinned,
    Expression<String>? tags,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (folder != null) 'folder': folder,
      if (subject != null) 'subject': subject,
      if (classLevel != null) 'class_level': classLevel,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isPinned != null) 'is_pinned': isPinned,
      if (tags != null) 'tags': tags,
    });
  }

  NotesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? content,
    Value<String?>? folder,
    Value<String?>? subject,
    Value<String?>? classLevel,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isPinned,
    Value<String?>? tags,
  }) {
    return NotesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      folder: folder ?? this.folder,
      subject: subject ?? this.subject,
      classLevel: classLevel ?? this.classLevel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPinned: isPinned ?? this.isPinned,
      tags: tags ?? this.tags,
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
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (folder.present) {
      map['folder'] = Variable<String>(folder.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (classLevel.present) {
      map['class_level'] = Variable<String>(classLevel.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('folder: $folder, ')
          ..write('subject: $subject, ')
          ..write('classLevel: $classLevel, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isPinned: $isPinned, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<int> messageId = GeneratedColumn<int>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES messages (id) ON DELETE CASCADE',
    ),
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, messageId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      messageId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}message_id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final int id;
  final int messageId;
  final DateTime createdAt;
  const Bookmark({
    required this.id,
    required this.messageId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['message_id'] = Variable<int>(messageId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      messageId: Value(messageId),
      createdAt: Value(createdAt),
    );
  }

  factory Bookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      id: serializer.fromJson<int>(json['id']),
      messageId: serializer.fromJson<int>(json['messageId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'messageId': serializer.toJson<int>(messageId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Bookmark copyWith({int? id, int? messageId, DateTime? createdAt}) => Bookmark(
    id: id ?? this.id,
    messageId: messageId ?? this.messageId,
    createdAt: createdAt ?? this.createdAt,
  );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, messageId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.createdAt == this.createdAt);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> id;
  final Value<int> messageId;
  final Value<DateTime> createdAt;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.id = const Value.absent(),
    required int messageId,
    required DateTime createdAt,
  }) : messageId = Value(messageId),
       createdAt = Value(createdAt);
  static Insertable<Bookmark> custom({
    Expression<int>? id,
    Expression<int>? messageId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BookmarksCompanion copyWith({
    Value<int>? id,
    Value<int>? messageId,
    Value<DateTime>? createdAt,
  }) {
    return BookmarksCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<int>(messageId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $QuizHistoryTable extends QuizHistory
    with TableInfo<$QuizHistoryTable, QuizHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuizHistoryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _classLevelMeta = const VerificationMeta(
    'classLevel',
  );
  @override
  late final GeneratedColumn<String> classLevel = GeneratedColumn<String>(
    'class_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalQuestionsMeta = const VerificationMeta(
    'totalQuestions',
  );
  @override
  late final GeneratedColumn<int> totalQuestions = GeneratedColumn<int>(
    'total_questions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctAnswersMeta = const VerificationMeta(
    'correctAnswers',
  );
  @override
  late final GeneratedColumn<int> correctAnswers = GeneratedColumn<int>(
    'correct_answers',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    subject,
    classLevel,
    totalQuestions,
    correctAnswers,
    score,
    durationSeconds,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quiz_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuizHistoryData> instance, {
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
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    }
    if (data.containsKey('class_level')) {
      context.handle(
        _classLevelMeta,
        classLevel.isAcceptableOrUnknown(data['class_level']!, _classLevelMeta),
      );
    }
    if (data.containsKey('total_questions')) {
      context.handle(
        _totalQuestionsMeta,
        totalQuestions.isAcceptableOrUnknown(
          data['total_questions']!,
          _totalQuestionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalQuestionsMeta);
    }
    if (data.containsKey('correct_answers')) {
      context.handle(
        _correctAnswersMeta,
        correctAnswers.isAcceptableOrUnknown(
          data['correct_answers']!,
          _correctAnswersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctAnswersMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuizHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuizHistoryData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      ),
      classLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_level'],
      ),
      totalQuestions:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}total_questions'],
          )!,
      correctAnswers:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}correct_answers'],
          )!,
      score:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}score'],
          )!,
      durationSeconds:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}duration_seconds'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $QuizHistoryTable createAlias(String alias) {
    return $QuizHistoryTable(attachedDatabase, alias);
  }
}

class QuizHistoryData extends DataClass implements Insertable<QuizHistoryData> {
  final int id;
  final String title;
  final String? subject;
  final String? classLevel;
  final int totalQuestions;
  final int correctAnswers;
  final int score;
  final int durationSeconds;
  final DateTime createdAt;
  const QuizHistoryData({
    required this.id,
    required this.title,
    this.subject,
    this.classLevel,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.score,
    required this.durationSeconds,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || subject != null) {
      map['subject'] = Variable<String>(subject);
    }
    if (!nullToAbsent || classLevel != null) {
      map['class_level'] = Variable<String>(classLevel);
    }
    map['total_questions'] = Variable<int>(totalQuestions);
    map['correct_answers'] = Variable<int>(correctAnswers);
    map['score'] = Variable<int>(score);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  QuizHistoryCompanion toCompanion(bool nullToAbsent) {
    return QuizHistoryCompanion(
      id: Value(id),
      title: Value(title),
      subject:
          subject == null && nullToAbsent
              ? const Value.absent()
              : Value(subject),
      classLevel:
          classLevel == null && nullToAbsent
              ? const Value.absent()
              : Value(classLevel),
      totalQuestions: Value(totalQuestions),
      correctAnswers: Value(correctAnswers),
      score: Value(score),
      durationSeconds: Value(durationSeconds),
      createdAt: Value(createdAt),
    );
  }

  factory QuizHistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizHistoryData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      subject: serializer.fromJson<String?>(json['subject']),
      classLevel: serializer.fromJson<String?>(json['classLevel']),
      totalQuestions: serializer.fromJson<int>(json['totalQuestions']),
      correctAnswers: serializer.fromJson<int>(json['correctAnswers']),
      score: serializer.fromJson<int>(json['score']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'subject': serializer.toJson<String?>(subject),
      'classLevel': serializer.toJson<String?>(classLevel),
      'totalQuestions': serializer.toJson<int>(totalQuestions),
      'correctAnswers': serializer.toJson<int>(correctAnswers),
      'score': serializer.toJson<int>(score),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  QuizHistoryData copyWith({
    int? id,
    String? title,
    Value<String?> subject = const Value.absent(),
    Value<String?> classLevel = const Value.absent(),
    int? totalQuestions,
    int? correctAnswers,
    int? score,
    int? durationSeconds,
    DateTime? createdAt,
  }) => QuizHistoryData(
    id: id ?? this.id,
    title: title ?? this.title,
    subject: subject.present ? subject.value : this.subject,
    classLevel: classLevel.present ? classLevel.value : this.classLevel,
    totalQuestions: totalQuestions ?? this.totalQuestions,
    correctAnswers: correctAnswers ?? this.correctAnswers,
    score: score ?? this.score,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    createdAt: createdAt ?? this.createdAt,
  );
  QuizHistoryData copyWithCompanion(QuizHistoryCompanion data) {
    return QuizHistoryData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      subject: data.subject.present ? data.subject.value : this.subject,
      classLevel:
          data.classLevel.present ? data.classLevel.value : this.classLevel,
      totalQuestions:
          data.totalQuestions.present
              ? data.totalQuestions.value
              : this.totalQuestions,
      correctAnswers:
          data.correctAnswers.present
              ? data.correctAnswers.value
              : this.correctAnswers,
      score: data.score.present ? data.score.value : this.score,
      durationSeconds:
          data.durationSeconds.present
              ? data.durationSeconds.value
              : this.durationSeconds,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizHistoryData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('subject: $subject, ')
          ..write('classLevel: $classLevel, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('score: $score, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    subject,
    classLevel,
    totalQuestions,
    correctAnswers,
    score,
    durationSeconds,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizHistoryData &&
          other.id == this.id &&
          other.title == this.title &&
          other.subject == this.subject &&
          other.classLevel == this.classLevel &&
          other.totalQuestions == this.totalQuestions &&
          other.correctAnswers == this.correctAnswers &&
          other.score == this.score &&
          other.durationSeconds == this.durationSeconds &&
          other.createdAt == this.createdAt);
}

class QuizHistoryCompanion extends UpdateCompanion<QuizHistoryData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> subject;
  final Value<String?> classLevel;
  final Value<int> totalQuestions;
  final Value<int> correctAnswers;
  final Value<int> score;
  final Value<int> durationSeconds;
  final Value<DateTime> createdAt;
  const QuizHistoryCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.subject = const Value.absent(),
    this.classLevel = const Value.absent(),
    this.totalQuestions = const Value.absent(),
    this.correctAnswers = const Value.absent(),
    this.score = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  QuizHistoryCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.subject = const Value.absent(),
    this.classLevel = const Value.absent(),
    required int totalQuestions,
    required int correctAnswers,
    required int score,
    required int durationSeconds,
    required DateTime createdAt,
  }) : title = Value(title),
       totalQuestions = Value(totalQuestions),
       correctAnswers = Value(correctAnswers),
       score = Value(score),
       durationSeconds = Value(durationSeconds),
       createdAt = Value(createdAt);
  static Insertable<QuizHistoryData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? subject,
    Expression<String>? classLevel,
    Expression<int>? totalQuestions,
    Expression<int>? correctAnswers,
    Expression<int>? score,
    Expression<int>? durationSeconds,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (subject != null) 'subject': subject,
      if (classLevel != null) 'class_level': classLevel,
      if (totalQuestions != null) 'total_questions': totalQuestions,
      if (correctAnswers != null) 'correct_answers': correctAnswers,
      if (score != null) 'score': score,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  QuizHistoryCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? subject,
    Value<String?>? classLevel,
    Value<int>? totalQuestions,
    Value<int>? correctAnswers,
    Value<int>? score,
    Value<int>? durationSeconds,
    Value<DateTime>? createdAt,
  }) {
    return QuizHistoryCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      classLevel: classLevel ?? this.classLevel,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      score: score ?? this.score,
      durationSeconds: durationSeconds ?? this.durationSeconds,
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
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (classLevel.present) {
      map['class_level'] = Variable<String>(classLevel.value);
    }
    if (totalQuestions.present) {
      map['total_questions'] = Variable<int>(totalQuestions.value);
    }
    if (correctAnswers.present) {
      map['correct_answers'] = Variable<int>(correctAnswers.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizHistoryCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('subject: $subject, ')
          ..write('classLevel: $classLevel, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('score: $score, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $LearningActivityTable extends LearningActivity
    with TableInfo<$LearningActivityTable, LearningActivityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningActivityTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _activityTypeMeta = const VerificationMeta(
    'activityType',
  );
  @override
  late final GeneratedColumn<String> activityType = GeneratedColumn<String>(
    'activity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _classLevelMeta = const VerificationMeta(
    'classLevel',
  );
  @override
  late final GeneratedColumn<String> classLevel = GeneratedColumn<String>(
    'class_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    activityType,
    subject,
    classLevel,
    durationMinutes,
    date,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_activity';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearningActivityData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('activity_type')) {
      context.handle(
        _activityTypeMeta,
        activityType.isAcceptableOrUnknown(
          data['activity_type']!,
          _activityTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activityTypeMeta);
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    }
    if (data.containsKey('class_level')) {
      context.handle(
        _classLevelMeta,
        classLevel.isAcceptableOrUnknown(data['class_level']!, _classLevelMeta),
      );
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearningActivityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningActivityData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      activityType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}activity_type'],
          )!,
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      ),
      classLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_level'],
      ),
      durationMinutes:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}duration_minutes'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
    );
  }

  @override
  $LearningActivityTable createAlias(String alias) {
    return $LearningActivityTable(attachedDatabase, alias);
  }
}

class LearningActivityData extends DataClass
    implements Insertable<LearningActivityData> {
  final int id;
  final String activityType;
  final String? subject;
  final String? classLevel;
  final int durationMinutes;
  final DateTime date;
  const LearningActivityData({
    required this.id,
    required this.activityType,
    this.subject,
    this.classLevel,
    required this.durationMinutes,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['activity_type'] = Variable<String>(activityType);
    if (!nullToAbsent || subject != null) {
      map['subject'] = Variable<String>(subject);
    }
    if (!nullToAbsent || classLevel != null) {
      map['class_level'] = Variable<String>(classLevel);
    }
    map['duration_minutes'] = Variable<int>(durationMinutes);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  LearningActivityCompanion toCompanion(bool nullToAbsent) {
    return LearningActivityCompanion(
      id: Value(id),
      activityType: Value(activityType),
      subject:
          subject == null && nullToAbsent
              ? const Value.absent()
              : Value(subject),
      classLevel:
          classLevel == null && nullToAbsent
              ? const Value.absent()
              : Value(classLevel),
      durationMinutes: Value(durationMinutes),
      date: Value(date),
    );
  }

  factory LearningActivityData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningActivityData(
      id: serializer.fromJson<int>(json['id']),
      activityType: serializer.fromJson<String>(json['activityType']),
      subject: serializer.fromJson<String?>(json['subject']),
      classLevel: serializer.fromJson<String?>(json['classLevel']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'activityType': serializer.toJson<String>(activityType),
      'subject': serializer.toJson<String?>(subject),
      'classLevel': serializer.toJson<String?>(classLevel),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  LearningActivityData copyWith({
    int? id,
    String? activityType,
    Value<String?> subject = const Value.absent(),
    Value<String?> classLevel = const Value.absent(),
    int? durationMinutes,
    DateTime? date,
  }) => LearningActivityData(
    id: id ?? this.id,
    activityType: activityType ?? this.activityType,
    subject: subject.present ? subject.value : this.subject,
    classLevel: classLevel.present ? classLevel.value : this.classLevel,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    date: date ?? this.date,
  );
  LearningActivityData copyWithCompanion(LearningActivityCompanion data) {
    return LearningActivityData(
      id: data.id.present ? data.id.value : this.id,
      activityType:
          data.activityType.present
              ? data.activityType.value
              : this.activityType,
      subject: data.subject.present ? data.subject.value : this.subject,
      classLevel:
          data.classLevel.present ? data.classLevel.value : this.classLevel,
      durationMinutes:
          data.durationMinutes.present
              ? data.durationMinutes.value
              : this.durationMinutes,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningActivityData(')
          ..write('id: $id, ')
          ..write('activityType: $activityType, ')
          ..write('subject: $subject, ')
          ..write('classLevel: $classLevel, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, activityType, subject, classLevel, durationMinutes, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningActivityData &&
          other.id == this.id &&
          other.activityType == this.activityType &&
          other.subject == this.subject &&
          other.classLevel == this.classLevel &&
          other.durationMinutes == this.durationMinutes &&
          other.date == this.date);
}

class LearningActivityCompanion extends UpdateCompanion<LearningActivityData> {
  final Value<int> id;
  final Value<String> activityType;
  final Value<String?> subject;
  final Value<String?> classLevel;
  final Value<int> durationMinutes;
  final Value<DateTime> date;
  const LearningActivityCompanion({
    this.id = const Value.absent(),
    this.activityType = const Value.absent(),
    this.subject = const Value.absent(),
    this.classLevel = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.date = const Value.absent(),
  });
  LearningActivityCompanion.insert({
    this.id = const Value.absent(),
    required String activityType,
    this.subject = const Value.absent(),
    this.classLevel = const Value.absent(),
    required int durationMinutes,
    required DateTime date,
  }) : activityType = Value(activityType),
       durationMinutes = Value(durationMinutes),
       date = Value(date);
  static Insertable<LearningActivityData> custom({
    Expression<int>? id,
    Expression<String>? activityType,
    Expression<String>? subject,
    Expression<String>? classLevel,
    Expression<int>? durationMinutes,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (activityType != null) 'activity_type': activityType,
      if (subject != null) 'subject': subject,
      if (classLevel != null) 'class_level': classLevel,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (date != null) 'date': date,
    });
  }

  LearningActivityCompanion copyWith({
    Value<int>? id,
    Value<String>? activityType,
    Value<String?>? subject,
    Value<String?>? classLevel,
    Value<int>? durationMinutes,
    Value<DateTime>? date,
  }) {
    return LearningActivityCompanion(
      id: id ?? this.id,
      activityType: activityType ?? this.activityType,
      subject: subject ?? this.subject,
      classLevel: classLevel ?? this.classLevel,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (activityType.present) {
      map['activity_type'] = Variable<String>(activityType.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (classLevel.present) {
      map['class_level'] = Variable<String>(classLevel.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningActivityCompanion(')
          ..write('id: $id, ')
          ..write('activityType: $activityType, ')
          ..write('subject: $subject, ')
          ..write('classLevel: $classLevel, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $AppModelsTable extends AppModels
    with TableInfo<$AppModelsTable, AppModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppModelsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantizationMeta = const VerificationMeta(
    'quantization',
  );
  @override
  late final GeneratedColumn<String> quantization = GeneratedColumn<String>(
    'quantization',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _architectureMeta = const VerificationMeta(
    'architecture',
  );
  @override
  late final GeneratedColumn<String> architecture = GeneratedColumn<String>(
    'architecture',
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
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _installedAtMeta = const VerificationMeta(
    'installedAt',
  );
  @override
  late final GeneratedColumn<DateTime> installedAt = GeneratedColumn<DateTime>(
    'installed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    filePath,
    quantization,
    sizeBytes,
    architecture,
    isActive,
    installedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'models';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppModel> instance, {
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
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('quantization')) {
      context.handle(
        _quantizationMeta,
        quantization.isAcceptableOrUnknown(
          data['quantization']!,
          _quantizationMeta,
        ),
      );
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('architecture')) {
      context.handle(
        _architectureMeta,
        architecture.isAcceptableOrUnknown(
          data['architecture']!,
          _architectureMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('installed_at')) {
      context.handle(
        _installedAtMeta,
        installedAt.isAcceptableOrUnknown(
          data['installed_at']!,
          _installedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppModel(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      filePath:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}file_path'],
          )!,
      quantization: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quantization'],
      ),
      sizeBytes:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}size_bytes'],
          )!,
      architecture: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}architecture'],
      ),
      isActive:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_active'],
          )!,
      installedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}installed_at'],
          )!,
    );
  }

  @override
  $AppModelsTable createAlias(String alias) {
    return $AppModelsTable(attachedDatabase, alias);
  }
}

class AppModel extends DataClass implements Insertable<AppModel> {
  final int id;
  final String name;
  final String filePath;
  final String? quantization;
  final int sizeBytes;
  final String? architecture;
  final bool isActive;
  final DateTime installedAt;
  const AppModel({
    required this.id,
    required this.name,
    required this.filePath,
    this.quantization,
    required this.sizeBytes,
    this.architecture,
    required this.isActive,
    required this.installedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['file_path'] = Variable<String>(filePath);
    if (!nullToAbsent || quantization != null) {
      map['quantization'] = Variable<String>(quantization);
    }
    map['size_bytes'] = Variable<int>(sizeBytes);
    if (!nullToAbsent || architecture != null) {
      map['architecture'] = Variable<String>(architecture);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['installed_at'] = Variable<DateTime>(installedAt);
    return map;
  }

  AppModelsCompanion toCompanion(bool nullToAbsent) {
    return AppModelsCompanion(
      id: Value(id),
      name: Value(name),
      filePath: Value(filePath),
      quantization:
          quantization == null && nullToAbsent
              ? const Value.absent()
              : Value(quantization),
      sizeBytes: Value(sizeBytes),
      architecture:
          architecture == null && nullToAbsent
              ? const Value.absent()
              : Value(architecture),
      isActive: Value(isActive),
      installedAt: Value(installedAt),
    );
  }

  factory AppModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppModel(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      filePath: serializer.fromJson<String>(json['filePath']),
      quantization: serializer.fromJson<String?>(json['quantization']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      architecture: serializer.fromJson<String?>(json['architecture']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      installedAt: serializer.fromJson<DateTime>(json['installedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'filePath': serializer.toJson<String>(filePath),
      'quantization': serializer.toJson<String?>(quantization),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'architecture': serializer.toJson<String?>(architecture),
      'isActive': serializer.toJson<bool>(isActive),
      'installedAt': serializer.toJson<DateTime>(installedAt),
    };
  }

  AppModel copyWith({
    int? id,
    String? name,
    String? filePath,
    Value<String?> quantization = const Value.absent(),
    int? sizeBytes,
    Value<String?> architecture = const Value.absent(),
    bool? isActive,
    DateTime? installedAt,
  }) => AppModel(
    id: id ?? this.id,
    name: name ?? this.name,
    filePath: filePath ?? this.filePath,
    quantization: quantization.present ? quantization.value : this.quantization,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    architecture: architecture.present ? architecture.value : this.architecture,
    isActive: isActive ?? this.isActive,
    installedAt: installedAt ?? this.installedAt,
  );
  AppModel copyWithCompanion(AppModelsCompanion data) {
    return AppModel(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      quantization:
          data.quantization.present
              ? data.quantization.value
              : this.quantization,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      architecture:
          data.architecture.present
              ? data.architecture.value
              : this.architecture,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      installedAt:
          data.installedAt.present ? data.installedAt.value : this.installedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppModel(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('filePath: $filePath, ')
          ..write('quantization: $quantization, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('architecture: $architecture, ')
          ..write('isActive: $isActive, ')
          ..write('installedAt: $installedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    filePath,
    quantization,
    sizeBytes,
    architecture,
    isActive,
    installedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppModel &&
          other.id == this.id &&
          other.name == this.name &&
          other.filePath == this.filePath &&
          other.quantization == this.quantization &&
          other.sizeBytes == this.sizeBytes &&
          other.architecture == this.architecture &&
          other.isActive == this.isActive &&
          other.installedAt == this.installedAt);
}

class AppModelsCompanion extends UpdateCompanion<AppModel> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> filePath;
  final Value<String?> quantization;
  final Value<int> sizeBytes;
  final Value<String?> architecture;
  final Value<bool> isActive;
  final Value<DateTime> installedAt;
  const AppModelsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.filePath = const Value.absent(),
    this.quantization = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.architecture = const Value.absent(),
    this.isActive = const Value.absent(),
    this.installedAt = const Value.absent(),
  });
  AppModelsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String filePath,
    this.quantization = const Value.absent(),
    required int sizeBytes,
    this.architecture = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime installedAt,
  }) : name = Value(name),
       filePath = Value(filePath),
       sizeBytes = Value(sizeBytes),
       installedAt = Value(installedAt);
  static Insertable<AppModel> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? filePath,
    Expression<String>? quantization,
    Expression<int>? sizeBytes,
    Expression<String>? architecture,
    Expression<bool>? isActive,
    Expression<DateTime>? installedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (filePath != null) 'file_path': filePath,
      if (quantization != null) 'quantization': quantization,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (architecture != null) 'architecture': architecture,
      if (isActive != null) 'is_active': isActive,
      if (installedAt != null) 'installed_at': installedAt,
    });
  }

  AppModelsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? filePath,
    Value<String?>? quantization,
    Value<int>? sizeBytes,
    Value<String?>? architecture,
    Value<bool>? isActive,
    Value<DateTime>? installedAt,
  }) {
    return AppModelsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      filePath: filePath ?? this.filePath,
      quantization: quantization ?? this.quantization,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      architecture: architecture ?? this.architecture,
      isActive: isActive ?? this.isActive,
      installedAt: installedAt ?? this.installedAt,
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
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (quantization.present) {
      map['quantization'] = Variable<String>(quantization.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (architecture.present) {
      map['architecture'] = Variable<String>(architecture.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (installedAt.present) {
      map['installed_at'] = Variable<DateTime>(installedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppModelsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('filePath: $filePath, ')
          ..write('quantization: $quantization, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('architecture: $architecture, ')
          ..write('isActive: $isActive, ')
          ..write('installedAt: $installedAt')
          ..write(')'))
        .toString();
  }
}

class $PreferencesTable extends Preferences
    with TableInfo<$PreferencesTable, Preference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<Preference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Preference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Preference(
      key:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}key'],
          )!,
      value:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}value'],
          )!,
    );
  }

  @override
  $PreferencesTable createAlias(String alias) {
    return $PreferencesTable(attachedDatabase, alias);
  }
}

class Preference extends DataClass implements Insertable<Preference> {
  final String key;
  final String value;
  const Preference({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  PreferencesCompanion toCompanion(bool nullToAbsent) {
    return PreferencesCompanion(key: Value(key), value: Value(value));
  }

  factory Preference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Preference(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  Preference copyWith({String? key, String? value}) =>
      Preference(key: key ?? this.key, value: value ?? this.value);
  Preference copyWithCompanion(PreferencesCompanion data) {
    return Preference(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Preference(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Preference &&
          other.key == this.key &&
          other.value == this.value);
}

class PreferencesCompanion extends UpdateCompanion<Preference> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const PreferencesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PreferencesCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<Preference> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PreferencesCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return PreferencesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferencesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileTypeMeta = const VerificationMeta(
    'fileType',
  );
  @override
  late final GeneratedColumn<String> fileType = GeneratedColumn<String>(
    'file_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _extractedTextMeta = const VerificationMeta(
    'extractedText',
  );
  @override
  late final GeneratedColumn<String> extractedText = GeneratedColumn<String>(
    'extracted_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _importedAtMeta = const VerificationMeta(
    'importedAt',
  );
  @override
  late final GeneratedColumn<DateTime> importedAt = GeneratedColumn<DateTime>(
    'imported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    filePath,
    fileType,
    sizeBytes,
    extractedText,
    summary,
    importedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Document> instance, {
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
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('file_type')) {
      context.handle(
        _fileTypeMeta,
        fileType.isAcceptableOrUnknown(data['file_type']!, _fileTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileTypeMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('extracted_text')) {
      context.handle(
        _extractedTextMeta,
        extractedText.isAcceptableOrUnknown(
          data['extracted_text']!,
          _extractedTextMeta,
        ),
      );
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    }
    if (data.containsKey('imported_at')) {
      context.handle(
        _importedAtMeta,
        importedAt.isAcceptableOrUnknown(data['imported_at']!, _importedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_importedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      filePath:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}file_path'],
          )!,
      fileType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}file_type'],
          )!,
      sizeBytes:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}size_bytes'],
          )!,
      extractedText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extracted_text'],
      ),
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      ),
      importedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}imported_at'],
          )!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class Document extends DataClass implements Insertable<Document> {
  final int id;
  final String title;
  final String filePath;
  final String fileType;
  final int sizeBytes;
  final String? extractedText;
  final String? summary;
  final DateTime importedAt;
  const Document({
    required this.id,
    required this.title,
    required this.filePath,
    required this.fileType,
    required this.sizeBytes,
    this.extractedText,
    this.summary,
    required this.importedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['file_path'] = Variable<String>(filePath);
    map['file_type'] = Variable<String>(fileType);
    map['size_bytes'] = Variable<int>(sizeBytes);
    if (!nullToAbsent || extractedText != null) {
      map['extracted_text'] = Variable<String>(extractedText);
    }
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    map['imported_at'] = Variable<DateTime>(importedAt);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      title: Value(title),
      filePath: Value(filePath),
      fileType: Value(fileType),
      sizeBytes: Value(sizeBytes),
      extractedText:
          extractedText == null && nullToAbsent
              ? const Value.absent()
              : Value(extractedText),
      summary:
          summary == null && nullToAbsent
              ? const Value.absent()
              : Value(summary),
      importedAt: Value(importedAt),
    );
  }

  factory Document.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      filePath: serializer.fromJson<String>(json['filePath']),
      fileType: serializer.fromJson<String>(json['fileType']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      extractedText: serializer.fromJson<String?>(json['extractedText']),
      summary: serializer.fromJson<String?>(json['summary']),
      importedAt: serializer.fromJson<DateTime>(json['importedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'filePath': serializer.toJson<String>(filePath),
      'fileType': serializer.toJson<String>(fileType),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'extractedText': serializer.toJson<String?>(extractedText),
      'summary': serializer.toJson<String?>(summary),
      'importedAt': serializer.toJson<DateTime>(importedAt),
    };
  }

  Document copyWith({
    int? id,
    String? title,
    String? filePath,
    String? fileType,
    int? sizeBytes,
    Value<String?> extractedText = const Value.absent(),
    Value<String?> summary = const Value.absent(),
    DateTime? importedAt,
  }) => Document(
    id: id ?? this.id,
    title: title ?? this.title,
    filePath: filePath ?? this.filePath,
    fileType: fileType ?? this.fileType,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    extractedText:
        extractedText.present ? extractedText.value : this.extractedText,
    summary: summary.present ? summary.value : this.summary,
    importedAt: importedAt ?? this.importedAt,
  );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      fileType: data.fileType.present ? data.fileType.value : this.fileType,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      extractedText:
          data.extractedText.present
              ? data.extractedText.value
              : this.extractedText,
      summary: data.summary.present ? data.summary.value : this.summary,
      importedAt:
          data.importedAt.present ? data.importedAt.value : this.importedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('filePath: $filePath, ')
          ..write('fileType: $fileType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('extractedText: $extractedText, ')
          ..write('summary: $summary, ')
          ..write('importedAt: $importedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    filePath,
    fileType,
    sizeBytes,
    extractedText,
    summary,
    importedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.title == this.title &&
          other.filePath == this.filePath &&
          other.fileType == this.fileType &&
          other.sizeBytes == this.sizeBytes &&
          other.extractedText == this.extractedText &&
          other.summary == this.summary &&
          other.importedAt == this.importedAt);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> filePath;
  final Value<String> fileType;
  final Value<int> sizeBytes;
  final Value<String?> extractedText;
  final Value<String?> summary;
  final Value<DateTime> importedAt;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.filePath = const Value.absent(),
    this.fileType = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.extractedText = const Value.absent(),
    this.summary = const Value.absent(),
    this.importedAt = const Value.absent(),
  });
  DocumentsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String filePath,
    required String fileType,
    required int sizeBytes,
    this.extractedText = const Value.absent(),
    this.summary = const Value.absent(),
    required DateTime importedAt,
  }) : title = Value(title),
       filePath = Value(filePath),
       fileType = Value(fileType),
       sizeBytes = Value(sizeBytes),
       importedAt = Value(importedAt);
  static Insertable<Document> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? filePath,
    Expression<String>? fileType,
    Expression<int>? sizeBytes,
    Expression<String>? extractedText,
    Expression<String>? summary,
    Expression<DateTime>? importedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (filePath != null) 'file_path': filePath,
      if (fileType != null) 'file_type': fileType,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (extractedText != null) 'extracted_text': extractedText,
      if (summary != null) 'summary': summary,
      if (importedAt != null) 'imported_at': importedAt,
    });
  }

  DocumentsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? filePath,
    Value<String>? fileType,
    Value<int>? sizeBytes,
    Value<String?>? extractedText,
    Value<String?>? summary,
    Value<DateTime>? importedAt,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      filePath: filePath ?? this.filePath,
      fileType: fileType ?? this.fileType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      extractedText: extractedText ?? this.extractedText,
      summary: summary ?? this.summary,
      importedAt: importedAt ?? this.importedAt,
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
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (fileType.present) {
      map['file_type'] = Variable<String>(fileType.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (extractedText.present) {
      map['extracted_text'] = Variable<String>(extractedText.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<DateTime>(importedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('filePath: $filePath, ')
          ..write('fileType: $fileType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('extractedText: $extractedText, ')
          ..write('summary: $summary, ')
          ..write('importedAt: $importedAt')
          ..write(')'))
        .toString();
  }
}

class $MemoriesTable extends Memories with TableInfo<$MemoriesTable, Memory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemoriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<int> conversationId = GeneratedColumn<int>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES conversations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importanceMeta = const VerificationMeta(
    'importance',
  );
  @override
  late final GeneratedColumn<double> importance = GeneratedColumn<double>(
    'importance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.5),
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    conversationId,
    type,
    content,
    importance,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Memory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('importance')) {
      context.handle(
        _importanceMeta,
        importance.isAcceptableOrUnknown(data['importance']!, _importanceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Memory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Memory(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      conversationId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}conversation_id'],
          )!,
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      content:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}content'],
          )!,
      importance:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}importance'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $MemoriesTable createAlias(String alias) {
    return $MemoriesTable(attachedDatabase, alias);
  }
}

class Memory extends DataClass implements Insertable<Memory> {
  final int id;
  final int conversationId;
  final String type;
  final String content;
  final double importance;
  final DateTime createdAt;
  const Memory({
    required this.id,
    required this.conversationId,
    required this.type,
    required this.content,
    required this.importance,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['conversation_id'] = Variable<int>(conversationId);
    map['type'] = Variable<String>(type);
    map['content'] = Variable<String>(content);
    map['importance'] = Variable<double>(importance);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MemoriesCompanion toCompanion(bool nullToAbsent) {
    return MemoriesCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      type: Value(type),
      content: Value(content),
      importance: Value(importance),
      createdAt: Value(createdAt),
    );
  }

  factory Memory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Memory(
      id: serializer.fromJson<int>(json['id']),
      conversationId: serializer.fromJson<int>(json['conversationId']),
      type: serializer.fromJson<String>(json['type']),
      content: serializer.fromJson<String>(json['content']),
      importance: serializer.fromJson<double>(json['importance']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'conversationId': serializer.toJson<int>(conversationId),
      'type': serializer.toJson<String>(type),
      'content': serializer.toJson<String>(content),
      'importance': serializer.toJson<double>(importance),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Memory copyWith({
    int? id,
    int? conversationId,
    String? type,
    String? content,
    double? importance,
    DateTime? createdAt,
  }) => Memory(
    id: id ?? this.id,
    conversationId: conversationId ?? this.conversationId,
    type: type ?? this.type,
    content: content ?? this.content,
    importance: importance ?? this.importance,
    createdAt: createdAt ?? this.createdAt,
  );
  Memory copyWithCompanion(MemoriesCompanion data) {
    return Memory(
      id: data.id.present ? data.id.value : this.id,
      conversationId:
          data.conversationId.present
              ? data.conversationId.value
              : this.conversationId,
      type: data.type.present ? data.type.value : this.type,
      content: data.content.present ? data.content.value : this.content,
      importance:
          data.importance.present ? data.importance.value : this.importance,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Memory(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('importance: $importance, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, conversationId, type, content, importance, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Memory &&
          other.id == this.id &&
          other.conversationId == this.conversationId &&
          other.type == this.type &&
          other.content == this.content &&
          other.importance == this.importance &&
          other.createdAt == this.createdAt);
}

class MemoriesCompanion extends UpdateCompanion<Memory> {
  final Value<int> id;
  final Value<int> conversationId;
  final Value<String> type;
  final Value<String> content;
  final Value<double> importance;
  final Value<DateTime> createdAt;
  const MemoriesCompanion({
    this.id = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.importance = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MemoriesCompanion.insert({
    this.id = const Value.absent(),
    required int conversationId,
    required String type,
    required String content,
    this.importance = const Value.absent(),
    required DateTime createdAt,
  }) : conversationId = Value(conversationId),
       type = Value(type),
       content = Value(content),
       createdAt = Value(createdAt);
  static Insertable<Memory> custom({
    Expression<int>? id,
    Expression<int>? conversationId,
    Expression<String>? type,
    Expression<String>? content,
    Expression<double>? importance,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conversationId != null) 'conversation_id': conversationId,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
      if (importance != null) 'importance': importance,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MemoriesCompanion copyWith({
    Value<int>? id,
    Value<int>? conversationId,
    Value<String>? type,
    Value<String>? content,
    Value<double>? importance,
    Value<DateTime>? createdAt,
  }) {
    return MemoriesCompanion(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      type: type ?? this.type,
      content: content ?? this.content,
      importance: importance ?? this.importance,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<int>(conversationId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (importance.present) {
      map['importance'] = Variable<double>(importance.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoriesCompanion(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('importance: $importance, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    icon,
    color,
    sortOrder,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subjects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subject> instance, {
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
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
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
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subject(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      sortOrder:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}sort_order'],
          )!,
      isActive:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_active'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class Subject extends DataClass implements Insertable<Subject> {
  final int id;
  final String name;
  final String? description;
  final String? icon;
  final String? color;
  final int sortOrder;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Subject({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    this.color,
    required this.sortOrder,
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
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      name: Value(name),
      description:
          description == null && nullToAbsent
              ? const Value.absent()
              : Value(description),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Subject.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      icon: serializer.fromJson<String?>(json['icon']),
      color: serializer.fromJson<String?>(json['color']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
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
      'icon': serializer.toJson<String?>(icon),
      'color': serializer.toJson<String?>(color),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Subject copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> icon = const Value.absent(),
    Value<String?> color = const Value.absent(),
    int? sortOrder,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Subject(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    icon: icon.present ? icon.value : this.icon,
    color: color.present ? color.value : this.color,
    sortOrder: sortOrder ?? this.sortOrder,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Subject copyWithCompanion(SubjectsCompanion data) {
    return Subject(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('sortOrder: $sortOrder, ')
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
    icon,
    color,
    sortOrder,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.sortOrder == this.sortOrder &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> icon;
  final Value<String?> color;
  final Value<int> sortOrder;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SubjectsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Subject> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<String>? color,
    Expression<int>? sortOrder,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SubjectsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? icon,
    Value<String?>? color,
    Value<int>? sortOrder,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SubjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      sortOrder: sortOrder ?? this.sortOrder,
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
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
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
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ChaptersTable extends Chapters with TableInfo<$ChaptersTable, Chapter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChaptersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE CASCADE',
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
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _estimatedMinutesMeta = const VerificationMeta(
    'estimatedMinutes',
  );
  @override
  late final GeneratedColumn<int> estimatedMinutes = GeneratedColumn<int>(
    'estimated_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    name,
    description,
    orderIndex,
    estimatedMinutes,
    isCompleted,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chapters';
  @override
  VerificationContext validateIntegrity(
    Insertable<Chapter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
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
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
        _estimatedMinutesMeta,
        estimatedMinutes.isAcceptableOrUnknown(
          data['estimated_minutes']!,
          _estimatedMinutesMeta,
        ),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Chapter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chapter(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      subjectId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}subject_id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      orderIndex:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}order_index'],
          )!,
      estimatedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_minutes'],
      ),
      isCompleted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_completed'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $ChaptersTable createAlias(String alias) {
    return $ChaptersTable(attachedDatabase, alias);
  }
}

class Chapter extends DataClass implements Insertable<Chapter> {
  final int id;
  final int subjectId;
  final String name;
  final String? description;
  final int orderIndex;
  final int? estimatedMinutes;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Chapter({
    required this.id,
    required this.subjectId,
    required this.name,
    this.description,
    required this.orderIndex,
    this.estimatedMinutes,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subject_id'] = Variable<int>(subjectId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['order_index'] = Variable<int>(orderIndex);
    if (!nullToAbsent || estimatedMinutes != null) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ChaptersCompanion toCompanion(bool nullToAbsent) {
    return ChaptersCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      name: Value(name),
      description:
          description == null && nullToAbsent
              ? const Value.absent()
              : Value(description),
      orderIndex: Value(orderIndex),
      estimatedMinutes:
          estimatedMinutes == null && nullToAbsent
              ? const Value.absent()
              : Value(estimatedMinutes),
      isCompleted: Value(isCompleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Chapter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chapter(
      id: serializer.fromJson<int>(json['id']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      estimatedMinutes: serializer.fromJson<int?>(json['estimatedMinutes']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subjectId': serializer.toJson<int>(subjectId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'estimatedMinutes': serializer.toJson<int?>(estimatedMinutes),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Chapter copyWith({
    int? id,
    int? subjectId,
    String? name,
    Value<String?> description = const Value.absent(),
    int? orderIndex,
    Value<int?> estimatedMinutes = const Value.absent(),
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Chapter(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    orderIndex: orderIndex ?? this.orderIndex,
    estimatedMinutes:
        estimatedMinutes.present
            ? estimatedMinutes.value
            : this.estimatedMinutes,
    isCompleted: isCompleted ?? this.isCompleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Chapter copyWithCompanion(ChaptersCompanion data) {
    return Chapter(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      estimatedMinutes:
          data.estimatedMinutes.present
              ? data.estimatedMinutes.value
              : this.estimatedMinutes,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Chapter(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subjectId,
    name,
    description,
    orderIndex,
    estimatedMinutes,
    isCompleted,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chapter &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.name == this.name &&
          other.description == this.description &&
          other.orderIndex == this.orderIndex &&
          other.estimatedMinutes == this.estimatedMinutes &&
          other.isCompleted == this.isCompleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ChaptersCompanion extends UpdateCompanion<Chapter> {
  final Value<int> id;
  final Value<int> subjectId;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> orderIndex;
  final Value<int?> estimatedMinutes;
  final Value<bool> isCompleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ChaptersCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ChaptersCompanion.insert({
    this.id = const Value.absent(),
    required int subjectId,
    required String name,
    this.description = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.isCompleted = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : subjectId = Value(subjectId),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Chapter> custom({
    Expression<int>? id,
    Expression<int>? subjectId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? orderIndex,
    Expression<int>? estimatedMinutes,
    Expression<bool>? isCompleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (orderIndex != null) 'order_index': orderIndex,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ChaptersCompanion copyWith({
    Value<int>? id,
    Value<int>? subjectId,
    Value<String>? name,
    Value<String?>? description,
    Value<int>? orderIndex,
    Value<int?>? estimatedMinutes,
    Value<bool>? isCompleted,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ChaptersCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      name: name ?? this.name,
      description: description ?? this.description,
      orderIndex: orderIndex ?? this.orderIndex,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      isCompleted: isCompleted ?? this.isCompleted,
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
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
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
    return (StringBuffer('ChaptersCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TopicsTable extends Topics with TableInfo<$TopicsTable, Topic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<int> chapterId = GeneratedColumn<int>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chapters (id) ON DELETE CASCADE',
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
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _estimatedMinutesMeta = const VerificationMeta(
    'estimatedMinutes',
  );
  @override
  late final GeneratedColumn<int> estimatedMinutes = GeneratedColumn<int>(
    'estimated_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prerequisitesMeta = const VerificationMeta(
    'prerequisites',
  );
  @override
  late final GeneratedColumn<String> prerequisites = GeneratedColumn<String>(
    'prerequisites',
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    chapterId,
    name,
    description,
    difficulty,
    orderIndex,
    estimatedMinutes,
    prerequisites,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topics';
  @override
  VerificationContext validateIntegrity(
    Insertable<Topic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
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
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
        _estimatedMinutesMeta,
        estimatedMinutes.isAcceptableOrUnknown(
          data['estimated_minutes']!,
          _estimatedMinutesMeta,
        ),
      );
    }
    if (data.containsKey('prerequisites')) {
      context.handle(
        _prerequisitesMeta,
        prerequisites.isAcceptableOrUnknown(
          data['prerequisites']!,
          _prerequisitesMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Topic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Topic(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      chapterId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}chapter_id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      ),
      orderIndex:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}order_index'],
          )!,
      estimatedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_minutes'],
      ),
      prerequisites: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prerequisites'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $TopicsTable createAlias(String alias) {
    return $TopicsTable(attachedDatabase, alias);
  }
}

class Topic extends DataClass implements Insertable<Topic> {
  final int id;
  final int chapterId;
  final String name;
  final String? description;
  final String? difficulty;
  final int orderIndex;
  final int? estimatedMinutes;
  final String? prerequisites;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Topic({
    required this.id,
    required this.chapterId,
    required this.name,
    this.description,
    this.difficulty,
    required this.orderIndex,
    this.estimatedMinutes,
    this.prerequisites,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chapter_id'] = Variable<int>(chapterId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<String>(difficulty);
    }
    map['order_index'] = Variable<int>(orderIndex);
    if (!nullToAbsent || estimatedMinutes != null) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes);
    }
    if (!nullToAbsent || prerequisites != null) {
      map['prerequisites'] = Variable<String>(prerequisites);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TopicsCompanion toCompanion(bool nullToAbsent) {
    return TopicsCompanion(
      id: Value(id),
      chapterId: Value(chapterId),
      name: Value(name),
      description:
          description == null && nullToAbsent
              ? const Value.absent()
              : Value(description),
      difficulty:
          difficulty == null && nullToAbsent
              ? const Value.absent()
              : Value(difficulty),
      orderIndex: Value(orderIndex),
      estimatedMinutes:
          estimatedMinutes == null && nullToAbsent
              ? const Value.absent()
              : Value(estimatedMinutes),
      prerequisites:
          prerequisites == null && nullToAbsent
              ? const Value.absent()
              : Value(prerequisites),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Topic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Topic(
      id: serializer.fromJson<int>(json['id']),
      chapterId: serializer.fromJson<int>(json['chapterId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      difficulty: serializer.fromJson<String?>(json['difficulty']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      estimatedMinutes: serializer.fromJson<int?>(json['estimatedMinutes']),
      prerequisites: serializer.fromJson<String?>(json['prerequisites']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chapterId': serializer.toJson<int>(chapterId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'difficulty': serializer.toJson<String?>(difficulty),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'estimatedMinutes': serializer.toJson<int?>(estimatedMinutes),
      'prerequisites': serializer.toJson<String?>(prerequisites),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Topic copyWith({
    int? id,
    int? chapterId,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> difficulty = const Value.absent(),
    int? orderIndex,
    Value<int?> estimatedMinutes = const Value.absent(),
    Value<String?> prerequisites = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Topic(
    id: id ?? this.id,
    chapterId: chapterId ?? this.chapterId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    difficulty: difficulty.present ? difficulty.value : this.difficulty,
    orderIndex: orderIndex ?? this.orderIndex,
    estimatedMinutes:
        estimatedMinutes.present
            ? estimatedMinutes.value
            : this.estimatedMinutes,
    prerequisites:
        prerequisites.present ? prerequisites.value : this.prerequisites,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Topic copyWithCompanion(TopicsCompanion data) {
    return Topic(
      id: data.id.present ? data.id.value : this.id,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      estimatedMinutes:
          data.estimatedMinutes.present
              ? data.estimatedMinutes.value
              : this.estimatedMinutes,
      prerequisites:
          data.prerequisites.present
              ? data.prerequisites.value
              : this.prerequisites,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Topic(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('difficulty: $difficulty, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('prerequisites: $prerequisites, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    chapterId,
    name,
    description,
    difficulty,
    orderIndex,
    estimatedMinutes,
    prerequisites,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Topic &&
          other.id == this.id &&
          other.chapterId == this.chapterId &&
          other.name == this.name &&
          other.description == this.description &&
          other.difficulty == this.difficulty &&
          other.orderIndex == this.orderIndex &&
          other.estimatedMinutes == this.estimatedMinutes &&
          other.prerequisites == this.prerequisites &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TopicsCompanion extends UpdateCompanion<Topic> {
  final Value<int> id;
  final Value<int> chapterId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> difficulty;
  final Value<int> orderIndex;
  final Value<int?> estimatedMinutes;
  final Value<String?> prerequisites;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TopicsCompanion({
    this.id = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.prerequisites = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TopicsCompanion.insert({
    this.id = const Value.absent(),
    required int chapterId,
    required String name,
    this.description = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.prerequisites = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : chapterId = Value(chapterId),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Topic> custom({
    Expression<int>? id,
    Expression<int>? chapterId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? difficulty,
    Expression<int>? orderIndex,
    Expression<int>? estimatedMinutes,
    Expression<String>? prerequisites,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chapterId != null) 'chapter_id': chapterId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (difficulty != null) 'difficulty': difficulty,
      if (orderIndex != null) 'order_index': orderIndex,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (prerequisites != null) 'prerequisites': prerequisites,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TopicsCompanion copyWith({
    Value<int>? id,
    Value<int>? chapterId,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? difficulty,
    Value<int>? orderIndex,
    Value<int?>? estimatedMinutes,
    Value<String?>? prerequisites,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return TopicsCompanion(
      id: id ?? this.id,
      chapterId: chapterId ?? this.chapterId,
      name: name ?? this.name,
      description: description ?? this.description,
      difficulty: difficulty ?? this.difficulty,
      orderIndex: orderIndex ?? this.orderIndex,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      prerequisites: prerequisites ?? this.prerequisites,
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
    if (chapterId.present) {
      map['chapter_id'] = Variable<int>(chapterId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes.value);
    }
    if (prerequisites.present) {
      map['prerequisites'] = Variable<String>(prerequisites.value);
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
    return (StringBuffer('TopicsCompanion(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('difficulty: $difficulty, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('prerequisites: $prerequisites, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LearningResourcesTable extends LearningResources
    with TableInfo<$LearningResourcesTable, LearningResource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningResourcesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<int> topicId = GeneratedColumn<int>(
    'topic_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topics (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE CASCADE',
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceUrlMeta = const VerificationMeta(
    'sourceUrl',
  );
  @override
  late final GeneratedColumn<String> sourceUrl = GeneratedColumn<String>(
    'source_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _thumbnailUrlMeta = const VerificationMeta(
    'thumbnailUrl',
  );
  @override
  late final GeneratedColumn<String> thumbnailUrl = GeneratedColumn<String>(
    'thumbnail_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    topicId,
    subjectId,
    title,
    type,
    sourceUrl,
    localPath,
    description,
    thumbnailUrl,
    durationSeconds,
    tags,
    isFavorite,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_resources';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearningResource> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('source_url')) {
      context.handle(
        _sourceUrlMeta,
        sourceUrl.isAcceptableOrUnknown(data['source_url']!, _sourceUrlMeta),
      );
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
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
    if (data.containsKey('thumbnail_url')) {
      context.handle(
        _thumbnailUrlMeta,
        thumbnailUrl.isAcceptableOrUnknown(
          data['thumbnail_url']!,
          _thumbnailUrlMeta,
        ),
      );
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearningResource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningResource(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}topic_id'],
      ),
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      ),
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      sourceUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_url'],
      ),
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      thumbnailUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_url'],
      ),
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      ),
      isFavorite:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_favorite'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $LearningResourcesTable createAlias(String alias) {
    return $LearningResourcesTable(attachedDatabase, alias);
  }
}

class LearningResource extends DataClass
    implements Insertable<LearningResource> {
  final int id;
  final int? topicId;
  final int? subjectId;
  final String title;
  final String type;
  final String? sourceUrl;
  final String? localPath;
  final String? description;
  final String? thumbnailUrl;
  final int? durationSeconds;
  final String? tags;
  final bool isFavorite;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LearningResource({
    required this.id,
    this.topicId,
    this.subjectId,
    required this.title,
    required this.type,
    this.sourceUrl,
    this.localPath,
    this.description,
    this.thumbnailUrl,
    this.durationSeconds,
    this.tags,
    required this.isFavorite,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || topicId != null) {
      map['topic_id'] = Variable<int>(topicId);
    }
    if (!nullToAbsent || subjectId != null) {
      map['subject_id'] = Variable<int>(subjectId);
    }
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || sourceUrl != null) {
      map['source_url'] = Variable<String>(sourceUrl);
    }
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || thumbnailUrl != null) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl);
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LearningResourcesCompanion toCompanion(bool nullToAbsent) {
    return LearningResourcesCompanion(
      id: Value(id),
      topicId:
          topicId == null && nullToAbsent
              ? const Value.absent()
              : Value(topicId),
      subjectId:
          subjectId == null && nullToAbsent
              ? const Value.absent()
              : Value(subjectId),
      title: Value(title),
      type: Value(type),
      sourceUrl:
          sourceUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(sourceUrl),
      localPath:
          localPath == null && nullToAbsent
              ? const Value.absent()
              : Value(localPath),
      description:
          description == null && nullToAbsent
              ? const Value.absent()
              : Value(description),
      thumbnailUrl:
          thumbnailUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(thumbnailUrl),
      durationSeconds:
          durationSeconds == null && nullToAbsent
              ? const Value.absent()
              : Value(durationSeconds),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      isFavorite: Value(isFavorite),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LearningResource.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningResource(
      id: serializer.fromJson<int>(json['id']),
      topicId: serializer.fromJson<int?>(json['topicId']),
      subjectId: serializer.fromJson<int?>(json['subjectId']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      sourceUrl: serializer.fromJson<String?>(json['sourceUrl']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      description: serializer.fromJson<String?>(json['description']),
      thumbnailUrl: serializer.fromJson<String?>(json['thumbnailUrl']),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      tags: serializer.fromJson<String?>(json['tags']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'topicId': serializer.toJson<int?>(topicId),
      'subjectId': serializer.toJson<int?>(subjectId),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'sourceUrl': serializer.toJson<String?>(sourceUrl),
      'localPath': serializer.toJson<String?>(localPath),
      'description': serializer.toJson<String?>(description),
      'thumbnailUrl': serializer.toJson<String?>(thumbnailUrl),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'tags': serializer.toJson<String?>(tags),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LearningResource copyWith({
    int? id,
    Value<int?> topicId = const Value.absent(),
    Value<int?> subjectId = const Value.absent(),
    String? title,
    String? type,
    Value<String?> sourceUrl = const Value.absent(),
    Value<String?> localPath = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> thumbnailUrl = const Value.absent(),
    Value<int?> durationSeconds = const Value.absent(),
    Value<String?> tags = const Value.absent(),
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LearningResource(
    id: id ?? this.id,
    topicId: topicId.present ? topicId.value : this.topicId,
    subjectId: subjectId.present ? subjectId.value : this.subjectId,
    title: title ?? this.title,
    type: type ?? this.type,
    sourceUrl: sourceUrl.present ? sourceUrl.value : this.sourceUrl,
    localPath: localPath.present ? localPath.value : this.localPath,
    description: description.present ? description.value : this.description,
    thumbnailUrl: thumbnailUrl.present ? thumbnailUrl.value : this.thumbnailUrl,
    durationSeconds:
        durationSeconds.present ? durationSeconds.value : this.durationSeconds,
    tags: tags.present ? tags.value : this.tags,
    isFavorite: isFavorite ?? this.isFavorite,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LearningResource copyWithCompanion(LearningResourcesCompanion data) {
    return LearningResource(
      id: data.id.present ? data.id.value : this.id,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      sourceUrl: data.sourceUrl.present ? data.sourceUrl.value : this.sourceUrl,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      description:
          data.description.present ? data.description.value : this.description,
      thumbnailUrl:
          data.thumbnailUrl.present
              ? data.thumbnailUrl.value
              : this.thumbnailUrl,
      durationSeconds:
          data.durationSeconds.present
              ? data.durationSeconds.value
              : this.durationSeconds,
      tags: data.tags.present ? data.tags.value : this.tags,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningResource(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('localPath: $localPath, ')
          ..write('description: $description, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('tags: $tags, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    topicId,
    subjectId,
    title,
    type,
    sourceUrl,
    localPath,
    description,
    thumbnailUrl,
    durationSeconds,
    tags,
    isFavorite,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningResource &&
          other.id == this.id &&
          other.topicId == this.topicId &&
          other.subjectId == this.subjectId &&
          other.title == this.title &&
          other.type == this.type &&
          other.sourceUrl == this.sourceUrl &&
          other.localPath == this.localPath &&
          other.description == this.description &&
          other.thumbnailUrl == this.thumbnailUrl &&
          other.durationSeconds == this.durationSeconds &&
          other.tags == this.tags &&
          other.isFavorite == this.isFavorite &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LearningResourcesCompanion extends UpdateCompanion<LearningResource> {
  final Value<int> id;
  final Value<int?> topicId;
  final Value<int?> subjectId;
  final Value<String> title;
  final Value<String> type;
  final Value<String?> sourceUrl;
  final Value<String?> localPath;
  final Value<String?> description;
  final Value<String?> thumbnailUrl;
  final Value<int?> durationSeconds;
  final Value<String?> tags;
  final Value<bool> isFavorite;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LearningResourcesCompanion({
    this.id = const Value.absent(),
    this.topicId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.localPath = const Value.absent(),
    this.description = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.tags = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LearningResourcesCompanion.insert({
    this.id = const Value.absent(),
    this.topicId = const Value.absent(),
    this.subjectId = const Value.absent(),
    required String title,
    required String type,
    this.sourceUrl = const Value.absent(),
    this.localPath = const Value.absent(),
    this.description = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.tags = const Value.absent(),
    this.isFavorite = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : title = Value(title),
       type = Value(type),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LearningResource> custom({
    Expression<int>? id,
    Expression<int>? topicId,
    Expression<int>? subjectId,
    Expression<String>? title,
    Expression<String>? type,
    Expression<String>? sourceUrl,
    Expression<String>? localPath,
    Expression<String>? description,
    Expression<String>? thumbnailUrl,
    Expression<int>? durationSeconds,
    Expression<String>? tags,
    Expression<bool>? isFavorite,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (topicId != null) 'topic_id': topicId,
      if (subjectId != null) 'subject_id': subjectId,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (sourceUrl != null) 'source_url': sourceUrl,
      if (localPath != null) 'local_path': localPath,
      if (description != null) 'description': description,
      if (thumbnailUrl != null) 'thumbnail_url': thumbnailUrl,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (tags != null) 'tags': tags,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LearningResourcesCompanion copyWith({
    Value<int>? id,
    Value<int?>? topicId,
    Value<int?>? subjectId,
    Value<String>? title,
    Value<String>? type,
    Value<String?>? sourceUrl,
    Value<String?>? localPath,
    Value<String?>? description,
    Value<String?>? thumbnailUrl,
    Value<int?>? durationSeconds,
    Value<String?>? tags,
    Value<bool>? isFavorite,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return LearningResourcesCompanion(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      type: type ?? this.type,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      localPath: localPath ?? this.localPath,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
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
    if (topicId.present) {
      map['topic_id'] = Variable<int>(topicId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (sourceUrl.present) {
      map['source_url'] = Variable<String>(sourceUrl.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (thumbnailUrl.present) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
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
    return (StringBuffer('LearningResourcesCompanion(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('localPath: $localPath, ')
          ..write('description: $description, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('tags: $tags, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FlashcardDecksTable extends FlashcardDecks
    with TableInfo<$FlashcardDecksTable, FlashcardDeck> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlashcardDecksTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<int> topicId = GeneratedColumn<int>(
    'topic_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topics (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _sourceDocumentIdMeta = const VerificationMeta(
    'sourceDocumentId',
  );
  @override
  late final GeneratedColumn<String> sourceDocumentId = GeneratedColumn<String>(
    'source_document_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cardCountMeta = const VerificationMeta(
    'cardCount',
  );
  @override
  late final GeneratedColumn<int> cardCount = GeneratedColumn<int>(
    'card_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isPublicMeta = const VerificationMeta(
    'isPublic',
  );
  @override
  late final GeneratedColumn<bool> isPublic = GeneratedColumn<bool>(
    'is_public',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_public" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    subjectId,
    topicId,
    sourceDocumentId,
    cardCount,
    isPublic,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flashcard_decks';
  @override
  VerificationContext validateIntegrity(
    Insertable<FlashcardDeck> instance, {
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
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    }
    if (data.containsKey('source_document_id')) {
      context.handle(
        _sourceDocumentIdMeta,
        sourceDocumentId.isAcceptableOrUnknown(
          data['source_document_id']!,
          _sourceDocumentIdMeta,
        ),
      );
    }
    if (data.containsKey('card_count')) {
      context.handle(
        _cardCountMeta,
        cardCount.isAcceptableOrUnknown(data['card_count']!, _cardCountMeta),
      );
    }
    if (data.containsKey('is_public')) {
      context.handle(
        _isPublicMeta,
        isPublic.isAcceptableOrUnknown(data['is_public']!, _isPublicMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FlashcardDeck map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FlashcardDeck(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      ),
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}topic_id'],
      ),
      sourceDocumentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_document_id'],
      ),
      cardCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}card_count'],
          )!,
      isPublic:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_public'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $FlashcardDecksTable createAlias(String alias) {
    return $FlashcardDecksTable(attachedDatabase, alias);
  }
}

class FlashcardDeck extends DataClass implements Insertable<FlashcardDeck> {
  final int id;
  final String name;
  final String? description;
  final int? subjectId;
  final int? topicId;
  final String? sourceDocumentId;
  final int cardCount;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FlashcardDeck({
    required this.id,
    required this.name,
    this.description,
    this.subjectId,
    this.topicId,
    this.sourceDocumentId,
    required this.cardCount,
    required this.isPublic,
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
    if (!nullToAbsent || subjectId != null) {
      map['subject_id'] = Variable<int>(subjectId);
    }
    if (!nullToAbsent || topicId != null) {
      map['topic_id'] = Variable<int>(topicId);
    }
    if (!nullToAbsent || sourceDocumentId != null) {
      map['source_document_id'] = Variable<String>(sourceDocumentId);
    }
    map['card_count'] = Variable<int>(cardCount);
    map['is_public'] = Variable<bool>(isPublic);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FlashcardDecksCompanion toCompanion(bool nullToAbsent) {
    return FlashcardDecksCompanion(
      id: Value(id),
      name: Value(name),
      description:
          description == null && nullToAbsent
              ? const Value.absent()
              : Value(description),
      subjectId:
          subjectId == null && nullToAbsent
              ? const Value.absent()
              : Value(subjectId),
      topicId:
          topicId == null && nullToAbsent
              ? const Value.absent()
              : Value(topicId),
      sourceDocumentId:
          sourceDocumentId == null && nullToAbsent
              ? const Value.absent()
              : Value(sourceDocumentId),
      cardCount: Value(cardCount),
      isPublic: Value(isPublic),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FlashcardDeck.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FlashcardDeck(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      subjectId: serializer.fromJson<int?>(json['subjectId']),
      topicId: serializer.fromJson<int?>(json['topicId']),
      sourceDocumentId: serializer.fromJson<String?>(json['sourceDocumentId']),
      cardCount: serializer.fromJson<int>(json['cardCount']),
      isPublic: serializer.fromJson<bool>(json['isPublic']),
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
      'subjectId': serializer.toJson<int?>(subjectId),
      'topicId': serializer.toJson<int?>(topicId),
      'sourceDocumentId': serializer.toJson<String?>(sourceDocumentId),
      'cardCount': serializer.toJson<int>(cardCount),
      'isPublic': serializer.toJson<bool>(isPublic),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FlashcardDeck copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<int?> subjectId = const Value.absent(),
    Value<int?> topicId = const Value.absent(),
    Value<String?> sourceDocumentId = const Value.absent(),
    int? cardCount,
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FlashcardDeck(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    subjectId: subjectId.present ? subjectId.value : this.subjectId,
    topicId: topicId.present ? topicId.value : this.topicId,
    sourceDocumentId:
        sourceDocumentId.present
            ? sourceDocumentId.value
            : this.sourceDocumentId,
    cardCount: cardCount ?? this.cardCount,
    isPublic: isPublic ?? this.isPublic,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FlashcardDeck copyWithCompanion(FlashcardDecksCompanion data) {
    return FlashcardDeck(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      sourceDocumentId:
          data.sourceDocumentId.present
              ? data.sourceDocumentId.value
              : this.sourceDocumentId,
      cardCount: data.cardCount.present ? data.cardCount.value : this.cardCount,
      isPublic: data.isPublic.present ? data.isPublic.value : this.isPublic,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FlashcardDeck(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('subjectId: $subjectId, ')
          ..write('topicId: $topicId, ')
          ..write('sourceDocumentId: $sourceDocumentId, ')
          ..write('cardCount: $cardCount, ')
          ..write('isPublic: $isPublic, ')
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
    subjectId,
    topicId,
    sourceDocumentId,
    cardCount,
    isPublic,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlashcardDeck &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.subjectId == this.subjectId &&
          other.topicId == this.topicId &&
          other.sourceDocumentId == this.sourceDocumentId &&
          other.cardCount == this.cardCount &&
          other.isPublic == this.isPublic &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FlashcardDecksCompanion extends UpdateCompanion<FlashcardDeck> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<int?> subjectId;
  final Value<int?> topicId;
  final Value<String?> sourceDocumentId;
  final Value<int> cardCount;
  final Value<bool> isPublic;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const FlashcardDecksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.sourceDocumentId = const Value.absent(),
    this.cardCount = const Value.absent(),
    this.isPublic = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FlashcardDecksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.sourceDocumentId = const Value.absent(),
    this.cardCount = const Value.absent(),
    this.isPublic = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FlashcardDeck> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? subjectId,
    Expression<int>? topicId,
    Expression<String>? sourceDocumentId,
    Expression<int>? cardCount,
    Expression<bool>? isPublic,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (subjectId != null) 'subject_id': subjectId,
      if (topicId != null) 'topic_id': topicId,
      if (sourceDocumentId != null) 'source_document_id': sourceDocumentId,
      if (cardCount != null) 'card_count': cardCount,
      if (isPublic != null) 'is_public': isPublic,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FlashcardDecksCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<int?>? subjectId,
    Value<int?>? topicId,
    Value<String?>? sourceDocumentId,
    Value<int>? cardCount,
    Value<bool>? isPublic,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return FlashcardDecksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      subjectId: subjectId ?? this.subjectId,
      topicId: topicId ?? this.topicId,
      sourceDocumentId: sourceDocumentId ?? this.sourceDocumentId,
      cardCount: cardCount ?? this.cardCount,
      isPublic: isPublic ?? this.isPublic,
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
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<int>(topicId.value);
    }
    if (sourceDocumentId.present) {
      map['source_document_id'] = Variable<String>(sourceDocumentId.value);
    }
    if (cardCount.present) {
      map['card_count'] = Variable<int>(cardCount.value);
    }
    if (isPublic.present) {
      map['is_public'] = Variable<bool>(isPublic.value);
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
    return (StringBuffer('FlashcardDecksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('subjectId: $subjectId, ')
          ..write('topicId: $topicId, ')
          ..write('sourceDocumentId: $sourceDocumentId, ')
          ..write('cardCount: $cardCount, ')
          ..write('isPublic: $isPublic, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FlashcardsTable extends Flashcards
    with TableInfo<$FlashcardsTable, Flashcard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlashcardsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deckIdMeta = const VerificationMeta('deckId');
  @override
  late final GeneratedColumn<int> deckId = GeneratedColumn<int>(
    'deck_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES flashcard_decks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _frontMeta = const VerificationMeta('front');
  @override
  late final GeneratedColumn<String> front = GeneratedColumn<String>(
    'front',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _backMeta = const VerificationMeta('back');
  @override
  late final GeneratedColumn<String> back = GeneratedColumn<String>(
    'back',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hintMeta = const VerificationMeta('hint');
  @override
  late final GeneratedColumn<String> hint = GeneratedColumn<String>(
    'hint',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceChunkIdMeta = const VerificationMeta(
    'sourceChunkId',
  );
  @override
  late final GeneratedColumn<String> sourceChunkId = GeneratedColumn<String>(
    'source_chunk_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stabilityMeta = const VerificationMeta(
    'stability',
  );
  @override
  late final GeneratedColumn<double> stability = GeneratedColumn<double>(
    'stability',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<double> difficulty = GeneratedColumn<double>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _elapsedDaysMeta = const VerificationMeta(
    'elapsedDays',
  );
  @override
  late final GeneratedColumn<int> elapsedDays = GeneratedColumn<int>(
    'elapsed_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _scheduledDaysMeta = const VerificationMeta(
    'scheduledDays',
  );
  @override
  late final GeneratedColumn<int> scheduledDays = GeneratedColumn<int>(
    'scheduled_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastReviewedMeta = const VerificationMeta(
    'lastReviewed',
  );
  @override
  late final GeneratedColumn<DateTime> lastReviewed = GeneratedColumn<DateTime>(
    'last_reviewed',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reviewCountMeta = const VerificationMeta(
    'reviewCount',
  );
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
    'review_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lapseCountMeta = const VerificationMeta(
    'lapseCount',
  );
  @override
  late final GeneratedColumn<int> lapseCount = GeneratedColumn<int>(
    'lapse_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    deckId,
    front,
    back,
    hint,
    tags,
    sourceChunkId,
    stability,
    difficulty,
    elapsedDays,
    scheduledDays,
    dueDate,
    lastReviewed,
    reviewCount,
    lapseCount,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flashcards';
  @override
  VerificationContext validateIntegrity(
    Insertable<Flashcard> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('deck_id')) {
      context.handle(
        _deckIdMeta,
        deckId.isAcceptableOrUnknown(data['deck_id']!, _deckIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deckIdMeta);
    }
    if (data.containsKey('front')) {
      context.handle(
        _frontMeta,
        front.isAcceptableOrUnknown(data['front']!, _frontMeta),
      );
    } else if (isInserting) {
      context.missing(_frontMeta);
    }
    if (data.containsKey('back')) {
      context.handle(
        _backMeta,
        back.isAcceptableOrUnknown(data['back']!, _backMeta),
      );
    } else if (isInserting) {
      context.missing(_backMeta);
    }
    if (data.containsKey('hint')) {
      context.handle(
        _hintMeta,
        hint.isAcceptableOrUnknown(data['hint']!, _hintMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('source_chunk_id')) {
      context.handle(
        _sourceChunkIdMeta,
        sourceChunkId.isAcceptableOrUnknown(
          data['source_chunk_id']!,
          _sourceChunkIdMeta,
        ),
      );
    }
    if (data.containsKey('stability')) {
      context.handle(
        _stabilityMeta,
        stability.isAcceptableOrUnknown(data['stability']!, _stabilityMeta),
      );
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('elapsed_days')) {
      context.handle(
        _elapsedDaysMeta,
        elapsedDays.isAcceptableOrUnknown(
          data['elapsed_days']!,
          _elapsedDaysMeta,
        ),
      );
    }
    if (data.containsKey('scheduled_days')) {
      context.handle(
        _scheduledDaysMeta,
        scheduledDays.isAcceptableOrUnknown(
          data['scheduled_days']!,
          _scheduledDaysMeta,
        ),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('last_reviewed')) {
      context.handle(
        _lastReviewedMeta,
        lastReviewed.isAcceptableOrUnknown(
          data['last_reviewed']!,
          _lastReviewedMeta,
        ),
      );
    }
    if (data.containsKey('review_count')) {
      context.handle(
        _reviewCountMeta,
        reviewCount.isAcceptableOrUnknown(
          data['review_count']!,
          _reviewCountMeta,
        ),
      );
    }
    if (data.containsKey('lapse_count')) {
      context.handle(
        _lapseCountMeta,
        lapseCount.isAcceptableOrUnknown(data['lapse_count']!, _lapseCountMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Flashcard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Flashcard(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      deckId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}deck_id'],
          )!,
      front:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}front'],
          )!,
      back:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}back'],
          )!,
      hint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hint'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      ),
      sourceChunkId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_chunk_id'],
      ),
      stability:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}stability'],
          )!,
      difficulty:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}difficulty'],
          )!,
      elapsedDays:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}elapsed_days'],
          )!,
      scheduledDays:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}scheduled_days'],
          )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      lastReviewed: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reviewed'],
      ),
      reviewCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}review_count'],
          )!,
      lapseCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}lapse_count'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $FlashcardsTable createAlias(String alias) {
    return $FlashcardsTable(attachedDatabase, alias);
  }
}

class Flashcard extends DataClass implements Insertable<Flashcard> {
  final int id;
  final int deckId;
  final String front;
  final String back;
  final String? hint;
  final String? tags;
  final String? sourceChunkId;
  final double stability;
  final double difficulty;
  final int elapsedDays;
  final int scheduledDays;
  final DateTime? dueDate;
  final DateTime? lastReviewed;
  final int reviewCount;
  final int lapseCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Flashcard({
    required this.id,
    required this.deckId,
    required this.front,
    required this.back,
    this.hint,
    this.tags,
    this.sourceChunkId,
    required this.stability,
    required this.difficulty,
    required this.elapsedDays,
    required this.scheduledDays,
    this.dueDate,
    this.lastReviewed,
    required this.reviewCount,
    required this.lapseCount,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['deck_id'] = Variable<int>(deckId);
    map['front'] = Variable<String>(front);
    map['back'] = Variable<String>(back);
    if (!nullToAbsent || hint != null) {
      map['hint'] = Variable<String>(hint);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    if (!nullToAbsent || sourceChunkId != null) {
      map['source_chunk_id'] = Variable<String>(sourceChunkId);
    }
    map['stability'] = Variable<double>(stability);
    map['difficulty'] = Variable<double>(difficulty);
    map['elapsed_days'] = Variable<int>(elapsedDays);
    map['scheduled_days'] = Variable<int>(scheduledDays);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || lastReviewed != null) {
      map['last_reviewed'] = Variable<DateTime>(lastReviewed);
    }
    map['review_count'] = Variable<int>(reviewCount);
    map['lapse_count'] = Variable<int>(lapseCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FlashcardsCompanion toCompanion(bool nullToAbsent) {
    return FlashcardsCompanion(
      id: Value(id),
      deckId: Value(deckId),
      front: Value(front),
      back: Value(back),
      hint: hint == null && nullToAbsent ? const Value.absent() : Value(hint),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      sourceChunkId:
          sourceChunkId == null && nullToAbsent
              ? const Value.absent()
              : Value(sourceChunkId),
      stability: Value(stability),
      difficulty: Value(difficulty),
      elapsedDays: Value(elapsedDays),
      scheduledDays: Value(scheduledDays),
      dueDate:
          dueDate == null && nullToAbsent
              ? const Value.absent()
              : Value(dueDate),
      lastReviewed:
          lastReviewed == null && nullToAbsent
              ? const Value.absent()
              : Value(lastReviewed),
      reviewCount: Value(reviewCount),
      lapseCount: Value(lapseCount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Flashcard.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Flashcard(
      id: serializer.fromJson<int>(json['id']),
      deckId: serializer.fromJson<int>(json['deckId']),
      front: serializer.fromJson<String>(json['front']),
      back: serializer.fromJson<String>(json['back']),
      hint: serializer.fromJson<String?>(json['hint']),
      tags: serializer.fromJson<String?>(json['tags']),
      sourceChunkId: serializer.fromJson<String?>(json['sourceChunkId']),
      stability: serializer.fromJson<double>(json['stability']),
      difficulty: serializer.fromJson<double>(json['difficulty']),
      elapsedDays: serializer.fromJson<int>(json['elapsedDays']),
      scheduledDays: serializer.fromJson<int>(json['scheduledDays']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      lastReviewed: serializer.fromJson<DateTime?>(json['lastReviewed']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      lapseCount: serializer.fromJson<int>(json['lapseCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'deckId': serializer.toJson<int>(deckId),
      'front': serializer.toJson<String>(front),
      'back': serializer.toJson<String>(back),
      'hint': serializer.toJson<String?>(hint),
      'tags': serializer.toJson<String?>(tags),
      'sourceChunkId': serializer.toJson<String?>(sourceChunkId),
      'stability': serializer.toJson<double>(stability),
      'difficulty': serializer.toJson<double>(difficulty),
      'elapsedDays': serializer.toJson<int>(elapsedDays),
      'scheduledDays': serializer.toJson<int>(scheduledDays),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'lastReviewed': serializer.toJson<DateTime?>(lastReviewed),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'lapseCount': serializer.toJson<int>(lapseCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Flashcard copyWith({
    int? id,
    int? deckId,
    String? front,
    String? back,
    Value<String?> hint = const Value.absent(),
    Value<String?> tags = const Value.absent(),
    Value<String?> sourceChunkId = const Value.absent(),
    double? stability,
    double? difficulty,
    int? elapsedDays,
    int? scheduledDays,
    Value<DateTime?> dueDate = const Value.absent(),
    Value<DateTime?> lastReviewed = const Value.absent(),
    int? reviewCount,
    int? lapseCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Flashcard(
    id: id ?? this.id,
    deckId: deckId ?? this.deckId,
    front: front ?? this.front,
    back: back ?? this.back,
    hint: hint.present ? hint.value : this.hint,
    tags: tags.present ? tags.value : this.tags,
    sourceChunkId:
        sourceChunkId.present ? sourceChunkId.value : this.sourceChunkId,
    stability: stability ?? this.stability,
    difficulty: difficulty ?? this.difficulty,
    elapsedDays: elapsedDays ?? this.elapsedDays,
    scheduledDays: scheduledDays ?? this.scheduledDays,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    lastReviewed: lastReviewed.present ? lastReviewed.value : this.lastReviewed,
    reviewCount: reviewCount ?? this.reviewCount,
    lapseCount: lapseCount ?? this.lapseCount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Flashcard copyWithCompanion(FlashcardsCompanion data) {
    return Flashcard(
      id: data.id.present ? data.id.value : this.id,
      deckId: data.deckId.present ? data.deckId.value : this.deckId,
      front: data.front.present ? data.front.value : this.front,
      back: data.back.present ? data.back.value : this.back,
      hint: data.hint.present ? data.hint.value : this.hint,
      tags: data.tags.present ? data.tags.value : this.tags,
      sourceChunkId:
          data.sourceChunkId.present
              ? data.sourceChunkId.value
              : this.sourceChunkId,
      stability: data.stability.present ? data.stability.value : this.stability,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      elapsedDays:
          data.elapsedDays.present ? data.elapsedDays.value : this.elapsedDays,
      scheduledDays:
          data.scheduledDays.present
              ? data.scheduledDays.value
              : this.scheduledDays,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      lastReviewed:
          data.lastReviewed.present
              ? data.lastReviewed.value
              : this.lastReviewed,
      reviewCount:
          data.reviewCount.present ? data.reviewCount.value : this.reviewCount,
      lapseCount:
          data.lapseCount.present ? data.lapseCount.value : this.lapseCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Flashcard(')
          ..write('id: $id, ')
          ..write('deckId: $deckId, ')
          ..write('front: $front, ')
          ..write('back: $back, ')
          ..write('hint: $hint, ')
          ..write('tags: $tags, ')
          ..write('sourceChunkId: $sourceChunkId, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('elapsedDays: $elapsedDays, ')
          ..write('scheduledDays: $scheduledDays, ')
          ..write('dueDate: $dueDate, ')
          ..write('lastReviewed: $lastReviewed, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('lapseCount: $lapseCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    deckId,
    front,
    back,
    hint,
    tags,
    sourceChunkId,
    stability,
    difficulty,
    elapsedDays,
    scheduledDays,
    dueDate,
    lastReviewed,
    reviewCount,
    lapseCount,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Flashcard &&
          other.id == this.id &&
          other.deckId == this.deckId &&
          other.front == this.front &&
          other.back == this.back &&
          other.hint == this.hint &&
          other.tags == this.tags &&
          other.sourceChunkId == this.sourceChunkId &&
          other.stability == this.stability &&
          other.difficulty == this.difficulty &&
          other.elapsedDays == this.elapsedDays &&
          other.scheduledDays == this.scheduledDays &&
          other.dueDate == this.dueDate &&
          other.lastReviewed == this.lastReviewed &&
          other.reviewCount == this.reviewCount &&
          other.lapseCount == this.lapseCount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FlashcardsCompanion extends UpdateCompanion<Flashcard> {
  final Value<int> id;
  final Value<int> deckId;
  final Value<String> front;
  final Value<String> back;
  final Value<String?> hint;
  final Value<String?> tags;
  final Value<String?> sourceChunkId;
  final Value<double> stability;
  final Value<double> difficulty;
  final Value<int> elapsedDays;
  final Value<int> scheduledDays;
  final Value<DateTime?> dueDate;
  final Value<DateTime?> lastReviewed;
  final Value<int> reviewCount;
  final Value<int> lapseCount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const FlashcardsCompanion({
    this.id = const Value.absent(),
    this.deckId = const Value.absent(),
    this.front = const Value.absent(),
    this.back = const Value.absent(),
    this.hint = const Value.absent(),
    this.tags = const Value.absent(),
    this.sourceChunkId = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.elapsedDays = const Value.absent(),
    this.scheduledDays = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.lastReviewed = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.lapseCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FlashcardsCompanion.insert({
    this.id = const Value.absent(),
    required int deckId,
    required String front,
    required String back,
    this.hint = const Value.absent(),
    this.tags = const Value.absent(),
    this.sourceChunkId = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.elapsedDays = const Value.absent(),
    this.scheduledDays = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.lastReviewed = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.lapseCount = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : deckId = Value(deckId),
       front = Value(front),
       back = Value(back),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Flashcard> custom({
    Expression<int>? id,
    Expression<int>? deckId,
    Expression<String>? front,
    Expression<String>? back,
    Expression<String>? hint,
    Expression<String>? tags,
    Expression<String>? sourceChunkId,
    Expression<double>? stability,
    Expression<double>? difficulty,
    Expression<int>? elapsedDays,
    Expression<int>? scheduledDays,
    Expression<DateTime>? dueDate,
    Expression<DateTime>? lastReviewed,
    Expression<int>? reviewCount,
    Expression<int>? lapseCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deckId != null) 'deck_id': deckId,
      if (front != null) 'front': front,
      if (back != null) 'back': back,
      if (hint != null) 'hint': hint,
      if (tags != null) 'tags': tags,
      if (sourceChunkId != null) 'source_chunk_id': sourceChunkId,
      if (stability != null) 'stability': stability,
      if (difficulty != null) 'difficulty': difficulty,
      if (elapsedDays != null) 'elapsed_days': elapsedDays,
      if (scheduledDays != null) 'scheduled_days': scheduledDays,
      if (dueDate != null) 'due_date': dueDate,
      if (lastReviewed != null) 'last_reviewed': lastReviewed,
      if (reviewCount != null) 'review_count': reviewCount,
      if (lapseCount != null) 'lapse_count': lapseCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FlashcardsCompanion copyWith({
    Value<int>? id,
    Value<int>? deckId,
    Value<String>? front,
    Value<String>? back,
    Value<String?>? hint,
    Value<String?>? tags,
    Value<String?>? sourceChunkId,
    Value<double>? stability,
    Value<double>? difficulty,
    Value<int>? elapsedDays,
    Value<int>? scheduledDays,
    Value<DateTime?>? dueDate,
    Value<DateTime?>? lastReviewed,
    Value<int>? reviewCount,
    Value<int>? lapseCount,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return FlashcardsCompanion(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      front: front ?? this.front,
      back: back ?? this.back,
      hint: hint ?? this.hint,
      tags: tags ?? this.tags,
      sourceChunkId: sourceChunkId ?? this.sourceChunkId,
      stability: stability ?? this.stability,
      difficulty: difficulty ?? this.difficulty,
      elapsedDays: elapsedDays ?? this.elapsedDays,
      scheduledDays: scheduledDays ?? this.scheduledDays,
      dueDate: dueDate ?? this.dueDate,
      lastReviewed: lastReviewed ?? this.lastReviewed,
      reviewCount: reviewCount ?? this.reviewCount,
      lapseCount: lapseCount ?? this.lapseCount,
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
    if (deckId.present) {
      map['deck_id'] = Variable<int>(deckId.value);
    }
    if (front.present) {
      map['front'] = Variable<String>(front.value);
    }
    if (back.present) {
      map['back'] = Variable<String>(back.value);
    }
    if (hint.present) {
      map['hint'] = Variable<String>(hint.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (sourceChunkId.present) {
      map['source_chunk_id'] = Variable<String>(sourceChunkId.value);
    }
    if (stability.present) {
      map['stability'] = Variable<double>(stability.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<double>(difficulty.value);
    }
    if (elapsedDays.present) {
      map['elapsed_days'] = Variable<int>(elapsedDays.value);
    }
    if (scheduledDays.present) {
      map['scheduled_days'] = Variable<int>(scheduledDays.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (lastReviewed.present) {
      map['last_reviewed'] = Variable<DateTime>(lastReviewed.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (lapseCount.present) {
      map['lapse_count'] = Variable<int>(lapseCount.value);
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
    return (StringBuffer('FlashcardsCompanion(')
          ..write('id: $id, ')
          ..write('deckId: $deckId, ')
          ..write('front: $front, ')
          ..write('back: $back, ')
          ..write('hint: $hint, ')
          ..write('tags: $tags, ')
          ..write('sourceChunkId: $sourceChunkId, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('elapsedDays: $elapsedDays, ')
          ..write('scheduledDays: $scheduledDays, ')
          ..write('dueDate: $dueDate, ')
          ..write('lastReviewed: $lastReviewed, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('lapseCount: $lapseCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FlashcardReviewsTable extends FlashcardReviews
    with TableInfo<$FlashcardReviewsTable, FlashcardReview> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlashcardReviewsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _flashcardIdMeta = const VerificationMeta(
    'flashcardId',
  );
  @override
  late final GeneratedColumn<int> flashcardId = GeneratedColumn<int>(
    'flashcard_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES flashcards (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stabilityBeforeMeta = const VerificationMeta(
    'stabilityBefore',
  );
  @override
  late final GeneratedColumn<double> stabilityBefore = GeneratedColumn<double>(
    'stability_before',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyBeforeMeta = const VerificationMeta(
    'difficultyBefore',
  );
  @override
  late final GeneratedColumn<double> difficultyBefore = GeneratedColumn<double>(
    'difficulty_before',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stabilityAfterMeta = const VerificationMeta(
    'stabilityAfter',
  );
  @override
  late final GeneratedColumn<double> stabilityAfter = GeneratedColumn<double>(
    'stability_after',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyAfterMeta = const VerificationMeta(
    'difficultyAfter',
  );
  @override
  late final GeneratedColumn<double> difficultyAfter = GeneratedColumn<double>(
    'difficulty_after',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _elapsedDaysMeta = const VerificationMeta(
    'elapsedDays',
  );
  @override
  late final GeneratedColumn<int> elapsedDays = GeneratedColumn<int>(
    'elapsed_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledDaysMeta = const VerificationMeta(
    'scheduledDays',
  );
  @override
  late final GeneratedColumn<int> scheduledDays = GeneratedColumn<int>(
    'scheduled_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reviewedAtMeta = const VerificationMeta(
    'reviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> reviewedAt = GeneratedColumn<DateTime>(
    'reviewed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    flashcardId,
    rating,
    stabilityBefore,
    difficultyBefore,
    stabilityAfter,
    difficultyAfter,
    elapsedDays,
    scheduledDays,
    reviewedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flashcard_reviews';
  @override
  VerificationContext validateIntegrity(
    Insertable<FlashcardReview> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('flashcard_id')) {
      context.handle(
        _flashcardIdMeta,
        flashcardId.isAcceptableOrUnknown(
          data['flashcard_id']!,
          _flashcardIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_flashcardIdMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('stability_before')) {
      context.handle(
        _stabilityBeforeMeta,
        stabilityBefore.isAcceptableOrUnknown(
          data['stability_before']!,
          _stabilityBeforeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stabilityBeforeMeta);
    }
    if (data.containsKey('difficulty_before')) {
      context.handle(
        _difficultyBeforeMeta,
        difficultyBefore.isAcceptableOrUnknown(
          data['difficulty_before']!,
          _difficultyBeforeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_difficultyBeforeMeta);
    }
    if (data.containsKey('stability_after')) {
      context.handle(
        _stabilityAfterMeta,
        stabilityAfter.isAcceptableOrUnknown(
          data['stability_after']!,
          _stabilityAfterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stabilityAfterMeta);
    }
    if (data.containsKey('difficulty_after')) {
      context.handle(
        _difficultyAfterMeta,
        difficultyAfter.isAcceptableOrUnknown(
          data['difficulty_after']!,
          _difficultyAfterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_difficultyAfterMeta);
    }
    if (data.containsKey('elapsed_days')) {
      context.handle(
        _elapsedDaysMeta,
        elapsedDays.isAcceptableOrUnknown(
          data['elapsed_days']!,
          _elapsedDaysMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_elapsedDaysMeta);
    }
    if (data.containsKey('scheduled_days')) {
      context.handle(
        _scheduledDaysMeta,
        scheduledDays.isAcceptableOrUnknown(
          data['scheduled_days']!,
          _scheduledDaysMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledDaysMeta);
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
        _reviewedAtMeta,
        reviewedAt.isAcceptableOrUnknown(data['reviewed_at']!, _reviewedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_reviewedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FlashcardReview map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FlashcardReview(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      flashcardId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}flashcard_id'],
          )!,
      rating:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}rating'],
          )!,
      stabilityBefore:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}stability_before'],
          )!,
      difficultyBefore:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}difficulty_before'],
          )!,
      stabilityAfter:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}stability_after'],
          )!,
      difficultyAfter:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}difficulty_after'],
          )!,
      elapsedDays:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}elapsed_days'],
          )!,
      scheduledDays:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}scheduled_days'],
          )!,
      reviewedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}reviewed_at'],
          )!,
    );
  }

  @override
  $FlashcardReviewsTable createAlias(String alias) {
    return $FlashcardReviewsTable(attachedDatabase, alias);
  }
}

class FlashcardReview extends DataClass implements Insertable<FlashcardReview> {
  final int id;
  final int flashcardId;
  final int rating;
  final double stabilityBefore;
  final double difficultyBefore;
  final double stabilityAfter;
  final double difficultyAfter;
  final int elapsedDays;
  final int scheduledDays;
  final DateTime reviewedAt;
  const FlashcardReview({
    required this.id,
    required this.flashcardId,
    required this.rating,
    required this.stabilityBefore,
    required this.difficultyBefore,
    required this.stabilityAfter,
    required this.difficultyAfter,
    required this.elapsedDays,
    required this.scheduledDays,
    required this.reviewedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['flashcard_id'] = Variable<int>(flashcardId);
    map['rating'] = Variable<int>(rating);
    map['stability_before'] = Variable<double>(stabilityBefore);
    map['difficulty_before'] = Variable<double>(difficultyBefore);
    map['stability_after'] = Variable<double>(stabilityAfter);
    map['difficulty_after'] = Variable<double>(difficultyAfter);
    map['elapsed_days'] = Variable<int>(elapsedDays);
    map['scheduled_days'] = Variable<int>(scheduledDays);
    map['reviewed_at'] = Variable<DateTime>(reviewedAt);
    return map;
  }

  FlashcardReviewsCompanion toCompanion(bool nullToAbsent) {
    return FlashcardReviewsCompanion(
      id: Value(id),
      flashcardId: Value(flashcardId),
      rating: Value(rating),
      stabilityBefore: Value(stabilityBefore),
      difficultyBefore: Value(difficultyBefore),
      stabilityAfter: Value(stabilityAfter),
      difficultyAfter: Value(difficultyAfter),
      elapsedDays: Value(elapsedDays),
      scheduledDays: Value(scheduledDays),
      reviewedAt: Value(reviewedAt),
    );
  }

  factory FlashcardReview.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FlashcardReview(
      id: serializer.fromJson<int>(json['id']),
      flashcardId: serializer.fromJson<int>(json['flashcardId']),
      rating: serializer.fromJson<int>(json['rating']),
      stabilityBefore: serializer.fromJson<double>(json['stabilityBefore']),
      difficultyBefore: serializer.fromJson<double>(json['difficultyBefore']),
      stabilityAfter: serializer.fromJson<double>(json['stabilityAfter']),
      difficultyAfter: serializer.fromJson<double>(json['difficultyAfter']),
      elapsedDays: serializer.fromJson<int>(json['elapsedDays']),
      scheduledDays: serializer.fromJson<int>(json['scheduledDays']),
      reviewedAt: serializer.fromJson<DateTime>(json['reviewedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'flashcardId': serializer.toJson<int>(flashcardId),
      'rating': serializer.toJson<int>(rating),
      'stabilityBefore': serializer.toJson<double>(stabilityBefore),
      'difficultyBefore': serializer.toJson<double>(difficultyBefore),
      'stabilityAfter': serializer.toJson<double>(stabilityAfter),
      'difficultyAfter': serializer.toJson<double>(difficultyAfter),
      'elapsedDays': serializer.toJson<int>(elapsedDays),
      'scheduledDays': serializer.toJson<int>(scheduledDays),
      'reviewedAt': serializer.toJson<DateTime>(reviewedAt),
    };
  }

  FlashcardReview copyWith({
    int? id,
    int? flashcardId,
    int? rating,
    double? stabilityBefore,
    double? difficultyBefore,
    double? stabilityAfter,
    double? difficultyAfter,
    int? elapsedDays,
    int? scheduledDays,
    DateTime? reviewedAt,
  }) => FlashcardReview(
    id: id ?? this.id,
    flashcardId: flashcardId ?? this.flashcardId,
    rating: rating ?? this.rating,
    stabilityBefore: stabilityBefore ?? this.stabilityBefore,
    difficultyBefore: difficultyBefore ?? this.difficultyBefore,
    stabilityAfter: stabilityAfter ?? this.stabilityAfter,
    difficultyAfter: difficultyAfter ?? this.difficultyAfter,
    elapsedDays: elapsedDays ?? this.elapsedDays,
    scheduledDays: scheduledDays ?? this.scheduledDays,
    reviewedAt: reviewedAt ?? this.reviewedAt,
  );
  FlashcardReview copyWithCompanion(FlashcardReviewsCompanion data) {
    return FlashcardReview(
      id: data.id.present ? data.id.value : this.id,
      flashcardId:
          data.flashcardId.present ? data.flashcardId.value : this.flashcardId,
      rating: data.rating.present ? data.rating.value : this.rating,
      stabilityBefore:
          data.stabilityBefore.present
              ? data.stabilityBefore.value
              : this.stabilityBefore,
      difficultyBefore:
          data.difficultyBefore.present
              ? data.difficultyBefore.value
              : this.difficultyBefore,
      stabilityAfter:
          data.stabilityAfter.present
              ? data.stabilityAfter.value
              : this.stabilityAfter,
      difficultyAfter:
          data.difficultyAfter.present
              ? data.difficultyAfter.value
              : this.difficultyAfter,
      elapsedDays:
          data.elapsedDays.present ? data.elapsedDays.value : this.elapsedDays,
      scheduledDays:
          data.scheduledDays.present
              ? data.scheduledDays.value
              : this.scheduledDays,
      reviewedAt:
          data.reviewedAt.present ? data.reviewedAt.value : this.reviewedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FlashcardReview(')
          ..write('id: $id, ')
          ..write('flashcardId: $flashcardId, ')
          ..write('rating: $rating, ')
          ..write('stabilityBefore: $stabilityBefore, ')
          ..write('difficultyBefore: $difficultyBefore, ')
          ..write('stabilityAfter: $stabilityAfter, ')
          ..write('difficultyAfter: $difficultyAfter, ')
          ..write('elapsedDays: $elapsedDays, ')
          ..write('scheduledDays: $scheduledDays, ')
          ..write('reviewedAt: $reviewedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    flashcardId,
    rating,
    stabilityBefore,
    difficultyBefore,
    stabilityAfter,
    difficultyAfter,
    elapsedDays,
    scheduledDays,
    reviewedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlashcardReview &&
          other.id == this.id &&
          other.flashcardId == this.flashcardId &&
          other.rating == this.rating &&
          other.stabilityBefore == this.stabilityBefore &&
          other.difficultyBefore == this.difficultyBefore &&
          other.stabilityAfter == this.stabilityAfter &&
          other.difficultyAfter == this.difficultyAfter &&
          other.elapsedDays == this.elapsedDays &&
          other.scheduledDays == this.scheduledDays &&
          other.reviewedAt == this.reviewedAt);
}

class FlashcardReviewsCompanion extends UpdateCompanion<FlashcardReview> {
  final Value<int> id;
  final Value<int> flashcardId;
  final Value<int> rating;
  final Value<double> stabilityBefore;
  final Value<double> difficultyBefore;
  final Value<double> stabilityAfter;
  final Value<double> difficultyAfter;
  final Value<int> elapsedDays;
  final Value<int> scheduledDays;
  final Value<DateTime> reviewedAt;
  const FlashcardReviewsCompanion({
    this.id = const Value.absent(),
    this.flashcardId = const Value.absent(),
    this.rating = const Value.absent(),
    this.stabilityBefore = const Value.absent(),
    this.difficultyBefore = const Value.absent(),
    this.stabilityAfter = const Value.absent(),
    this.difficultyAfter = const Value.absent(),
    this.elapsedDays = const Value.absent(),
    this.scheduledDays = const Value.absent(),
    this.reviewedAt = const Value.absent(),
  });
  FlashcardReviewsCompanion.insert({
    this.id = const Value.absent(),
    required int flashcardId,
    required int rating,
    required double stabilityBefore,
    required double difficultyBefore,
    required double stabilityAfter,
    required double difficultyAfter,
    required int elapsedDays,
    required int scheduledDays,
    required DateTime reviewedAt,
  }) : flashcardId = Value(flashcardId),
       rating = Value(rating),
       stabilityBefore = Value(stabilityBefore),
       difficultyBefore = Value(difficultyBefore),
       stabilityAfter = Value(stabilityAfter),
       difficultyAfter = Value(difficultyAfter),
       elapsedDays = Value(elapsedDays),
       scheduledDays = Value(scheduledDays),
       reviewedAt = Value(reviewedAt);
  static Insertable<FlashcardReview> custom({
    Expression<int>? id,
    Expression<int>? flashcardId,
    Expression<int>? rating,
    Expression<double>? stabilityBefore,
    Expression<double>? difficultyBefore,
    Expression<double>? stabilityAfter,
    Expression<double>? difficultyAfter,
    Expression<int>? elapsedDays,
    Expression<int>? scheduledDays,
    Expression<DateTime>? reviewedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (flashcardId != null) 'flashcard_id': flashcardId,
      if (rating != null) 'rating': rating,
      if (stabilityBefore != null) 'stability_before': stabilityBefore,
      if (difficultyBefore != null) 'difficulty_before': difficultyBefore,
      if (stabilityAfter != null) 'stability_after': stabilityAfter,
      if (difficultyAfter != null) 'difficulty_after': difficultyAfter,
      if (elapsedDays != null) 'elapsed_days': elapsedDays,
      if (scheduledDays != null) 'scheduled_days': scheduledDays,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
    });
  }

  FlashcardReviewsCompanion copyWith({
    Value<int>? id,
    Value<int>? flashcardId,
    Value<int>? rating,
    Value<double>? stabilityBefore,
    Value<double>? difficultyBefore,
    Value<double>? stabilityAfter,
    Value<double>? difficultyAfter,
    Value<int>? elapsedDays,
    Value<int>? scheduledDays,
    Value<DateTime>? reviewedAt,
  }) {
    return FlashcardReviewsCompanion(
      id: id ?? this.id,
      flashcardId: flashcardId ?? this.flashcardId,
      rating: rating ?? this.rating,
      stabilityBefore: stabilityBefore ?? this.stabilityBefore,
      difficultyBefore: difficultyBefore ?? this.difficultyBefore,
      stabilityAfter: stabilityAfter ?? this.stabilityAfter,
      difficultyAfter: difficultyAfter ?? this.difficultyAfter,
      elapsedDays: elapsedDays ?? this.elapsedDays,
      scheduledDays: scheduledDays ?? this.scheduledDays,
      reviewedAt: reviewedAt ?? this.reviewedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (flashcardId.present) {
      map['flashcard_id'] = Variable<int>(flashcardId.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (stabilityBefore.present) {
      map['stability_before'] = Variable<double>(stabilityBefore.value);
    }
    if (difficultyBefore.present) {
      map['difficulty_before'] = Variable<double>(difficultyBefore.value);
    }
    if (stabilityAfter.present) {
      map['stability_after'] = Variable<double>(stabilityAfter.value);
    }
    if (difficultyAfter.present) {
      map['difficulty_after'] = Variable<double>(difficultyAfter.value);
    }
    if (elapsedDays.present) {
      map['elapsed_days'] = Variable<int>(elapsedDays.value);
    }
    if (scheduledDays.present) {
      map['scheduled_days'] = Variable<int>(scheduledDays.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlashcardReviewsCompanion(')
          ..write('id: $id, ')
          ..write('flashcardId: $flashcardId, ')
          ..write('rating: $rating, ')
          ..write('stabilityBefore: $stabilityBefore, ')
          ..write('difficultyBefore: $difficultyBefore, ')
          ..write('stabilityAfter: $stabilityAfter, ')
          ..write('difficultyAfter: $difficultyAfter, ')
          ..write('elapsedDays: $elapsedDays, ')
          ..write('scheduledDays: $scheduledDays, ')
          ..write('reviewedAt: $reviewedAt')
          ..write(')'))
        .toString();
  }
}

class $StudyPlansTable extends StudyPlans
    with TableInfo<$StudyPlansTable, StudyPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyPlansTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalsMeta = const VerificationMeta('goals');
  @override
  late final GeneratedColumn<String> goals = GeneratedColumn<String>(
    'goals',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetHoursPerWeekMeta =
      const VerificationMeta('targetHoursPerWeek');
  @override
  late final GeneratedColumn<int> targetHoursPerWeek = GeneratedColumn<int>(
    'target_hours_per_week',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduleConfigMeta = const VerificationMeta(
    'scheduleConfig',
  );
  @override
  late final GeneratedColumn<String> scheduleConfig = GeneratedColumn<String>(
    'schedule_config',
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    startDate,
    endDate,
    goals,
    targetHoursPerWeek,
    scheduleConfig,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyPlan> instance, {
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
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('goals')) {
      context.handle(
        _goalsMeta,
        goals.isAcceptableOrUnknown(data['goals']!, _goalsMeta),
      );
    }
    if (data.containsKey('target_hours_per_week')) {
      context.handle(
        _targetHoursPerWeekMeta,
        targetHoursPerWeek.isAcceptableOrUnknown(
          data['target_hours_per_week']!,
          _targetHoursPerWeekMeta,
        ),
      );
    }
    if (data.containsKey('schedule_config')) {
      context.handle(
        _scheduleConfigMeta,
        scheduleConfig.isAcceptableOrUnknown(
          data['schedule_config']!,
          _scheduleConfigMeta,
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
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudyPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyPlan(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      startDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}start_date'],
          )!,
      endDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}end_date'],
          )!,
      goals: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goals'],
      ),
      targetHoursPerWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_hours_per_week'],
      ),
      scheduleConfig: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schedule_config'],
      ),
      isActive:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_active'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $StudyPlansTable createAlias(String alias) {
    return $StudyPlansTable(attachedDatabase, alias);
  }
}

class StudyPlan extends DataClass implements Insertable<StudyPlan> {
  final int id;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final String? goals;
  final int? targetHoursPerWeek;
  final String? scheduleConfig;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const StudyPlan({
    required this.id,
    required this.name,
    this.description,
    required this.startDate,
    required this.endDate,
    this.goals,
    this.targetHoursPerWeek,
    this.scheduleConfig,
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
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    if (!nullToAbsent || goals != null) {
      map['goals'] = Variable<String>(goals);
    }
    if (!nullToAbsent || targetHoursPerWeek != null) {
      map['target_hours_per_week'] = Variable<int>(targetHoursPerWeek);
    }
    if (!nullToAbsent || scheduleConfig != null) {
      map['schedule_config'] = Variable<String>(scheduleConfig);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StudyPlansCompanion toCompanion(bool nullToAbsent) {
    return StudyPlansCompanion(
      id: Value(id),
      name: Value(name),
      description:
          description == null && nullToAbsent
              ? const Value.absent()
              : Value(description),
      startDate: Value(startDate),
      endDate: Value(endDate),
      goals:
          goals == null && nullToAbsent ? const Value.absent() : Value(goals),
      targetHoursPerWeek:
          targetHoursPerWeek == null && nullToAbsent
              ? const Value.absent()
              : Value(targetHoursPerWeek),
      scheduleConfig:
          scheduleConfig == null && nullToAbsent
              ? const Value.absent()
              : Value(scheduleConfig),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory StudyPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyPlan(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      goals: serializer.fromJson<String?>(json['goals']),
      targetHoursPerWeek: serializer.fromJson<int?>(json['targetHoursPerWeek']),
      scheduleConfig: serializer.fromJson<String?>(json['scheduleConfig']),
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
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'goals': serializer.toJson<String?>(goals),
      'targetHoursPerWeek': serializer.toJson<int?>(targetHoursPerWeek),
      'scheduleConfig': serializer.toJson<String?>(scheduleConfig),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StudyPlan copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    DateTime? startDate,
    DateTime? endDate,
    Value<String?> goals = const Value.absent(),
    Value<int?> targetHoursPerWeek = const Value.absent(),
    Value<String?> scheduleConfig = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => StudyPlan(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    goals: goals.present ? goals.value : this.goals,
    targetHoursPerWeek:
        targetHoursPerWeek.present
            ? targetHoursPerWeek.value
            : this.targetHoursPerWeek,
    scheduleConfig:
        scheduleConfig.present ? scheduleConfig.value : this.scheduleConfig,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StudyPlan copyWithCompanion(StudyPlansCompanion data) {
    return StudyPlan(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      goals: data.goals.present ? data.goals.value : this.goals,
      targetHoursPerWeek:
          data.targetHoursPerWeek.present
              ? data.targetHoursPerWeek.value
              : this.targetHoursPerWeek,
      scheduleConfig:
          data.scheduleConfig.present
              ? data.scheduleConfig.value
              : this.scheduleConfig,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyPlan(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('goals: $goals, ')
          ..write('targetHoursPerWeek: $targetHoursPerWeek, ')
          ..write('scheduleConfig: $scheduleConfig, ')
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
    startDate,
    endDate,
    goals,
    targetHoursPerWeek,
    scheduleConfig,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyPlan &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.goals == this.goals &&
          other.targetHoursPerWeek == this.targetHoursPerWeek &&
          other.scheduleConfig == this.scheduleConfig &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StudyPlansCompanion extends UpdateCompanion<StudyPlan> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<String?> goals;
  final Value<int?> targetHoursPerWeek;
  final Value<String?> scheduleConfig;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const StudyPlansCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.goals = const Value.absent(),
    this.targetHoursPerWeek = const Value.absent(),
    this.scheduleConfig = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StudyPlansCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required DateTime startDate,
    required DateTime endDate,
    this.goals = const Value.absent(),
    this.targetHoursPerWeek = const Value.absent(),
    this.scheduleConfig = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : name = Value(name),
       startDate = Value(startDate),
       endDate = Value(endDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<StudyPlan> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? goals,
    Expression<int>? targetHoursPerWeek,
    Expression<String>? scheduleConfig,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (goals != null) 'goals': goals,
      if (targetHoursPerWeek != null)
        'target_hours_per_week': targetHoursPerWeek,
      if (scheduleConfig != null) 'schedule_config': scheduleConfig,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StudyPlansCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<String?>? goals,
    Value<int?>? targetHoursPerWeek,
    Value<String?>? scheduleConfig,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return StudyPlansCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      goals: goals ?? this.goals,
      targetHoursPerWeek: targetHoursPerWeek ?? this.targetHoursPerWeek,
      scheduleConfig: scheduleConfig ?? this.scheduleConfig,
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
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (goals.present) {
      map['goals'] = Variable<String>(goals.value);
    }
    if (targetHoursPerWeek.present) {
      map['target_hours_per_week'] = Variable<int>(targetHoursPerWeek.value);
    }
    if (scheduleConfig.present) {
      map['schedule_config'] = Variable<String>(scheduleConfig.value);
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
    return (StringBuffer('StudyPlansCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('goals: $goals, ')
          ..write('targetHoursPerWeek: $targetHoursPerWeek, ')
          ..write('scheduleConfig: $scheduleConfig, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StudyPlanItemsTable extends StudyPlanItems
    with TableInfo<$StudyPlanItemsTable, StudyPlanItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyPlanItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<int> topicId = GeneratedColumn<int>(
    'topic_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topics (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _resourceIdMeta = const VerificationMeta(
    'resourceId',
  );
  @override
  late final GeneratedColumn<int> resourceId = GeneratedColumn<int>(
    'resource_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES learning_resources (id) ON DELETE SET NULL',
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estimatedMinutesMeta = const VerificationMeta(
    'estimatedMinutes',
  );
  @override
  late final GeneratedColumn<int> estimatedMinutes = GeneratedColumn<int>(
    'estimated_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _scheduledDateMeta = const VerificationMeta(
    'scheduledDate',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledDate =
      GeneratedColumn<DateTime>(
        'scheduled_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    planId,
    topicId,
    resourceId,
    title,
    type,
    estimatedMinutes,
    orderIndex,
    scheduledDate,
    isCompleted,
    completedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_plan_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyPlanItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    }
    if (data.containsKey('resource_id')) {
      context.handle(
        _resourceIdMeta,
        resourceId.isAcceptableOrUnknown(data['resource_id']!, _resourceIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
        _estimatedMinutesMeta,
        estimatedMinutes.isAcceptableOrUnknown(
          data['estimated_minutes']!,
          _estimatedMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimatedMinutesMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    }
    if (data.containsKey('scheduled_date')) {
      context.handle(
        _scheduledDateMeta,
        scheduledDate.isAcceptableOrUnknown(
          data['scheduled_date']!,
          _scheduledDateMeta,
        ),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudyPlanItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyPlanItem(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      planId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}plan_id'],
          )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}topic_id'],
      ),
      resourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}resource_id'],
      ),
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      estimatedMinutes:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}estimated_minutes'],
          )!,
      orderIndex:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}order_index'],
          )!,
      scheduledDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_date'],
      ),
      isCompleted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_completed'],
          )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $StudyPlanItemsTable createAlias(String alias) {
    return $StudyPlanItemsTable(attachedDatabase, alias);
  }
}

class StudyPlanItem extends DataClass implements Insertable<StudyPlanItem> {
  final int id;
  final int planId;
  final int? topicId;
  final int? resourceId;
  final String title;
  final String type;
  final int estimatedMinutes;
  final int orderIndex;
  final DateTime? scheduledDate;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  const StudyPlanItem({
    required this.id,
    required this.planId,
    this.topicId,
    this.resourceId,
    required this.title,
    required this.type,
    required this.estimatedMinutes,
    required this.orderIndex,
    this.scheduledDate,
    required this.isCompleted,
    this.completedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plan_id'] = Variable<int>(planId);
    if (!nullToAbsent || topicId != null) {
      map['topic_id'] = Variable<int>(topicId);
    }
    if (!nullToAbsent || resourceId != null) {
      map['resource_id'] = Variable<int>(resourceId);
    }
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    map['estimated_minutes'] = Variable<int>(estimatedMinutes);
    map['order_index'] = Variable<int>(orderIndex);
    if (!nullToAbsent || scheduledDate != null) {
      map['scheduled_date'] = Variable<DateTime>(scheduledDate);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StudyPlanItemsCompanion toCompanion(bool nullToAbsent) {
    return StudyPlanItemsCompanion(
      id: Value(id),
      planId: Value(planId),
      topicId:
          topicId == null && nullToAbsent
              ? const Value.absent()
              : Value(topicId),
      resourceId:
          resourceId == null && nullToAbsent
              ? const Value.absent()
              : Value(resourceId),
      title: Value(title),
      type: Value(type),
      estimatedMinutes: Value(estimatedMinutes),
      orderIndex: Value(orderIndex),
      scheduledDate:
          scheduledDate == null && nullToAbsent
              ? const Value.absent()
              : Value(scheduledDate),
      isCompleted: Value(isCompleted),
      completedAt:
          completedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(completedAt),
      createdAt: Value(createdAt),
    );
  }

  factory StudyPlanItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyPlanItem(
      id: serializer.fromJson<int>(json['id']),
      planId: serializer.fromJson<int>(json['planId']),
      topicId: serializer.fromJson<int?>(json['topicId']),
      resourceId: serializer.fromJson<int?>(json['resourceId']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      estimatedMinutes: serializer.fromJson<int>(json['estimatedMinutes']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      scheduledDate: serializer.fromJson<DateTime?>(json['scheduledDate']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'planId': serializer.toJson<int>(planId),
      'topicId': serializer.toJson<int?>(topicId),
      'resourceId': serializer.toJson<int?>(resourceId),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'estimatedMinutes': serializer.toJson<int>(estimatedMinutes),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'scheduledDate': serializer.toJson<DateTime?>(scheduledDate),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StudyPlanItem copyWith({
    int? id,
    int? planId,
    Value<int?> topicId = const Value.absent(),
    Value<int?> resourceId = const Value.absent(),
    String? title,
    String? type,
    int? estimatedMinutes,
    int? orderIndex,
    Value<DateTime?> scheduledDate = const Value.absent(),
    bool? isCompleted,
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
  }) => StudyPlanItem(
    id: id ?? this.id,
    planId: planId ?? this.planId,
    topicId: topicId.present ? topicId.value : this.topicId,
    resourceId: resourceId.present ? resourceId.value : this.resourceId,
    title: title ?? this.title,
    type: type ?? this.type,
    estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
    orderIndex: orderIndex ?? this.orderIndex,
    scheduledDate:
        scheduledDate.present ? scheduledDate.value : this.scheduledDate,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  StudyPlanItem copyWithCompanion(StudyPlanItemsCompanion data) {
    return StudyPlanItem(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      resourceId:
          data.resourceId.present ? data.resourceId.value : this.resourceId,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      estimatedMinutes:
          data.estimatedMinutes.present
              ? data.estimatedMinutes.value
              : this.estimatedMinutes,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      scheduledDate:
          data.scheduledDate.present
              ? data.scheduledDate.value
              : this.scheduledDate,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyPlanItem(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('topicId: $topicId, ')
          ..write('resourceId: $resourceId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    planId,
    topicId,
    resourceId,
    title,
    type,
    estimatedMinutes,
    orderIndex,
    scheduledDate,
    isCompleted,
    completedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyPlanItem &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.topicId == this.topicId &&
          other.resourceId == this.resourceId &&
          other.title == this.title &&
          other.type == this.type &&
          other.estimatedMinutes == this.estimatedMinutes &&
          other.orderIndex == this.orderIndex &&
          other.scheduledDate == this.scheduledDate &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt);
}

class StudyPlanItemsCompanion extends UpdateCompanion<StudyPlanItem> {
  final Value<int> id;
  final Value<int> planId;
  final Value<int?> topicId;
  final Value<int?> resourceId;
  final Value<String> title;
  final Value<String> type;
  final Value<int> estimatedMinutes;
  final Value<int> orderIndex;
  final Value<DateTime?> scheduledDate;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  const StudyPlanItemsCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.resourceId = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.scheduledDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  StudyPlanItemsCompanion.insert({
    this.id = const Value.absent(),
    required int planId,
    this.topicId = const Value.absent(),
    this.resourceId = const Value.absent(),
    required String title,
    required String type,
    required int estimatedMinutes,
    this.orderIndex = const Value.absent(),
    this.scheduledDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    required DateTime createdAt,
  }) : planId = Value(planId),
       title = Value(title),
       type = Value(type),
       estimatedMinutes = Value(estimatedMinutes),
       createdAt = Value(createdAt);
  static Insertable<StudyPlanItem> custom({
    Expression<int>? id,
    Expression<int>? planId,
    Expression<int>? topicId,
    Expression<int>? resourceId,
    Expression<String>? title,
    Expression<String>? type,
    Expression<int>? estimatedMinutes,
    Expression<int>? orderIndex,
    Expression<DateTime>? scheduledDate,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (topicId != null) 'topic_id': topicId,
      if (resourceId != null) 'resource_id': resourceId,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (orderIndex != null) 'order_index': orderIndex,
      if (scheduledDate != null) 'scheduled_date': scheduledDate,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  StudyPlanItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? planId,
    Value<int?>? topicId,
    Value<int?>? resourceId,
    Value<String>? title,
    Value<String>? type,
    Value<int>? estimatedMinutes,
    Value<int>? orderIndex,
    Value<DateTime?>? scheduledDate,
    Value<bool>? isCompleted,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
  }) {
    return StudyPlanItemsCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      topicId: topicId ?? this.topicId,
      resourceId: resourceId ?? this.resourceId,
      title: title ?? this.title,
      type: type ?? this.type,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      orderIndex: orderIndex ?? this.orderIndex,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<int>(topicId.value);
    }
    if (resourceId.present) {
      map['resource_id'] = Variable<int>(resourceId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (scheduledDate.present) {
      map['scheduled_date'] = Variable<DateTime>(scheduledDate.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyPlanItemsCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('topicId: $topicId, ')
          ..write('resourceId: $resourceId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $StudySessionsTable extends StudySessions
    with TableInfo<$StudySessionsTable, StudySession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudySessionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
    'plan_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_plans (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _planItemIdMeta = const VerificationMeta(
    'planItemId',
  );
  @override
  late final GeneratedColumn<int> planItemId = GeneratedColumn<int>(
    'plan_item_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_plan_items (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<int> topicId = GeneratedColumn<int>(
    'topic_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topics (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _activityTypeMeta = const VerificationMeta(
    'activityType',
  );
  @override
  late final GeneratedColumn<String> activityType = GeneratedColumn<String>(
    'activity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _focusScoreMeta = const VerificationMeta(
    'focusScore',
  );
  @override
  late final GeneratedColumn<int> focusScore = GeneratedColumn<int>(
    'focus_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    planId,
    planItemId,
    topicId,
    activityType,
    durationMinutes,
    focusScore,
    notes,
    startedAt,
    endedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudySession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    }
    if (data.containsKey('plan_item_id')) {
      context.handle(
        _planItemIdMeta,
        planItemId.isAcceptableOrUnknown(
          data['plan_item_id']!,
          _planItemIdMeta,
        ),
      );
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    }
    if (data.containsKey('activity_type')) {
      context.handle(
        _activityTypeMeta,
        activityType.isAcceptableOrUnknown(
          data['activity_type']!,
          _activityTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activityTypeMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('focus_score')) {
      context.handle(
        _focusScoreMeta,
        focusScore.isAcceptableOrUnknown(data['focus_score']!, _focusScoreMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudySession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudySession(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plan_id'],
      ),
      planItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plan_item_id'],
      ),
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}topic_id'],
      ),
      activityType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}activity_type'],
          )!,
      durationMinutes:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}duration_minutes'],
          )!,
      focusScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}focus_score'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      startedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}started_at'],
          )!,
      endedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}ended_at'],
          )!,
    );
  }

  @override
  $StudySessionsTable createAlias(String alias) {
    return $StudySessionsTable(attachedDatabase, alias);
  }
}

class StudySession extends DataClass implements Insertable<StudySession> {
  final int id;
  final int? planId;
  final int? planItemId;
  final int? topicId;
  final String activityType;
  final int durationMinutes;
  final int? focusScore;
  final String? notes;
  final DateTime startedAt;
  final DateTime endedAt;
  const StudySession({
    required this.id,
    this.planId,
    this.planItemId,
    this.topicId,
    required this.activityType,
    required this.durationMinutes,
    this.focusScore,
    this.notes,
    required this.startedAt,
    required this.endedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || planId != null) {
      map['plan_id'] = Variable<int>(planId);
    }
    if (!nullToAbsent || planItemId != null) {
      map['plan_item_id'] = Variable<int>(planItemId);
    }
    if (!nullToAbsent || topicId != null) {
      map['topic_id'] = Variable<int>(topicId);
    }
    map['activity_type'] = Variable<String>(activityType);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || focusScore != null) {
      map['focus_score'] = Variable<int>(focusScore);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    map['ended_at'] = Variable<DateTime>(endedAt);
    return map;
  }

  StudySessionsCompanion toCompanion(bool nullToAbsent) {
    return StudySessionsCompanion(
      id: Value(id),
      planId:
          planId == null && nullToAbsent ? const Value.absent() : Value(planId),
      planItemId:
          planItemId == null && nullToAbsent
              ? const Value.absent()
              : Value(planItemId),
      topicId:
          topicId == null && nullToAbsent
              ? const Value.absent()
              : Value(topicId),
      activityType: Value(activityType),
      durationMinutes: Value(durationMinutes),
      focusScore:
          focusScore == null && nullToAbsent
              ? const Value.absent()
              : Value(focusScore),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      startedAt: Value(startedAt),
      endedAt: Value(endedAt),
    );
  }

  factory StudySession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudySession(
      id: serializer.fromJson<int>(json['id']),
      planId: serializer.fromJson<int?>(json['planId']),
      planItemId: serializer.fromJson<int?>(json['planItemId']),
      topicId: serializer.fromJson<int?>(json['topicId']),
      activityType: serializer.fromJson<String>(json['activityType']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      focusScore: serializer.fromJson<int?>(json['focusScore']),
      notes: serializer.fromJson<String?>(json['notes']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime>(json['endedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'planId': serializer.toJson<int?>(planId),
      'planItemId': serializer.toJson<int?>(planItemId),
      'topicId': serializer.toJson<int?>(topicId),
      'activityType': serializer.toJson<String>(activityType),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'focusScore': serializer.toJson<int?>(focusScore),
      'notes': serializer.toJson<String?>(notes),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime>(endedAt),
    };
  }

  StudySession copyWith({
    int? id,
    Value<int?> planId = const Value.absent(),
    Value<int?> planItemId = const Value.absent(),
    Value<int?> topicId = const Value.absent(),
    String? activityType,
    int? durationMinutes,
    Value<int?> focusScore = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? startedAt,
    DateTime? endedAt,
  }) => StudySession(
    id: id ?? this.id,
    planId: planId.present ? planId.value : this.planId,
    planItemId: planItemId.present ? planItemId.value : this.planItemId,
    topicId: topicId.present ? topicId.value : this.topicId,
    activityType: activityType ?? this.activityType,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    focusScore: focusScore.present ? focusScore.value : this.focusScore,
    notes: notes.present ? notes.value : this.notes,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt ?? this.endedAt,
  );
  StudySession copyWithCompanion(StudySessionsCompanion data) {
    return StudySession(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      planItemId:
          data.planItemId.present ? data.planItemId.value : this.planItemId,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      activityType:
          data.activityType.present
              ? data.activityType.value
              : this.activityType,
      durationMinutes:
          data.durationMinutes.present
              ? data.durationMinutes.value
              : this.durationMinutes,
      focusScore:
          data.focusScore.present ? data.focusScore.value : this.focusScore,
      notes: data.notes.present ? data.notes.value : this.notes,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudySession(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('planItemId: $planItemId, ')
          ..write('topicId: $topicId, ')
          ..write('activityType: $activityType, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('focusScore: $focusScore, ')
          ..write('notes: $notes, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    planId,
    planItemId,
    topicId,
    activityType,
    durationMinutes,
    focusScore,
    notes,
    startedAt,
    endedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudySession &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.planItemId == this.planItemId &&
          other.topicId == this.topicId &&
          other.activityType == this.activityType &&
          other.durationMinutes == this.durationMinutes &&
          other.focusScore == this.focusScore &&
          other.notes == this.notes &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt);
}

class StudySessionsCompanion extends UpdateCompanion<StudySession> {
  final Value<int> id;
  final Value<int?> planId;
  final Value<int?> planItemId;
  final Value<int?> topicId;
  final Value<String> activityType;
  final Value<int> durationMinutes;
  final Value<int?> focusScore;
  final Value<String?> notes;
  final Value<DateTime> startedAt;
  final Value<DateTime> endedAt;
  const StudySessionsCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.planItemId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.activityType = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.focusScore = const Value.absent(),
    this.notes = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
  });
  StudySessionsCompanion.insert({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.planItemId = const Value.absent(),
    this.topicId = const Value.absent(),
    required String activityType,
    required int durationMinutes,
    this.focusScore = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime startedAt,
    required DateTime endedAt,
  }) : activityType = Value(activityType),
       durationMinutes = Value(durationMinutes),
       startedAt = Value(startedAt),
       endedAt = Value(endedAt);
  static Insertable<StudySession> custom({
    Expression<int>? id,
    Expression<int>? planId,
    Expression<int>? planItemId,
    Expression<int>? topicId,
    Expression<String>? activityType,
    Expression<int>? durationMinutes,
    Expression<int>? focusScore,
    Expression<String>? notes,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (planItemId != null) 'plan_item_id': planItemId,
      if (topicId != null) 'topic_id': topicId,
      if (activityType != null) 'activity_type': activityType,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (focusScore != null) 'focus_score': focusScore,
      if (notes != null) 'notes': notes,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
    });
  }

  StudySessionsCompanion copyWith({
    Value<int>? id,
    Value<int?>? planId,
    Value<int?>? planItemId,
    Value<int?>? topicId,
    Value<String>? activityType,
    Value<int>? durationMinutes,
    Value<int?>? focusScore,
    Value<String?>? notes,
    Value<DateTime>? startedAt,
    Value<DateTime>? endedAt,
  }) {
    return StudySessionsCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      planItemId: planItemId ?? this.planItemId,
      topicId: topicId ?? this.topicId,
      activityType: activityType ?? this.activityType,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      focusScore: focusScore ?? this.focusScore,
      notes: notes ?? this.notes,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    if (planItemId.present) {
      map['plan_item_id'] = Variable<int>(planItemId.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<int>(topicId.value);
    }
    if (activityType.present) {
      map['activity_type'] = Variable<String>(activityType.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (focusScore.present) {
      map['focus_score'] = Variable<int>(focusScore.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudySessionsCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('planItemId: $planItemId, ')
          ..write('topicId: $topicId, ')
          ..write('activityType: $activityType, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('focusScore: $focusScore, ')
          ..write('notes: $notes, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }
}

class $ExamSchedulesTable extends ExamSchedules
    with TableInfo<$ExamSchedulesTable, ExamSchedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamSchedulesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _examTypeMeta = const VerificationMeta(
    'examType',
  );
  @override
  late final GeneratedColumn<String> examType = GeneratedColumn<String>(
    'exam_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _examDateMeta = const VerificationMeta(
    'examDate',
  );
  @override
  late final GeneratedColumn<DateTime> examDate = GeneratedColumn<DateTime>(
    'exam_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _topicsCoveredMeta = const VerificationMeta(
    'topicsCovered',
  );
  @override
  late final GeneratedColumn<String> topicsCovered = GeneratedColumn<String>(
    'topics_covered',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resourcesMeta = const VerificationMeta(
    'resources',
  );
  @override
  late final GeneratedColumn<String> resources = GeneratedColumn<String>(
    'resources',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetScoreMeta = const VerificationMeta(
    'targetScore',
  );
  @override
  late final GeneratedColumn<int> targetScore = GeneratedColumn<int>(
    'target_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _actualScoreMeta = const VerificationMeta(
    'actualScore',
  );
  @override
  late final GeneratedColumn<int> actualScore = GeneratedColumn<int>(
    'actual_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    subject,
    examType,
    examDate,
    durationMinutes,
    topicsCovered,
    resources,
    targetScore,
    notes,
    isCompleted,
    actualScore,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exam_schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExamSchedule> instance, {
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
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    }
    if (data.containsKey('exam_type')) {
      context.handle(
        _examTypeMeta,
        examType.isAcceptableOrUnknown(data['exam_type']!, _examTypeMeta),
      );
    }
    if (data.containsKey('exam_date')) {
      context.handle(
        _examDateMeta,
        examDate.isAcceptableOrUnknown(data['exam_date']!, _examDateMeta),
      );
    } else if (isInserting) {
      context.missing(_examDateMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('topics_covered')) {
      context.handle(
        _topicsCoveredMeta,
        topicsCovered.isAcceptableOrUnknown(
          data['topics_covered']!,
          _topicsCoveredMeta,
        ),
      );
    }
    if (data.containsKey('resources')) {
      context.handle(
        _resourcesMeta,
        resources.isAcceptableOrUnknown(data['resources']!, _resourcesMeta),
      );
    }
    if (data.containsKey('target_score')) {
      context.handle(
        _targetScoreMeta,
        targetScore.isAcceptableOrUnknown(
          data['target_score']!,
          _targetScoreMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('actual_score')) {
      context.handle(
        _actualScoreMeta,
        actualScore.isAcceptableOrUnknown(
          data['actual_score']!,
          _actualScoreMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExamSchedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamSchedule(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      ),
      examType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exam_type'],
      ),
      examDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}exam_date'],
          )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      ),
      topicsCovered: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topics_covered'],
      ),
      resources: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resources'],
      ),
      targetScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_score'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isCompleted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_completed'],
          )!,
      actualScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_score'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $ExamSchedulesTable createAlias(String alias) {
    return $ExamSchedulesTable(attachedDatabase, alias);
  }
}

class ExamSchedule extends DataClass implements Insertable<ExamSchedule> {
  final int id;
  final String name;
  final String? subject;
  final String? examType;
  final DateTime examDate;
  final int? durationMinutes;
  final String? topicsCovered;
  final String? resources;
  final int? targetScore;
  final String? notes;
  final bool isCompleted;
  final int? actualScore;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ExamSchedule({
    required this.id,
    required this.name,
    this.subject,
    this.examType,
    required this.examDate,
    this.durationMinutes,
    this.topicsCovered,
    this.resources,
    this.targetScore,
    this.notes,
    required this.isCompleted,
    this.actualScore,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || subject != null) {
      map['subject'] = Variable<String>(subject);
    }
    if (!nullToAbsent || examType != null) {
      map['exam_type'] = Variable<String>(examType);
    }
    map['exam_date'] = Variable<DateTime>(examDate);
    if (!nullToAbsent || durationMinutes != null) {
      map['duration_minutes'] = Variable<int>(durationMinutes);
    }
    if (!nullToAbsent || topicsCovered != null) {
      map['topics_covered'] = Variable<String>(topicsCovered);
    }
    if (!nullToAbsent || resources != null) {
      map['resources'] = Variable<String>(resources);
    }
    if (!nullToAbsent || targetScore != null) {
      map['target_score'] = Variable<int>(targetScore);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || actualScore != null) {
      map['actual_score'] = Variable<int>(actualScore);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ExamSchedulesCompanion toCompanion(bool nullToAbsent) {
    return ExamSchedulesCompanion(
      id: Value(id),
      name: Value(name),
      subject:
          subject == null && nullToAbsent
              ? const Value.absent()
              : Value(subject),
      examType:
          examType == null && nullToAbsent
              ? const Value.absent()
              : Value(examType),
      examDate: Value(examDate),
      durationMinutes:
          durationMinutes == null && nullToAbsent
              ? const Value.absent()
              : Value(durationMinutes),
      topicsCovered:
          topicsCovered == null && nullToAbsent
              ? const Value.absent()
              : Value(topicsCovered),
      resources:
          resources == null && nullToAbsent
              ? const Value.absent()
              : Value(resources),
      targetScore:
          targetScore == null && nullToAbsent
              ? const Value.absent()
              : Value(targetScore),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      isCompleted: Value(isCompleted),
      actualScore:
          actualScore == null && nullToAbsent
              ? const Value.absent()
              : Value(actualScore),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ExamSchedule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamSchedule(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      subject: serializer.fromJson<String?>(json['subject']),
      examType: serializer.fromJson<String?>(json['examType']),
      examDate: serializer.fromJson<DateTime>(json['examDate']),
      durationMinutes: serializer.fromJson<int?>(json['durationMinutes']),
      topicsCovered: serializer.fromJson<String?>(json['topicsCovered']),
      resources: serializer.fromJson<String?>(json['resources']),
      targetScore: serializer.fromJson<int?>(json['targetScore']),
      notes: serializer.fromJson<String?>(json['notes']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      actualScore: serializer.fromJson<int?>(json['actualScore']),
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
      'subject': serializer.toJson<String?>(subject),
      'examType': serializer.toJson<String?>(examType),
      'examDate': serializer.toJson<DateTime>(examDate),
      'durationMinutes': serializer.toJson<int?>(durationMinutes),
      'topicsCovered': serializer.toJson<String?>(topicsCovered),
      'resources': serializer.toJson<String?>(resources),
      'targetScore': serializer.toJson<int?>(targetScore),
      'notes': serializer.toJson<String?>(notes),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'actualScore': serializer.toJson<int?>(actualScore),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ExamSchedule copyWith({
    int? id,
    String? name,
    Value<String?> subject = const Value.absent(),
    Value<String?> examType = const Value.absent(),
    DateTime? examDate,
    Value<int?> durationMinutes = const Value.absent(),
    Value<String?> topicsCovered = const Value.absent(),
    Value<String?> resources = const Value.absent(),
    Value<int?> targetScore = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isCompleted,
    Value<int?> actualScore = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ExamSchedule(
    id: id ?? this.id,
    name: name ?? this.name,
    subject: subject.present ? subject.value : this.subject,
    examType: examType.present ? examType.value : this.examType,
    examDate: examDate ?? this.examDate,
    durationMinutes:
        durationMinutes.present ? durationMinutes.value : this.durationMinutes,
    topicsCovered:
        topicsCovered.present ? topicsCovered.value : this.topicsCovered,
    resources: resources.present ? resources.value : this.resources,
    targetScore: targetScore.present ? targetScore.value : this.targetScore,
    notes: notes.present ? notes.value : this.notes,
    isCompleted: isCompleted ?? this.isCompleted,
    actualScore: actualScore.present ? actualScore.value : this.actualScore,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ExamSchedule copyWithCompanion(ExamSchedulesCompanion data) {
    return ExamSchedule(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      subject: data.subject.present ? data.subject.value : this.subject,
      examType: data.examType.present ? data.examType.value : this.examType,
      examDate: data.examDate.present ? data.examDate.value : this.examDate,
      durationMinutes:
          data.durationMinutes.present
              ? data.durationMinutes.value
              : this.durationMinutes,
      topicsCovered:
          data.topicsCovered.present
              ? data.topicsCovered.value
              : this.topicsCovered,
      resources: data.resources.present ? data.resources.value : this.resources,
      targetScore:
          data.targetScore.present ? data.targetScore.value : this.targetScore,
      notes: data.notes.present ? data.notes.value : this.notes,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      actualScore:
          data.actualScore.present ? data.actualScore.value : this.actualScore,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamSchedule(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('subject: $subject, ')
          ..write('examType: $examType, ')
          ..write('examDate: $examDate, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('topicsCovered: $topicsCovered, ')
          ..write('resources: $resources, ')
          ..write('targetScore: $targetScore, ')
          ..write('notes: $notes, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('actualScore: $actualScore, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    subject,
    examType,
    examDate,
    durationMinutes,
    topicsCovered,
    resources,
    targetScore,
    notes,
    isCompleted,
    actualScore,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamSchedule &&
          other.id == this.id &&
          other.name == this.name &&
          other.subject == this.subject &&
          other.examType == this.examType &&
          other.examDate == this.examDate &&
          other.durationMinutes == this.durationMinutes &&
          other.topicsCovered == this.topicsCovered &&
          other.resources == this.resources &&
          other.targetScore == this.targetScore &&
          other.notes == this.notes &&
          other.isCompleted == this.isCompleted &&
          other.actualScore == this.actualScore &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExamSchedulesCompanion extends UpdateCompanion<ExamSchedule> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> subject;
  final Value<String?> examType;
  final Value<DateTime> examDate;
  final Value<int?> durationMinutes;
  final Value<String?> topicsCovered;
  final Value<String?> resources;
  final Value<int?> targetScore;
  final Value<String?> notes;
  final Value<bool> isCompleted;
  final Value<int?> actualScore;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ExamSchedulesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.subject = const Value.absent(),
    this.examType = const Value.absent(),
    this.examDate = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.topicsCovered = const Value.absent(),
    this.resources = const Value.absent(),
    this.targetScore = const Value.absent(),
    this.notes = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.actualScore = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ExamSchedulesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.subject = const Value.absent(),
    this.examType = const Value.absent(),
    required DateTime examDate,
    this.durationMinutes = const Value.absent(),
    this.topicsCovered = const Value.absent(),
    this.resources = const Value.absent(),
    this.targetScore = const Value.absent(),
    this.notes = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.actualScore = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : name = Value(name),
       examDate = Value(examDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ExamSchedule> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? subject,
    Expression<String>? examType,
    Expression<DateTime>? examDate,
    Expression<int>? durationMinutes,
    Expression<String>? topicsCovered,
    Expression<String>? resources,
    Expression<int>? targetScore,
    Expression<String>? notes,
    Expression<bool>? isCompleted,
    Expression<int>? actualScore,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (subject != null) 'subject': subject,
      if (examType != null) 'exam_type': examType,
      if (examDate != null) 'exam_date': examDate,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (topicsCovered != null) 'topics_covered': topicsCovered,
      if (resources != null) 'resources': resources,
      if (targetScore != null) 'target_score': targetScore,
      if (notes != null) 'notes': notes,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (actualScore != null) 'actual_score': actualScore,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ExamSchedulesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? subject,
    Value<String?>? examType,
    Value<DateTime>? examDate,
    Value<int?>? durationMinutes,
    Value<String?>? topicsCovered,
    Value<String?>? resources,
    Value<int?>? targetScore,
    Value<String?>? notes,
    Value<bool>? isCompleted,
    Value<int?>? actualScore,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ExamSchedulesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      subject: subject ?? this.subject,
      examType: examType ?? this.examType,
      examDate: examDate ?? this.examDate,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      topicsCovered: topicsCovered ?? this.topicsCovered,
      resources: resources ?? this.resources,
      targetScore: targetScore ?? this.targetScore,
      notes: notes ?? this.notes,
      isCompleted: isCompleted ?? this.isCompleted,
      actualScore: actualScore ?? this.actualScore,
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
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (examType.present) {
      map['exam_type'] = Variable<String>(examType.value);
    }
    if (examDate.present) {
      map['exam_date'] = Variable<DateTime>(examDate.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (topicsCovered.present) {
      map['topics_covered'] = Variable<String>(topicsCovered.value);
    }
    if (resources.present) {
      map['resources'] = Variable<String>(resources.value);
    }
    if (targetScore.present) {
      map['target_score'] = Variable<int>(targetScore.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (actualScore.present) {
      map['actual_score'] = Variable<int>(actualScore.value);
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
    return (StringBuffer('ExamSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('subject: $subject, ')
          ..write('examType: $examType, ')
          ..write('examDate: $examDate, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('topicsCovered: $topicsCovered, ')
          ..write('resources: $resources, ')
          ..write('targetScore: $targetScore, ')
          ..write('notes: $notes, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('actualScore: $actualScore, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTable extends Achievements
    with TableInfo<$AchievementsTable, Achievement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<int> tier = GeneratedColumn<int>(
    'tier',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _xpRewardMeta = const VerificationMeta(
    'xpReward',
  );
  @override
  late final GeneratedColumn<int> xpReward = GeneratedColumn<int>(
    'xp_reward',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _criteriaMeta = const VerificationMeta(
    'criteria',
  );
  @override
  late final GeneratedColumn<String> criteria = GeneratedColumn<String>(
    'criteria',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSecretMeta = const VerificationMeta(
    'isSecret',
  );
  @override
  late final GeneratedColumn<bool> isSecret = GeneratedColumn<bool>(
    'is_secret',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_secret" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    key,
    name,
    description,
    icon,
    category,
    tier,
    xpReward,
    criteria,
    isSecret,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievements';
  @override
  VerificationContext validateIntegrity(
    Insertable<Achievement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
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
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('tier')) {
      context.handle(
        _tierMeta,
        tier.isAcceptableOrUnknown(data['tier']!, _tierMeta),
      );
    }
    if (data.containsKey('xp_reward')) {
      context.handle(
        _xpRewardMeta,
        xpReward.isAcceptableOrUnknown(data['xp_reward']!, _xpRewardMeta),
      );
    }
    if (data.containsKey('criteria')) {
      context.handle(
        _criteriaMeta,
        criteria.isAcceptableOrUnknown(data['criteria']!, _criteriaMeta),
      );
    }
    if (data.containsKey('is_secret')) {
      context.handle(
        _isSecretMeta,
        isSecret.isAcceptableOrUnknown(data['is_secret']!, _isSecretMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Achievement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Achievement(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      key:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}key'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
      category:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category'],
          )!,
      tier:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}tier'],
          )!,
      xpReward:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}xp_reward'],
          )!,
      criteria: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}criteria'],
      ),
      isSecret:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_secret'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $AchievementsTable createAlias(String alias) {
    return $AchievementsTable(attachedDatabase, alias);
  }
}

class Achievement extends DataClass implements Insertable<Achievement> {
  final int id;
  final String key;
  final String name;
  final String description;
  final String? icon;
  final String category;
  final int tier;
  final int xpReward;
  final String? criteria;
  final bool isSecret;
  final DateTime createdAt;
  const Achievement({
    required this.id,
    required this.key,
    required this.name,
    required this.description,
    this.icon,
    required this.category,
    required this.tier,
    required this.xpReward,
    this.criteria,
    required this.isSecret,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    map['category'] = Variable<String>(category);
    map['tier'] = Variable<int>(tier);
    map['xp_reward'] = Variable<int>(xpReward);
    if (!nullToAbsent || criteria != null) {
      map['criteria'] = Variable<String>(criteria);
    }
    map['is_secret'] = Variable<bool>(isSecret);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AchievementsCompanion toCompanion(bool nullToAbsent) {
    return AchievementsCompanion(
      id: Value(id),
      key: Value(key),
      name: Value(name),
      description: Value(description),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      category: Value(category),
      tier: Value(tier),
      xpReward: Value(xpReward),
      criteria:
          criteria == null && nullToAbsent
              ? const Value.absent()
              : Value(criteria),
      isSecret: Value(isSecret),
      createdAt: Value(createdAt),
    );
  }

  factory Achievement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Achievement(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      icon: serializer.fromJson<String?>(json['icon']),
      category: serializer.fromJson<String>(json['category']),
      tier: serializer.fromJson<int>(json['tier']),
      xpReward: serializer.fromJson<int>(json['xpReward']),
      criteria: serializer.fromJson<String?>(json['criteria']),
      isSecret: serializer.fromJson<bool>(json['isSecret']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'icon': serializer.toJson<String?>(icon),
      'category': serializer.toJson<String>(category),
      'tier': serializer.toJson<int>(tier),
      'xpReward': serializer.toJson<int>(xpReward),
      'criteria': serializer.toJson<String?>(criteria),
      'isSecret': serializer.toJson<bool>(isSecret),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Achievement copyWith({
    int? id,
    String? key,
    String? name,
    String? description,
    Value<String?> icon = const Value.absent(),
    String? category,
    int? tier,
    int? xpReward,
    Value<String?> criteria = const Value.absent(),
    bool? isSecret,
    DateTime? createdAt,
  }) => Achievement(
    id: id ?? this.id,
    key: key ?? this.key,
    name: name ?? this.name,
    description: description ?? this.description,
    icon: icon.present ? icon.value : this.icon,
    category: category ?? this.category,
    tier: tier ?? this.tier,
    xpReward: xpReward ?? this.xpReward,
    criteria: criteria.present ? criteria.value : this.criteria,
    isSecret: isSecret ?? this.isSecret,
    createdAt: createdAt ?? this.createdAt,
  );
  Achievement copyWithCompanion(AchievementsCompanion data) {
    return Achievement(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      category: data.category.present ? data.category.value : this.category,
      tier: data.tier.present ? data.tier.value : this.tier,
      xpReward: data.xpReward.present ? data.xpReward.value : this.xpReward,
      criteria: data.criteria.present ? data.criteria.value : this.criteria,
      isSecret: data.isSecret.present ? data.isSecret.value : this.isSecret,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Achievement(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('category: $category, ')
          ..write('tier: $tier, ')
          ..write('xpReward: $xpReward, ')
          ..write('criteria: $criteria, ')
          ..write('isSecret: $isSecret, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    key,
    name,
    description,
    icon,
    category,
    tier,
    xpReward,
    criteria,
    isSecret,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Achievement &&
          other.id == this.id &&
          other.key == this.key &&
          other.name == this.name &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.category == this.category &&
          other.tier == this.tier &&
          other.xpReward == this.xpReward &&
          other.criteria == this.criteria &&
          other.isSecret == this.isSecret &&
          other.createdAt == this.createdAt);
}

class AchievementsCompanion extends UpdateCompanion<Achievement> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> name;
  final Value<String> description;
  final Value<String?> icon;
  final Value<String> category;
  final Value<int> tier;
  final Value<int> xpReward;
  final Value<String?> criteria;
  final Value<bool> isSecret;
  final Value<DateTime> createdAt;
  const AchievementsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.category = const Value.absent(),
    this.tier = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.criteria = const Value.absent(),
    this.isSecret = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AchievementsCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required String name,
    required String description,
    this.icon = const Value.absent(),
    required String category,
    this.tier = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.criteria = const Value.absent(),
    this.isSecret = const Value.absent(),
    required DateTime createdAt,
  }) : key = Value(key),
       name = Value(name),
       description = Value(description),
       category = Value(category),
       createdAt = Value(createdAt);
  static Insertable<Achievement> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<String>? category,
    Expression<int>? tier,
    Expression<int>? xpReward,
    Expression<String>? criteria,
    Expression<bool>? isSecret,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (category != null) 'category': category,
      if (tier != null) 'tier': tier,
      if (xpReward != null) 'xp_reward': xpReward,
      if (criteria != null) 'criteria': criteria,
      if (isSecret != null) 'is_secret': isSecret,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AchievementsCompanion copyWith({
    Value<int>? id,
    Value<String>? key,
    Value<String>? name,
    Value<String>? description,
    Value<String?>? icon,
    Value<String>? category,
    Value<int>? tier,
    Value<int>? xpReward,
    Value<String?>? criteria,
    Value<bool>? isSecret,
    Value<DateTime>? createdAt,
  }) {
    return AchievementsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      category: category ?? this.category,
      tier: tier ?? this.tier,
      xpReward: xpReward ?? this.xpReward,
      criteria: criteria ?? this.criteria,
      isSecret: isSecret ?? this.isSecret,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (tier.present) {
      map['tier'] = Variable<int>(tier.value);
    }
    if (xpReward.present) {
      map['xp_reward'] = Variable<int>(xpReward.value);
    }
    if (criteria.present) {
      map['criteria'] = Variable<String>(criteria.value);
    }
    if (isSecret.present) {
      map['is_secret'] = Variable<bool>(isSecret.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('category: $category, ')
          ..write('tier: $tier, ')
          ..write('xpReward: $xpReward, ')
          ..write('criteria: $criteria, ')
          ..write('isSecret: $isSecret, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserAchievementsTable extends UserAchievements
    with TableInfo<$UserAchievementsTable, UserAchievement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserAchievementsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _achievementIdMeta = const VerificationMeta(
    'achievementId',
  );
  @override
  late final GeneratedColumn<int> achievementId = GeneratedColumn<int>(
    'achievement_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES achievements (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<int> progress = GeneratedColumn<int>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<int> target = GeneratedColumn<int>(
    'target',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _isUnlockedMeta = const VerificationMeta(
    'isUnlocked',
  );
  @override
  late final GeneratedColumn<bool> isUnlocked = GeneratedColumn<bool>(
    'is_unlocked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_unlocked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    achievementId,
    progress,
    target,
    isUnlocked,
    unlockedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_achievements';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserAchievement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('achievement_id')) {
      context.handle(
        _achievementIdMeta,
        achievementId.isAcceptableOrUnknown(
          data['achievement_id']!,
          _achievementIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_achievementIdMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    }
    if (data.containsKey('is_unlocked')) {
      context.handle(
        _isUnlockedMeta,
        isUnlocked.isAcceptableOrUnknown(data['is_unlocked']!, _isUnlockedMeta),
      );
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserAchievement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserAchievement(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      achievementId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}achievement_id'],
          )!,
      progress:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}progress'],
          )!,
      target:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}target'],
          )!,
      isUnlocked:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_unlocked'],
          )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $UserAchievementsTable createAlias(String alias) {
    return $UserAchievementsTable(attachedDatabase, alias);
  }
}

class UserAchievement extends DataClass implements Insertable<UserAchievement> {
  final int id;
  final int achievementId;
  final int progress;
  final int target;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserAchievement({
    required this.id,
    required this.achievementId,
    required this.progress,
    required this.target,
    required this.isUnlocked,
    this.unlockedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['achievement_id'] = Variable<int>(achievementId);
    map['progress'] = Variable<int>(progress);
    map['target'] = Variable<int>(target);
    map['is_unlocked'] = Variable<bool>(isUnlocked);
    if (!nullToAbsent || unlockedAt != null) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserAchievementsCompanion toCompanion(bool nullToAbsent) {
    return UserAchievementsCompanion(
      id: Value(id),
      achievementId: Value(achievementId),
      progress: Value(progress),
      target: Value(target),
      isUnlocked: Value(isUnlocked),
      unlockedAt:
          unlockedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(unlockedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserAchievement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserAchievement(
      id: serializer.fromJson<int>(json['id']),
      achievementId: serializer.fromJson<int>(json['achievementId']),
      progress: serializer.fromJson<int>(json['progress']),
      target: serializer.fromJson<int>(json['target']),
      isUnlocked: serializer.fromJson<bool>(json['isUnlocked']),
      unlockedAt: serializer.fromJson<DateTime?>(json['unlockedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'achievementId': serializer.toJson<int>(achievementId),
      'progress': serializer.toJson<int>(progress),
      'target': serializer.toJson<int>(target),
      'isUnlocked': serializer.toJson<bool>(isUnlocked),
      'unlockedAt': serializer.toJson<DateTime?>(unlockedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserAchievement copyWith({
    int? id,
    int? achievementId,
    int? progress,
    int? target,
    bool? isUnlocked,
    Value<DateTime?> unlockedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserAchievement(
    id: id ?? this.id,
    achievementId: achievementId ?? this.achievementId,
    progress: progress ?? this.progress,
    target: target ?? this.target,
    isUnlocked: isUnlocked ?? this.isUnlocked,
    unlockedAt: unlockedAt.present ? unlockedAt.value : this.unlockedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserAchievement copyWithCompanion(UserAchievementsCompanion data) {
    return UserAchievement(
      id: data.id.present ? data.id.value : this.id,
      achievementId:
          data.achievementId.present
              ? data.achievementId.value
              : this.achievementId,
      progress: data.progress.present ? data.progress.value : this.progress,
      target: data.target.present ? data.target.value : this.target,
      isUnlocked:
          data.isUnlocked.present ? data.isUnlocked.value : this.isUnlocked,
      unlockedAt:
          data.unlockedAt.present ? data.unlockedAt.value : this.unlockedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserAchievement(')
          ..write('id: $id, ')
          ..write('achievementId: $achievementId, ')
          ..write('progress: $progress, ')
          ..write('target: $target, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    achievementId,
    progress,
    target,
    isUnlocked,
    unlockedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserAchievement &&
          other.id == this.id &&
          other.achievementId == this.achievementId &&
          other.progress == this.progress &&
          other.target == this.target &&
          other.isUnlocked == this.isUnlocked &&
          other.unlockedAt == this.unlockedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserAchievementsCompanion extends UpdateCompanion<UserAchievement> {
  final Value<int> id;
  final Value<int> achievementId;
  final Value<int> progress;
  final Value<int> target;
  final Value<bool> isUnlocked;
  final Value<DateTime?> unlockedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserAchievementsCompanion({
    this.id = const Value.absent(),
    this.achievementId = const Value.absent(),
    this.progress = const Value.absent(),
    this.target = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserAchievementsCompanion.insert({
    this.id = const Value.absent(),
    required int achievementId,
    this.progress = const Value.absent(),
    this.target = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : achievementId = Value(achievementId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserAchievement> custom({
    Expression<int>? id,
    Expression<int>? achievementId,
    Expression<int>? progress,
    Expression<int>? target,
    Expression<bool>? isUnlocked,
    Expression<DateTime>? unlockedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (achievementId != null) 'achievement_id': achievementId,
      if (progress != null) 'progress': progress,
      if (target != null) 'target': target,
      if (isUnlocked != null) 'is_unlocked': isUnlocked,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserAchievementsCompanion copyWith({
    Value<int>? id,
    Value<int>? achievementId,
    Value<int>? progress,
    Value<int>? target,
    Value<bool>? isUnlocked,
    Value<DateTime?>? unlockedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserAchievementsCompanion(
      id: id ?? this.id,
      achievementId: achievementId ?? this.achievementId,
      progress: progress ?? this.progress,
      target: target ?? this.target,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
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
    if (achievementId.present) {
      map['achievement_id'] = Variable<int>(achievementId.value);
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (target.present) {
      map['target'] = Variable<int>(target.value);
    }
    if (isUnlocked.present) {
      map['is_unlocked'] = Variable<bool>(isUnlocked.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
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
    return (StringBuffer('UserAchievementsCompanion(')
          ..write('id: $id, ')
          ..write('achievementId: $achievementId, ')
          ..write('progress: $progress, ')
          ..write('target: $target, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, Notification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDismissedMeta = const VerificationMeta(
    'isDismissed',
  );
  @override
  late final GeneratedColumn<bool> isDismissed = GeneratedColumn<bool>(
    'is_dismissed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dismissed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _scheduledForMeta = const VerificationMeta(
    'scheduledFor',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledFor = GeneratedColumn<DateTime>(
    'scheduled_for',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _readAtMeta = const VerificationMeta('readAt');
  @override
  late final GeneratedColumn<DateTime> readAt = GeneratedColumn<DateTime>(
    'read_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    title,
    body,
    payload,
    isRead,
    isDismissed,
    scheduledFor,
    readAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<Notification> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('is_dismissed')) {
      context.handle(
        _isDismissedMeta,
        isDismissed.isAcceptableOrUnknown(
          data['is_dismissed']!,
          _isDismissedMeta,
        ),
      );
    }
    if (data.containsKey('scheduled_for')) {
      context.handle(
        _scheduledForMeta,
        scheduledFor.isAcceptableOrUnknown(
          data['scheduled_for']!,
          _scheduledForMeta,
        ),
      );
    }
    if (data.containsKey('read_at')) {
      context.handle(
        _readAtMeta,
        readAt.isAcceptableOrUnknown(data['read_at']!, _readAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Notification(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      body:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}body'],
          )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      ),
      isRead:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_read'],
          )!,
      isDismissed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_dismissed'],
          )!,
      scheduledFor: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_for'],
      ),
      readAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}read_at'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(attachedDatabase, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  final int id;
  final String type;
  final String title;
  final String body;
  final String? payload;
  final bool isRead;
  final bool isDismissed;
  final DateTime? scheduledFor;
  final DateTime? readAt;
  final DateTime createdAt;
  const Notification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    this.payload,
    required this.isRead,
    required this.isDismissed,
    this.scheduledFor,
    this.readAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || payload != null) {
      map['payload'] = Variable<String>(payload);
    }
    map['is_read'] = Variable<bool>(isRead);
    map['is_dismissed'] = Variable<bool>(isDismissed);
    if (!nullToAbsent || scheduledFor != null) {
      map['scheduled_for'] = Variable<DateTime>(scheduledFor);
    }
    if (!nullToAbsent || readAt != null) {
      map['read_at'] = Variable<DateTime>(readAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: Value(id),
      type: Value(type),
      title: Value(title),
      body: Value(body),
      payload:
          payload == null && nullToAbsent
              ? const Value.absent()
              : Value(payload),
      isRead: Value(isRead),
      isDismissed: Value(isDismissed),
      scheduledFor:
          scheduledFor == null && nullToAbsent
              ? const Value.absent()
              : Value(scheduledFor),
      readAt:
          readAt == null && nullToAbsent ? const Value.absent() : Value(readAt),
      createdAt: Value(createdAt),
    );
  }

  factory Notification.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Notification(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      payload: serializer.fromJson<String?>(json['payload']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      isDismissed: serializer.fromJson<bool>(json['isDismissed']),
      scheduledFor: serializer.fromJson<DateTime?>(json['scheduledFor']),
      readAt: serializer.fromJson<DateTime?>(json['readAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'payload': serializer.toJson<String?>(payload),
      'isRead': serializer.toJson<bool>(isRead),
      'isDismissed': serializer.toJson<bool>(isDismissed),
      'scheduledFor': serializer.toJson<DateTime?>(scheduledFor),
      'readAt': serializer.toJson<DateTime?>(readAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Notification copyWith({
    int? id,
    String? type,
    String? title,
    String? body,
    Value<String?> payload = const Value.absent(),
    bool? isRead,
    bool? isDismissed,
    Value<DateTime?> scheduledFor = const Value.absent(),
    Value<DateTime?> readAt = const Value.absent(),
    DateTime? createdAt,
  }) => Notification(
    id: id ?? this.id,
    type: type ?? this.type,
    title: title ?? this.title,
    body: body ?? this.body,
    payload: payload.present ? payload.value : this.payload,
    isRead: isRead ?? this.isRead,
    isDismissed: isDismissed ?? this.isDismissed,
    scheduledFor: scheduledFor.present ? scheduledFor.value : this.scheduledFor,
    readAt: readAt.present ? readAt.value : this.readAt,
    createdAt: createdAt ?? this.createdAt,
  );
  Notification copyWithCompanion(NotificationsCompanion data) {
    return Notification(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      payload: data.payload.present ? data.payload.value : this.payload,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      isDismissed:
          data.isDismissed.present ? data.isDismissed.value : this.isDismissed,
      scheduledFor:
          data.scheduledFor.present
              ? data.scheduledFor.value
              : this.scheduledFor,
      readAt: data.readAt.present ? data.readAt.value : this.readAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('payload: $payload, ')
          ..write('isRead: $isRead, ')
          ..write('isDismissed: $isDismissed, ')
          ..write('scheduledFor: $scheduledFor, ')
          ..write('readAt: $readAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    title,
    body,
    payload,
    isRead,
    isDismissed,
    scheduledFor,
    readAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          other.id == this.id &&
          other.type == this.type &&
          other.title == this.title &&
          other.body == this.body &&
          other.payload == this.payload &&
          other.isRead == this.isRead &&
          other.isDismissed == this.isDismissed &&
          other.scheduledFor == this.scheduledFor &&
          other.readAt == this.readAt &&
          other.createdAt == this.createdAt);
}

class NotificationsCompanion extends UpdateCompanion<Notification> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> title;
  final Value<String> body;
  final Value<String?> payload;
  final Value<bool> isRead;
  final Value<bool> isDismissed;
  final Value<DateTime?> scheduledFor;
  final Value<DateTime?> readAt;
  final Value<DateTime> createdAt;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.payload = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isDismissed = const Value.absent(),
    this.scheduledFor = const Value.absent(),
    this.readAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  NotificationsCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required String title,
    required String body,
    this.payload = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isDismissed = const Value.absent(),
    this.scheduledFor = const Value.absent(),
    this.readAt = const Value.absent(),
    required DateTime createdAt,
  }) : type = Value(type),
       title = Value(title),
       body = Value(body),
       createdAt = Value(createdAt);
  static Insertable<Notification> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? payload,
    Expression<bool>? isRead,
    Expression<bool>? isDismissed,
    Expression<DateTime>? scheduledFor,
    Expression<DateTime>? readAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (payload != null) 'payload': payload,
      if (isRead != null) 'is_read': isRead,
      if (isDismissed != null) 'is_dismissed': isDismissed,
      if (scheduledFor != null) 'scheduled_for': scheduledFor,
      if (readAt != null) 'read_at': readAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  NotificationsCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<String>? title,
    Value<String>? body,
    Value<String?>? payload,
    Value<bool>? isRead,
    Value<bool>? isDismissed,
    Value<DateTime?>? scheduledFor,
    Value<DateTime?>? readAt,
    Value<DateTime>? createdAt,
  }) {
    return NotificationsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      payload: payload ?? this.payload,
      isRead: isRead ?? this.isRead,
      isDismissed: isDismissed ?? this.isDismissed,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (isDismissed.present) {
      map['is_dismissed'] = Variable<bool>(isDismissed.value);
    }
    if (scheduledFor.present) {
      map['scheduled_for'] = Variable<DateTime>(scheduledFor.value);
    }
    if (readAt.present) {
      map['read_at'] = Variable<DateTime>(readAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('payload: $payload, ')
          ..write('isRead: $isRead, ')
          ..write('isDismissed: $isDismissed, ')
          ..write('scheduledFor: $scheduledFor, ')
          ..write('readAt: $readAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RecommendationsTable extends Recommendations
    with TableInfo<$RecommendationsTable, Recommendation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecommendationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<int> topicId = GeneratedColumn<int>(
    'topic_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topics (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _resourceIdMeta = const VerificationMeta(
    'resourceId',
  );
  @override
  late final GeneratedColumn<int> resourceId = GeneratedColumn<int>(
    'resource_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES learning_resources (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _isDismissedMeta = const VerificationMeta(
    'isDismissed',
  );
  @override
  late final GeneratedColumn<bool> isDismissed = GeneratedColumn<bool>(
    'is_dismissed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dismissed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isAcceptedMeta = const VerificationMeta(
    'isAccepted',
  );
  @override
  late final GeneratedColumn<bool> isAccepted = GeneratedColumn<bool>(
    'is_accepted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_accepted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    title,
    description,
    reason,
    priority,
    topicId,
    resourceId,
    isDismissed,
    isAccepted,
    expiresAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recommendations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Recommendation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
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
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    }
    if (data.containsKey('resource_id')) {
      context.handle(
        _resourceIdMeta,
        resourceId.isAcceptableOrUnknown(data['resource_id']!, _resourceIdMeta),
      );
    }
    if (data.containsKey('is_dismissed')) {
      context.handle(
        _isDismissedMeta,
        isDismissed.isAcceptableOrUnknown(
          data['is_dismissed']!,
          _isDismissedMeta,
        ),
      );
    }
    if (data.containsKey('is_accepted')) {
      context.handle(
        _isAcceptedMeta,
        isAccepted.isAcceptableOrUnknown(data['is_accepted']!, _isAcceptedMeta),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recommendation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recommendation(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      reason:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}reason'],
          )!,
      priority:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}priority'],
          )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}topic_id'],
      ),
      resourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}resource_id'],
      ),
      isDismissed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_dismissed'],
          )!,
      isAccepted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_accepted'],
          )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $RecommendationsTable createAlias(String alias) {
    return $RecommendationsTable(attachedDatabase, alias);
  }
}

class Recommendation extends DataClass implements Insertable<Recommendation> {
  final int id;
  final String type;
  final String title;
  final String description;
  final String reason;
  final int priority;
  final int? topicId;
  final int? resourceId;
  final bool isDismissed;
  final bool isAccepted;
  final DateTime? expiresAt;
  final DateTime createdAt;
  const Recommendation({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.reason,
    required this.priority,
    this.topicId,
    this.resourceId,
    required this.isDismissed,
    required this.isAccepted,
    this.expiresAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['reason'] = Variable<String>(reason);
    map['priority'] = Variable<int>(priority);
    if (!nullToAbsent || topicId != null) {
      map['topic_id'] = Variable<int>(topicId);
    }
    if (!nullToAbsent || resourceId != null) {
      map['resource_id'] = Variable<int>(resourceId);
    }
    map['is_dismissed'] = Variable<bool>(isDismissed);
    map['is_accepted'] = Variable<bool>(isAccepted);
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<DateTime>(expiresAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RecommendationsCompanion toCompanion(bool nullToAbsent) {
    return RecommendationsCompanion(
      id: Value(id),
      type: Value(type),
      title: Value(title),
      description: Value(description),
      reason: Value(reason),
      priority: Value(priority),
      topicId:
          topicId == null && nullToAbsent
              ? const Value.absent()
              : Value(topicId),
      resourceId:
          resourceId == null && nullToAbsent
              ? const Value.absent()
              : Value(resourceId),
      isDismissed: Value(isDismissed),
      isAccepted: Value(isAccepted),
      expiresAt:
          expiresAt == null && nullToAbsent
              ? const Value.absent()
              : Value(expiresAt),
      createdAt: Value(createdAt),
    );
  }

  factory Recommendation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recommendation(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      reason: serializer.fromJson<String>(json['reason']),
      priority: serializer.fromJson<int>(json['priority']),
      topicId: serializer.fromJson<int?>(json['topicId']),
      resourceId: serializer.fromJson<int?>(json['resourceId']),
      isDismissed: serializer.fromJson<bool>(json['isDismissed']),
      isAccepted: serializer.fromJson<bool>(json['isAccepted']),
      expiresAt: serializer.fromJson<DateTime?>(json['expiresAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'reason': serializer.toJson<String>(reason),
      'priority': serializer.toJson<int>(priority),
      'topicId': serializer.toJson<int?>(topicId),
      'resourceId': serializer.toJson<int?>(resourceId),
      'isDismissed': serializer.toJson<bool>(isDismissed),
      'isAccepted': serializer.toJson<bool>(isAccepted),
      'expiresAt': serializer.toJson<DateTime?>(expiresAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Recommendation copyWith({
    int? id,
    String? type,
    String? title,
    String? description,
    String? reason,
    int? priority,
    Value<int?> topicId = const Value.absent(),
    Value<int?> resourceId = const Value.absent(),
    bool? isDismissed,
    bool? isAccepted,
    Value<DateTime?> expiresAt = const Value.absent(),
    DateTime? createdAt,
  }) => Recommendation(
    id: id ?? this.id,
    type: type ?? this.type,
    title: title ?? this.title,
    description: description ?? this.description,
    reason: reason ?? this.reason,
    priority: priority ?? this.priority,
    topicId: topicId.present ? topicId.value : this.topicId,
    resourceId: resourceId.present ? resourceId.value : this.resourceId,
    isDismissed: isDismissed ?? this.isDismissed,
    isAccepted: isAccepted ?? this.isAccepted,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
    createdAt: createdAt ?? this.createdAt,
  );
  Recommendation copyWithCompanion(RecommendationsCompanion data) {
    return Recommendation(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      reason: data.reason.present ? data.reason.value : this.reason,
      priority: data.priority.present ? data.priority.value : this.priority,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      resourceId:
          data.resourceId.present ? data.resourceId.value : this.resourceId,
      isDismissed:
          data.isDismissed.present ? data.isDismissed.value : this.isDismissed,
      isAccepted:
          data.isAccepted.present ? data.isAccepted.value : this.isAccepted,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Recommendation(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('reason: $reason, ')
          ..write('priority: $priority, ')
          ..write('topicId: $topicId, ')
          ..write('resourceId: $resourceId, ')
          ..write('isDismissed: $isDismissed, ')
          ..write('isAccepted: $isAccepted, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    title,
    description,
    reason,
    priority,
    topicId,
    resourceId,
    isDismissed,
    isAccepted,
    expiresAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recommendation &&
          other.id == this.id &&
          other.type == this.type &&
          other.title == this.title &&
          other.description == this.description &&
          other.reason == this.reason &&
          other.priority == this.priority &&
          other.topicId == this.topicId &&
          other.resourceId == this.resourceId &&
          other.isDismissed == this.isDismissed &&
          other.isAccepted == this.isAccepted &&
          other.expiresAt == this.expiresAt &&
          other.createdAt == this.createdAt);
}

class RecommendationsCompanion extends UpdateCompanion<Recommendation> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> title;
  final Value<String> description;
  final Value<String> reason;
  final Value<int> priority;
  final Value<int?> topicId;
  final Value<int?> resourceId;
  final Value<bool> isDismissed;
  final Value<bool> isAccepted;
  final Value<DateTime?> expiresAt;
  final Value<DateTime> createdAt;
  const RecommendationsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.reason = const Value.absent(),
    this.priority = const Value.absent(),
    this.topicId = const Value.absent(),
    this.resourceId = const Value.absent(),
    this.isDismissed = const Value.absent(),
    this.isAccepted = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RecommendationsCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required String title,
    required String description,
    required String reason,
    this.priority = const Value.absent(),
    this.topicId = const Value.absent(),
    this.resourceId = const Value.absent(),
    this.isDismissed = const Value.absent(),
    this.isAccepted = const Value.absent(),
    this.expiresAt = const Value.absent(),
    required DateTime createdAt,
  }) : type = Value(type),
       title = Value(title),
       description = Value(description),
       reason = Value(reason),
       createdAt = Value(createdAt);
  static Insertable<Recommendation> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? reason,
    Expression<int>? priority,
    Expression<int>? topicId,
    Expression<int>? resourceId,
    Expression<bool>? isDismissed,
    Expression<bool>? isAccepted,
    Expression<DateTime>? expiresAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (reason != null) 'reason': reason,
      if (priority != null) 'priority': priority,
      if (topicId != null) 'topic_id': topicId,
      if (resourceId != null) 'resource_id': resourceId,
      if (isDismissed != null) 'is_dismissed': isDismissed,
      if (isAccepted != null) 'is_accepted': isAccepted,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RecommendationsCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<String>? title,
    Value<String>? description,
    Value<String>? reason,
    Value<int>? priority,
    Value<int?>? topicId,
    Value<int?>? resourceId,
    Value<bool>? isDismissed,
    Value<bool>? isAccepted,
    Value<DateTime?>? expiresAt,
    Value<DateTime>? createdAt,
  }) {
    return RecommendationsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      reason: reason ?? this.reason,
      priority: priority ?? this.priority,
      topicId: topicId ?? this.topicId,
      resourceId: resourceId ?? this.resourceId,
      isDismissed: isDismissed ?? this.isDismissed,
      isAccepted: isAccepted ?? this.isAccepted,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<int>(topicId.value);
    }
    if (resourceId.present) {
      map['resource_id'] = Variable<int>(resourceId.value);
    }
    if (isDismissed.present) {
      map['is_dismissed'] = Variable<bool>(isDismissed.value);
    }
    if (isAccepted.present) {
      map['is_accepted'] = Variable<bool>(isAccepted.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecommendationsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('reason: $reason, ')
          ..write('priority: $priority, ')
          ..write('topicId: $topicId, ')
          ..write('resourceId: $resourceId, ')
          ..write('isDismissed: $isDismissed, ')
          ..write('isAccepted: $isAccepted, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MindMapsTable extends MindMaps with TableInfo<$MindMapsTable, MindMap> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MindMapsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<int> topicId = GeneratedColumn<int>(
    'topic_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topics (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
    'data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _layoutMeta = const VerificationMeta('layout');
  @override
  late final GeneratedColumn<String> layout = GeneratedColumn<String>(
    'layout',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isAiGeneratedMeta = const VerificationMeta(
    'isAiGenerated',
  );
  @override
  late final GeneratedColumn<bool> isAiGenerated = GeneratedColumn<bool>(
    'is_ai_generated',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_ai_generated" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    topicId,
    subjectId,
    data,
    layout,
    isAiGenerated,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mind_maps';
  @override
  VerificationContext validateIntegrity(
    Insertable<MindMap> instance, {
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
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('layout')) {
      context.handle(
        _layoutMeta,
        layout.isAcceptableOrUnknown(data['layout']!, _layoutMeta),
      );
    }
    if (data.containsKey('is_ai_generated')) {
      context.handle(
        _isAiGeneratedMeta,
        isAiGenerated.isAcceptableOrUnknown(
          data['is_ai_generated']!,
          _isAiGeneratedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MindMap map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MindMap(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}topic_id'],
      ),
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      ),
      data:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}data'],
          )!,
      layout: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}layout'],
      ),
      isAiGenerated:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_ai_generated'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $MindMapsTable createAlias(String alias) {
    return $MindMapsTable(attachedDatabase, alias);
  }
}

class MindMap extends DataClass implements Insertable<MindMap> {
  final int id;
  final String title;
  final String? description;
  final int? topicId;
  final int? subjectId;
  final String data;
  final String? layout;
  final bool isAiGenerated;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MindMap({
    required this.id,
    required this.title,
    this.description,
    this.topicId,
    this.subjectId,
    required this.data,
    this.layout,
    required this.isAiGenerated,
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
    if (!nullToAbsent || topicId != null) {
      map['topic_id'] = Variable<int>(topicId);
    }
    if (!nullToAbsent || subjectId != null) {
      map['subject_id'] = Variable<int>(subjectId);
    }
    map['data'] = Variable<String>(data);
    if (!nullToAbsent || layout != null) {
      map['layout'] = Variable<String>(layout);
    }
    map['is_ai_generated'] = Variable<bool>(isAiGenerated);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MindMapsCompanion toCompanion(bool nullToAbsent) {
    return MindMapsCompanion(
      id: Value(id),
      title: Value(title),
      description:
          description == null && nullToAbsent
              ? const Value.absent()
              : Value(description),
      topicId:
          topicId == null && nullToAbsent
              ? const Value.absent()
              : Value(topicId),
      subjectId:
          subjectId == null && nullToAbsent
              ? const Value.absent()
              : Value(subjectId),
      data: Value(data),
      layout:
          layout == null && nullToAbsent ? const Value.absent() : Value(layout),
      isAiGenerated: Value(isAiGenerated),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MindMap.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MindMap(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      topicId: serializer.fromJson<int?>(json['topicId']),
      subjectId: serializer.fromJson<int?>(json['subjectId']),
      data: serializer.fromJson<String>(json['data']),
      layout: serializer.fromJson<String?>(json['layout']),
      isAiGenerated: serializer.fromJson<bool>(json['isAiGenerated']),
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
      'topicId': serializer.toJson<int?>(topicId),
      'subjectId': serializer.toJson<int?>(subjectId),
      'data': serializer.toJson<String>(data),
      'layout': serializer.toJson<String?>(layout),
      'isAiGenerated': serializer.toJson<bool>(isAiGenerated),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MindMap copyWith({
    int? id,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<int?> topicId = const Value.absent(),
    Value<int?> subjectId = const Value.absent(),
    String? data,
    Value<String?> layout = const Value.absent(),
    bool? isAiGenerated,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MindMap(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    topicId: topicId.present ? topicId.value : this.topicId,
    subjectId: subjectId.present ? subjectId.value : this.subjectId,
    data: data ?? this.data,
    layout: layout.present ? layout.value : this.layout,
    isAiGenerated: isAiGenerated ?? this.isAiGenerated,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MindMap copyWithCompanion(MindMapsCompanion data) {
    return MindMap(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      data: data.data.present ? data.data.value : this.data,
      layout: data.layout.present ? data.layout.value : this.layout,
      isAiGenerated:
          data.isAiGenerated.present
              ? data.isAiGenerated.value
              : this.isAiGenerated,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MindMap(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('topicId: $topicId, ')
          ..write('subjectId: $subjectId, ')
          ..write('data: $data, ')
          ..write('layout: $layout, ')
          ..write('isAiGenerated: $isAiGenerated, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    topicId,
    subjectId,
    data,
    layout,
    isAiGenerated,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MindMap &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.topicId == this.topicId &&
          other.subjectId == this.subjectId &&
          other.data == this.data &&
          other.layout == this.layout &&
          other.isAiGenerated == this.isAiGenerated &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MindMapsCompanion extends UpdateCompanion<MindMap> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<int?> topicId;
  final Value<int?> subjectId;
  final Value<String> data;
  final Value<String?> layout;
  final Value<bool> isAiGenerated;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MindMapsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.topicId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.data = const Value.absent(),
    this.layout = const Value.absent(),
    this.isAiGenerated = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MindMapsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.topicId = const Value.absent(),
    this.subjectId = const Value.absent(),
    required String data,
    this.layout = const Value.absent(),
    this.isAiGenerated = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : title = Value(title),
       data = Value(data),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MindMap> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? topicId,
    Expression<int>? subjectId,
    Expression<String>? data,
    Expression<String>? layout,
    Expression<bool>? isAiGenerated,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (topicId != null) 'topic_id': topicId,
      if (subjectId != null) 'subject_id': subjectId,
      if (data != null) 'data': data,
      if (layout != null) 'layout': layout,
      if (isAiGenerated != null) 'is_ai_generated': isAiGenerated,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MindMapsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<int?>? topicId,
    Value<int?>? subjectId,
    Value<String>? data,
    Value<String?>? layout,
    Value<bool>? isAiGenerated,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MindMapsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      topicId: topicId ?? this.topicId,
      subjectId: subjectId ?? this.subjectId,
      data: data ?? this.data,
      layout: layout ?? this.layout,
      isAiGenerated: isAiGenerated ?? this.isAiGenerated,
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
    if (topicId.present) {
      map['topic_id'] = Variable<int>(topicId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (layout.present) {
      map['layout'] = Variable<String>(layout.value);
    }
    if (isAiGenerated.present) {
      map['is_ai_generated'] = Variable<bool>(isAiGenerated.value);
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
    return (StringBuffer('MindMapsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('topicId: $topicId, ')
          ..write('subjectId: $subjectId, ')
          ..write('data: $data, ')
          ..write('layout: $layout, ')
          ..write('isAiGenerated: $isAiGenerated, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $VideoTranscriptsTable extends VideoTranscripts
    with TableInfo<$VideoTranscriptsTable, VideoTranscript> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideoTranscriptsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _resourceIdMeta = const VerificationMeta(
    'resourceId',
  );
  @override
  late final GeneratedColumn<int> resourceId = GeneratedColumn<int>(
    'resource_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES learning_resources (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('en'),
  );
  static const VerificationMeta _fullTextMeta = const VerificationMeta(
    'fullText',
  );
  @override
  late final GeneratedColumn<String> fullText = GeneratedColumn<String>(
    'full_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _segmentsMeta = const VerificationMeta(
    'segments',
  );
  @override
  late final GeneratedColumn<String> segments = GeneratedColumn<String>(
    'segments',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _keyTopicsMeta = const VerificationMeta(
    'keyTopics',
  );
  @override
  late final GeneratedColumn<String> keyTopics = GeneratedColumn<String>(
    'key_topics',
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    resourceId,
    language,
    fullText,
    segments,
    summary,
    keyTopics,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_transcripts';
  @override
  VerificationContext validateIntegrity(
    Insertable<VideoTranscript> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('resource_id')) {
      context.handle(
        _resourceIdMeta,
        resourceId.isAcceptableOrUnknown(data['resource_id']!, _resourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_resourceIdMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('full_text')) {
      context.handle(
        _fullTextMeta,
        fullText.isAcceptableOrUnknown(data['full_text']!, _fullTextMeta),
      );
    } else if (isInserting) {
      context.missing(_fullTextMeta);
    }
    if (data.containsKey('segments')) {
      context.handle(
        _segmentsMeta,
        segments.isAcceptableOrUnknown(data['segments']!, _segmentsMeta),
      );
    } else if (isInserting) {
      context.missing(_segmentsMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    }
    if (data.containsKey('key_topics')) {
      context.handle(
        _keyTopicsMeta,
        keyTopics.isAcceptableOrUnknown(data['key_topics']!, _keyTopicsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoTranscript map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoTranscript(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      resourceId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}resource_id'],
          )!,
      language:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}language'],
          )!,
      fullText:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}full_text'],
          )!,
      segments:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}segments'],
          )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      ),
      keyTopics: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key_topics'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $VideoTranscriptsTable createAlias(String alias) {
    return $VideoTranscriptsTable(attachedDatabase, alias);
  }
}

class VideoTranscript extends DataClass implements Insertable<VideoTranscript> {
  final int id;
  final int resourceId;
  final String language;
  final String fullText;
  final String segments;
  final String? summary;
  final String? keyTopics;
  final DateTime createdAt;
  final DateTime updatedAt;
  const VideoTranscript({
    required this.id,
    required this.resourceId,
    required this.language,
    required this.fullText,
    required this.segments,
    this.summary,
    this.keyTopics,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['resource_id'] = Variable<int>(resourceId);
    map['language'] = Variable<String>(language);
    map['full_text'] = Variable<String>(fullText);
    map['segments'] = Variable<String>(segments);
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    if (!nullToAbsent || keyTopics != null) {
      map['key_topics'] = Variable<String>(keyTopics);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VideoTranscriptsCompanion toCompanion(bool nullToAbsent) {
    return VideoTranscriptsCompanion(
      id: Value(id),
      resourceId: Value(resourceId),
      language: Value(language),
      fullText: Value(fullText),
      segments: Value(segments),
      summary:
          summary == null && nullToAbsent
              ? const Value.absent()
              : Value(summary),
      keyTopics:
          keyTopics == null && nullToAbsent
              ? const Value.absent()
              : Value(keyTopics),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory VideoTranscript.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoTranscript(
      id: serializer.fromJson<int>(json['id']),
      resourceId: serializer.fromJson<int>(json['resourceId']),
      language: serializer.fromJson<String>(json['language']),
      fullText: serializer.fromJson<String>(json['fullText']),
      segments: serializer.fromJson<String>(json['segments']),
      summary: serializer.fromJson<String?>(json['summary']),
      keyTopics: serializer.fromJson<String?>(json['keyTopics']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'resourceId': serializer.toJson<int>(resourceId),
      'language': serializer.toJson<String>(language),
      'fullText': serializer.toJson<String>(fullText),
      'segments': serializer.toJson<String>(segments),
      'summary': serializer.toJson<String?>(summary),
      'keyTopics': serializer.toJson<String?>(keyTopics),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  VideoTranscript copyWith({
    int? id,
    int? resourceId,
    String? language,
    String? fullText,
    String? segments,
    Value<String?> summary = const Value.absent(),
    Value<String?> keyTopics = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => VideoTranscript(
    id: id ?? this.id,
    resourceId: resourceId ?? this.resourceId,
    language: language ?? this.language,
    fullText: fullText ?? this.fullText,
    segments: segments ?? this.segments,
    summary: summary.present ? summary.value : this.summary,
    keyTopics: keyTopics.present ? keyTopics.value : this.keyTopics,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  VideoTranscript copyWithCompanion(VideoTranscriptsCompanion data) {
    return VideoTranscript(
      id: data.id.present ? data.id.value : this.id,
      resourceId:
          data.resourceId.present ? data.resourceId.value : this.resourceId,
      language: data.language.present ? data.language.value : this.language,
      fullText: data.fullText.present ? data.fullText.value : this.fullText,
      segments: data.segments.present ? data.segments.value : this.segments,
      summary: data.summary.present ? data.summary.value : this.summary,
      keyTopics: data.keyTopics.present ? data.keyTopics.value : this.keyTopics,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VideoTranscript(')
          ..write('id: $id, ')
          ..write('resourceId: $resourceId, ')
          ..write('language: $language, ')
          ..write('fullText: $fullText, ')
          ..write('segments: $segments, ')
          ..write('summary: $summary, ')
          ..write('keyTopics: $keyTopics, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    resourceId,
    language,
    fullText,
    segments,
    summary,
    keyTopics,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoTranscript &&
          other.id == this.id &&
          other.resourceId == this.resourceId &&
          other.language == this.language &&
          other.fullText == this.fullText &&
          other.segments == this.segments &&
          other.summary == this.summary &&
          other.keyTopics == this.keyTopics &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VideoTranscriptsCompanion extends UpdateCompanion<VideoTranscript> {
  final Value<int> id;
  final Value<int> resourceId;
  final Value<String> language;
  final Value<String> fullText;
  final Value<String> segments;
  final Value<String?> summary;
  final Value<String?> keyTopics;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const VideoTranscriptsCompanion({
    this.id = const Value.absent(),
    this.resourceId = const Value.absent(),
    this.language = const Value.absent(),
    this.fullText = const Value.absent(),
    this.segments = const Value.absent(),
    this.summary = const Value.absent(),
    this.keyTopics = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  VideoTranscriptsCompanion.insert({
    this.id = const Value.absent(),
    required int resourceId,
    this.language = const Value.absent(),
    required String fullText,
    required String segments,
    this.summary = const Value.absent(),
    this.keyTopics = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : resourceId = Value(resourceId),
       fullText = Value(fullText),
       segments = Value(segments),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<VideoTranscript> custom({
    Expression<int>? id,
    Expression<int>? resourceId,
    Expression<String>? language,
    Expression<String>? fullText,
    Expression<String>? segments,
    Expression<String>? summary,
    Expression<String>? keyTopics,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (resourceId != null) 'resource_id': resourceId,
      if (language != null) 'language': language,
      if (fullText != null) 'full_text': fullText,
      if (segments != null) 'segments': segments,
      if (summary != null) 'summary': summary,
      if (keyTopics != null) 'key_topics': keyTopics,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  VideoTranscriptsCompanion copyWith({
    Value<int>? id,
    Value<int>? resourceId,
    Value<String>? language,
    Value<String>? fullText,
    Value<String>? segments,
    Value<String?>? summary,
    Value<String?>? keyTopics,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return VideoTranscriptsCompanion(
      id: id ?? this.id,
      resourceId: resourceId ?? this.resourceId,
      language: language ?? this.language,
      fullText: fullText ?? this.fullText,
      segments: segments ?? this.segments,
      summary: summary ?? this.summary,
      keyTopics: keyTopics ?? this.keyTopics,
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
    if (resourceId.present) {
      map['resource_id'] = Variable<int>(resourceId.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (fullText.present) {
      map['full_text'] = Variable<String>(fullText.value);
    }
    if (segments.present) {
      map['segments'] = Variable<String>(segments.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (keyTopics.present) {
      map['key_topics'] = Variable<String>(keyTopics.value);
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
    return (StringBuffer('VideoTranscriptsCompanion(')
          ..write('id: $id, ')
          ..write('resourceId: $resourceId, ')
          ..write('language: $language, ')
          ..write('fullText: $fullText, ')
          ..write('segments: $segments, ')
          ..write('summary: $summary, ')
          ..write('keyTopics: $keyTopics, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ConversationsTable conversations = $ConversationsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $QuizHistoryTable quizHistory = $QuizHistoryTable(this);
  late final $LearningActivityTable learningActivity = $LearningActivityTable(
    this,
  );
  late final $AppModelsTable appModels = $AppModelsTable(this);
  late final $PreferencesTable preferences = $PreferencesTable(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $MemoriesTable memories = $MemoriesTable(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $ChaptersTable chapters = $ChaptersTable(this);
  late final $TopicsTable topics = $TopicsTable(this);
  late final $LearningResourcesTable learningResources =
      $LearningResourcesTable(this);
  late final $FlashcardDecksTable flashcardDecks = $FlashcardDecksTable(this);
  late final $FlashcardsTable flashcards = $FlashcardsTable(this);
  late final $FlashcardReviewsTable flashcardReviews = $FlashcardReviewsTable(
    this,
  );
  late final $StudyPlansTable studyPlans = $StudyPlansTable(this);
  late final $StudyPlanItemsTable studyPlanItems = $StudyPlanItemsTable(this);
  late final $StudySessionsTable studySessions = $StudySessionsTable(this);
  late final $ExamSchedulesTable examSchedules = $ExamSchedulesTable(this);
  late final $AchievementsTable achievements = $AchievementsTable(this);
  late final $UserAchievementsTable userAchievements = $UserAchievementsTable(
    this,
  );
  late final $NotificationsTable notifications = $NotificationsTable(this);
  late final $RecommendationsTable recommendations = $RecommendationsTable(
    this,
  );
  late final $MindMapsTable mindMaps = $MindMapsTable(this);
  late final $VideoTranscriptsTable videoTranscripts = $VideoTranscriptsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    conversations,
    messages,
    notes,
    bookmarks,
    quizHistory,
    learningActivity,
    appModels,
    preferences,
    documents,
    memories,
    subjects,
    chapters,
    topics,
    learningResources,
    flashcardDecks,
    flashcards,
    flashcardReviews,
    studyPlans,
    studyPlanItems,
    studySessions,
    examSchedules,
    achievements,
    userAchievements,
    notifications,
    recommendations,
    mindMaps,
    videoTranscripts,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'conversations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('messages', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'messages',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('bookmarks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'conversations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('memories', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('chapters', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'chapters',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('topics', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'topics',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('learning_resources', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('learning_resources', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('flashcard_decks', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'topics',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('flashcard_decks', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'flashcard_decks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('flashcards', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'flashcards',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('flashcard_reviews', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('study_plan_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'topics',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('study_plan_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'learning_resources',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('study_plan_items', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('study_sessions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_plan_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('study_sessions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'topics',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('study_sessions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'achievements',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_achievements', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'topics',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recommendations', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'learning_resources',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recommendations', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'topics',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('mind_maps', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('mind_maps', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'learning_resources',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('video_transcripts', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ConversationsTableCreateCompanionBuilder =
    ConversationsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> mode,
      Value<String?> context,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> isPinned,
      Value<int> messageCount,
    });
typedef $$ConversationsTableUpdateCompanionBuilder =
    ConversationsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> mode,
      Value<String?> context,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isPinned,
      Value<int> messageCount,
    });

final class $$ConversationsTableReferences
    extends BaseReferences<_$AppDatabase, $ConversationsTable, Conversation> {
  $$ConversationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$MessagesTable, List<Message>> _messagesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.messages,
    aliasName: 'conversations__id__messages__conversation_id',
  );

  $$MessagesTableProcessedTableManager get messagesRefs {
    final manager = $$MessagesTableTableManager(
      $_db,
      $_db.messages,
    ).filter((f) => f.conversationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_messagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MemoriesTable, List<Memory>> _memoriesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.memories,
    aliasName: 'conversations__id__memories__conversation_id',
  );

  $$MemoriesTableProcessedTableManager get memoriesRefs {
    final manager = $$MemoriesTableTableManager(
      $_db,
      $_db.memories,
    ).filter((f) => f.conversationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_memoriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get context => $composableBuilder(
    column: $table.context,
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

  ColumnFilters<bool> get isPinned => $composableBuilder(
    column: $table.isPinned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get messageCount => $composableBuilder(
    column: $table.messageCount,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> messagesRefs(
    Expression<bool> Function($$MessagesTableFilterComposer f) f,
  ) {
    final $$MessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.conversationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessagesTableFilterComposer(
            $db: $db,
            $table: $db.messages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> memoriesRefs(
    Expression<bool> Function($$MemoriesTableFilterComposer f) f,
  ) {
    final $$MemoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.memories,
      getReferencedColumn: (t) => t.conversationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemoriesTableFilterComposer(
            $db: $db,
            $table: $db.memories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get context => $composableBuilder(
    column: $table.context,
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

  ColumnOrderings<bool> get isPinned => $composableBuilder(
    column: $table.isPinned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get messageCount => $composableBuilder(
    column: $table.messageCount,
    builder: (column) => ColumnOrderings(column),
  );
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

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get context =>
      $composableBuilder(column: $table.context, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isPinned =>
      $composableBuilder(column: $table.isPinned, builder: (column) => column);

  GeneratedColumn<int> get messageCount => $composableBuilder(
    column: $table.messageCount,
    builder: (column) => column,
  );

  Expression<T> messagesRefs<T extends Object>(
    Expression<T> Function($$MessagesTableAnnotationComposer a) f,
  ) {
    final $$MessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.conversationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.messages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> memoriesRefs<T extends Object>(
    Expression<T> Function($$MemoriesTableAnnotationComposer a) f,
  ) {
    final $$MemoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.memories,
      getReferencedColumn: (t) => t.conversationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.memories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
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
          PrefetchHooks Function({bool messagesRefs, bool memoriesRefs})
        > {
  $$ConversationsTableTableManager(_$AppDatabase db, $ConversationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ConversationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$ConversationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ConversationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> mode = const Value.absent(),
                Value<String?> context = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isPinned = const Value.absent(),
                Value<int> messageCount = const Value.absent(),
              }) => ConversationsCompanion(
                id: id,
                title: title,
                mode: mode,
                context: context,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isPinned: isPinned,
                messageCount: messageCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> mode = const Value.absent(),
                Value<String?> context = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> isPinned = const Value.absent(),
                Value<int> messageCount = const Value.absent(),
              }) => ConversationsCompanion.insert(
                id: id,
                title: title,
                mode: mode,
                context: context,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isPinned: isPinned,
                messageCount: messageCount,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$ConversationsTable, Conversation>(table),
                          $$ConversationsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            messagesRefs = false,
            memoriesRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (messagesRefs) db.messages,
                if (memoriesRefs) db.memories,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (messagesRefs)
                    await $_getPrefetchedDataByColumns<
                      Conversation,
                      $ConversationsTable,
                      Message,
                      $MessagesTable
                    >(
                      currentTable: table,
                      referencedTable: $$ConversationsTableReferences
                          ._messagesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$ConversationsTableReferences(
                                db,
                                table,
                                p0,
                              ).messagesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'conversation_id',
                      typedResults: items,
                    ),
                  if (memoriesRefs)
                    await $_getPrefetchedDataByColumns<
                      Conversation,
                      $ConversationsTable,
                      Memory,
                      $MemoriesTable
                    >(
                      currentTable: table,
                      referencedTable: $$ConversationsTableReferences
                          ._memoriesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$ConversationsTableReferences(
                                db,
                                table,
                                p0,
                              ).memoriesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'conversation_id',
                      typedResults: items,
                    ),
                ];
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
      PrefetchHooks Function({bool messagesRefs, bool memoriesRefs})
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> id,
      required int conversationId,
      required String role,
      required String content,
      required DateTime createdAt,
      Value<bool> isEdited,
      Value<bool> isBookmarked,
      Value<int?> tokenCount,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> id,
      Value<int> conversationId,
      Value<String> role,
      Value<String> content,
      Value<DateTime> createdAt,
      Value<bool> isEdited,
      Value<bool> isBookmarked,
      Value<int?> tokenCount,
    });

final class $$MessagesTableReferences
    extends BaseReferences<_$AppDatabase, $MessagesTable, Message> {
  $$MessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ConversationsTable _conversationIdTable(_$AppDatabase db) => db
      .conversations
      .createAlias('messages__conversation_id__conversations__id');

  $$ConversationsTableProcessedTableManager get conversationId {
    final $_column = $_itemColumn<int>('conversation_id')!;

    final manager = $$ConversationsTableTableManager(
      $_db,
      $_db.conversations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BookmarksTable, List<Bookmark>>
  _bookmarksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bookmarks,
    aliasName: 'messages__id__bookmarks__message_id',
  );

  $$BookmarksTableProcessedTableManager get bookmarksRefs {
    final manager = $$BookmarksTableTableManager(
      $_db,
      $_db.bookmarks,
    ).filter((f) => f.messageId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bookmarksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
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

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEdited => $composableBuilder(
    column: $table.isEdited,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBookmarked => $composableBuilder(
    column: $table.isBookmarked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tokenCount => $composableBuilder(
    column: $table.tokenCount,
    builder: (column) => ColumnFilters(column),
  );

  $$ConversationsTableFilterComposer get conversationId {
    final $$ConversationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.conversations,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  Expression<bool> bookmarksRefs(
    Expression<bool> Function($$BookmarksTableFilterComposer f) f,
  ) {
    final $$BookmarksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookmarks,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarksTableFilterComposer(
            $db: $db,
            $table: $db.bookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEdited => $composableBuilder(
    column: $table.isEdited,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBookmarked => $composableBuilder(
    column: $table.isBookmarked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tokenCount => $composableBuilder(
    column: $table.tokenCount,
    builder: (column) => ColumnOrderings(column),
  );

  $$ConversationsTableOrderingComposer get conversationId {
    final $$ConversationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.conversations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConversationsTableOrderingComposer(
            $db: $db,
            $table: $db.conversations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isEdited =>
      $composableBuilder(column: $table.isEdited, builder: (column) => column);

  GeneratedColumn<bool> get isBookmarked => $composableBuilder(
    column: $table.isBookmarked,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tokenCount => $composableBuilder(
    column: $table.tokenCount,
    builder: (column) => column,
  );

  $$ConversationsTableAnnotationComposer get conversationId {
    final $$ConversationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.conversations,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  Expression<T> bookmarksRefs<T extends Object>(
    Expression<T> Function($$BookmarksTableAnnotationComposer a) f,
  ) {
    final $$BookmarksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookmarks,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarksTableAnnotationComposer(
            $db: $db,
            $table: $db.bookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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
          (Message, $$MessagesTableReferences),
          Message,
          PrefetchHooks Function({bool conversationId, bool bookmarksRefs})
        > {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> conversationId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isEdited = const Value.absent(),
                Value<bool> isBookmarked = const Value.absent(),
                Value<int?> tokenCount = const Value.absent(),
              }) => MessagesCompanion(
                id: id,
                conversationId: conversationId,
                role: role,
                content: content,
                createdAt: createdAt,
                isEdited: isEdited,
                isBookmarked: isBookmarked,
                tokenCount: tokenCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int conversationId,
                required String role,
                required String content,
                required DateTime createdAt,
                Value<bool> isEdited = const Value.absent(),
                Value<bool> isBookmarked = const Value.absent(),
                Value<int?> tokenCount = const Value.absent(),
              }) => MessagesCompanion.insert(
                id: id,
                conversationId: conversationId,
                role: role,
                content: content,
                createdAt: createdAt,
                isEdited: isEdited,
                isBookmarked: isBookmarked,
                tokenCount: tokenCount,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$MessagesTable, Message>(table),
                          $$MessagesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            conversationId = false,
            bookmarksRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (bookmarksRefs) db.bookmarks],
              addJoins: <
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
                if (conversationId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.conversationId,
                            referencedTable: $$MessagesTableReferences
                                ._conversationIdTable(db),
                            referencedColumn:
                                $$MessagesTableReferences
                                    ._conversationIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bookmarksRefs)
                    await $_getPrefetchedDataByColumns<
                      Message,
                      $MessagesTable,
                      Bookmark,
                      $BookmarksTable
                    >(
                      currentTable: table,
                      referencedTable: $$MessagesTableReferences
                          ._bookmarksRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$MessagesTableReferences(
                                db,
                                table,
                                p0,
                              ).bookmarksRefs,
                      currentColumn: 'id',
                      referencedColumn: 'message_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
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
      (Message, $$MessagesTableReferences),
      Message,
      PrefetchHooks Function({bool conversationId, bool bookmarksRefs})
    >;
typedef $$NotesTableCreateCompanionBuilder =
    NotesCompanion Function({
      Value<int> id,
      required String title,
      required String content,
      Value<String?> folder,
      Value<String?> subject,
      Value<String?> classLevel,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> isPinned,
      Value<String?> tags,
    });
typedef $$NotesTableUpdateCompanionBuilder =
    NotesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> content,
      Value<String?> folder,
      Value<String?> subject,
      Value<String?> classLevel,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isPinned,
      Value<String?> tags,
    });

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
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

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get folder => $composableBuilder(
    column: $table.folder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classLevel => $composableBuilder(
    column: $table.classLevel,
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

  ColumnFilters<bool> get isPinned => $composableBuilder(
    column: $table.isPinned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
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

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get folder => $composableBuilder(
    column: $table.folder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classLevel => $composableBuilder(
    column: $table.classLevel,
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

  ColumnOrderings<bool> get isPinned => $composableBuilder(
    column: $table.isPinned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
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

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get folder =>
      $composableBuilder(column: $table.folder, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get classLevel => $composableBuilder(
    column: $table.classLevel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isPinned =>
      $composableBuilder(column: $table.isPinned, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);
}

class $$NotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotesTable,
          Note,
          $$NotesTableFilterComposer,
          $$NotesTableOrderingComposer,
          $$NotesTableAnnotationComposer,
          $$NotesTableCreateCompanionBuilder,
          $$NotesTableUpdateCompanionBuilder,
          (Note, BaseReferences<_$AppDatabase, $NotesTable, Note>),
          Note,
          PrefetchHooks Function()
        > {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> folder = const Value.absent(),
                Value<String?> subject = const Value.absent(),
                Value<String?> classLevel = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isPinned = const Value.absent(),
                Value<String?> tags = const Value.absent(),
              }) => NotesCompanion(
                id: id,
                title: title,
                content: content,
                folder: folder,
                subject: subject,
                classLevel: classLevel,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isPinned: isPinned,
                tags: tags,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String content,
                Value<String?> folder = const Value.absent(),
                Value<String?> subject = const Value.absent(),
                Value<String?> classLevel = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> isPinned = const Value.absent(),
                Value<String?> tags = const Value.absent(),
              }) => NotesCompanion.insert(
                id: id,
                title: title,
                content: content,
                folder: folder,
                subject: subject,
                classLevel: classLevel,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isPinned: isPinned,
                tags: tags,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$NotesTable, Note>(table),
                          BaseReferences<_$AppDatabase, $NotesTable, Note>(
                            db,
                            table,
                            e,
                          ),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotesTable,
      Note,
      $$NotesTableFilterComposer,
      $$NotesTableOrderingComposer,
      $$NotesTableAnnotationComposer,
      $$NotesTableCreateCompanionBuilder,
      $$NotesTableUpdateCompanionBuilder,
      (Note, BaseReferences<_$AppDatabase, $NotesTable, Note>),
      Note,
      PrefetchHooks Function()
    >;
typedef $$BookmarksTableCreateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      required int messageId,
      required DateTime createdAt,
    });
typedef $$BookmarksTableUpdateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      Value<int> messageId,
      Value<DateTime> createdAt,
    });

final class $$BookmarksTableReferences
    extends BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark> {
  $$BookmarksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MessagesTable _messageIdTable(_$AppDatabase db) =>
      db.messages.createAlias('bookmarks__message_id__messages__id');

  $$MessagesTableProcessedTableManager get messageId {
    final $_column = $_itemColumn<int>('message_id')!;

    final manager = $$MessagesTableTableManager(
      $_db,
      $_db.messages,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_messageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MessagesTableFilterComposer get messageId {
    final $$MessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessagesTableFilterComposer(
            $db: $db,
            $table: $db.messages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MessagesTableOrderingComposer get messageId {
    final $$MessagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessagesTableOrderingComposer(
            $db: $db,
            $table: $db.messages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MessagesTableAnnotationComposer get messageId {
    final $$MessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.messages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarksTable,
          Bookmark,
          $$BookmarksTableFilterComposer,
          $$BookmarksTableOrderingComposer,
          $$BookmarksTableAnnotationComposer,
          $$BookmarksTableCreateCompanionBuilder,
          $$BookmarksTableUpdateCompanionBuilder,
          (Bookmark, $$BookmarksTableReferences),
          Bookmark,
          PrefetchHooks Function({bool messageId})
        > {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> messageId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BookmarksCompanion(
                id: id,
                messageId: messageId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int messageId,
                required DateTime createdAt,
              }) => BookmarksCompanion.insert(
                id: id,
                messageId: messageId,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$BookmarksTable, Bookmark>(table),
                          $$BookmarksTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({messageId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (messageId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.messageId,
                            referencedTable: $$BookmarksTableReferences
                                ._messageIdTable(db),
                            referencedColumn:
                                $$BookmarksTableReferences
                                    ._messageIdTable(db)
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

typedef $$BookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarksTable,
      Bookmark,
      $$BookmarksTableFilterComposer,
      $$BookmarksTableOrderingComposer,
      $$BookmarksTableAnnotationComposer,
      $$BookmarksTableCreateCompanionBuilder,
      $$BookmarksTableUpdateCompanionBuilder,
      (Bookmark, $$BookmarksTableReferences),
      Bookmark,
      PrefetchHooks Function({bool messageId})
    >;
typedef $$QuizHistoryTableCreateCompanionBuilder =
    QuizHistoryCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> subject,
      Value<String?> classLevel,
      required int totalQuestions,
      required int correctAnswers,
      required int score,
      required int durationSeconds,
      required DateTime createdAt,
    });
typedef $$QuizHistoryTableUpdateCompanionBuilder =
    QuizHistoryCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> subject,
      Value<String?> classLevel,
      Value<int> totalQuestions,
      Value<int> correctAnswers,
      Value<int> score,
      Value<int> durationSeconds,
      Value<DateTime> createdAt,
    });

class $$QuizHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $QuizHistoryTable> {
  $$QuizHistoryTableFilterComposer({
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

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classLevel => $composableBuilder(
    column: $table.classLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QuizHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $QuizHistoryTable> {
  $$QuizHistoryTableOrderingComposer({
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

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classLevel => $composableBuilder(
    column: $table.classLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuizHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuizHistoryTable> {
  $$QuizHistoryTableAnnotationComposer({
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

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get classLevel => $composableBuilder(
    column: $table.classLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => column,
  );

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$QuizHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuizHistoryTable,
          QuizHistoryData,
          $$QuizHistoryTableFilterComposer,
          $$QuizHistoryTableOrderingComposer,
          $$QuizHistoryTableAnnotationComposer,
          $$QuizHistoryTableCreateCompanionBuilder,
          $$QuizHistoryTableUpdateCompanionBuilder,
          (
            QuizHistoryData,
            BaseReferences<_$AppDatabase, $QuizHistoryTable, QuizHistoryData>,
          ),
          QuizHistoryData,
          PrefetchHooks Function()
        > {
  $$QuizHistoryTableTableManager(_$AppDatabase db, $QuizHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$QuizHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$QuizHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$QuizHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> subject = const Value.absent(),
                Value<String?> classLevel = const Value.absent(),
                Value<int> totalQuestions = const Value.absent(),
                Value<int> correctAnswers = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => QuizHistoryCompanion(
                id: id,
                title: title,
                subject: subject,
                classLevel: classLevel,
                totalQuestions: totalQuestions,
                correctAnswers: correctAnswers,
                score: score,
                durationSeconds: durationSeconds,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> subject = const Value.absent(),
                Value<String?> classLevel = const Value.absent(),
                required int totalQuestions,
                required int correctAnswers,
                required int score,
                required int durationSeconds,
                required DateTime createdAt,
              }) => QuizHistoryCompanion.insert(
                id: id,
                title: title,
                subject: subject,
                classLevel: classLevel,
                totalQuestions: totalQuestions,
                correctAnswers: correctAnswers,
                score: score,
                durationSeconds: durationSeconds,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$QuizHistoryTable, QuizHistoryData>(
                            table,
                          ),
                          BaseReferences<
                            _$AppDatabase,
                            $QuizHistoryTable,
                            QuizHistoryData
                          >(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QuizHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuizHistoryTable,
      QuizHistoryData,
      $$QuizHistoryTableFilterComposer,
      $$QuizHistoryTableOrderingComposer,
      $$QuizHistoryTableAnnotationComposer,
      $$QuizHistoryTableCreateCompanionBuilder,
      $$QuizHistoryTableUpdateCompanionBuilder,
      (
        QuizHistoryData,
        BaseReferences<_$AppDatabase, $QuizHistoryTable, QuizHistoryData>,
      ),
      QuizHistoryData,
      PrefetchHooks Function()
    >;
typedef $$LearningActivityTableCreateCompanionBuilder =
    LearningActivityCompanion Function({
      Value<int> id,
      required String activityType,
      Value<String?> subject,
      Value<String?> classLevel,
      required int durationMinutes,
      required DateTime date,
    });
typedef $$LearningActivityTableUpdateCompanionBuilder =
    LearningActivityCompanion Function({
      Value<int> id,
      Value<String> activityType,
      Value<String?> subject,
      Value<String?> classLevel,
      Value<int> durationMinutes,
      Value<DateTime> date,
    });

class $$LearningActivityTableFilterComposer
    extends Composer<_$AppDatabase, $LearningActivityTable> {
  $$LearningActivityTableFilterComposer({
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

  ColumnFilters<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classLevel => $composableBuilder(
    column: $table.classLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LearningActivityTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningActivityTable> {
  $$LearningActivityTableOrderingComposer({
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

  ColumnOrderings<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classLevel => $composableBuilder(
    column: $table.classLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LearningActivityTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningActivityTable> {
  $$LearningActivityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get classLevel => $composableBuilder(
    column: $table.classLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$LearningActivityTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningActivityTable,
          LearningActivityData,
          $$LearningActivityTableFilterComposer,
          $$LearningActivityTableOrderingComposer,
          $$LearningActivityTableAnnotationComposer,
          $$LearningActivityTableCreateCompanionBuilder,
          $$LearningActivityTableUpdateCompanionBuilder,
          (
            LearningActivityData,
            BaseReferences<
              _$AppDatabase,
              $LearningActivityTable,
              LearningActivityData
            >,
          ),
          LearningActivityData,
          PrefetchHooks Function()
        > {
  $$LearningActivityTableTableManager(
    _$AppDatabase db,
    $LearningActivityTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$LearningActivityTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LearningActivityTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$LearningActivityTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> activityType = const Value.absent(),
                Value<String?> subject = const Value.absent(),
                Value<String?> classLevel = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
              }) => LearningActivityCompanion(
                id: id,
                activityType: activityType,
                subject: subject,
                classLevel: classLevel,
                durationMinutes: durationMinutes,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String activityType,
                Value<String?> subject = const Value.absent(),
                Value<String?> classLevel = const Value.absent(),
                required int durationMinutes,
                required DateTime date,
              }) => LearningActivityCompanion.insert(
                id: id,
                activityType: activityType,
                subject: subject,
                classLevel: classLevel,
                durationMinutes: durationMinutes,
                date: date,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<
                            $LearningActivityTable,
                            LearningActivityData
                          >(table),
                          BaseReferences<
                            _$AppDatabase,
                            $LearningActivityTable,
                            LearningActivityData
                          >(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LearningActivityTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningActivityTable,
      LearningActivityData,
      $$LearningActivityTableFilterComposer,
      $$LearningActivityTableOrderingComposer,
      $$LearningActivityTableAnnotationComposer,
      $$LearningActivityTableCreateCompanionBuilder,
      $$LearningActivityTableUpdateCompanionBuilder,
      (
        LearningActivityData,
        BaseReferences<
          _$AppDatabase,
          $LearningActivityTable,
          LearningActivityData
        >,
      ),
      LearningActivityData,
      PrefetchHooks Function()
    >;
typedef $$AppModelsTableCreateCompanionBuilder =
    AppModelsCompanion Function({
      Value<int> id,
      required String name,
      required String filePath,
      Value<String?> quantization,
      required int sizeBytes,
      Value<String?> architecture,
      Value<bool> isActive,
      required DateTime installedAt,
    });
typedef $$AppModelsTableUpdateCompanionBuilder =
    AppModelsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> filePath,
      Value<String?> quantization,
      Value<int> sizeBytes,
      Value<String?> architecture,
      Value<bool> isActive,
      Value<DateTime> installedAt,
    });

class $$AppModelsTableFilterComposer
    extends Composer<_$AppDatabase, $AppModelsTable> {
  $$AppModelsTableFilterComposer({
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

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quantization => $composableBuilder(
    column: $table.quantization,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get architecture => $composableBuilder(
    column: $table.architecture,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get installedAt => $composableBuilder(
    column: $table.installedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppModelsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppModelsTable> {
  $$AppModelsTableOrderingComposer({
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

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quantization => $composableBuilder(
    column: $table.quantization,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get architecture => $composableBuilder(
    column: $table.architecture,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get installedAt => $composableBuilder(
    column: $table.installedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppModelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppModelsTable> {
  $$AppModelsTableAnnotationComposer({
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

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get quantization => $composableBuilder(
    column: $table.quantization,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<String> get architecture => $composableBuilder(
    column: $table.architecture,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get installedAt => $composableBuilder(
    column: $table.installedAt,
    builder: (column) => column,
  );
}

class $$AppModelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppModelsTable,
          AppModel,
          $$AppModelsTableFilterComposer,
          $$AppModelsTableOrderingComposer,
          $$AppModelsTableAnnotationComposer,
          $$AppModelsTableCreateCompanionBuilder,
          $$AppModelsTableUpdateCompanionBuilder,
          (AppModel, BaseReferences<_$AppDatabase, $AppModelsTable, AppModel>),
          AppModel,
          PrefetchHooks Function()
        > {
  $$AppModelsTableTableManager(_$AppDatabase db, $AppModelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AppModelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AppModelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$AppModelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String?> quantization = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<String?> architecture = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> installedAt = const Value.absent(),
              }) => AppModelsCompanion(
                id: id,
                name: name,
                filePath: filePath,
                quantization: quantization,
                sizeBytes: sizeBytes,
                architecture: architecture,
                isActive: isActive,
                installedAt: installedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String filePath,
                Value<String?> quantization = const Value.absent(),
                required int sizeBytes,
                Value<String?> architecture = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime installedAt,
              }) => AppModelsCompanion.insert(
                id: id,
                name: name,
                filePath: filePath,
                quantization: quantization,
                sizeBytes: sizeBytes,
                architecture: architecture,
                isActive: isActive,
                installedAt: installedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$AppModelsTable, AppModel>(table),
                          BaseReferences<
                            _$AppDatabase,
                            $AppModelsTable,
                            AppModel
                          >(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppModelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppModelsTable,
      AppModel,
      $$AppModelsTableFilterComposer,
      $$AppModelsTableOrderingComposer,
      $$AppModelsTableAnnotationComposer,
      $$AppModelsTableCreateCompanionBuilder,
      $$AppModelsTableUpdateCompanionBuilder,
      (AppModel, BaseReferences<_$AppDatabase, $AppModelsTable, AppModel>),
      AppModel,
      PrefetchHooks Function()
    >;
typedef $$PreferencesTableCreateCompanionBuilder =
    PreferencesCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$PreferencesTableUpdateCompanionBuilder =
    PreferencesCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$PreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $PreferencesTable> {
  $$PreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $PreferencesTable> {
  $$PreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PreferencesTable> {
  $$PreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$PreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PreferencesTable,
          Preference,
          $$PreferencesTableFilterComposer,
          $$PreferencesTableOrderingComposer,
          $$PreferencesTableAnnotationComposer,
          $$PreferencesTableCreateCompanionBuilder,
          $$PreferencesTableUpdateCompanionBuilder,
          (
            Preference,
            BaseReferences<_$AppDatabase, $PreferencesTable, Preference>,
          ),
          Preference,
          PrefetchHooks Function()
        > {
  $$PreferencesTableTableManager(_$AppDatabase db, $PreferencesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$PreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PreferencesCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => PreferencesCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$PreferencesTable, Preference>(table),
                          BaseReferences<
                            _$AppDatabase,
                            $PreferencesTable,
                            Preference
                          >(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PreferencesTable,
      Preference,
      $$PreferencesTableFilterComposer,
      $$PreferencesTableOrderingComposer,
      $$PreferencesTableAnnotationComposer,
      $$PreferencesTableCreateCompanionBuilder,
      $$PreferencesTableUpdateCompanionBuilder,
      (
        Preference,
        BaseReferences<_$AppDatabase, $PreferencesTable, Preference>,
      ),
      Preference,
      PrefetchHooks Function()
    >;
typedef $$DocumentsTableCreateCompanionBuilder =
    DocumentsCompanion Function({
      Value<int> id,
      required String title,
      required String filePath,
      required String fileType,
      required int sizeBytes,
      Value<String?> extractedText,
      Value<String?> summary,
      required DateTime importedAt,
    });
typedef $$DocumentsTableUpdateCompanionBuilder =
    DocumentsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> filePath,
      Value<String> fileType,
      Value<int> sizeBytes,
      Value<String?> extractedText,
      Value<String?> summary,
      Value<DateTime> importedAt,
    });

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
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

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileType => $composableBuilder(
    column: $table.fileType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extractedText => $composableBuilder(
    column: $table.extractedText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
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

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileType => $composableBuilder(
    column: $table.fileType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extractedText => $composableBuilder(
    column: $table.extractedText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
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

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get fileType =>
      $composableBuilder(column: $table.fileType, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<String> get extractedText => $composableBuilder(
    column: $table.extractedText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => column,
  );
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTable,
          Document,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (Document, BaseReferences<_$AppDatabase, $DocumentsTable, Document>),
          Document,
          PrefetchHooks Function()
        > {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String> fileType = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<String?> extractedText = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<DateTime> importedAt = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                title: title,
                filePath: filePath,
                fileType: fileType,
                sizeBytes: sizeBytes,
                extractedText: extractedText,
                summary: summary,
                importedAt: importedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String filePath,
                required String fileType,
                required int sizeBytes,
                Value<String?> extractedText = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                required DateTime importedAt,
              }) => DocumentsCompanion.insert(
                id: id,
                title: title,
                filePath: filePath,
                fileType: fileType,
                sizeBytes: sizeBytes,
                extractedText: extractedText,
                summary: summary,
                importedAt: importedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$DocumentsTable, Document>(table),
                          BaseReferences<
                            _$AppDatabase,
                            $DocumentsTable,
                            Document
                          >(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTable,
      Document,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (Document, BaseReferences<_$AppDatabase, $DocumentsTable, Document>),
      Document,
      PrefetchHooks Function()
    >;
typedef $$MemoriesTableCreateCompanionBuilder =
    MemoriesCompanion Function({
      Value<int> id,
      required int conversationId,
      required String type,
      required String content,
      Value<double> importance,
      required DateTime createdAt,
    });
typedef $$MemoriesTableUpdateCompanionBuilder =
    MemoriesCompanion Function({
      Value<int> id,
      Value<int> conversationId,
      Value<String> type,
      Value<String> content,
      Value<double> importance,
      Value<DateTime> createdAt,
    });

final class $$MemoriesTableReferences
    extends BaseReferences<_$AppDatabase, $MemoriesTable, Memory> {
  $$MemoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ConversationsTable _conversationIdTable(_$AppDatabase db) => db
      .conversations
      .createAlias('memories__conversation_id__conversations__id');

  $$ConversationsTableProcessedTableManager get conversationId {
    final $_column = $_itemColumn<int>('conversation_id')!;

    final manager = $$ConversationsTableTableManager(
      $_db,
      $_db.conversations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MemoriesTableFilterComposer
    extends Composer<_$AppDatabase, $MemoriesTable> {
  $$MemoriesTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ConversationsTableFilterComposer get conversationId {
    final $$ConversationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.conversations,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }
}

class $$MemoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MemoriesTable> {
  $$MemoriesTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ConversationsTableOrderingComposer get conversationId {
    final $$ConversationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.conversations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConversationsTableOrderingComposer(
            $db: $db,
            $table: $db.conversations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MemoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MemoriesTable> {
  $$MemoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<double> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ConversationsTableAnnotationComposer get conversationId {
    final $$ConversationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.conversations,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }
}

class $$MemoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MemoriesTable,
          Memory,
          $$MemoriesTableFilterComposer,
          $$MemoriesTableOrderingComposer,
          $$MemoriesTableAnnotationComposer,
          $$MemoriesTableCreateCompanionBuilder,
          $$MemoriesTableUpdateCompanionBuilder,
          (Memory, $$MemoriesTableReferences),
          Memory,
          PrefetchHooks Function({bool conversationId})
        > {
  $$MemoriesTableTableManager(_$AppDatabase db, $MemoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MemoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$MemoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$MemoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> conversationId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<double> importance = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MemoriesCompanion(
                id: id,
                conversationId: conversationId,
                type: type,
                content: content,
                importance: importance,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int conversationId,
                required String type,
                required String content,
                Value<double> importance = const Value.absent(),
                required DateTime createdAt,
              }) => MemoriesCompanion.insert(
                id: id,
                conversationId: conversationId,
                type: type,
                content: content,
                importance: importance,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$MemoriesTable, Memory>(table),
                          $$MemoriesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({conversationId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (conversationId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.conversationId,
                            referencedTable: $$MemoriesTableReferences
                                ._conversationIdTable(db),
                            referencedColumn:
                                $$MemoriesTableReferences
                                    ._conversationIdTable(db)
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

typedef $$MemoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MemoriesTable,
      Memory,
      $$MemoriesTableFilterComposer,
      $$MemoriesTableOrderingComposer,
      $$MemoriesTableAnnotationComposer,
      $$MemoriesTableCreateCompanionBuilder,
      $$MemoriesTableUpdateCompanionBuilder,
      (Memory, $$MemoriesTableReferences),
      Memory,
      PrefetchHooks Function({bool conversationId})
    >;
typedef $$SubjectsTableCreateCompanionBuilder =
    SubjectsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<String?> icon,
      Value<String?> color,
      Value<int> sortOrder,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$SubjectsTableUpdateCompanionBuilder =
    SubjectsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String?> icon,
      Value<String?> color,
      Value<int> sortOrder,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$SubjectsTableReferences
    extends BaseReferences<_$AppDatabase, $SubjectsTable, Subject> {
  $$SubjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChaptersTable, List<Chapter>> _chaptersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.chapters,
    aliasName: 'subjects__id__chapters__subject_id',
  );

  $$ChaptersTableProcessedTableManager get chaptersRefs {
    final manager = $$ChaptersTableTableManager(
      $_db,
      $_db.chapters,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_chaptersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LearningResourcesTable, List<LearningResource>>
  _learningResourcesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.learningResources,
        aliasName: 'subjects__id__learning_resources__subject_id',
      );

  $$LearningResourcesTableProcessedTableManager get learningResourcesRefs {
    final manager = $$LearningResourcesTableTableManager(
      $_db,
      $_db.learningResources,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _learningResourcesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FlashcardDecksTable, List<FlashcardDeck>>
  _flashcardDecksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flashcardDecks,
    aliasName: 'subjects__id__flashcard_decks__subject_id',
  );

  $$FlashcardDecksTableProcessedTableManager get flashcardDecksRefs {
    final manager = $$FlashcardDecksTableTableManager(
      $_db,
      $_db.flashcardDecks,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_flashcardDecksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MindMapsTable, List<MindMap>> _mindMapsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.mindMaps,
    aliasName: 'subjects__id__mind_maps__subject_id',
  );

  $$MindMapsTableProcessedTableManager get mindMapsRefs {
    final manager = $$MindMapsTableTableManager(
      $_db,
      $_db.mindMaps,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mindMapsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SubjectsTableFilterComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableFilterComposer({
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

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
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

  Expression<bool> chaptersRefs(
    Expression<bool> Function($$ChaptersTableFilterComposer f) f,
  ) {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> learningResourcesRefs(
    Expression<bool> Function($$LearningResourcesTableFilterComposer f) f,
  ) {
    final $$LearningResourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learningResources,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningResourcesTableFilterComposer(
            $db: $db,
            $table: $db.learningResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> flashcardDecksRefs(
    Expression<bool> Function($$FlashcardDecksTableFilterComposer f) f,
  ) {
    final $$FlashcardDecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcardDecks,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardDecksTableFilterComposer(
            $db: $db,
            $table: $db.flashcardDecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mindMapsRefs(
    Expression<bool> Function($$MindMapsTableFilterComposer f) f,
  ) {
    final $$MindMapsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mindMaps,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MindMapsTableFilterComposer(
            $db: $db,
            $table: $db.mindMaps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableOrderingComposer({
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

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
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

class $$SubjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableAnnotationComposer({
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

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> chaptersRefs<T extends Object>(
    Expression<T> Function($$ChaptersTableAnnotationComposer a) f,
  ) {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> learningResourcesRefs<T extends Object>(
    Expression<T> Function($$LearningResourcesTableAnnotationComposer a) f,
  ) {
    final $$LearningResourcesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.learningResources,
          getReferencedColumn: (t) => t.subjectId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LearningResourcesTableAnnotationComposer(
                $db: $db,
                $table: $db.learningResources,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> flashcardDecksRefs<T extends Object>(
    Expression<T> Function($$FlashcardDecksTableAnnotationComposer a) f,
  ) {
    final $$FlashcardDecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcardDecks,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardDecksTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcardDecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mindMapsRefs<T extends Object>(
    Expression<T> Function($$MindMapsTableAnnotationComposer a) f,
  ) {
    final $$MindMapsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mindMaps,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MindMapsTableAnnotationComposer(
            $db: $db,
            $table: $db.mindMaps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubjectsTable,
          Subject,
          $$SubjectsTableFilterComposer,
          $$SubjectsTableOrderingComposer,
          $$SubjectsTableAnnotationComposer,
          $$SubjectsTableCreateCompanionBuilder,
          $$SubjectsTableUpdateCompanionBuilder,
          (Subject, $$SubjectsTableReferences),
          Subject,
          PrefetchHooks Function({
            bool chaptersRefs,
            bool learningResourcesRefs,
            bool flashcardDecksRefs,
            bool mindMapsRefs,
          })
        > {
  $$SubjectsTableTableManager(_$AppDatabase db, $SubjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SubjectsCompanion(
                id: id,
                name: name,
                description: description,
                icon: icon,
                color: color,
                sortOrder: sortOrder,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => SubjectsCompanion.insert(
                id: id,
                name: name,
                description: description,
                icon: icon,
                color: color,
                sortOrder: sortOrder,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$SubjectsTable, Subject>(table),
                          $$SubjectsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            chaptersRefs = false,
            learningResourcesRefs = false,
            flashcardDecksRefs = false,
            mindMapsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (chaptersRefs) db.chapters,
                if (learningResourcesRefs) db.learningResources,
                if (flashcardDecksRefs) db.flashcardDecks,
                if (mindMapsRefs) db.mindMaps,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chaptersRefs)
                    await $_getPrefetchedDataByColumns<
                      Subject,
                      $SubjectsTable,
                      Chapter,
                      $ChaptersTable
                    >(
                      currentTable: table,
                      referencedTable: $$SubjectsTableReferences
                          ._chaptersRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).chaptersRefs,
                      currentColumn: 'id',
                      referencedColumn: 'subject_id',
                      typedResults: items,
                    ),
                  if (learningResourcesRefs)
                    await $_getPrefetchedDataByColumns<
                      Subject,
                      $SubjectsTable,
                      LearningResource,
                      $LearningResourcesTable
                    >(
                      currentTable: table,
                      referencedTable: $$SubjectsTableReferences
                          ._learningResourcesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).learningResourcesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'subject_id',
                      typedResults: items,
                    ),
                  if (flashcardDecksRefs)
                    await $_getPrefetchedDataByColumns<
                      Subject,
                      $SubjectsTable,
                      FlashcardDeck,
                      $FlashcardDecksTable
                    >(
                      currentTable: table,
                      referencedTable: $$SubjectsTableReferences
                          ._flashcardDecksRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).flashcardDecksRefs,
                      currentColumn: 'id',
                      referencedColumn: 'subject_id',
                      typedResults: items,
                    ),
                  if (mindMapsRefs)
                    await $_getPrefetchedDataByColumns<
                      Subject,
                      $SubjectsTable,
                      MindMap,
                      $MindMapsTable
                    >(
                      currentTable: table,
                      referencedTable: $$SubjectsTableReferences
                          ._mindMapsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).mindMapsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'subject_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SubjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubjectsTable,
      Subject,
      $$SubjectsTableFilterComposer,
      $$SubjectsTableOrderingComposer,
      $$SubjectsTableAnnotationComposer,
      $$SubjectsTableCreateCompanionBuilder,
      $$SubjectsTableUpdateCompanionBuilder,
      (Subject, $$SubjectsTableReferences),
      Subject,
      PrefetchHooks Function({
        bool chaptersRefs,
        bool learningResourcesRefs,
        bool flashcardDecksRefs,
        bool mindMapsRefs,
      })
    >;
typedef $$ChaptersTableCreateCompanionBuilder =
    ChaptersCompanion Function({
      Value<int> id,
      required int subjectId,
      required String name,
      Value<String?> description,
      Value<int> orderIndex,
      Value<int?> estimatedMinutes,
      Value<bool> isCompleted,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$ChaptersTableUpdateCompanionBuilder =
    ChaptersCompanion Function({
      Value<int> id,
      Value<int> subjectId,
      Value<String> name,
      Value<String?> description,
      Value<int> orderIndex,
      Value<int?> estimatedMinutes,
      Value<bool> isCompleted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ChaptersTableReferences
    extends BaseReferences<_$AppDatabase, $ChaptersTable, Chapter> {
  $$ChaptersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('chapters__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TopicsTable, List<Topic>> _topicsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.topics,
    aliasName: 'chapters__id__topics__chapter_id',
  );

  $$TopicsTableProcessedTableManager get topicsRefs {
    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_topicsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChaptersTableFilterComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableFilterComposer({
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

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
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

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> topicsRefs(
    Expression<bool> Function($$TopicsTableFilterComposer f) f,
  ) {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChaptersTableOrderingComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableOrderingComposer({
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

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
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

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChaptersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableAnnotationComposer({
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

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> topicsRefs<T extends Object>(
    Expression<T> Function($$TopicsTableAnnotationComposer a) f,
  ) {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChaptersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChaptersTable,
          Chapter,
          $$ChaptersTableFilterComposer,
          $$ChaptersTableOrderingComposer,
          $$ChaptersTableAnnotationComposer,
          $$ChaptersTableCreateCompanionBuilder,
          $$ChaptersTableUpdateCompanionBuilder,
          (Chapter, $$ChaptersTableReferences),
          Chapter,
          PrefetchHooks Function({bool subjectId, bool topicsRefs})
        > {
  $$ChaptersTableTableManager(_$AppDatabase db, $ChaptersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ChaptersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ChaptersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ChaptersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> subjectId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<int?> estimatedMinutes = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ChaptersCompanion(
                id: id,
                subjectId: subjectId,
                name: name,
                description: description,
                orderIndex: orderIndex,
                estimatedMinutes: estimatedMinutes,
                isCompleted: isCompleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int subjectId,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<int?> estimatedMinutes = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => ChaptersCompanion.insert(
                id: id,
                subjectId: subjectId,
                name: name,
                description: description,
                orderIndex: orderIndex,
                estimatedMinutes: estimatedMinutes,
                isCompleted: isCompleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$ChaptersTable, Chapter>(table),
                          $$ChaptersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({subjectId = false, topicsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (topicsRefs) db.topics],
              addJoins: <
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
                if (subjectId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$ChaptersTableReferences
                                ._subjectIdTable(db),
                            referencedColumn:
                                $$ChaptersTableReferences
                                    ._subjectIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (topicsRefs)
                    await $_getPrefetchedDataByColumns<
                      Chapter,
                      $ChaptersTable,
                      Topic,
                      $TopicsTable
                    >(
                      currentTable: table,
                      referencedTable: $$ChaptersTableReferences
                          ._topicsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$ChaptersTableReferences(
                                db,
                                table,
                                p0,
                              ).topicsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'chapter_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ChaptersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChaptersTable,
      Chapter,
      $$ChaptersTableFilterComposer,
      $$ChaptersTableOrderingComposer,
      $$ChaptersTableAnnotationComposer,
      $$ChaptersTableCreateCompanionBuilder,
      $$ChaptersTableUpdateCompanionBuilder,
      (Chapter, $$ChaptersTableReferences),
      Chapter,
      PrefetchHooks Function({bool subjectId, bool topicsRefs})
    >;
typedef $$TopicsTableCreateCompanionBuilder =
    TopicsCompanion Function({
      Value<int> id,
      required int chapterId,
      required String name,
      Value<String?> description,
      Value<String?> difficulty,
      Value<int> orderIndex,
      Value<int?> estimatedMinutes,
      Value<String?> prerequisites,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$TopicsTableUpdateCompanionBuilder =
    TopicsCompanion Function({
      Value<int> id,
      Value<int> chapterId,
      Value<String> name,
      Value<String?> description,
      Value<String?> difficulty,
      Value<int> orderIndex,
      Value<int?> estimatedMinutes,
      Value<String?> prerequisites,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$TopicsTableReferences
    extends BaseReferences<_$AppDatabase, $TopicsTable, Topic> {
  $$TopicsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) =>
      db.chapters.createAlias('topics__chapter_id__chapters__id');

  $$ChaptersTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<int>('chapter_id')!;

    final manager = $$ChaptersTableTableManager(
      $_db,
      $_db.chapters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LearningResourcesTable, List<LearningResource>>
  _learningResourcesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.learningResources,
        aliasName: 'topics__id__learning_resources__topic_id',
      );

  $$LearningResourcesTableProcessedTableManager get learningResourcesRefs {
    final manager = $$LearningResourcesTableTableManager(
      $_db,
      $_db.learningResources,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _learningResourcesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FlashcardDecksTable, List<FlashcardDeck>>
  _flashcardDecksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flashcardDecks,
    aliasName: 'topics__id__flashcard_decks__topic_id',
  );

  $$FlashcardDecksTableProcessedTableManager get flashcardDecksRefs {
    final manager = $$FlashcardDecksTableTableManager(
      $_db,
      $_db.flashcardDecks,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_flashcardDecksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudyPlanItemsTable, List<StudyPlanItem>>
  _studyPlanItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studyPlanItems,
    aliasName: 'topics__id__study_plan_items__topic_id',
  );

  $$StudyPlanItemsTableProcessedTableManager get studyPlanItemsRefs {
    final manager = $$StudyPlanItemsTableTableManager(
      $_db,
      $_db.studyPlanItems,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studyPlanItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudySessionsTable, List<StudySession>>
  _studySessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studySessions,
    aliasName: 'topics__id__study_sessions__topic_id',
  );

  $$StudySessionsTableProcessedTableManager get studySessionsRefs {
    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studySessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecommendationsTable, List<Recommendation>>
  _recommendationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recommendations,
    aliasName: 'topics__id__recommendations__topic_id',
  );

  $$RecommendationsTableProcessedTableManager get recommendationsRefs {
    final manager = $$RecommendationsTableTableManager(
      $_db,
      $_db.recommendations,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recommendationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MindMapsTable, List<MindMap>> _mindMapsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.mindMaps,
    aliasName: 'topics__id__mind_maps__topic_id',
  );

  $$MindMapsTableProcessedTableManager get mindMapsRefs {
    final manager = $$MindMapsTableTableManager(
      $_db,
      $_db.mindMaps,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mindMapsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TopicsTableFilterComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableFilterComposer({
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

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prerequisites => $composableBuilder(
    column: $table.prerequisites,
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

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> learningResourcesRefs(
    Expression<bool> Function($$LearningResourcesTableFilterComposer f) f,
  ) {
    final $$LearningResourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learningResources,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningResourcesTableFilterComposer(
            $db: $db,
            $table: $db.learningResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> flashcardDecksRefs(
    Expression<bool> Function($$FlashcardDecksTableFilterComposer f) f,
  ) {
    final $$FlashcardDecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcardDecks,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardDecksTableFilterComposer(
            $db: $db,
            $table: $db.flashcardDecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studyPlanItemsRefs(
    Expression<bool> Function($$StudyPlanItemsTableFilterComposer f) f,
  ) {
    final $$StudyPlanItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyPlanItems,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlanItemsTableFilterComposer(
            $db: $db,
            $table: $db.studyPlanItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studySessionsRefs(
    Expression<bool> Function($$StudySessionsTableFilterComposer f) f,
  ) {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recommendationsRefs(
    Expression<bool> Function($$RecommendationsTableFilterComposer f) f,
  ) {
    final $$RecommendationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recommendations,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecommendationsTableFilterComposer(
            $db: $db,
            $table: $db.recommendations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mindMapsRefs(
    Expression<bool> Function($$MindMapsTableFilterComposer f) f,
  ) {
    final $$MindMapsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mindMaps,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MindMapsTableFilterComposer(
            $db: $db,
            $table: $db.mindMaps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicsTableOrderingComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableOrderingComposer({
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

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prerequisites => $composableBuilder(
    column: $table.prerequisites,
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

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableOrderingComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TopicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableAnnotationComposer({
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

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prerequisites => $composableBuilder(
    column: $table.prerequisites,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> learningResourcesRefs<T extends Object>(
    Expression<T> Function($$LearningResourcesTableAnnotationComposer a) f,
  ) {
    final $$LearningResourcesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.learningResources,
          getReferencedColumn: (t) => t.topicId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LearningResourcesTableAnnotationComposer(
                $db: $db,
                $table: $db.learningResources,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> flashcardDecksRefs<T extends Object>(
    Expression<T> Function($$FlashcardDecksTableAnnotationComposer a) f,
  ) {
    final $$FlashcardDecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcardDecks,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardDecksTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcardDecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> studyPlanItemsRefs<T extends Object>(
    Expression<T> Function($$StudyPlanItemsTableAnnotationComposer a) f,
  ) {
    final $$StudyPlanItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyPlanItems,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlanItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyPlanItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> studySessionsRefs<T extends Object>(
    Expression<T> Function($$StudySessionsTableAnnotationComposer a) f,
  ) {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recommendationsRefs<T extends Object>(
    Expression<T> Function($$RecommendationsTableAnnotationComposer a) f,
  ) {
    final $$RecommendationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recommendations,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecommendationsTableAnnotationComposer(
            $db: $db,
            $table: $db.recommendations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mindMapsRefs<T extends Object>(
    Expression<T> Function($$MindMapsTableAnnotationComposer a) f,
  ) {
    final $$MindMapsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mindMaps,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MindMapsTableAnnotationComposer(
            $db: $db,
            $table: $db.mindMaps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TopicsTable,
          Topic,
          $$TopicsTableFilterComposer,
          $$TopicsTableOrderingComposer,
          $$TopicsTableAnnotationComposer,
          $$TopicsTableCreateCompanionBuilder,
          $$TopicsTableUpdateCompanionBuilder,
          (Topic, $$TopicsTableReferences),
          Topic,
          PrefetchHooks Function({
            bool chapterId,
            bool learningResourcesRefs,
            bool flashcardDecksRefs,
            bool studyPlanItemsRefs,
            bool studySessionsRefs,
            bool recommendationsRefs,
            bool mindMapsRefs,
          })
        > {
  $$TopicsTableTableManager(_$AppDatabase db, $TopicsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TopicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$TopicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$TopicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> chapterId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> difficulty = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<int?> estimatedMinutes = const Value.absent(),
                Value<String?> prerequisites = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TopicsCompanion(
                id: id,
                chapterId: chapterId,
                name: name,
                description: description,
                difficulty: difficulty,
                orderIndex: orderIndex,
                estimatedMinutes: estimatedMinutes,
                prerequisites: prerequisites,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int chapterId,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> difficulty = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<int?> estimatedMinutes = const Value.absent(),
                Value<String?> prerequisites = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => TopicsCompanion.insert(
                id: id,
                chapterId: chapterId,
                name: name,
                description: description,
                difficulty: difficulty,
                orderIndex: orderIndex,
                estimatedMinutes: estimatedMinutes,
                prerequisites: prerequisites,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$TopicsTable, Topic>(table),
                          $$TopicsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            chapterId = false,
            learningResourcesRefs = false,
            flashcardDecksRefs = false,
            studyPlanItemsRefs = false,
            studySessionsRefs = false,
            recommendationsRefs = false,
            mindMapsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (learningResourcesRefs) db.learningResources,
                if (flashcardDecksRefs) db.flashcardDecks,
                if (studyPlanItemsRefs) db.studyPlanItems,
                if (studySessionsRefs) db.studySessions,
                if (recommendationsRefs) db.recommendations,
                if (mindMapsRefs) db.mindMaps,
              ],
              addJoins: <
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
                if (chapterId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.chapterId,
                            referencedTable: $$TopicsTableReferences
                                ._chapterIdTable(db),
                            referencedColumn:
                                $$TopicsTableReferences._chapterIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (learningResourcesRefs)
                    await $_getPrefetchedDataByColumns<
                      Topic,
                      $TopicsTable,
                      LearningResource,
                      $LearningResourcesTable
                    >(
                      currentTable: table,
                      referencedTable: $$TopicsTableReferences
                          ._learningResourcesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$TopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).learningResourcesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'topic_id',
                      typedResults: items,
                    ),
                  if (flashcardDecksRefs)
                    await $_getPrefetchedDataByColumns<
                      Topic,
                      $TopicsTable,
                      FlashcardDeck,
                      $FlashcardDecksTable
                    >(
                      currentTable: table,
                      referencedTable: $$TopicsTableReferences
                          ._flashcardDecksRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$TopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).flashcardDecksRefs,
                      currentColumn: 'id',
                      referencedColumn: 'topic_id',
                      typedResults: items,
                    ),
                  if (studyPlanItemsRefs)
                    await $_getPrefetchedDataByColumns<
                      Topic,
                      $TopicsTable,
                      StudyPlanItem,
                      $StudyPlanItemsTable
                    >(
                      currentTable: table,
                      referencedTable: $$TopicsTableReferences
                          ._studyPlanItemsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$TopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).studyPlanItemsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'topic_id',
                      typedResults: items,
                    ),
                  if (studySessionsRefs)
                    await $_getPrefetchedDataByColumns<
                      Topic,
                      $TopicsTable,
                      StudySession,
                      $StudySessionsTable
                    >(
                      currentTable: table,
                      referencedTable: $$TopicsTableReferences
                          ._studySessionsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$TopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).studySessionsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'topic_id',
                      typedResults: items,
                    ),
                  if (recommendationsRefs)
                    await $_getPrefetchedDataByColumns<
                      Topic,
                      $TopicsTable,
                      Recommendation,
                      $RecommendationsTable
                    >(
                      currentTable: table,
                      referencedTable: $$TopicsTableReferences
                          ._recommendationsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$TopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).recommendationsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'topic_id',
                      typedResults: items,
                    ),
                  if (mindMapsRefs)
                    await $_getPrefetchedDataByColumns<
                      Topic,
                      $TopicsTable,
                      MindMap,
                      $MindMapsTable
                    >(
                      currentTable: table,
                      referencedTable: $$TopicsTableReferences
                          ._mindMapsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$TopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).mindMapsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'topic_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TopicsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TopicsTable,
      Topic,
      $$TopicsTableFilterComposer,
      $$TopicsTableOrderingComposer,
      $$TopicsTableAnnotationComposer,
      $$TopicsTableCreateCompanionBuilder,
      $$TopicsTableUpdateCompanionBuilder,
      (Topic, $$TopicsTableReferences),
      Topic,
      PrefetchHooks Function({
        bool chapterId,
        bool learningResourcesRefs,
        bool flashcardDecksRefs,
        bool studyPlanItemsRefs,
        bool studySessionsRefs,
        bool recommendationsRefs,
        bool mindMapsRefs,
      })
    >;
typedef $$LearningResourcesTableCreateCompanionBuilder =
    LearningResourcesCompanion Function({
      Value<int> id,
      Value<int?> topicId,
      Value<int?> subjectId,
      required String title,
      required String type,
      Value<String?> sourceUrl,
      Value<String?> localPath,
      Value<String?> description,
      Value<String?> thumbnailUrl,
      Value<int?> durationSeconds,
      Value<String?> tags,
      Value<bool> isFavorite,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$LearningResourcesTableUpdateCompanionBuilder =
    LearningResourcesCompanion Function({
      Value<int> id,
      Value<int?> topicId,
      Value<int?> subjectId,
      Value<String> title,
      Value<String> type,
      Value<String?> sourceUrl,
      Value<String?> localPath,
      Value<String?> description,
      Value<String?> thumbnailUrl,
      Value<int?> durationSeconds,
      Value<String?> tags,
      Value<bool> isFavorite,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$LearningResourcesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LearningResourcesTable,
          LearningResource
        > {
  $$LearningResourcesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TopicsTable _topicIdTable(_$AppDatabase db) =>
      db.topics.createAlias('learning_resources__topic_id__topics__id');

  $$TopicsTableProcessedTableManager? get topicId {
    final $_column = $_itemColumn<int>('topic_id');
    if ($_column == null) return null;
    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('learning_resources__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager? get subjectId {
    final $_column = $_itemColumn<int>('subject_id');
    if ($_column == null) return null;
    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$StudyPlanItemsTable, List<StudyPlanItem>>
  _studyPlanItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studyPlanItems,
    aliasName: 'learning_resources__id__study_plan_items__resource_id',
  );

  $$StudyPlanItemsTableProcessedTableManager get studyPlanItemsRefs {
    final manager = $$StudyPlanItemsTableTableManager(
      $_db,
      $_db.studyPlanItems,
    ).filter((f) => f.resourceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studyPlanItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecommendationsTable, List<Recommendation>>
  _recommendationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recommendations,
    aliasName: 'learning_resources__id__recommendations__resource_id',
  );

  $$RecommendationsTableProcessedTableManager get recommendationsRefs {
    final manager = $$RecommendationsTableTableManager(
      $_db,
      $_db.recommendations,
    ).filter((f) => f.resourceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recommendationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VideoTranscriptsTable, List<VideoTranscript>>
  _videoTranscriptsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.videoTranscripts,
    aliasName: 'learning_resources__id__video_transcripts__resource_id',
  );

  $$VideoTranscriptsTableProcessedTableManager get videoTranscriptsRefs {
    final manager = $$VideoTranscriptsTableTableManager(
      $_db,
      $_db.videoTranscripts,
    ).filter((f) => f.resourceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _videoTranscriptsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LearningResourcesTableFilterComposer
    extends Composer<_$AppDatabase, $LearningResourcesTable> {
  $$LearningResourcesTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
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

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> studyPlanItemsRefs(
    Expression<bool> Function($$StudyPlanItemsTableFilterComposer f) f,
  ) {
    final $$StudyPlanItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyPlanItems,
      getReferencedColumn: (t) => t.resourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlanItemsTableFilterComposer(
            $db: $db,
            $table: $db.studyPlanItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recommendationsRefs(
    Expression<bool> Function($$RecommendationsTableFilterComposer f) f,
  ) {
    final $$RecommendationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recommendations,
      getReferencedColumn: (t) => t.resourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecommendationsTableFilterComposer(
            $db: $db,
            $table: $db.recommendations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> videoTranscriptsRefs(
    Expression<bool> Function($$VideoTranscriptsTableFilterComposer f) f,
  ) {
    final $$VideoTranscriptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoTranscripts,
      getReferencedColumn: (t) => t.resourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoTranscriptsTableFilterComposer(
            $db: $db,
            $table: $db.videoTranscripts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LearningResourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningResourcesTable> {
  $$LearningResourcesTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
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

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningResourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningResourcesTable> {
  $$LearningResourcesTableAnnotationComposer({
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

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get sourceUrl =>
      $composableBuilder(column: $table.sourceUrl, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> studyPlanItemsRefs<T extends Object>(
    Expression<T> Function($$StudyPlanItemsTableAnnotationComposer a) f,
  ) {
    final $$StudyPlanItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyPlanItems,
      getReferencedColumn: (t) => t.resourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlanItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyPlanItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recommendationsRefs<T extends Object>(
    Expression<T> Function($$RecommendationsTableAnnotationComposer a) f,
  ) {
    final $$RecommendationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recommendations,
      getReferencedColumn: (t) => t.resourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecommendationsTableAnnotationComposer(
            $db: $db,
            $table: $db.recommendations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> videoTranscriptsRefs<T extends Object>(
    Expression<T> Function($$VideoTranscriptsTableAnnotationComposer a) f,
  ) {
    final $$VideoTranscriptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.videoTranscripts,
      getReferencedColumn: (t) => t.resourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VideoTranscriptsTableAnnotationComposer(
            $db: $db,
            $table: $db.videoTranscripts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LearningResourcesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningResourcesTable,
          LearningResource,
          $$LearningResourcesTableFilterComposer,
          $$LearningResourcesTableOrderingComposer,
          $$LearningResourcesTableAnnotationComposer,
          $$LearningResourcesTableCreateCompanionBuilder,
          $$LearningResourcesTableUpdateCompanionBuilder,
          (LearningResource, $$LearningResourcesTableReferences),
          LearningResource,
          PrefetchHooks Function({
            bool topicId,
            bool subjectId,
            bool studyPlanItemsRefs,
            bool recommendationsRefs,
            bool videoTranscriptsRefs,
          })
        > {
  $$LearningResourcesTableTableManager(
    _$AppDatabase db,
    $LearningResourcesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LearningResourcesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$LearningResourcesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$LearningResourcesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> topicId = const Value.absent(),
                Value<int?> subjectId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> sourceUrl = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> thumbnailUrl = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LearningResourcesCompanion(
                id: id,
                topicId: topicId,
                subjectId: subjectId,
                title: title,
                type: type,
                sourceUrl: sourceUrl,
                localPath: localPath,
                description: description,
                thumbnailUrl: thumbnailUrl,
                durationSeconds: durationSeconds,
                tags: tags,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> topicId = const Value.absent(),
                Value<int?> subjectId = const Value.absent(),
                required String title,
                required String type,
                Value<String?> sourceUrl = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> thumbnailUrl = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => LearningResourcesCompanion.insert(
                id: id,
                topicId: topicId,
                subjectId: subjectId,
                title: title,
                type: type,
                sourceUrl: sourceUrl,
                localPath: localPath,
                description: description,
                thumbnailUrl: thumbnailUrl,
                durationSeconds: durationSeconds,
                tags: tags,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<
                            $LearningResourcesTable,
                            LearningResource
                          >(table),
                          $$LearningResourcesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            topicId = false,
            subjectId = false,
            studyPlanItemsRefs = false,
            recommendationsRefs = false,
            videoTranscriptsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (studyPlanItemsRefs) db.studyPlanItems,
                if (recommendationsRefs) db.recommendations,
                if (videoTranscriptsRefs) db.videoTranscripts,
              ],
              addJoins: <
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
                if (topicId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.topicId,
                            referencedTable: $$LearningResourcesTableReferences
                                ._topicIdTable(db),
                            referencedColumn:
                                $$LearningResourcesTableReferences
                                    ._topicIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (subjectId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$LearningResourcesTableReferences
                                ._subjectIdTable(db),
                            referencedColumn:
                                $$LearningResourcesTableReferences
                                    ._subjectIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (studyPlanItemsRefs)
                    await $_getPrefetchedDataByColumns<
                      LearningResource,
                      $LearningResourcesTable,
                      StudyPlanItem,
                      $StudyPlanItemsTable
                    >(
                      currentTable: table,
                      referencedTable: $$LearningResourcesTableReferences
                          ._studyPlanItemsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$LearningResourcesTableReferences(
                                db,
                                table,
                                p0,
                              ).studyPlanItemsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'resource_id',
                      typedResults: items,
                    ),
                  if (recommendationsRefs)
                    await $_getPrefetchedDataByColumns<
                      LearningResource,
                      $LearningResourcesTable,
                      Recommendation,
                      $RecommendationsTable
                    >(
                      currentTable: table,
                      referencedTable: $$LearningResourcesTableReferences
                          ._recommendationsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$LearningResourcesTableReferences(
                                db,
                                table,
                                p0,
                              ).recommendationsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'resource_id',
                      typedResults: items,
                    ),
                  if (videoTranscriptsRefs)
                    await $_getPrefetchedDataByColumns<
                      LearningResource,
                      $LearningResourcesTable,
                      VideoTranscript,
                      $VideoTranscriptsTable
                    >(
                      currentTable: table,
                      referencedTable: $$LearningResourcesTableReferences
                          ._videoTranscriptsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$LearningResourcesTableReferences(
                                db,
                                table,
                                p0,
                              ).videoTranscriptsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'resource_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$LearningResourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningResourcesTable,
      LearningResource,
      $$LearningResourcesTableFilterComposer,
      $$LearningResourcesTableOrderingComposer,
      $$LearningResourcesTableAnnotationComposer,
      $$LearningResourcesTableCreateCompanionBuilder,
      $$LearningResourcesTableUpdateCompanionBuilder,
      (LearningResource, $$LearningResourcesTableReferences),
      LearningResource,
      PrefetchHooks Function({
        bool topicId,
        bool subjectId,
        bool studyPlanItemsRefs,
        bool recommendationsRefs,
        bool videoTranscriptsRefs,
      })
    >;
typedef $$FlashcardDecksTableCreateCompanionBuilder =
    FlashcardDecksCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<int?> subjectId,
      Value<int?> topicId,
      Value<String?> sourceDocumentId,
      Value<int> cardCount,
      Value<bool> isPublic,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$FlashcardDecksTableUpdateCompanionBuilder =
    FlashcardDecksCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<int?> subjectId,
      Value<int?> topicId,
      Value<String?> sourceDocumentId,
      Value<int> cardCount,
      Value<bool> isPublic,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$FlashcardDecksTableReferences
    extends BaseReferences<_$AppDatabase, $FlashcardDecksTable, FlashcardDeck> {
  $$FlashcardDecksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('flashcard_decks__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager? get subjectId {
    final $_column = $_itemColumn<int>('subject_id');
    if ($_column == null) return null;
    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TopicsTable _topicIdTable(_$AppDatabase db) =>
      db.topics.createAlias('flashcard_decks__topic_id__topics__id');

  $$TopicsTableProcessedTableManager? get topicId {
    final $_column = $_itemColumn<int>('topic_id');
    if ($_column == null) return null;
    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FlashcardsTable, List<Flashcard>>
  _flashcardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flashcards,
    aliasName: 'flashcard_decks__id__flashcards__deck_id',
  );

  $$FlashcardsTableProcessedTableManager get flashcardsRefs {
    final manager = $$FlashcardsTableTableManager(
      $_db,
      $_db.flashcards,
    ).filter((f) => f.deckId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_flashcardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FlashcardDecksTableFilterComposer
    extends Composer<_$AppDatabase, $FlashcardDecksTable> {
  $$FlashcardDecksTableFilterComposer({
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

  ColumnFilters<String> get sourceDocumentId => $composableBuilder(
    column: $table.sourceDocumentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cardCount => $composableBuilder(
    column: $table.cardCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPublic => $composableBuilder(
    column: $table.isPublic,
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

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> flashcardsRefs(
    Expression<bool> Function($$FlashcardsTableFilterComposer f) f,
  ) {
    final $$FlashcardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableFilterComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FlashcardDecksTableOrderingComposer
    extends Composer<_$AppDatabase, $FlashcardDecksTable> {
  $$FlashcardDecksTableOrderingComposer({
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

  ColumnOrderings<String> get sourceDocumentId => $composableBuilder(
    column: $table.sourceDocumentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cardCount => $composableBuilder(
    column: $table.cardCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPublic => $composableBuilder(
    column: $table.isPublic,
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

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardDecksTableAnnotationComposer
    extends Composer<_$AppDatabase, $FlashcardDecksTable> {
  $$FlashcardDecksTableAnnotationComposer({
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

  GeneratedColumn<String> get sourceDocumentId => $composableBuilder(
    column: $table.sourceDocumentId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cardCount =>
      $composableBuilder(column: $table.cardCount, builder: (column) => column);

  GeneratedColumn<bool> get isPublic =>
      $composableBuilder(column: $table.isPublic, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> flashcardsRefs<T extends Object>(
    Expression<T> Function($$FlashcardsTableAnnotationComposer a) f,
  ) {
    final $$FlashcardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FlashcardDecksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FlashcardDecksTable,
          FlashcardDeck,
          $$FlashcardDecksTableFilterComposer,
          $$FlashcardDecksTableOrderingComposer,
          $$FlashcardDecksTableAnnotationComposer,
          $$FlashcardDecksTableCreateCompanionBuilder,
          $$FlashcardDecksTableUpdateCompanionBuilder,
          (FlashcardDeck, $$FlashcardDecksTableReferences),
          FlashcardDeck,
          PrefetchHooks Function({
            bool subjectId,
            bool topicId,
            bool flashcardsRefs,
          })
        > {
  $$FlashcardDecksTableTableManager(
    _$AppDatabase db,
    $FlashcardDecksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$FlashcardDecksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$FlashcardDecksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$FlashcardDecksTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int?> subjectId = const Value.absent(),
                Value<int?> topicId = const Value.absent(),
                Value<String?> sourceDocumentId = const Value.absent(),
                Value<int> cardCount = const Value.absent(),
                Value<bool> isPublic = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FlashcardDecksCompanion(
                id: id,
                name: name,
                description: description,
                subjectId: subjectId,
                topicId: topicId,
                sourceDocumentId: sourceDocumentId,
                cardCount: cardCount,
                isPublic: isPublic,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<int?> subjectId = const Value.absent(),
                Value<int?> topicId = const Value.absent(),
                Value<String?> sourceDocumentId = const Value.absent(),
                Value<int> cardCount = const Value.absent(),
                Value<bool> isPublic = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => FlashcardDecksCompanion.insert(
                id: id,
                name: name,
                description: description,
                subjectId: subjectId,
                topicId: topicId,
                sourceDocumentId: sourceDocumentId,
                cardCount: cardCount,
                isPublic: isPublic,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$FlashcardDecksTable, FlashcardDeck>(
                            table,
                          ),
                          $$FlashcardDecksTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            subjectId = false,
            topicId = false,
            flashcardsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (flashcardsRefs) db.flashcards],
              addJoins: <
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
                if (subjectId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$FlashcardDecksTableReferences
                                ._subjectIdTable(db),
                            referencedColumn:
                                $$FlashcardDecksTableReferences
                                    ._subjectIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (topicId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.topicId,
                            referencedTable: $$FlashcardDecksTableReferences
                                ._topicIdTable(db),
                            referencedColumn:
                                $$FlashcardDecksTableReferences
                                    ._topicIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (flashcardsRefs)
                    await $_getPrefetchedDataByColumns<
                      FlashcardDeck,
                      $FlashcardDecksTable,
                      Flashcard,
                      $FlashcardsTable
                    >(
                      currentTable: table,
                      referencedTable: $$FlashcardDecksTableReferences
                          ._flashcardsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$FlashcardDecksTableReferences(
                                db,
                                table,
                                p0,
                              ).flashcardsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'deck_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FlashcardDecksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FlashcardDecksTable,
      FlashcardDeck,
      $$FlashcardDecksTableFilterComposer,
      $$FlashcardDecksTableOrderingComposer,
      $$FlashcardDecksTableAnnotationComposer,
      $$FlashcardDecksTableCreateCompanionBuilder,
      $$FlashcardDecksTableUpdateCompanionBuilder,
      (FlashcardDeck, $$FlashcardDecksTableReferences),
      FlashcardDeck,
      PrefetchHooks Function({
        bool subjectId,
        bool topicId,
        bool flashcardsRefs,
      })
    >;
typedef $$FlashcardsTableCreateCompanionBuilder =
    FlashcardsCompanion Function({
      Value<int> id,
      required int deckId,
      required String front,
      required String back,
      Value<String?> hint,
      Value<String?> tags,
      Value<String?> sourceChunkId,
      Value<double> stability,
      Value<double> difficulty,
      Value<int> elapsedDays,
      Value<int> scheduledDays,
      Value<DateTime?> dueDate,
      Value<DateTime?> lastReviewed,
      Value<int> reviewCount,
      Value<int> lapseCount,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$FlashcardsTableUpdateCompanionBuilder =
    FlashcardsCompanion Function({
      Value<int> id,
      Value<int> deckId,
      Value<String> front,
      Value<String> back,
      Value<String?> hint,
      Value<String?> tags,
      Value<String?> sourceChunkId,
      Value<double> stability,
      Value<double> difficulty,
      Value<int> elapsedDays,
      Value<int> scheduledDays,
      Value<DateTime?> dueDate,
      Value<DateTime?> lastReviewed,
      Value<int> reviewCount,
      Value<int> lapseCount,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$FlashcardsTableReferences
    extends BaseReferences<_$AppDatabase, $FlashcardsTable, Flashcard> {
  $$FlashcardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FlashcardDecksTable _deckIdTable(_$AppDatabase db) =>
      db.flashcardDecks.createAlias('flashcards__deck_id__flashcard_decks__id');

  $$FlashcardDecksTableProcessedTableManager get deckId {
    final $_column = $_itemColumn<int>('deck_id')!;

    final manager = $$FlashcardDecksTableTableManager(
      $_db,
      $_db.flashcardDecks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deckIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FlashcardReviewsTable, List<FlashcardReview>>
  _flashcardReviewsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flashcardReviews,
    aliasName: 'flashcards__id__flashcard_reviews__flashcard_id',
  );

  $$FlashcardReviewsTableProcessedTableManager get flashcardReviewsRefs {
    final manager = $$FlashcardReviewsTableTableManager(
      $_db,
      $_db.flashcardReviews,
    ).filter((f) => f.flashcardId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _flashcardReviewsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FlashcardsTableFilterComposer
    extends Composer<_$AppDatabase, $FlashcardsTable> {
  $$FlashcardsTableFilterComposer({
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

  ColumnFilters<String> get front => $composableBuilder(
    column: $table.front,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get back => $composableBuilder(
    column: $table.back,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hint => $composableBuilder(
    column: $table.hint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceChunkId => $composableBuilder(
    column: $table.sourceChunkId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stability => $composableBuilder(
    column: $table.stability,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elapsedDays => $composableBuilder(
    column: $table.elapsedDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scheduledDays => $composableBuilder(
    column: $table.scheduledDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReviewed => $composableBuilder(
    column: $table.lastReviewed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lapseCount => $composableBuilder(
    column: $table.lapseCount,
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

  $$FlashcardDecksTableFilterComposer get deckId {
    final $$FlashcardDecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.flashcardDecks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardDecksTableFilterComposer(
            $db: $db,
            $table: $db.flashcardDecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> flashcardReviewsRefs(
    Expression<bool> Function($$FlashcardReviewsTableFilterComposer f) f,
  ) {
    final $$FlashcardReviewsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcardReviews,
      getReferencedColumn: (t) => t.flashcardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardReviewsTableFilterComposer(
            $db: $db,
            $table: $db.flashcardReviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FlashcardsTableOrderingComposer
    extends Composer<_$AppDatabase, $FlashcardsTable> {
  $$FlashcardsTableOrderingComposer({
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

  ColumnOrderings<String> get front => $composableBuilder(
    column: $table.front,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get back => $composableBuilder(
    column: $table.back,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hint => $composableBuilder(
    column: $table.hint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceChunkId => $composableBuilder(
    column: $table.sourceChunkId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stability => $composableBuilder(
    column: $table.stability,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elapsedDays => $composableBuilder(
    column: $table.elapsedDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduledDays => $composableBuilder(
    column: $table.scheduledDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReviewed => $composableBuilder(
    column: $table.lastReviewed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lapseCount => $composableBuilder(
    column: $table.lapseCount,
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

  $$FlashcardDecksTableOrderingComposer get deckId {
    final $$FlashcardDecksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.flashcardDecks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardDecksTableOrderingComposer(
            $db: $db,
            $table: $db.flashcardDecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FlashcardsTable> {
  $$FlashcardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get front =>
      $composableBuilder(column: $table.front, builder: (column) => column);

  GeneratedColumn<String> get back =>
      $composableBuilder(column: $table.back, builder: (column) => column);

  GeneratedColumn<String> get hint =>
      $composableBuilder(column: $table.hint, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get sourceChunkId => $composableBuilder(
    column: $table.sourceChunkId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get stability =>
      $composableBuilder(column: $table.stability, builder: (column) => column);

  GeneratedColumn<double> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get elapsedDays => $composableBuilder(
    column: $table.elapsedDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scheduledDays => $composableBuilder(
    column: $table.scheduledDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get lastReviewed => $composableBuilder(
    column: $table.lastReviewed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lapseCount => $composableBuilder(
    column: $table.lapseCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FlashcardDecksTableAnnotationComposer get deckId {
    final $$FlashcardDecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.flashcardDecks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardDecksTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcardDecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> flashcardReviewsRefs<T extends Object>(
    Expression<T> Function($$FlashcardReviewsTableAnnotationComposer a) f,
  ) {
    final $$FlashcardReviewsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcardReviews,
      getReferencedColumn: (t) => t.flashcardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardReviewsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcardReviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FlashcardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FlashcardsTable,
          Flashcard,
          $$FlashcardsTableFilterComposer,
          $$FlashcardsTableOrderingComposer,
          $$FlashcardsTableAnnotationComposer,
          $$FlashcardsTableCreateCompanionBuilder,
          $$FlashcardsTableUpdateCompanionBuilder,
          (Flashcard, $$FlashcardsTableReferences),
          Flashcard,
          PrefetchHooks Function({bool deckId, bool flashcardReviewsRefs})
        > {
  $$FlashcardsTableTableManager(_$AppDatabase db, $FlashcardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$FlashcardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$FlashcardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$FlashcardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> deckId = const Value.absent(),
                Value<String> front = const Value.absent(),
                Value<String> back = const Value.absent(),
                Value<String?> hint = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<String?> sourceChunkId = const Value.absent(),
                Value<double> stability = const Value.absent(),
                Value<double> difficulty = const Value.absent(),
                Value<int> elapsedDays = const Value.absent(),
                Value<int> scheduledDays = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime?> lastReviewed = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<int> lapseCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FlashcardsCompanion(
                id: id,
                deckId: deckId,
                front: front,
                back: back,
                hint: hint,
                tags: tags,
                sourceChunkId: sourceChunkId,
                stability: stability,
                difficulty: difficulty,
                elapsedDays: elapsedDays,
                scheduledDays: scheduledDays,
                dueDate: dueDate,
                lastReviewed: lastReviewed,
                reviewCount: reviewCount,
                lapseCount: lapseCount,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int deckId,
                required String front,
                required String back,
                Value<String?> hint = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<String?> sourceChunkId = const Value.absent(),
                Value<double> stability = const Value.absent(),
                Value<double> difficulty = const Value.absent(),
                Value<int> elapsedDays = const Value.absent(),
                Value<int> scheduledDays = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime?> lastReviewed = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<int> lapseCount = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => FlashcardsCompanion.insert(
                id: id,
                deckId: deckId,
                front: front,
                back: back,
                hint: hint,
                tags: tags,
                sourceChunkId: sourceChunkId,
                stability: stability,
                difficulty: difficulty,
                elapsedDays: elapsedDays,
                scheduledDays: scheduledDays,
                dueDate: dueDate,
                lastReviewed: lastReviewed,
                reviewCount: reviewCount,
                lapseCount: lapseCount,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$FlashcardsTable, Flashcard>(table),
                          $$FlashcardsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            deckId = false,
            flashcardReviewsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (flashcardReviewsRefs) db.flashcardReviews,
              ],
              addJoins: <
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
                if (deckId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.deckId,
                            referencedTable: $$FlashcardsTableReferences
                                ._deckIdTable(db),
                            referencedColumn:
                                $$FlashcardsTableReferences._deckIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (flashcardReviewsRefs)
                    await $_getPrefetchedDataByColumns<
                      Flashcard,
                      $FlashcardsTable,
                      FlashcardReview,
                      $FlashcardReviewsTable
                    >(
                      currentTable: table,
                      referencedTable: $$FlashcardsTableReferences
                          ._flashcardReviewsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$FlashcardsTableReferences(
                                db,
                                table,
                                p0,
                              ).flashcardReviewsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'flashcard_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FlashcardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FlashcardsTable,
      Flashcard,
      $$FlashcardsTableFilterComposer,
      $$FlashcardsTableOrderingComposer,
      $$FlashcardsTableAnnotationComposer,
      $$FlashcardsTableCreateCompanionBuilder,
      $$FlashcardsTableUpdateCompanionBuilder,
      (Flashcard, $$FlashcardsTableReferences),
      Flashcard,
      PrefetchHooks Function({bool deckId, bool flashcardReviewsRefs})
    >;
typedef $$FlashcardReviewsTableCreateCompanionBuilder =
    FlashcardReviewsCompanion Function({
      Value<int> id,
      required int flashcardId,
      required int rating,
      required double stabilityBefore,
      required double difficultyBefore,
      required double stabilityAfter,
      required double difficultyAfter,
      required int elapsedDays,
      required int scheduledDays,
      required DateTime reviewedAt,
    });
typedef $$FlashcardReviewsTableUpdateCompanionBuilder =
    FlashcardReviewsCompanion Function({
      Value<int> id,
      Value<int> flashcardId,
      Value<int> rating,
      Value<double> stabilityBefore,
      Value<double> difficultyBefore,
      Value<double> stabilityAfter,
      Value<double> difficultyAfter,
      Value<int> elapsedDays,
      Value<int> scheduledDays,
      Value<DateTime> reviewedAt,
    });

final class $$FlashcardReviewsTableReferences
    extends
        BaseReferences<_$AppDatabase, $FlashcardReviewsTable, FlashcardReview> {
  $$FlashcardReviewsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FlashcardsTable _flashcardIdTable(_$AppDatabase db) => db.flashcards
      .createAlias('flashcard_reviews__flashcard_id__flashcards__id');

  $$FlashcardsTableProcessedTableManager get flashcardId {
    final $_column = $_itemColumn<int>('flashcard_id')!;

    final manager = $$FlashcardsTableTableManager(
      $_db,
      $_db.flashcards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_flashcardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FlashcardReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $FlashcardReviewsTable> {
  $$FlashcardReviewsTableFilterComposer({
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

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stabilityBefore => $composableBuilder(
    column: $table.stabilityBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get difficultyBefore => $composableBuilder(
    column: $table.difficultyBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stabilityAfter => $composableBuilder(
    column: $table.stabilityAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get difficultyAfter => $composableBuilder(
    column: $table.difficultyAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elapsedDays => $composableBuilder(
    column: $table.elapsedDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scheduledDays => $composableBuilder(
    column: $table.scheduledDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FlashcardsTableFilterComposer get flashcardId {
    final $$FlashcardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.flashcardId,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableFilterComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $FlashcardReviewsTable> {
  $$FlashcardReviewsTableOrderingComposer({
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

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stabilityBefore => $composableBuilder(
    column: $table.stabilityBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get difficultyBefore => $composableBuilder(
    column: $table.difficultyBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stabilityAfter => $composableBuilder(
    column: $table.stabilityAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get difficultyAfter => $composableBuilder(
    column: $table.difficultyAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elapsedDays => $composableBuilder(
    column: $table.elapsedDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduledDays => $composableBuilder(
    column: $table.scheduledDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FlashcardsTableOrderingComposer get flashcardId {
    final $$FlashcardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.flashcardId,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableOrderingComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FlashcardReviewsTable> {
  $$FlashcardReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<double> get stabilityBefore => $composableBuilder(
    column: $table.stabilityBefore,
    builder: (column) => column,
  );

  GeneratedColumn<double> get difficultyBefore => $composableBuilder(
    column: $table.difficultyBefore,
    builder: (column) => column,
  );

  GeneratedColumn<double> get stabilityAfter => $composableBuilder(
    column: $table.stabilityAfter,
    builder: (column) => column,
  );

  GeneratedColumn<double> get difficultyAfter => $composableBuilder(
    column: $table.difficultyAfter,
    builder: (column) => column,
  );

  GeneratedColumn<int> get elapsedDays => $composableBuilder(
    column: $table.elapsedDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scheduledDays => $composableBuilder(
    column: $table.scheduledDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => column,
  );

  $$FlashcardsTableAnnotationComposer get flashcardId {
    final $$FlashcardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.flashcardId,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardReviewsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FlashcardReviewsTable,
          FlashcardReview,
          $$FlashcardReviewsTableFilterComposer,
          $$FlashcardReviewsTableOrderingComposer,
          $$FlashcardReviewsTableAnnotationComposer,
          $$FlashcardReviewsTableCreateCompanionBuilder,
          $$FlashcardReviewsTableUpdateCompanionBuilder,
          (FlashcardReview, $$FlashcardReviewsTableReferences),
          FlashcardReview,
          PrefetchHooks Function({bool flashcardId})
        > {
  $$FlashcardReviewsTableTableManager(
    _$AppDatabase db,
    $FlashcardReviewsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$FlashcardReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$FlashcardReviewsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$FlashcardReviewsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> flashcardId = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<double> stabilityBefore = const Value.absent(),
                Value<double> difficultyBefore = const Value.absent(),
                Value<double> stabilityAfter = const Value.absent(),
                Value<double> difficultyAfter = const Value.absent(),
                Value<int> elapsedDays = const Value.absent(),
                Value<int> scheduledDays = const Value.absent(),
                Value<DateTime> reviewedAt = const Value.absent(),
              }) => FlashcardReviewsCompanion(
                id: id,
                flashcardId: flashcardId,
                rating: rating,
                stabilityBefore: stabilityBefore,
                difficultyBefore: difficultyBefore,
                stabilityAfter: stabilityAfter,
                difficultyAfter: difficultyAfter,
                elapsedDays: elapsedDays,
                scheduledDays: scheduledDays,
                reviewedAt: reviewedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int flashcardId,
                required int rating,
                required double stabilityBefore,
                required double difficultyBefore,
                required double stabilityAfter,
                required double difficultyAfter,
                required int elapsedDays,
                required int scheduledDays,
                required DateTime reviewedAt,
              }) => FlashcardReviewsCompanion.insert(
                id: id,
                flashcardId: flashcardId,
                rating: rating,
                stabilityBefore: stabilityBefore,
                difficultyBefore: difficultyBefore,
                stabilityAfter: stabilityAfter,
                difficultyAfter: difficultyAfter,
                elapsedDays: elapsedDays,
                scheduledDays: scheduledDays,
                reviewedAt: reviewedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$FlashcardReviewsTable, FlashcardReview>(
                            table,
                          ),
                          $$FlashcardReviewsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({flashcardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (flashcardId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.flashcardId,
                            referencedTable: $$FlashcardReviewsTableReferences
                                ._flashcardIdTable(db),
                            referencedColumn:
                                $$FlashcardReviewsTableReferences
                                    ._flashcardIdTable(db)
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

typedef $$FlashcardReviewsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FlashcardReviewsTable,
      FlashcardReview,
      $$FlashcardReviewsTableFilterComposer,
      $$FlashcardReviewsTableOrderingComposer,
      $$FlashcardReviewsTableAnnotationComposer,
      $$FlashcardReviewsTableCreateCompanionBuilder,
      $$FlashcardReviewsTableUpdateCompanionBuilder,
      (FlashcardReview, $$FlashcardReviewsTableReferences),
      FlashcardReview,
      PrefetchHooks Function({bool flashcardId})
    >;
typedef $$StudyPlansTableCreateCompanionBuilder =
    StudyPlansCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      required DateTime startDate,
      required DateTime endDate,
      Value<String?> goals,
      Value<int?> targetHoursPerWeek,
      Value<String?> scheduleConfig,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$StudyPlansTableUpdateCompanionBuilder =
    StudyPlansCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<String?> goals,
      Value<int?> targetHoursPerWeek,
      Value<String?> scheduleConfig,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$StudyPlansTableReferences
    extends BaseReferences<_$AppDatabase, $StudyPlansTable, StudyPlan> {
  $$StudyPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$StudyPlanItemsTable, List<StudyPlanItem>>
  _studyPlanItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studyPlanItems,
    aliasName: 'study_plans__id__study_plan_items__plan_id',
  );

  $$StudyPlanItemsTableProcessedTableManager get studyPlanItemsRefs {
    final manager = $$StudyPlanItemsTableTableManager(
      $_db,
      $_db.studyPlanItems,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studyPlanItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudySessionsTable, List<StudySession>>
  _studySessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studySessions,
    aliasName: 'study_plans__id__study_sessions__plan_id',
  );

  $$StudySessionsTableProcessedTableManager get studySessionsRefs {
    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studySessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StudyPlansTableFilterComposer
    extends Composer<_$AppDatabase, $StudyPlansTable> {
  $$StudyPlansTableFilterComposer({
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

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goals => $composableBuilder(
    column: $table.goals,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetHoursPerWeek => $composableBuilder(
    column: $table.targetHoursPerWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduleConfig => $composableBuilder(
    column: $table.scheduleConfig,
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

  Expression<bool> studyPlanItemsRefs(
    Expression<bool> Function($$StudyPlanItemsTableFilterComposer f) f,
  ) {
    final $$StudyPlanItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyPlanItems,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlanItemsTableFilterComposer(
            $db: $db,
            $table: $db.studyPlanItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studySessionsRefs(
    Expression<bool> Function($$StudySessionsTableFilterComposer f) f,
  ) {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudyPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $StudyPlansTable> {
  $$StudyPlansTableOrderingComposer({
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

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goals => $composableBuilder(
    column: $table.goals,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetHoursPerWeek => $composableBuilder(
    column: $table.targetHoursPerWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduleConfig => $composableBuilder(
    column: $table.scheduleConfig,
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

class $$StudyPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudyPlansTable> {
  $$StudyPlansTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get goals =>
      $composableBuilder(column: $table.goals, builder: (column) => column);

  GeneratedColumn<int> get targetHoursPerWeek => $composableBuilder(
    column: $table.targetHoursPerWeek,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scheduleConfig => $composableBuilder(
    column: $table.scheduleConfig,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> studyPlanItemsRefs<T extends Object>(
    Expression<T> Function($$StudyPlanItemsTableAnnotationComposer a) f,
  ) {
    final $$StudyPlanItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyPlanItems,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlanItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyPlanItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> studySessionsRefs<T extends Object>(
    Expression<T> Function($$StudySessionsTableAnnotationComposer a) f,
  ) {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudyPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudyPlansTable,
          StudyPlan,
          $$StudyPlansTableFilterComposer,
          $$StudyPlansTableOrderingComposer,
          $$StudyPlansTableAnnotationComposer,
          $$StudyPlansTableCreateCompanionBuilder,
          $$StudyPlansTableUpdateCompanionBuilder,
          (StudyPlan, $$StudyPlansTableReferences),
          StudyPlan,
          PrefetchHooks Function({
            bool studyPlanItemsRefs,
            bool studySessionsRefs,
          })
        > {
  $$StudyPlansTableTableManager(_$AppDatabase db, $StudyPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$StudyPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$StudyPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$StudyPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<String?> goals = const Value.absent(),
                Value<int?> targetHoursPerWeek = const Value.absent(),
                Value<String?> scheduleConfig = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StudyPlansCompanion(
                id: id,
                name: name,
                description: description,
                startDate: startDate,
                endDate: endDate,
                goals: goals,
                targetHoursPerWeek: targetHoursPerWeek,
                scheduleConfig: scheduleConfig,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                required DateTime startDate,
                required DateTime endDate,
                Value<String?> goals = const Value.absent(),
                Value<int?> targetHoursPerWeek = const Value.absent(),
                Value<String?> scheduleConfig = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => StudyPlansCompanion.insert(
                id: id,
                name: name,
                description: description,
                startDate: startDate,
                endDate: endDate,
                goals: goals,
                targetHoursPerWeek: targetHoursPerWeek,
                scheduleConfig: scheduleConfig,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$StudyPlansTable, StudyPlan>(table),
                          $$StudyPlansTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            studyPlanItemsRefs = false,
            studySessionsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (studyPlanItemsRefs) db.studyPlanItems,
                if (studySessionsRefs) db.studySessions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (studyPlanItemsRefs)
                    await $_getPrefetchedDataByColumns<
                      StudyPlan,
                      $StudyPlansTable,
                      StudyPlanItem,
                      $StudyPlanItemsTable
                    >(
                      currentTable: table,
                      referencedTable: $$StudyPlansTableReferences
                          ._studyPlanItemsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$StudyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).studyPlanItemsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'plan_id',
                      typedResults: items,
                    ),
                  if (studySessionsRefs)
                    await $_getPrefetchedDataByColumns<
                      StudyPlan,
                      $StudyPlansTable,
                      StudySession,
                      $StudySessionsTable
                    >(
                      currentTable: table,
                      referencedTable: $$StudyPlansTableReferences
                          ._studySessionsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$StudyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).studySessionsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'plan_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$StudyPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudyPlansTable,
      StudyPlan,
      $$StudyPlansTableFilterComposer,
      $$StudyPlansTableOrderingComposer,
      $$StudyPlansTableAnnotationComposer,
      $$StudyPlansTableCreateCompanionBuilder,
      $$StudyPlansTableUpdateCompanionBuilder,
      (StudyPlan, $$StudyPlansTableReferences),
      StudyPlan,
      PrefetchHooks Function({bool studyPlanItemsRefs, bool studySessionsRefs})
    >;
typedef $$StudyPlanItemsTableCreateCompanionBuilder =
    StudyPlanItemsCompanion Function({
      Value<int> id,
      required int planId,
      Value<int?> topicId,
      Value<int?> resourceId,
      required String title,
      required String type,
      required int estimatedMinutes,
      Value<int> orderIndex,
      Value<DateTime?> scheduledDate,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      required DateTime createdAt,
    });
typedef $$StudyPlanItemsTableUpdateCompanionBuilder =
    StudyPlanItemsCompanion Function({
      Value<int> id,
      Value<int> planId,
      Value<int?> topicId,
      Value<int?> resourceId,
      Value<String> title,
      Value<String> type,
      Value<int> estimatedMinutes,
      Value<int> orderIndex,
      Value<DateTime?> scheduledDate,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
    });

final class $$StudyPlanItemsTableReferences
    extends BaseReferences<_$AppDatabase, $StudyPlanItemsTable, StudyPlanItem> {
  $$StudyPlanItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StudyPlansTable _planIdTable(_$AppDatabase db) =>
      db.studyPlans.createAlias('study_plan_items__plan_id__study_plans__id');

  $$StudyPlansTableProcessedTableManager get planId {
    final $_column = $_itemColumn<int>('plan_id')!;

    final manager = $$StudyPlansTableTableManager(
      $_db,
      $_db.studyPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TopicsTable _topicIdTable(_$AppDatabase db) =>
      db.topics.createAlias('study_plan_items__topic_id__topics__id');

  $$TopicsTableProcessedTableManager? get topicId {
    final $_column = $_itemColumn<int>('topic_id');
    if ($_column == null) return null;
    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LearningResourcesTable _resourceIdTable(_$AppDatabase db) => db
      .learningResources
      .createAlias('study_plan_items__resource_id__learning_resources__id');

  $$LearningResourcesTableProcessedTableManager? get resourceId {
    final $_column = $_itemColumn<int>('resource_id');
    if ($_column == null) return null;
    final manager = $$LearningResourcesTableTableManager(
      $_db,
      $_db.learningResources,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_resourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$StudySessionsTable, List<StudySession>>
  _studySessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studySessions,
    aliasName: 'study_plan_items__id__study_sessions__plan_item_id',
  );

  $$StudySessionsTableProcessedTableManager get studySessionsRefs {
    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.planItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studySessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StudyPlanItemsTableFilterComposer
    extends Composer<_$AppDatabase, $StudyPlanItemsTable> {
  $$StudyPlanItemsTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyPlansTableFilterComposer get planId {
    final $$StudyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableFilterComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LearningResourcesTableFilterComposer get resourceId {
    final $$LearningResourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.resourceId,
      referencedTable: $db.learningResources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningResourcesTableFilterComposer(
            $db: $db,
            $table: $db.learningResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> studySessionsRefs(
    Expression<bool> Function($$StudySessionsTableFilterComposer f) f,
  ) {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.planItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudyPlanItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudyPlanItemsTable> {
  $$StudyPlanItemsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyPlansTableOrderingComposer get planId {
    final $$StudyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LearningResourcesTableOrderingComposer get resourceId {
    final $$LearningResourcesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.resourceId,
      referencedTable: $db.learningResources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningResourcesTableOrderingComposer(
            $db: $db,
            $table: $db.learningResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudyPlanItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudyPlanItemsTable> {
  $$StudyPlanItemsTableAnnotationComposer({
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

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$StudyPlansTableAnnotationComposer get planId {
    final $$StudyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LearningResourcesTableAnnotationComposer get resourceId {
    final $$LearningResourcesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.resourceId,
          referencedTable: $db.learningResources,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LearningResourcesTableAnnotationComposer(
                $db: $db,
                $table: $db.learningResources,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> studySessionsRefs<T extends Object>(
    Expression<T> Function($$StudySessionsTableAnnotationComposer a) f,
  ) {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.planItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudyPlanItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudyPlanItemsTable,
          StudyPlanItem,
          $$StudyPlanItemsTableFilterComposer,
          $$StudyPlanItemsTableOrderingComposer,
          $$StudyPlanItemsTableAnnotationComposer,
          $$StudyPlanItemsTableCreateCompanionBuilder,
          $$StudyPlanItemsTableUpdateCompanionBuilder,
          (StudyPlanItem, $$StudyPlanItemsTableReferences),
          StudyPlanItem,
          PrefetchHooks Function({
            bool planId,
            bool topicId,
            bool resourceId,
            bool studySessionsRefs,
          })
        > {
  $$StudyPlanItemsTableTableManager(
    _$AppDatabase db,
    $StudyPlanItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$StudyPlanItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$StudyPlanItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$StudyPlanItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> planId = const Value.absent(),
                Value<int?> topicId = const Value.absent(),
                Value<int?> resourceId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> estimatedMinutes = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<DateTime?> scheduledDate = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StudyPlanItemsCompanion(
                id: id,
                planId: planId,
                topicId: topicId,
                resourceId: resourceId,
                title: title,
                type: type,
                estimatedMinutes: estimatedMinutes,
                orderIndex: orderIndex,
                scheduledDate: scheduledDate,
                isCompleted: isCompleted,
                completedAt: completedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int planId,
                Value<int?> topicId = const Value.absent(),
                Value<int?> resourceId = const Value.absent(),
                required String title,
                required String type,
                required int estimatedMinutes,
                Value<int> orderIndex = const Value.absent(),
                Value<DateTime?> scheduledDate = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                required DateTime createdAt,
              }) => StudyPlanItemsCompanion.insert(
                id: id,
                planId: planId,
                topicId: topicId,
                resourceId: resourceId,
                title: title,
                type: type,
                estimatedMinutes: estimatedMinutes,
                orderIndex: orderIndex,
                scheduledDate: scheduledDate,
                isCompleted: isCompleted,
                completedAt: completedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$StudyPlanItemsTable, StudyPlanItem>(
                            table,
                          ),
                          $$StudyPlanItemsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            planId = false,
            topicId = false,
            resourceId = false,
            studySessionsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (studySessionsRefs) db.studySessions,
              ],
              addJoins: <
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
                if (planId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.planId,
                            referencedTable: $$StudyPlanItemsTableReferences
                                ._planIdTable(db),
                            referencedColumn:
                                $$StudyPlanItemsTableReferences
                                    ._planIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (topicId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.topicId,
                            referencedTable: $$StudyPlanItemsTableReferences
                                ._topicIdTable(db),
                            referencedColumn:
                                $$StudyPlanItemsTableReferences
                                    ._topicIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (resourceId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.resourceId,
                            referencedTable: $$StudyPlanItemsTableReferences
                                ._resourceIdTable(db),
                            referencedColumn:
                                $$StudyPlanItemsTableReferences
                                    ._resourceIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (studySessionsRefs)
                    await $_getPrefetchedDataByColumns<
                      StudyPlanItem,
                      $StudyPlanItemsTable,
                      StudySession,
                      $StudySessionsTable
                    >(
                      currentTable: table,
                      referencedTable: $$StudyPlanItemsTableReferences
                          ._studySessionsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$StudyPlanItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).studySessionsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'plan_item_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$StudyPlanItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudyPlanItemsTable,
      StudyPlanItem,
      $$StudyPlanItemsTableFilterComposer,
      $$StudyPlanItemsTableOrderingComposer,
      $$StudyPlanItemsTableAnnotationComposer,
      $$StudyPlanItemsTableCreateCompanionBuilder,
      $$StudyPlanItemsTableUpdateCompanionBuilder,
      (StudyPlanItem, $$StudyPlanItemsTableReferences),
      StudyPlanItem,
      PrefetchHooks Function({
        bool planId,
        bool topicId,
        bool resourceId,
        bool studySessionsRefs,
      })
    >;
typedef $$StudySessionsTableCreateCompanionBuilder =
    StudySessionsCompanion Function({
      Value<int> id,
      Value<int?> planId,
      Value<int?> planItemId,
      Value<int?> topicId,
      required String activityType,
      required int durationMinutes,
      Value<int?> focusScore,
      Value<String?> notes,
      required DateTime startedAt,
      required DateTime endedAt,
    });
typedef $$StudySessionsTableUpdateCompanionBuilder =
    StudySessionsCompanion Function({
      Value<int> id,
      Value<int?> planId,
      Value<int?> planItemId,
      Value<int?> topicId,
      Value<String> activityType,
      Value<int> durationMinutes,
      Value<int?> focusScore,
      Value<String?> notes,
      Value<DateTime> startedAt,
      Value<DateTime> endedAt,
    });

final class $$StudySessionsTableReferences
    extends BaseReferences<_$AppDatabase, $StudySessionsTable, StudySession> {
  $$StudySessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StudyPlansTable _planIdTable(_$AppDatabase db) =>
      db.studyPlans.createAlias('study_sessions__plan_id__study_plans__id');

  $$StudyPlansTableProcessedTableManager? get planId {
    final $_column = $_itemColumn<int>('plan_id');
    if ($_column == null) return null;
    final manager = $$StudyPlansTableTableManager(
      $_db,
      $_db.studyPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudyPlanItemsTable _planItemIdTable(_$AppDatabase db) => db
      .studyPlanItems
      .createAlias('study_sessions__plan_item_id__study_plan_items__id');

  $$StudyPlanItemsTableProcessedTableManager? get planItemId {
    final $_column = $_itemColumn<int>('plan_item_id');
    if ($_column == null) return null;
    final manager = $$StudyPlanItemsTableTableManager(
      $_db,
      $_db.studyPlanItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TopicsTable _topicIdTable(_$AppDatabase db) =>
      db.topics.createAlias('study_sessions__topic_id__topics__id');

  $$TopicsTableProcessedTableManager? get topicId {
    final $_column = $_itemColumn<int>('topic_id');
    if ($_column == null) return null;
    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StudySessionsTableFilterComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableFilterComposer({
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

  ColumnFilters<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get focusScore => $composableBuilder(
    column: $table.focusScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StudyPlansTableFilterComposer get planId {
    final $$StudyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableFilterComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudyPlanItemsTableFilterComposer get planItemId {
    final $$StudyPlanItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planItemId,
      referencedTable: $db.studyPlanItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlanItemsTableFilterComposer(
            $db: $db,
            $table: $db.studyPlanItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableOrderingComposer({
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

  ColumnOrderings<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get focusScore => $composableBuilder(
    column: $table.focusScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StudyPlansTableOrderingComposer get planId {
    final $$StudyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudyPlanItemsTableOrderingComposer get planItemId {
    final $$StudyPlanItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planItemId,
      referencedTable: $db.studyPlanItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlanItemsTableOrderingComposer(
            $db: $db,
            $table: $db.studyPlanItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get focusScore => $composableBuilder(
    column: $table.focusScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  $$StudyPlansTableAnnotationComposer get planId {
    final $$StudyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.studyPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.studyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudyPlanItemsTableAnnotationComposer get planItemId {
    final $$StudyPlanItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planItemId,
      referencedTable: $db.studyPlanItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyPlanItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyPlanItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudySessionsTable,
          StudySession,
          $$StudySessionsTableFilterComposer,
          $$StudySessionsTableOrderingComposer,
          $$StudySessionsTableAnnotationComposer,
          $$StudySessionsTableCreateCompanionBuilder,
          $$StudySessionsTableUpdateCompanionBuilder,
          (StudySession, $$StudySessionsTableReferences),
          StudySession,
          PrefetchHooks Function({bool planId, bool planItemId, bool topicId})
        > {
  $$StudySessionsTableTableManager(_$AppDatabase db, $StudySessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$StudySessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$StudySessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$StudySessionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> planId = const Value.absent(),
                Value<int?> planItemId = const Value.absent(),
                Value<int?> topicId = const Value.absent(),
                Value<String> activityType = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<int?> focusScore = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> endedAt = const Value.absent(),
              }) => StudySessionsCompanion(
                id: id,
                planId: planId,
                planItemId: planItemId,
                topicId: topicId,
                activityType: activityType,
                durationMinutes: durationMinutes,
                focusScore: focusScore,
                notes: notes,
                startedAt: startedAt,
                endedAt: endedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> planId = const Value.absent(),
                Value<int?> planItemId = const Value.absent(),
                Value<int?> topicId = const Value.absent(),
                required String activityType,
                required int durationMinutes,
                Value<int?> focusScore = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime startedAt,
                required DateTime endedAt,
              }) => StudySessionsCompanion.insert(
                id: id,
                planId: planId,
                planItemId: planItemId,
                topicId: topicId,
                activityType: activityType,
                durationMinutes: durationMinutes,
                focusScore: focusScore,
                notes: notes,
                startedAt: startedAt,
                endedAt: endedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$StudySessionsTable, StudySession>(table),
                          $$StudySessionsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            planId = false,
            planItemId = false,
            topicId = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (planId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.planId,
                            referencedTable: $$StudySessionsTableReferences
                                ._planIdTable(db),
                            referencedColumn:
                                $$StudySessionsTableReferences
                                    ._planIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (planItemId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.planItemId,
                            referencedTable: $$StudySessionsTableReferences
                                ._planItemIdTable(db),
                            referencedColumn:
                                $$StudySessionsTableReferences
                                    ._planItemIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (topicId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.topicId,
                            referencedTable: $$StudySessionsTableReferences
                                ._topicIdTable(db),
                            referencedColumn:
                                $$StudySessionsTableReferences
                                    ._topicIdTable(db)
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

typedef $$StudySessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudySessionsTable,
      StudySession,
      $$StudySessionsTableFilterComposer,
      $$StudySessionsTableOrderingComposer,
      $$StudySessionsTableAnnotationComposer,
      $$StudySessionsTableCreateCompanionBuilder,
      $$StudySessionsTableUpdateCompanionBuilder,
      (StudySession, $$StudySessionsTableReferences),
      StudySession,
      PrefetchHooks Function({bool planId, bool planItemId, bool topicId})
    >;
typedef $$ExamSchedulesTableCreateCompanionBuilder =
    ExamSchedulesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> subject,
      Value<String?> examType,
      required DateTime examDate,
      Value<int?> durationMinutes,
      Value<String?> topicsCovered,
      Value<String?> resources,
      Value<int?> targetScore,
      Value<String?> notes,
      Value<bool> isCompleted,
      Value<int?> actualScore,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$ExamSchedulesTableUpdateCompanionBuilder =
    ExamSchedulesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> subject,
      Value<String?> examType,
      Value<DateTime> examDate,
      Value<int?> durationMinutes,
      Value<String?> topicsCovered,
      Value<String?> resources,
      Value<int?> targetScore,
      Value<String?> notes,
      Value<bool> isCompleted,
      Value<int?> actualScore,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$ExamSchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $ExamSchedulesTable> {
  $$ExamSchedulesTableFilterComposer({
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

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get examType => $composableBuilder(
    column: $table.examType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get examDate => $composableBuilder(
    column: $table.examDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicsCovered => $composableBuilder(
    column: $table.topicsCovered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resources => $composableBuilder(
    column: $table.resources,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetScore => $composableBuilder(
    column: $table.targetScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualScore => $composableBuilder(
    column: $table.actualScore,
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

class $$ExamSchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamSchedulesTable> {
  $$ExamSchedulesTableOrderingComposer({
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

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get examType => $composableBuilder(
    column: $table.examType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get examDate => $composableBuilder(
    column: $table.examDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicsCovered => $composableBuilder(
    column: $table.topicsCovered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resources => $composableBuilder(
    column: $table.resources,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetScore => $composableBuilder(
    column: $table.targetScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualScore => $composableBuilder(
    column: $table.actualScore,
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

class $$ExamSchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamSchedulesTable> {
  $$ExamSchedulesTableAnnotationComposer({
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

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get examType =>
      $composableBuilder(column: $table.examType, builder: (column) => column);

  GeneratedColumn<DateTime> get examDate =>
      $composableBuilder(column: $table.examDate, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get topicsCovered => $composableBuilder(
    column: $table.topicsCovered,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resources =>
      $composableBuilder(column: $table.resources, builder: (column) => column);

  GeneratedColumn<int> get targetScore => $composableBuilder(
    column: $table.targetScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualScore => $composableBuilder(
    column: $table.actualScore,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ExamSchedulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExamSchedulesTable,
          ExamSchedule,
          $$ExamSchedulesTableFilterComposer,
          $$ExamSchedulesTableOrderingComposer,
          $$ExamSchedulesTableAnnotationComposer,
          $$ExamSchedulesTableCreateCompanionBuilder,
          $$ExamSchedulesTableUpdateCompanionBuilder,
          (
            ExamSchedule,
            BaseReferences<_$AppDatabase, $ExamSchedulesTable, ExamSchedule>,
          ),
          ExamSchedule,
          PrefetchHooks Function()
        > {
  $$ExamSchedulesTableTableManager(_$AppDatabase db, $ExamSchedulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ExamSchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$ExamSchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ExamSchedulesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> subject = const Value.absent(),
                Value<String?> examType = const Value.absent(),
                Value<DateTime> examDate = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<String?> topicsCovered = const Value.absent(),
                Value<String?> resources = const Value.absent(),
                Value<int?> targetScore = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<int?> actualScore = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ExamSchedulesCompanion(
                id: id,
                name: name,
                subject: subject,
                examType: examType,
                examDate: examDate,
                durationMinutes: durationMinutes,
                topicsCovered: topicsCovered,
                resources: resources,
                targetScore: targetScore,
                notes: notes,
                isCompleted: isCompleted,
                actualScore: actualScore,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> subject = const Value.absent(),
                Value<String?> examType = const Value.absent(),
                required DateTime examDate,
                Value<int?> durationMinutes = const Value.absent(),
                Value<String?> topicsCovered = const Value.absent(),
                Value<String?> resources = const Value.absent(),
                Value<int?> targetScore = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<int?> actualScore = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => ExamSchedulesCompanion.insert(
                id: id,
                name: name,
                subject: subject,
                examType: examType,
                examDate: examDate,
                durationMinutes: durationMinutes,
                topicsCovered: topicsCovered,
                resources: resources,
                targetScore: targetScore,
                notes: notes,
                isCompleted: isCompleted,
                actualScore: actualScore,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$ExamSchedulesTable, ExamSchedule>(table),
                          BaseReferences<
                            _$AppDatabase,
                            $ExamSchedulesTable,
                            ExamSchedule
                          >(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExamSchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExamSchedulesTable,
      ExamSchedule,
      $$ExamSchedulesTableFilterComposer,
      $$ExamSchedulesTableOrderingComposer,
      $$ExamSchedulesTableAnnotationComposer,
      $$ExamSchedulesTableCreateCompanionBuilder,
      $$ExamSchedulesTableUpdateCompanionBuilder,
      (
        ExamSchedule,
        BaseReferences<_$AppDatabase, $ExamSchedulesTable, ExamSchedule>,
      ),
      ExamSchedule,
      PrefetchHooks Function()
    >;
typedef $$AchievementsTableCreateCompanionBuilder =
    AchievementsCompanion Function({
      Value<int> id,
      required String key,
      required String name,
      required String description,
      Value<String?> icon,
      required String category,
      Value<int> tier,
      Value<int> xpReward,
      Value<String?> criteria,
      Value<bool> isSecret,
      required DateTime createdAt,
    });
typedef $$AchievementsTableUpdateCompanionBuilder =
    AchievementsCompanion Function({
      Value<int> id,
      Value<String> key,
      Value<String> name,
      Value<String> description,
      Value<String?> icon,
      Value<String> category,
      Value<int> tier,
      Value<int> xpReward,
      Value<String?> criteria,
      Value<bool> isSecret,
      Value<DateTime> createdAt,
    });

final class $$AchievementsTableReferences
    extends BaseReferences<_$AppDatabase, $AchievementsTable, Achievement> {
  $$AchievementsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserAchievementsTable, List<UserAchievement>>
  _userAchievementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userAchievements,
    aliasName: 'achievements__id__user_achievements__achievement_id',
  );

  $$UserAchievementsTableProcessedTableManager get userAchievementsRefs {
    final manager = $$UserAchievementsTableTableManager(
      $_db,
      $_db.userAchievements,
    ).filter((f) => f.achievementId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userAchievementsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AchievementsTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableFilterComposer({
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

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
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

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpReward => $composableBuilder(
    column: $table.xpReward,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get criteria => $composableBuilder(
    column: $table.criteria,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSecret => $composableBuilder(
    column: $table.isSecret,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userAchievementsRefs(
    Expression<bool> Function($$UserAchievementsTableFilterComposer f) f,
  ) {
    final $$UserAchievementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAchievements,
      getReferencedColumn: (t) => t.achievementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAchievementsTableFilterComposer(
            $db: $db,
            $table: $db.userAchievements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AchievementsTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableOrderingComposer({
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

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
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

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpReward => $composableBuilder(
    column: $table.xpReward,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get criteria => $composableBuilder(
    column: $table.criteria,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSecret => $composableBuilder(
    column: $table.isSecret,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AchievementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<int> get xpReward =>
      $composableBuilder(column: $table.xpReward, builder: (column) => column);

  GeneratedColumn<String> get criteria =>
      $composableBuilder(column: $table.criteria, builder: (column) => column);

  GeneratedColumn<bool> get isSecret =>
      $composableBuilder(column: $table.isSecret, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> userAchievementsRefs<T extends Object>(
    Expression<T> Function($$UserAchievementsTableAnnotationComposer a) f,
  ) {
    final $$UserAchievementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAchievements,
      getReferencedColumn: (t) => t.achievementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAchievementsTableAnnotationComposer(
            $db: $db,
            $table: $db.userAchievements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AchievementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementsTable,
          Achievement,
          $$AchievementsTableFilterComposer,
          $$AchievementsTableOrderingComposer,
          $$AchievementsTableAnnotationComposer,
          $$AchievementsTableCreateCompanionBuilder,
          $$AchievementsTableUpdateCompanionBuilder,
          (Achievement, $$AchievementsTableReferences),
          Achievement,
          PrefetchHooks Function({bool userAchievementsRefs})
        > {
  $$AchievementsTableTableManager(_$AppDatabase db, $AchievementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AchievementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AchievementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$AchievementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> tier = const Value.absent(),
                Value<int> xpReward = const Value.absent(),
                Value<String?> criteria = const Value.absent(),
                Value<bool> isSecret = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AchievementsCompanion(
                id: id,
                key: key,
                name: name,
                description: description,
                icon: icon,
                category: category,
                tier: tier,
                xpReward: xpReward,
                criteria: criteria,
                isSecret: isSecret,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String key,
                required String name,
                required String description,
                Value<String?> icon = const Value.absent(),
                required String category,
                Value<int> tier = const Value.absent(),
                Value<int> xpReward = const Value.absent(),
                Value<String?> criteria = const Value.absent(),
                Value<bool> isSecret = const Value.absent(),
                required DateTime createdAt,
              }) => AchievementsCompanion.insert(
                id: id,
                key: key,
                name: name,
                description: description,
                icon: icon,
                category: category,
                tier: tier,
                xpReward: xpReward,
                criteria: criteria,
                isSecret: isSecret,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$AchievementsTable, Achievement>(table),
                          $$AchievementsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({userAchievementsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userAchievementsRefs) db.userAchievements,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userAchievementsRefs)
                    await $_getPrefetchedDataByColumns<
                      Achievement,
                      $AchievementsTable,
                      UserAchievement,
                      $UserAchievementsTable
                    >(
                      currentTable: table,
                      referencedTable: $$AchievementsTableReferences
                          ._userAchievementsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$AchievementsTableReferences(
                                db,
                                table,
                                p0,
                              ).userAchievementsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'achievement_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AchievementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementsTable,
      Achievement,
      $$AchievementsTableFilterComposer,
      $$AchievementsTableOrderingComposer,
      $$AchievementsTableAnnotationComposer,
      $$AchievementsTableCreateCompanionBuilder,
      $$AchievementsTableUpdateCompanionBuilder,
      (Achievement, $$AchievementsTableReferences),
      Achievement,
      PrefetchHooks Function({bool userAchievementsRefs})
    >;
typedef $$UserAchievementsTableCreateCompanionBuilder =
    UserAchievementsCompanion Function({
      Value<int> id,
      required int achievementId,
      Value<int> progress,
      Value<int> target,
      Value<bool> isUnlocked,
      Value<DateTime?> unlockedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$UserAchievementsTableUpdateCompanionBuilder =
    UserAchievementsCompanion Function({
      Value<int> id,
      Value<int> achievementId,
      Value<int> progress,
      Value<int> target,
      Value<bool> isUnlocked,
      Value<DateTime?> unlockedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$UserAchievementsTableReferences
    extends
        BaseReferences<_$AppDatabase, $UserAchievementsTable, UserAchievement> {
  $$UserAchievementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AchievementsTable _achievementIdTable(_$AppDatabase db) => db
      .achievements
      .createAlias('user_achievements__achievement_id__achievements__id');

  $$AchievementsTableProcessedTableManager get achievementId {
    final $_column = $_itemColumn<int>('achievement_id')!;

    final manager = $$AchievementsTableTableManager(
      $_db,
      $_db.achievements,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_achievementIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserAchievementsTableFilterComposer
    extends Composer<_$AppDatabase, $UserAchievementsTable> {
  $$UserAchievementsTableFilterComposer({
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

  ColumnFilters<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUnlocked => $composableBuilder(
    column: $table.isUnlocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
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

  $$AchievementsTableFilterComposer get achievementId {
    final $$AchievementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.achievementId,
      referencedTable: $db.achievements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AchievementsTableFilterComposer(
            $db: $db,
            $table: $db.achievements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAchievementsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserAchievementsTable> {
  $$UserAchievementsTableOrderingComposer({
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

  ColumnOrderings<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUnlocked => $composableBuilder(
    column: $table.isUnlocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
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

  $$AchievementsTableOrderingComposer get achievementId {
    final $$AchievementsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.achievementId,
      referencedTable: $db.achievements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AchievementsTableOrderingComposer(
            $db: $db,
            $table: $db.achievements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAchievementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserAchievementsTable> {
  $$UserAchievementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<int> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumn<bool> get isUnlocked => $composableBuilder(
    column: $table.isUnlocked,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AchievementsTableAnnotationComposer get achievementId {
    final $$AchievementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.achievementId,
      referencedTable: $db.achievements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AchievementsTableAnnotationComposer(
            $db: $db,
            $table: $db.achievements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAchievementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserAchievementsTable,
          UserAchievement,
          $$UserAchievementsTableFilterComposer,
          $$UserAchievementsTableOrderingComposer,
          $$UserAchievementsTableAnnotationComposer,
          $$UserAchievementsTableCreateCompanionBuilder,
          $$UserAchievementsTableUpdateCompanionBuilder,
          (UserAchievement, $$UserAchievementsTableReferences),
          UserAchievement,
          PrefetchHooks Function({bool achievementId})
        > {
  $$UserAchievementsTableTableManager(
    _$AppDatabase db,
    $UserAchievementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$UserAchievementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UserAchievementsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$UserAchievementsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> achievementId = const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<int> target = const Value.absent(),
                Value<bool> isUnlocked = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserAchievementsCompanion(
                id: id,
                achievementId: achievementId,
                progress: progress,
                target: target,
                isUnlocked: isUnlocked,
                unlockedAt: unlockedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int achievementId,
                Value<int> progress = const Value.absent(),
                Value<int> target = const Value.absent(),
                Value<bool> isUnlocked = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => UserAchievementsCompanion.insert(
                id: id,
                achievementId: achievementId,
                progress: progress,
                target: target,
                isUnlocked: isUnlocked,
                unlockedAt: unlockedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$UserAchievementsTable, UserAchievement>(
                            table,
                          ),
                          $$UserAchievementsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({achievementId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (achievementId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.achievementId,
                            referencedTable: $$UserAchievementsTableReferences
                                ._achievementIdTable(db),
                            referencedColumn:
                                $$UserAchievementsTableReferences
                                    ._achievementIdTable(db)
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

typedef $$UserAchievementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserAchievementsTable,
      UserAchievement,
      $$UserAchievementsTableFilterComposer,
      $$UserAchievementsTableOrderingComposer,
      $$UserAchievementsTableAnnotationComposer,
      $$UserAchievementsTableCreateCompanionBuilder,
      $$UserAchievementsTableUpdateCompanionBuilder,
      (UserAchievement, $$UserAchievementsTableReferences),
      UserAchievement,
      PrefetchHooks Function({bool achievementId})
    >;
typedef $$NotificationsTableCreateCompanionBuilder =
    NotificationsCompanion Function({
      Value<int> id,
      required String type,
      required String title,
      required String body,
      Value<String?> payload,
      Value<bool> isRead,
      Value<bool> isDismissed,
      Value<DateTime?> scheduledFor,
      Value<DateTime?> readAt,
      required DateTime createdAt,
    });
typedef $$NotificationsTableUpdateCompanionBuilder =
    NotificationsCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<String> title,
      Value<String> body,
      Value<String?> payload,
      Value<bool> isRead,
      Value<bool> isDismissed,
      Value<DateTime?> scheduledFor,
      Value<DateTime?> readAt,
      Value<DateTime> createdAt,
    });

class $$NotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDismissed => $composableBuilder(
    column: $table.isDismissed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDismissed => $composableBuilder(
    column: $table.isDismissed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<bool> get isDismissed => $composableBuilder(
    column: $table.isDismissed,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get readAt =>
      $composableBuilder(column: $table.readAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$NotificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationsTable,
          Notification,
          $$NotificationsTableFilterComposer,
          $$NotificationsTableOrderingComposer,
          $$NotificationsTableAnnotationComposer,
          $$NotificationsTableCreateCompanionBuilder,
          $$NotificationsTableUpdateCompanionBuilder,
          (
            Notification,
            BaseReferences<_$AppDatabase, $NotificationsTable, Notification>,
          ),
          Notification,
          PrefetchHooks Function()
        > {
  $$NotificationsTableTableManager(_$AppDatabase db, $NotificationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$NotificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$NotificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$NotificationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String?> payload = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isDismissed = const Value.absent(),
                Value<DateTime?> scheduledFor = const Value.absent(),
                Value<DateTime?> readAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => NotificationsCompanion(
                id: id,
                type: type,
                title: title,
                body: body,
                payload: payload,
                isRead: isRead,
                isDismissed: isDismissed,
                scheduledFor: scheduledFor,
                readAt: readAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required String title,
                required String body,
                Value<String?> payload = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isDismissed = const Value.absent(),
                Value<DateTime?> scheduledFor = const Value.absent(),
                Value<DateTime?> readAt = const Value.absent(),
                required DateTime createdAt,
              }) => NotificationsCompanion.insert(
                id: id,
                type: type,
                title: title,
                body: body,
                payload: payload,
                isRead: isRead,
                isDismissed: isDismissed,
                scheduledFor: scheduledFor,
                readAt: readAt,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$NotificationsTable, Notification>(table),
                          BaseReferences<
                            _$AppDatabase,
                            $NotificationsTable,
                            Notification
                          >(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationsTable,
      Notification,
      $$NotificationsTableFilterComposer,
      $$NotificationsTableOrderingComposer,
      $$NotificationsTableAnnotationComposer,
      $$NotificationsTableCreateCompanionBuilder,
      $$NotificationsTableUpdateCompanionBuilder,
      (
        Notification,
        BaseReferences<_$AppDatabase, $NotificationsTable, Notification>,
      ),
      Notification,
      PrefetchHooks Function()
    >;
typedef $$RecommendationsTableCreateCompanionBuilder =
    RecommendationsCompanion Function({
      Value<int> id,
      required String type,
      required String title,
      required String description,
      required String reason,
      Value<int> priority,
      Value<int?> topicId,
      Value<int?> resourceId,
      Value<bool> isDismissed,
      Value<bool> isAccepted,
      Value<DateTime?> expiresAt,
      required DateTime createdAt,
    });
typedef $$RecommendationsTableUpdateCompanionBuilder =
    RecommendationsCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<String> title,
      Value<String> description,
      Value<String> reason,
      Value<int> priority,
      Value<int?> topicId,
      Value<int?> resourceId,
      Value<bool> isDismissed,
      Value<bool> isAccepted,
      Value<DateTime?> expiresAt,
      Value<DateTime> createdAt,
    });

final class $$RecommendationsTableReferences
    extends
        BaseReferences<_$AppDatabase, $RecommendationsTable, Recommendation> {
  $$RecommendationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TopicsTable _topicIdTable(_$AppDatabase db) =>
      db.topics.createAlias('recommendations__topic_id__topics__id');

  $$TopicsTableProcessedTableManager? get topicId {
    final $_column = $_itemColumn<int>('topic_id');
    if ($_column == null) return null;
    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LearningResourcesTable _resourceIdTable(_$AppDatabase db) => db
      .learningResources
      .createAlias('recommendations__resource_id__learning_resources__id');

  $$LearningResourcesTableProcessedTableManager? get resourceId {
    final $_column = $_itemColumn<int>('resource_id');
    if ($_column == null) return null;
    final manager = $$LearningResourcesTableTableManager(
      $_db,
      $_db.learningResources,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_resourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecommendationsTableFilterComposer
    extends Composer<_$AppDatabase, $RecommendationsTable> {
  $$RecommendationsTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
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

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDismissed => $composableBuilder(
    column: $table.isDismissed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAccepted => $composableBuilder(
    column: $table.isAccepted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LearningResourcesTableFilterComposer get resourceId {
    final $$LearningResourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.resourceId,
      referencedTable: $db.learningResources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningResourcesTableFilterComposer(
            $db: $db,
            $table: $db.learningResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecommendationsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecommendationsTable> {
  $$RecommendationsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
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

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDismissed => $composableBuilder(
    column: $table.isDismissed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAccepted => $composableBuilder(
    column: $table.isAccepted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LearningResourcesTableOrderingComposer get resourceId {
    final $$LearningResourcesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.resourceId,
      referencedTable: $db.learningResources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningResourcesTableOrderingComposer(
            $db: $db,
            $table: $db.learningResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecommendationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecommendationsTable> {
  $$RecommendationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<bool> get isDismissed => $composableBuilder(
    column: $table.isDismissed,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAccepted => $composableBuilder(
    column: $table.isAccepted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LearningResourcesTableAnnotationComposer get resourceId {
    final $$LearningResourcesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.resourceId,
          referencedTable: $db.learningResources,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LearningResourcesTableAnnotationComposer(
                $db: $db,
                $table: $db.learningResources,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$RecommendationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecommendationsTable,
          Recommendation,
          $$RecommendationsTableFilterComposer,
          $$RecommendationsTableOrderingComposer,
          $$RecommendationsTableAnnotationComposer,
          $$RecommendationsTableCreateCompanionBuilder,
          $$RecommendationsTableUpdateCompanionBuilder,
          (Recommendation, $$RecommendationsTableReferences),
          Recommendation,
          PrefetchHooks Function({bool topicId, bool resourceId})
        > {
  $$RecommendationsTableTableManager(
    _$AppDatabase db,
    $RecommendationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$RecommendationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RecommendationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$RecommendationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int?> topicId = const Value.absent(),
                Value<int?> resourceId = const Value.absent(),
                Value<bool> isDismissed = const Value.absent(),
                Value<bool> isAccepted = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RecommendationsCompanion(
                id: id,
                type: type,
                title: title,
                description: description,
                reason: reason,
                priority: priority,
                topicId: topicId,
                resourceId: resourceId,
                isDismissed: isDismissed,
                isAccepted: isAccepted,
                expiresAt: expiresAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required String title,
                required String description,
                required String reason,
                Value<int> priority = const Value.absent(),
                Value<int?> topicId = const Value.absent(),
                Value<int?> resourceId = const Value.absent(),
                Value<bool> isDismissed = const Value.absent(),
                Value<bool> isAccepted = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                required DateTime createdAt,
              }) => RecommendationsCompanion.insert(
                id: id,
                type: type,
                title: title,
                description: description,
                reason: reason,
                priority: priority,
                topicId: topicId,
                resourceId: resourceId,
                isDismissed: isDismissed,
                isAccepted: isAccepted,
                expiresAt: expiresAt,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$RecommendationsTable, Recommendation>(
                            table,
                          ),
                          $$RecommendationsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({topicId = false, resourceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (topicId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.topicId,
                            referencedTable: $$RecommendationsTableReferences
                                ._topicIdTable(db),
                            referencedColumn:
                                $$RecommendationsTableReferences
                                    ._topicIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (resourceId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.resourceId,
                            referencedTable: $$RecommendationsTableReferences
                                ._resourceIdTable(db),
                            referencedColumn:
                                $$RecommendationsTableReferences
                                    ._resourceIdTable(db)
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

typedef $$RecommendationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecommendationsTable,
      Recommendation,
      $$RecommendationsTableFilterComposer,
      $$RecommendationsTableOrderingComposer,
      $$RecommendationsTableAnnotationComposer,
      $$RecommendationsTableCreateCompanionBuilder,
      $$RecommendationsTableUpdateCompanionBuilder,
      (Recommendation, $$RecommendationsTableReferences),
      Recommendation,
      PrefetchHooks Function({bool topicId, bool resourceId})
    >;
typedef $$MindMapsTableCreateCompanionBuilder =
    MindMapsCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> description,
      Value<int?> topicId,
      Value<int?> subjectId,
      required String data,
      Value<String?> layout,
      Value<bool> isAiGenerated,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$MindMapsTableUpdateCompanionBuilder =
    MindMapsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> description,
      Value<int?> topicId,
      Value<int?> subjectId,
      Value<String> data,
      Value<String?> layout,
      Value<bool> isAiGenerated,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$MindMapsTableReferences
    extends BaseReferences<_$AppDatabase, $MindMapsTable, MindMap> {
  $$MindMapsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TopicsTable _topicIdTable(_$AppDatabase db) =>
      db.topics.createAlias('mind_maps__topic_id__topics__id');

  $$TopicsTableProcessedTableManager? get topicId {
    final $_column = $_itemColumn<int>('topic_id');
    if ($_column == null) return null;
    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('mind_maps__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager? get subjectId {
    final $_column = $_itemColumn<int>('subject_id');
    if ($_column == null) return null;
    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MindMapsTableFilterComposer
    extends Composer<_$AppDatabase, $MindMapsTable> {
  $$MindMapsTableFilterComposer({
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

  ColumnFilters<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get layout => $composableBuilder(
    column: $table.layout,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAiGenerated => $composableBuilder(
    column: $table.isAiGenerated,
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

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MindMapsTableOrderingComposer
    extends Composer<_$AppDatabase, $MindMapsTable> {
  $$MindMapsTableOrderingComposer({
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

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get layout => $composableBuilder(
    column: $table.layout,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAiGenerated => $composableBuilder(
    column: $table.isAiGenerated,
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

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MindMapsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MindMapsTable> {
  $$MindMapsTableAnnotationComposer({
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

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<String> get layout =>
      $composableBuilder(column: $table.layout, builder: (column) => column);

  GeneratedColumn<bool> get isAiGenerated => $composableBuilder(
    column: $table.isAiGenerated,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MindMapsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MindMapsTable,
          MindMap,
          $$MindMapsTableFilterComposer,
          $$MindMapsTableOrderingComposer,
          $$MindMapsTableAnnotationComposer,
          $$MindMapsTableCreateCompanionBuilder,
          $$MindMapsTableUpdateCompanionBuilder,
          (MindMap, $$MindMapsTableReferences),
          MindMap,
          PrefetchHooks Function({bool topicId, bool subjectId})
        > {
  $$MindMapsTableTableManager(_$AppDatabase db, $MindMapsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MindMapsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$MindMapsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$MindMapsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int?> topicId = const Value.absent(),
                Value<int?> subjectId = const Value.absent(),
                Value<String> data = const Value.absent(),
                Value<String?> layout = const Value.absent(),
                Value<bool> isAiGenerated = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MindMapsCompanion(
                id: id,
                title: title,
                description: description,
                topicId: topicId,
                subjectId: subjectId,
                data: data,
                layout: layout,
                isAiGenerated: isAiGenerated,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                Value<int?> topicId = const Value.absent(),
                Value<int?> subjectId = const Value.absent(),
                required String data,
                Value<String?> layout = const Value.absent(),
                Value<bool> isAiGenerated = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => MindMapsCompanion.insert(
                id: id,
                title: title,
                description: description,
                topicId: topicId,
                subjectId: subjectId,
                data: data,
                layout: layout,
                isAiGenerated: isAiGenerated,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$MindMapsTable, MindMap>(table),
                          $$MindMapsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({topicId = false, subjectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (topicId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.topicId,
                            referencedTable: $$MindMapsTableReferences
                                ._topicIdTable(db),
                            referencedColumn:
                                $$MindMapsTableReferences._topicIdTable(db).id,
                          )
                          as T;
                }
                if (subjectId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$MindMapsTableReferences
                                ._subjectIdTable(db),
                            referencedColumn:
                                $$MindMapsTableReferences
                                    ._subjectIdTable(db)
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

typedef $$MindMapsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MindMapsTable,
      MindMap,
      $$MindMapsTableFilterComposer,
      $$MindMapsTableOrderingComposer,
      $$MindMapsTableAnnotationComposer,
      $$MindMapsTableCreateCompanionBuilder,
      $$MindMapsTableUpdateCompanionBuilder,
      (MindMap, $$MindMapsTableReferences),
      MindMap,
      PrefetchHooks Function({bool topicId, bool subjectId})
    >;
typedef $$VideoTranscriptsTableCreateCompanionBuilder =
    VideoTranscriptsCompanion Function({
      Value<int> id,
      required int resourceId,
      Value<String> language,
      required String fullText,
      required String segments,
      Value<String?> summary,
      Value<String?> keyTopics,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$VideoTranscriptsTableUpdateCompanionBuilder =
    VideoTranscriptsCompanion Function({
      Value<int> id,
      Value<int> resourceId,
      Value<String> language,
      Value<String> fullText,
      Value<String> segments,
      Value<String?> summary,
      Value<String?> keyTopics,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$VideoTranscriptsTableReferences
    extends
        BaseReferences<_$AppDatabase, $VideoTranscriptsTable, VideoTranscript> {
  $$VideoTranscriptsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LearningResourcesTable _resourceIdTable(_$AppDatabase db) => db
      .learningResources
      .createAlias('video_transcripts__resource_id__learning_resources__id');

  $$LearningResourcesTableProcessedTableManager get resourceId {
    final $_column = $_itemColumn<int>('resource_id')!;

    final manager = $$LearningResourcesTableTableManager(
      $_db,
      $_db.learningResources,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_resourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VideoTranscriptsTableFilterComposer
    extends Composer<_$AppDatabase, $VideoTranscriptsTable> {
  $$VideoTranscriptsTableFilterComposer({
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

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullText => $composableBuilder(
    column: $table.fullText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get segments => $composableBuilder(
    column: $table.segments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keyTopics => $composableBuilder(
    column: $table.keyTopics,
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

  $$LearningResourcesTableFilterComposer get resourceId {
    final $$LearningResourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.resourceId,
      referencedTable: $db.learningResources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningResourcesTableFilterComposer(
            $db: $db,
            $table: $db.learningResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoTranscriptsTableOrderingComposer
    extends Composer<_$AppDatabase, $VideoTranscriptsTable> {
  $$VideoTranscriptsTableOrderingComposer({
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

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullText => $composableBuilder(
    column: $table.fullText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get segments => $composableBuilder(
    column: $table.segments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keyTopics => $composableBuilder(
    column: $table.keyTopics,
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

  $$LearningResourcesTableOrderingComposer get resourceId {
    final $$LearningResourcesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.resourceId,
      referencedTable: $db.learningResources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningResourcesTableOrderingComposer(
            $db: $db,
            $table: $db.learningResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VideoTranscriptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VideoTranscriptsTable> {
  $$VideoTranscriptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get fullText =>
      $composableBuilder(column: $table.fullText, builder: (column) => column);

  GeneratedColumn<String> get segments =>
      $composableBuilder(column: $table.segments, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get keyTopics =>
      $composableBuilder(column: $table.keyTopics, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LearningResourcesTableAnnotationComposer get resourceId {
    final $$LearningResourcesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.resourceId,
          referencedTable: $db.learningResources,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LearningResourcesTableAnnotationComposer(
                $db: $db,
                $table: $db.learningResources,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$VideoTranscriptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VideoTranscriptsTable,
          VideoTranscript,
          $$VideoTranscriptsTableFilterComposer,
          $$VideoTranscriptsTableOrderingComposer,
          $$VideoTranscriptsTableAnnotationComposer,
          $$VideoTranscriptsTableCreateCompanionBuilder,
          $$VideoTranscriptsTableUpdateCompanionBuilder,
          (VideoTranscript, $$VideoTranscriptsTableReferences),
          VideoTranscript,
          PrefetchHooks Function({bool resourceId})
        > {
  $$VideoTranscriptsTableTableManager(
    _$AppDatabase db,
    $VideoTranscriptsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$VideoTranscriptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$VideoTranscriptsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$VideoTranscriptsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> resourceId = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> fullText = const Value.absent(),
                Value<String> segments = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<String?> keyTopics = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => VideoTranscriptsCompanion(
                id: id,
                resourceId: resourceId,
                language: language,
                fullText: fullText,
                segments: segments,
                summary: summary,
                keyTopics: keyTopics,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int resourceId,
                Value<String> language = const Value.absent(),
                required String fullText,
                required String segments,
                Value<String?> summary = const Value.absent(),
                Value<String?> keyTopics = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => VideoTranscriptsCompanion.insert(
                id: id,
                resourceId: resourceId,
                language: language,
                fullText: fullText,
                segments: segments,
                summary: summary,
                keyTopics: keyTopics,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable<$VideoTranscriptsTable, VideoTranscript>(
                            table,
                          ),
                          $$VideoTranscriptsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({resourceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (resourceId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.resourceId,
                            referencedTable: $$VideoTranscriptsTableReferences
                                ._resourceIdTable(db),
                            referencedColumn:
                                $$VideoTranscriptsTableReferences
                                    ._resourceIdTable(db)
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

typedef $$VideoTranscriptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VideoTranscriptsTable,
      VideoTranscript,
      $$VideoTranscriptsTableFilterComposer,
      $$VideoTranscriptsTableOrderingComposer,
      $$VideoTranscriptsTableAnnotationComposer,
      $$VideoTranscriptsTableCreateCompanionBuilder,
      $$VideoTranscriptsTableUpdateCompanionBuilder,
      (VideoTranscript, $$VideoTranscriptsTableReferences),
      VideoTranscript,
      PrefetchHooks Function({bool resourceId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ConversationsTableTableManager get conversations =>
      $$ConversationsTableTableManager(_db, _db.conversations);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$QuizHistoryTableTableManager get quizHistory =>
      $$QuizHistoryTableTableManager(_db, _db.quizHistory);
  $$LearningActivityTableTableManager get learningActivity =>
      $$LearningActivityTableTableManager(_db, _db.learningActivity);
  $$AppModelsTableTableManager get appModels =>
      $$AppModelsTableTableManager(_db, _db.appModels);
  $$PreferencesTableTableManager get preferences =>
      $$PreferencesTableTableManager(_db, _db.preferences);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$MemoriesTableTableManager get memories =>
      $$MemoriesTableTableManager(_db, _db.memories);
  $$SubjectsTableTableManager get subjects =>
      $$SubjectsTableTableManager(_db, _db.subjects);
  $$ChaptersTableTableManager get chapters =>
      $$ChaptersTableTableManager(_db, _db.chapters);
  $$TopicsTableTableManager get topics =>
      $$TopicsTableTableManager(_db, _db.topics);
  $$LearningResourcesTableTableManager get learningResources =>
      $$LearningResourcesTableTableManager(_db, _db.learningResources);
  $$FlashcardDecksTableTableManager get flashcardDecks =>
      $$FlashcardDecksTableTableManager(_db, _db.flashcardDecks);
  $$FlashcardsTableTableManager get flashcards =>
      $$FlashcardsTableTableManager(_db, _db.flashcards);
  $$FlashcardReviewsTableTableManager get flashcardReviews =>
      $$FlashcardReviewsTableTableManager(_db, _db.flashcardReviews);
  $$StudyPlansTableTableManager get studyPlans =>
      $$StudyPlansTableTableManager(_db, _db.studyPlans);
  $$StudyPlanItemsTableTableManager get studyPlanItems =>
      $$StudyPlanItemsTableTableManager(_db, _db.studyPlanItems);
  $$StudySessionsTableTableManager get studySessions =>
      $$StudySessionsTableTableManager(_db, _db.studySessions);
  $$ExamSchedulesTableTableManager get examSchedules =>
      $$ExamSchedulesTableTableManager(_db, _db.examSchedules);
  $$AchievementsTableTableManager get achievements =>
      $$AchievementsTableTableManager(_db, _db.achievements);
  $$UserAchievementsTableTableManager get userAchievements =>
      $$UserAchievementsTableTableManager(_db, _db.userAchievements);
  $$NotificationsTableTableManager get notifications =>
      $$NotificationsTableTableManager(_db, _db.notifications);
  $$RecommendationsTableTableManager get recommendations =>
      $$RecommendationsTableTableManager(_db, _db.recommendations);
  $$MindMapsTableTableManager get mindMaps =>
      $$MindMapsTableTableManager(_db, _db.mindMaps);
  $$VideoTranscriptsTableTableManager get videoTranscripts =>
      $$VideoTranscriptsTableTableManager(_db, _db.videoTranscripts);
}
