import 'dart:convert';

import 'package:pay_pilot_plus/core/utils/helpers/data_models_helper.dart';

class OrderModel {
  final int id;
  final List<int> orders;
  final bool isDelivered;
  final ({int id, String name}) eventInfo;
  final ({int id, String name}) userInfo;

  OrderModel({
    required this.id,
    required this.orders,
    required this.isDelivered,
    required this.eventInfo,
    required this.userInfo,
    teamInfo,
  });

  OrderModel copyWith({
    int? id,
    List<int>? orders,
    bool? isDelivered,
    ({int id, String name})? eventInfo,
    ({int id, String name})? userInfo,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orders: orders ?? this.orders,
      isDelivered: isDelivered ?? this.isDelivered,
      eventInfo: eventInfo ?? this.eventInfo,
      userInfo: userInfo ?? this.userInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orders': orders,
      'isDelivered': isDelivered,
      'eventInfo': <String, dynamic>{
        'id': eventInfo.id,
        'name': eventInfo.name,
      },
      'userInfo': <String, dynamic>{'id': userInfo.id, 'name': userInfo.name},
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    final eventInfoData = map['eventInfo'];
    final userInfoData = map['userInfo'];

    return OrderModel(
      id: map['id'] as int,
      orders: List<int>.from((map['orders'] as List<int>)),
      isDelivered: map['isDelivered'] as bool,
      eventInfo: DataModelsHelper.parseInfo(eventInfoData),
      userInfo: DataModelsHelper.parseInfo(userInfoData),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
