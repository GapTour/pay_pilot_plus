import 'dart:convert';

import 'package:pay_pilot_plus/core/utils/helpers/data_models_helper.dart';

class EventModel {
  final int id;
  final String title;
  final DateTime date;
  final bool isClosed;
  final BigInt entranceFee;
  final BigInt snacksFee;
  final ({int id, String name}) teamInfo;
  final ({int id, String name}) userInfo;
  final ({int id, String name, String code}) detailedAccountInfo;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.isClosed,
    required this.entranceFee,
    required this.snacksFee,
    required this.teamInfo,
    required this.userInfo,
    required this.detailedAccountInfo,
  });

  EventModel copyWith({
    int? id,
    String? title,
    DateTime? date,
    bool? isClosed,
    BigInt? entranceFee,
    BigInt? snacksFee,
    ({int id, String name})? teamInfo,
    ({int id, String name})? userInfo,
    ({int id, String name, String code})? detailedAccountInfo,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      isClosed: isClosed ?? this.isClosed,
      entranceFee: entranceFee ?? this.entranceFee,
      snacksFee: snacksFee ?? this.snacksFee,
      teamInfo: teamInfo ?? this.teamInfo,
      userInfo: userInfo ?? this.userInfo,
      detailedAccountInfo: detailedAccountInfo ?? this.detailedAccountInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'date': date.millisecondsSinceEpoch,
      'isClosed': isClosed,
      'entranceFee': entranceFee,
      'snacksFee': snacksFee,
      'teamInfo': <String, dynamic>{'id': teamInfo.id, 'name': teamInfo.name},
      'userInfo': <String, dynamic>{'id': teamInfo.id, 'name': teamInfo.name},
      'detailedAccountInfo': <String, dynamic>{
        'id': detailedAccountInfo.id,
        'name': detailedAccountInfo.name,
        'code': detailedAccountInfo.code,
      },
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    final teamInfoData = map['teamInfo'];
    final userInfoData = map['userInfo'];
    final accountInfoData = map['detailedAccountInfo'];

    return EventModel(
      id: map['id'] as int,
      title: map['title'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      isClosed: map['isClosed'] as bool,
      entranceFee: BigInt.parse(map['entranceFee']),
      snacksFee: BigInt.parse(map['snacksFee']),
      teamInfo: DataModelsHelper.parseInfo(teamInfoData),
      userInfo: DataModelsHelper.parseInfo(userInfoData),
      detailedAccountInfo: DataModelsHelper.parseDetailedAccountInfo(
        accountInfoData,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
