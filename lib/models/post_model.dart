class PostModel {
  final String username;
  final String postType;
  final String postTitle;
  final String postDescription;
  final String thumbnailImageRef;
  final List<String> categories;
  // final int likes;
  // final List
  final DateTime createdAt;

  PostModel(
      {required this.postTitle,
      required this.username,
      required this.postType,
      required this.postDescription,
      required this.thumbnailImageRef,
      required this.categories,
      required this.createdAt});
}
