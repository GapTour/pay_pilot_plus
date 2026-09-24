import 'dart:convert';

import 'package:pay_pilot_plus/core/database/app_database.dart'
    show JournalType;

class HeaderModel {
  final int id;
  final String entryNumber;
  final DateTime entryDate;
  final String? description;
  final JournalType type;
  final DateTime createdAt;
  HeaderModel({
    required this.id,
    required this.entryNumber,
    required this.entryDate,
    this.description,
    required this.type,
    required this.createdAt,
  });

  HeaderModel copyWith({
    int? id,
    String? entryNumber,
    DateTime? entryDate,
    String? description,
    JournalType? type,
    DateTime? createdAt,
  }) {
    return HeaderModel(
      id: id ?? this.id,
      entryNumber: entryNumber ?? this.entryNumber,
      entryDate: entryDate ?? this.entryDate,
      description: description ?? this.description,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'entryNumber': entryNumber,
      'entryDate': entryDate.millisecondsSinceEpoch,
      'description': description,
      'type': type.title,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory HeaderModel.fromMap(Map<String, dynamic> map) {
    return HeaderModel(
      id: map['id'] as int,
      entryNumber: map['entryNumber'] as String,
      entryDate: DateTime.fromMillisecondsSinceEpoch(map['entryDate'] as int),
      description: map['description'] != null
          ? map['description'] as String
          : null,
      type: JournalType.fromTitle(map['type']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory HeaderModel.fromJson(String source) =>
      HeaderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
