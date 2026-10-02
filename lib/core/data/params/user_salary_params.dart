class UserSalaryParams {
  final ({int id, String name, int accountID}) userInfo;
  final BigInt salary;

  UserSalaryParams({required this.userInfo, required this.salary});
}
