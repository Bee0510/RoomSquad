class chatRoomUsers {
  chatRoomUsers({
    required this.id,
    required this.chatRoomId,
    required this.userId,
  });
  final String id;
  final String chatRoomId;
  final String userId;

  chatRoomUsers.fromMap({
    required Map<String, dynamic> map,
    required String myUserId,
  })  : id = map['id'].toString(),
        chatRoomId = map['chat_room-id'],
        userId = map['user_id'];
}
