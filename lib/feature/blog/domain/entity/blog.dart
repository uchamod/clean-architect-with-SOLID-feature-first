class Blog {
  final String blogId;
  final String blogTitle;
  final String blogContent;
  final String posterId;
  final String imageUrl;
  final List<String> tags;

  Blog({
    required this.blogId,
    required this.blogTitle,
    required this.blogContent,
    required this.posterId,
    required this.imageUrl,
    required this.tags,
  });
}
