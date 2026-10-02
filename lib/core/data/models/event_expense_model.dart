import 'dart:convert';

import 'package:pay_pilot_plus/core/data/models/fund_balance_model.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart'
    show SubsidiaryAccountType;
import 'package:pay_pilot_plus/core/utils/helpers/data_models_helper.dart';

class EventExpenseModel {
  final String series;
  final SubsidiaryAccountType subsidiaryAccountType;
  final ({int id, String name}) eventInfo;
  final ({int id, String name})? bankInfo;
  final ({int id, String name})? staffInfo;
  final FundBalanceModel? fundBalance;
  final BigInt amount;
  final DateTime paidAt;

  new({
    required this.series,
    required this.subsidiaryAccountType,
    required this.eventInfo,
    required this.bankInfo,
    required this.staffInfo,
    required this.fundBalance,
    required this.amount,
    required this.paidAt,
  });

  EventExpenseModel copyWith({
    String? series,
    SubsidiaryAccountType? subsidiaryAccountType,
    ({int id, String name})? eventInfo,
    ({int id, String name})? bankInfo,
    ({int id, String name})? staffInfo,
    FundBalanceModel? fundBalance,
    BigInt? amount,
    DateTime? paidAt,
  }) {
    return EventExpenseModel(
      series: series ?? this.series,
      subsidiaryAccountType:
          subsidiaryAccountType ?? this.subsidiaryAccountType,
      eventInfo: eventInfo ?? this.eventInfo,
      bankInfo: bankInfo ?? this.bankInfo,
      staffInfo: staffInfo ?? this.staffInfo,
      fundBalance: fundBalance ?? this.fundBalance,
      amount: amount ?? this.amount,
      paidAt: paidAt ?? this.paidAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'series': series,
      'subsidiaryAccountType': subsidiaryAccountType.title,
      'eventInfo': <String, dynamic>{
        'id': eventInfo.id,
        'name': eventInfo.name,
      },
      'bankInfo': bankInfo == null
          ? null
          : <String, dynamic>{'id': bankInfo!.id, 'name': bankInfo!.name},

      'staffInfo': staffInfo == null
          ? null
          : <String, dynamic>{'id': staffInfo!.id, 'name': staffInfo!.name},
      'fundBalance': fundBalance?.toMap(),
      'amount': amount.toString(),
      'paidAt': paidAt.millisecondsSinceEpoch,
    };
  }

  factory EventExpenseModel.fromMap(Map<String, dynamic> map) {
    final eventInfoData = map['eventInfo'];
    final bankInfoData = map['bankInfo'];
    final staffInfoData = map['staffInfo'];

    return EventExpenseModel(
      series: map['series'] as String,
      subsidiaryAccountType: SubsidiaryAccountType.fromTitle(
        map['subsidiaryAccountType'],
      ),
      eventInfo: DataModelsHelper.parseInfo(eventInfoData),
      bankInfo: bankInfoData == null
          ? null
          : DataModelsHelper.parseInfo(bankInfoData),
      staffInfo: staffInfoData == null
          ? null
          : DataModelsHelper.parseInfo(staffInfoData),
      amount: BigInt.parse(map['amount']),
      fundBalance: map['fundBalance'] == null
          ? null
          : FundBalanceModel.fromMap(map['fundBalance']),
      paidAt: DateTime.fromMillisecondsSinceEpoch(map['paidAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventExpenseModel.fromJson(String source) =>
      EventExpenseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
