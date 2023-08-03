class Profiles {
  Profiles({
    required this.id,
    required this.username,
    required this.createdAt,
  });
  final String id;
  final String username;
  final DateTime createdAt;

  Profiles.fromMap(Map<String, dynamic> map)
      : id = map['id'].toString(),
        username = map['username'],
        createdAt = DateTime.parse(map['created_at']);
}
