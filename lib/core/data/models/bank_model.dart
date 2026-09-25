import 'dart:convert';

import 'package:pay_pilot_plus/core/utils/helpers/data_models_helper.dart';

class BankModel {
  final int id;
  final String name;
  final String? description;
  final String? number;
  final BigInt openingBalance;
  final bool isActive;
  final ({int id, String name, String code}) detailedAccountInfo;

  BankModel({
    required this.id,
    required this.name,
    required this.description,
    required this.number,
    required this.openingBalance,
    required this.isActive,
    required this.detailedAccountInfo,
  });

  BankModel copyWith({
    int? id,
    String? name,
    String? description,
    String? number,
    BigInt? openingBalance,
    bool? isActive,
    ({int id, String name, String code})? detailedAccountInfo,
  }) {
    return BankModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      number: number ?? this.number,
      isActive: isActive ?? this.isActive,
      openingBalance: openingBalance ?? this.openingBalance,
      detailedAccountInfo: detailedAccountInfo ?? this.detailedAccountInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'number': number,
      'openingBalance': openingBalance.toString(),
      'isActive': isActive,
      'detailedAccountInfo': <String, dynamic>{
        'id': detailedAccountInfo.id,
        'name': detailedAccountInfo.name,
        'code': detailedAccountInfo.code,
      },
    };
  }

  factory BankModel.fromMap(Map<String, dynamic> map) {
    final accountInfoData = map['detailedAccountInfo'];

    return BankModel(
      id: map['id'] as int,
      name: map['name'] as String,
      openingBalance: BigInt.parse(map['openingBalance']),
      description: map['description'] != null
          ? map['description'] as String
          : null,
      number: map['number'] != null ? map['number'] as String : null,
      isActive: map['isActive'] as bool,
      detailedAccountInfo: DataModelsHelper.parseDetailedAccountInfo(
        accountInfoData,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BankModel.fromJson(String source) =>
      BankModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
