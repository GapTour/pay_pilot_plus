import 'dart:convert';

import 'package:pay_pilot_plus/core/data/models/detailed_account_model.dart';
import 'package:pay_pilot_plus/core/data/models/subsidiary_model.dart';

class JournalLineModel {
  final int id;
  final int headerID;
  final SubsidiaryModel subsidiaryAccount;
  final DetailedAccountModel? firstDetailedInfo;
  final DetailedAccountModel? secondDetailedInfo;
  final BigInt debit;
  final BigInt credit;
  final String series;
  final String? memo;
  final String? noticeMemo;
  JournalLineModel({
    required this.id,
    required this.headerID,
    required this.subsidiaryAccount,
    required this.firstDetailedInfo,
    required this.secondDetailedInfo,
    required this.debit,
    required this.credit,
    required this.series,
    required this.noticeMemo,
    this.memo,
  }) : assert(debit >= BigInt.zero, 'Debit cannot be negative'),
       assert(credit >= BigInt.zero, 'Credit cannot be negative'),
       assert(
         debit == BigInt.zero || credit == BigInt.zero,
         'A journal line cannot have both debit and credit values simultaneously.',
       );

  JournalLineModel copyWith({
    int? id,
    int? headerID,
    SubsidiaryModel? subsidiaryAccount,
    DetailedAccountModel? firstDetailedInfo,
    DetailedAccountModel? secondDetailedInfo,
    BigInt? debit,
    BigInt? credit,
    String? series,
    String? memo,
    String? noticeMemo,
  }) {
    return JournalLineModel(
      id: id ?? this.id,
      headerID: headerID ?? this.headerID,
      subsidiaryAccount: subsidiaryAccount ?? this.subsidiaryAccount,
      firstDetailedInfo: firstDetailedInfo ?? this.firstDetailedInfo,
      secondDetailedInfo: secondDetailedInfo ?? this.secondDetailedInfo,
      debit: debit ?? this.debit,
      credit: credit ?? this.credit,
      series: series ?? this.series,
      memo: memo ?? this.memo,
      noticeMemo: noticeMemo ?? this.noticeMemo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'headerID': headerID,
      'subsidiaryAccount': subsidiaryAccount.toMap(),
      'firstDetailedInfo': firstDetailedInfo?.toMap(),
      'secondDetailedInfo': secondDetailedInfo?.toMap(),
      'debit': debit,
      'credit': credit,
      'series': series,
      'memo': memo,
      'noticeMemo': noticeMemo,
    };
  }

  factory JournalLineModel.fromMap(Map<String, dynamic> map) {
    return JournalLineModel(
      id: map['id'] as int,
      headerID: map['headerID'] as int,
      subsidiaryAccount: SubsidiaryModel.fromMap(
        map['subsidiaryAccount'] as Map<String, dynamic>,
      ),
      firstDetailedInfo: map['firstDetailedInfo'] == null
          ? null
          : DetailedAccountModel.fromMap(
              map['firstDetailedInfo'] as Map<String, dynamic>,
            ),
      secondDetailedInfo: map['secondDetailedInfo'] == null
          ? null
          : DetailedAccountModel.fromMap(
              map['secondDetailedInfo'] as Map<String, dynamic>,
            ),
      debit: BigInt.parse(map['debit']),
      credit: BigInt.parse(map['credit']),
      series: map['series'] as String,
      memo: map['memo'] != null ? map['memo'] as String : null,
      noticeMemo: map['noticeMemo'] != null
          ? map['noticeMemo'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory JournalLineModel.fromJson(String source) =>
      JournalLineModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
