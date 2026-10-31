import 'dart:convert';

import 'package:pay_pilot_plus/core/data/models/salary_item_model.dart';

/// خلاصه حقوق یک عضو در بازه انتخاب‌شده
class MemberSalarySummaryModel {
  final ({int id, String name, String code}) memberInfo;

  /// جمع حقوق به‌دست‌آمده در بازه
  final BigInt totalSalary;

  /// مبلغی که در حال حاضر به عضو بدهکاریم (همه بابت‌ها، نه فقط حقوق)
  final BigInt currentBalance;

  final List<SalaryItemModel> items;

  MemberSalarySummaryModel({
    required this.memberInfo,
    required this.totalSalary,
    required this.currentBalance,
    required this.items,
  });

  int get eventsCount => items.map((e) => e.eventInfo?.id).toSet().length;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'memberInfo': <String, dynamic>{
        'id': memberInfo.id,
        'name': memberInfo.name,
        'code': memberInfo.code,
      },
      'totalSalary': totalSalary.toString(),
      'currentBalance': currentBalance.toString(),
      'items': items.map((e) => e.toMap()).toList(),
    };
  }

  factory MemberSalarySummaryModel.fromMap(Map<String, dynamic> map) {
    final member = map['memberInfo'] as Map<String, dynamic>;

    return MemberSalarySummaryModel(
      memberInfo: (
        id: member['id'] as int,
        name: member['name'] as String,
        code: member['code'] as String,
      ),
      totalSalary: BigInt.parse(map['totalSalary'] as String),
      currentBalance: BigInt.parse(map['currentBalance'] as String),
      items: (map['items'] as List)
          .map((e) => SalaryItemModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MemberSalarySummaryModel.fromJson(String source) =>
      MemberSalarySummaryModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
