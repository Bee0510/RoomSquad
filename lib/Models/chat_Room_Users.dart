class chatRoomUsers {
  chatRoomUsers({
    required this.profileid,
    required this.RoomId,
    required this.created_at,
  });
  final String profileid;
  final String RoomId;
  final DateTime created_at;

  chatRoomUsers.fromMap(
    Map<String, dynamic> map,
  )   : profileid = map['profile_id'],
        RoomId = map['room_id'],
        created_at = DateTime.parse(map['created_at']);
}
