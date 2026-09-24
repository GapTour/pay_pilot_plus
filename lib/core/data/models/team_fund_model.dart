import 'dart:convert';

import 'package:pay_pilot_plus/core/utils/helpers/data_models_helper.dart';

class TeamFundModel {
  final int id;
  final ({int id, String name}) teamInfo;
  final ({int id, String name}) fundInfo;
  final double sharePercentage;

  TeamFundModel({
    required this.id,
    required this.sharePercentage,
    required this.teamInfo,
    required this.fundInfo,
  });

  TeamFundModel copyWith({
    int? id,
    double? sharePercentage,
    ({int id, String name})? teamInfo,
    ({int id, String name})? fundInfo,
  }) {
    return TeamFundModel(
      id: id ?? this.id,
      sharePercentage: sharePercentage ?? this.sharePercentage,
      teamInfo: teamInfo ?? this.teamInfo,
      fundInfo: fundInfo ?? this.fundInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sharePercentage': sharePercentage,
      'teamInfo': <String, dynamic>{'id': teamInfo.id, 'name': teamInfo.name},
      'fundInfo': <String, dynamic>{'id': fundInfo.id, 'name': fundInfo.name},
    };
  }

  factory TeamFundModel.fromMap(Map<String, dynamic> map) {
    final teamInfoData = map['teamInfo'];
    final fundInfoData = map['fundInfo'];

    return TeamFundModel(
      id: map['id'] as int,
      sharePercentage: map['sharePercentage'] as double,
      teamInfo: DataModelsHelper.parseInfo(teamInfoData),
      fundInfo: DataModelsHelper.parseInfo(fundInfoData),
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamFundModel.fromJson(String source) =>
      TeamFundModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
