part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String message;

  BlogFailure({required this.message});
}

final class BlogSuccsuss extends BlogState {}

final class BlogSuccsussDisplay extends BlogState {
  final List<Blog> blogs;

  BlogSuccsussDisplay({required this.blogs});
}
