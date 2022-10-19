class User {
  final int userId;
  final int id;
  final String title;
  final String? body;

  User(this.userId, this.id, this.title, this.body);

  @override
  String toString() {
    return 'User{userId: $userId, id: $id, title: $title, body: $body}';
  }
}