class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(
      {required this.id,
      required this.body,
      required this.title,
      required this.userId});

  factory Post.fromJson(dynamic jsonData) {
    final userId = jsonData['userId'];
    final id = jsonData['id'];
    final body = jsonData['body'];
    final title = jsonData['title'];
    return Post(id: id, body: body, title: title, userId: userId);
  }
}
