import 'dart:convert';

import 'package:pay_pilot_plus/core/utils/helpers/data_models_helper.dart';

class FundBalanceModel {
  final int id;
  final BigInt debit;
  final BigInt credit;
  final DateTime date;
  final ({int id, String name}) eventInfo;
  FundBalanceModel({
    required this.id,
    required this.debit,
    required this.credit,
    required this.date,
    required this.eventInfo,
  });

  FundBalanceModel copyWith({
    int? id,
    BigInt? debit,
    BigInt? credit,
    DateTime? date,
    ({int id, String name})? eventInfo,
  }) {
    return FundBalanceModel(
      id: id ?? this.id,
      debit: debit ?? this.debit,
      credit: credit ?? this.credit,
      date: date ?? this.date,
      eventInfo: eventInfo ?? this.eventInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'debit': debit.toString(),
      'credit': credit.toString(),
      'date': date.millisecondsSinceEpoch,
      'eventInfo': <String, dynamic>{
        'id': eventInfo.id,
        'name': eventInfo.name,
      },
    };
  }

  factory FundBalanceModel.fromMap(Map<String, dynamic> map) {
    final eventInfoData = map['eventInfo'];

    return FundBalanceModel(
      id: map['id'] as int,
      debit: BigInt.parse(map['debit']),
      credit: BigInt.parse(map['credit']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      eventInfo: DataModelsHelper.parseInfo(eventInfoData),
    );
  }

  String toJson() => json.encode(toMap());

  factory FundBalanceModel.fromJson(String source) =>
      FundBalanceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
