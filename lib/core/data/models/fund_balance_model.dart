// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FundBalanceModel {
  final int id;
  final BigInt debit;
  final BigInt credit;
  final DateTime date;
  final String? memo;
  final String series;
  FundBalanceModel({
    required this.id,
    required this.debit,
    required this.credit,
    required this.date,
    this.memo,
    required this.series,
  });

  FundBalanceModel copyWith({
    int? id,
    BigInt? debit,
    BigInt? credit,
    DateTime? date,
    String? memo,
    String? series,
  }) {
    return FundBalanceModel(
      id: id ?? this.id,
      debit: debit ?? this.debit,
      credit: credit ?? this.credit,
      date: date ?? this.date,
      memo: memo ?? this.memo,
      series: series ?? this.series,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'debit': debit.toString(),
      'credit': credit.toString(),
      'date': date.millisecondsSinceEpoch,
      'memo': memo,
      'series': series,
    };
  }

  factory FundBalanceModel.fromMap(Map<String, dynamic> map) {
    return FundBalanceModel(
      id: map['id'] as int,
      debit: BigInt.parse(map['debit']),
      credit: BigInt.parse(map['credit']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      memo: map['memo'] != null ? map['memo'] as String : null,
      series: map['series'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FundBalanceModel.fromJson(String source) =>
      FundBalanceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
