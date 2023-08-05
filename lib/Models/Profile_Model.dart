class Profiles {
  Profiles({
    required this.id,
    required this.username,
  });
  final String id;
  final String username;

  Profiles.fromMap(Map<String, dynamic> map)
      : id = map['id'].toString(),
        username = map['username'];
}
