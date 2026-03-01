class AlbumsModel {
  final int userId;
  final int id;
  final String title;

  AlbumsModel({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory AlbumsModel.fromMap(Map<String, dynamic> json) {
    return AlbumsModel(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
    );
  }
}