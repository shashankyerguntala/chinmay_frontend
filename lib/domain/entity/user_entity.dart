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
}
