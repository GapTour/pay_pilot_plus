import 'dart:convert';

import 'package:pay_pilot_plus/core/data/models/user_model.dart';
import 'package:pay_pilot_plus/core/database/app_database.dart'
    show RegistrationStatus, SnacksFeeAssignmentStatus;

class EventRegistrationModel {
  final int id;
  final UserModel user;
  final RegistrationStatus status;
  final BigInt grossAmount;
  final BigInt discountAmount;
  final BigInt netAmount;
  final DateTime registeredAt;
  final bool wasAbsent;
  final int counter;
  final String? description;

  /// بانکی که پرداخت مهمان به آن واریز شده (از روی سند پرداخت)
  final ({int id, String name})? bankInfo;

  /// شخصی که پرداخت مهمان را دریافت کرده (از روی سند پرداخت)
  final ({int id, String name})? assignmentInfo;
  final SnacksFeeAssignmentStatus snacksAssignmentStatus;

  /// شخص یا کیف ذخیره‌ای که هزینه پذیرایی مهمان رایگان به آن واگذار شده
  final ({int id, String name})? snacksAssignmentInfo;

  EventRegistrationModel({
    required this.id,
    required this.user,
    required this.status,
    required this.grossAmount,
    required this.discountAmount,
    required this.netAmount,
    required this.registeredAt,
    required this.wasAbsent,
    required this.counter,
    required this.description,
    required this.bankInfo,
    required this.assignmentInfo,
    required this.snacksAssignmentStatus,
    required this.snacksAssignmentInfo,
  });

  EventRegistrationModel copyWith({
    int? id,
    UserModel? user,
    RegistrationStatus? status,
    BigInt? grossAmount,
    BigInt? discountAmount,
    BigInt? netAmount,
    DateTime? registeredAt,
    bool? wasAbsent,
    int? counter,
    String? description,
    ({int id, String name})? bankInfo,
    ({int id, String name})? assignmentInfo,
    SnacksFeeAssignmentStatus? snacksAssignmentStatus,
    ({int id, String name})? snacksAssignmentInfo,
  }) {
    return EventRegistrationModel(
      id: id ?? this.id,
      user: user ?? this.user,
      status: status ?? this.status,
      grossAmount: grossAmount ?? this.grossAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      netAmount: netAmount ?? this.netAmount,
      registeredAt: registeredAt ?? this.registeredAt,
      wasAbsent: wasAbsent ?? this.wasAbsent,
      counter: counter ?? this.counter,
      description: description ?? this.description,
      bankInfo: bankInfo ?? this.bankInfo,
      assignmentInfo: assignmentInfo ?? this.assignmentInfo,
      snacksAssignmentStatus:
          snacksAssignmentStatus ?? this.snacksAssignmentStatus,
      snacksAssignmentInfo: snacksAssignmentInfo ?? this.snacksAssignmentInfo,
    );
  }

  static Map<String, dynamic>? _infoToMap(({int id, String name})? info) =>
      info == null ? null : {'id': info.id, 'name': info.name};

  static ({int id, String name})? _infoFromMap(dynamic map) =>
      map == null ? null : (id: map['id'] as int, name: map['name'] as String);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user.toMap(),
      'status': status,
      'grossAmount': grossAmount,
      'discountAmount': discountAmount,
      'netAmount': netAmount,
      'registeredAt': registeredAt.millisecondsSinceEpoch,
      'counter': counter,
      'wasAbsent': wasAbsent,
      'description': description,
      'bankInfo': _infoToMap(bankInfo),
      'assignmentInfo': _infoToMap(assignmentInfo),
      'snacksAssignmentStatus': snacksAssignmentStatus.name,
      'snacksAssignmentInfo': _infoToMap(snacksAssignmentInfo),
    };
  }

  factory EventRegistrationModel.fromMap(Map<String, dynamic> map) {
    return EventRegistrationModel(
      id: map['id'] as int,
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      status: RegistrationStatus.fromMap(map['status'] as Map<String, dynamic>),
      grossAmount: BigInt.parse(map['grossAmount']),
      discountAmount: BigInt.parse(map['discountAmount']),
      netAmount: BigInt.parse(map['netAmount']),
      counter: int.parse(map['counter']),
      registeredAt: DateTime.fromMillisecondsSinceEpoch(
        map['registeredAt'] as int,
      ),
      wasAbsent: map['wasAbsent'] as bool,
      description: map['description'] as String?,
      bankInfo: _infoFromMap(map['bankInfo']),
      assignmentInfo: _infoFromMap(map['assignmentInfo']),
      snacksAssignmentStatus: SnacksFeeAssignmentStatus.values.byName(
        map['snacksAssignmentStatus'] as String,
      ),
      snacksAssignmentInfo: _infoFromMap(map['snacksAssignmentInfo']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventRegistrationModel.fromJson(String source) =>
      EventRegistrationModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
