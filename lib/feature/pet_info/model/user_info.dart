class UserInfo {
  final int money;

  UserInfo({
    required this.money,
  });

  UserInfo copyWith({
    int? money,
  }) {
    return UserInfo(
      money: money ?? this.money,
    );
  }
}
