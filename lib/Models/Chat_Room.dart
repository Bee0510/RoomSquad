class chatRooms {
  chatRooms({
    required this.id,
    required this.groupName,
    required this.createdAt,
  });
  final String id;

  final String groupName;
  final DateTime createdAt;
  chatRooms.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        groupName = map['name'] ?? 'Untitled',
        createdAt = DateTime.parse(map['created_at']);
}
