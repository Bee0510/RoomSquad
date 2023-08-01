class chatRooms {
  chatRooms({
    required this.id,
    required this.groupName,
    required this.roomCode,
  });
  final String id;
  final String groupName;
  final String roomCode;
  chatRooms.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        groupName = map['name'],
        roomCode = map['room_code'];
}
