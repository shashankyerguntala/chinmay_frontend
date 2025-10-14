class UserEntity {
  final int id;
  final String username;
  final String email;
  final List<String> role;

  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
  });

  UserEntity copyWith({
    int? id,
    String? username,
    String? email,
    List<String>? role,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      role: role ?? List<String>.from(this.role),
    );
  }
}
