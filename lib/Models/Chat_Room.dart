class chatRooms {
  chatRooms({
    required this.id,
    required this.groupName,
    required this.roomCode,
  });
  final int id;
  final String groupName;
  final String roomCode;
  chatRooms.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        groupName = map['name'] ?? 'Untitled',
        roomCode = map['room_code'];
}
