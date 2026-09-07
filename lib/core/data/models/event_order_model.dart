class OrderModel {
  final int id;
  final List<int> orders;
  final bool isDelivered;
  final int eventID;
  final int userID;
  final String userName;

  OrderModel({
    required this.id,
    required this.orders,
    required this.isDelivered,
    required this.eventID,
    required this.userID,
    required this.userName,
  });
}
