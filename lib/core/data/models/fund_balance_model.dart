import 'dart:convert';

class FundBalanceModel {
  final int id;
  final BigInt debit;
  final BigInt credit;
  final DateTime date;
  FundBalanceModel({
    required this.id,
    required this.debit,
    required this.credit,
    required this.date,
  });

  FundBalanceModel copyWith({
    int? id,
    BigInt? debit,
    BigInt? credit,
    DateTime? date,
  }) {
    return FundBalanceModel(
      id: id ?? this.id,
      debit: debit ?? this.debit,
      credit: credit ?? this.credit,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'debit': debit.toString(),
      'credit': credit.toString(),
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory FundBalanceModel.fromMap(Map<String, dynamic> map) {
    return FundBalanceModel(
      id: map['id'] as int,
      debit: BigInt.parse(map['debit']),
      credit: BigInt.parse(map['credit']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory FundBalanceModel.fromJson(String source) =>
      FundBalanceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
