import 'dart:convert';

/// یک قلم حقوق: مبلغی که یک عضو بابت یک رویداد به دست آورده است
class SalaryItemModel {
  final int id;
  final ({int id, String name, String code}) memberInfo;
  final ({int id, String name})? eventInfo;
  final BigInt amount;
  final DateTime date;
  final String? memo;

  SalaryItemModel({
    required this.id,
    required this.memberInfo,
    required this.eventInfo,
    required this.amount,
    required this.date,
    this.memo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'memberInfo': <String, dynamic>{
        'id': memberInfo.id,
        'name': memberInfo.name,
        'code': memberInfo.code,
      },
      'eventInfo': eventInfo == null
          ? null
          : <String, dynamic>{'id': eventInfo!.id, 'name': eventInfo!.name},
      'amount': amount.toString(),
      'date': date.toIso8601String(),
      'memo': memo,
    };
  }

  factory SalaryItemModel.fromMap(Map<String, dynamic> map) {
    final member = map['memberInfo'] as Map<String, dynamic>;
    final event = map['eventInfo'] as Map<String, dynamic>?;

    return SalaryItemModel(
      id: map['id'] as int,
      memberInfo: (
        id: member['id'] as int,
        name: member['name'] as String,
        code: member['code'] as String,
      ),
      eventInfo: event == null
          ? null
          : (id: event['id'] as int, name: event['name'] as String),
      amount: BigInt.parse(map['amount'] as String),
      date: DateTime.parse(map['date'] as String),
      memo: map['memo'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory SalaryItemModel.fromJson(String source) =>
      SalaryItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
