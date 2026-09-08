import 'dart:convert';

class TeamModel {
  final int id;
  final String title;
  final String? description;
  final bool isActive;

  TeamModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isActive,
  });

  TeamModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isActive,
  }) {
    return TeamModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'isActive': isActive,
    };
  }

  factory TeamModel.fromMap(Map<String, dynamic> map) {
    return TeamModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamModel.fromJson(String source) =>
      TeamModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
