import 'dart:convert';

import 'package:pay_pilot_plus/core/utils/helpers/data_models_helper.dart';

class EventModel {
  final int id;
  final String title;
  final DateTime date;
  final bool isClosed;
  final ({int id, String name}) teamInfo;
  final ({int id, String name, String code}) detailedAccountInfo;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.isClosed,
    required this.teamInfo,
    required this.detailedAccountInfo,
  });

  EventModel copyWith({
    int? id,
    String? title,
    DateTime? date,
    bool? isClosed,
    ({int id, String name})? teamInfo,
    ({int id, String name, String code})? detailedAccountInfo,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      isClosed: isClosed ?? this.isClosed,
      teamInfo: teamInfo ?? this.teamInfo,
      detailedAccountInfo: detailedAccountInfo ?? this.detailedAccountInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'date': date.millisecondsSinceEpoch,
      'isClosed': isClosed,
      'teamInfo': <String, dynamic>{'id': teamInfo.id, 'name': teamInfo.name},
      'detailedAccountInfo': <String, dynamic>{
        'id': detailedAccountInfo.id,
        'name': detailedAccountInfo.name,
        'code': detailedAccountInfo.code,
      },
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    final teamInfoData = map['teamInfo'];
    final accountInfoData = map['detailedAccountInfo'];

    return EventModel(
      id: map['id'] as int,
      title: map['title'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      isClosed: map['isClosed'] as bool,
      teamInfo: DataModelsHelper.parseInfo(teamInfoData),
      detailedAccountInfo: DataModelsHelper.parseDetailedAccountInfo(
        accountInfoData,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
