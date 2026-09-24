// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pay_pilot_plus/core/database/app_database.dart'
    show GeneralAccountType, AccountGroupType, SubsidiaryAccountType;

class SubsidiaryModel {
  final int id;
  final ({int id, AccountGroupType type}) accountGroup;
  final ({int id, GeneralAccountType type}) generalAccount;
  final SubsidiaryAccountType type;
  SubsidiaryModel({
    required this.id,
    required this.accountGroup,
    required this.generalAccount,
    required this.type,
  });

  SubsidiaryModel copyWith({
    int? id,
    ({int id, AccountGroupType type})? accountGroup,
    ({int id, GeneralAccountType type})? generalAccount,

    SubsidiaryAccountType? type,
  }) {
    return SubsidiaryModel(
      id: id ?? this.id,
      accountGroup: accountGroup ?? this.accountGroup,
      generalAccount: generalAccount ?? this.generalAccount,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'accountGroup': <String, dynamic>{
        'id': accountGroup.id,
        'type': accountGroup.type.title,
      },
      'generalAccount': <String, dynamic>{
        'id': generalAccount.id,
        'type': generalAccount.type.title,
      },
      'type': type.title,
    };
  }

  factory SubsidiaryModel.fromMap(Map<String, dynamic> map) {
    final accountGroupData = map['accountGroup'];
    final generalAccountData = map['generalAccount'];

    return SubsidiaryModel(
      id: map['id'] as int,
      accountGroup: (
        id: accountGroupData['id'],
        type: AccountGroupType.fromTitle(accountGroupData['type']),
      ),
      generalAccount: (
        id: generalAccountData['id'],
        type: GeneralAccountType.fromTitle(generalAccountData['type']),
      ),
      type: SubsidiaryAccountType.fromTitle(map['type']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubsidiaryModel.fromJson(String source) =>
      SubsidiaryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
