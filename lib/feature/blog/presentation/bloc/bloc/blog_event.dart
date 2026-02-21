part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent {
  final String blogTitle;
  final String blogContent;
  final String posterId;
  final File imageUrl;
  final List<String> tags;

  BlogUpload({
    required this.blogTitle,
    required this.blogContent,
    required this.posterId,
    required this.imageUrl,
    required this.tags,
  });
}
