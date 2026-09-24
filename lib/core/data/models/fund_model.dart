import 'dart:convert';

class FundModel {
  final int id;
  final String title;
  final BigInt openingBalance;
  final bool isActive;

  FundModel({
    required this.id,
    required this.title,
    required this.openingBalance,
    required this.isActive,
  });

  FundModel copyWith({
    int? id,
    String? title,
    BigInt? openingBalance,
    bool? isActive,
  }) {
    return FundModel(
      id: id ?? this.id,
      title: title ?? this.title,
      openingBalance: openingBalance ?? this.openingBalance,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'openingBalance': openingBalance,
      'isActive': isActive,
    };
  }

  factory FundModel.fromMap(Map<String, dynamic> map) {
    return FundModel(
      id: map['id'] as int,
      title: map['title'] as String,
      openingBalance: BigInt.parse(map['openingBalance']),
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory FundModel.fromJson(String source) =>
      FundModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
