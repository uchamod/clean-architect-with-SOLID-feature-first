import 'dart:io';

import 'package:clen_archetecture_bloc_app/core/error/faliure.dart';
import 'package:clen_archetecture_bloc_app/core/usecase/auth/usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/domain/entity/blog.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class BlogUploadUsecase implements Usecase<Blog, Blogparams> {
  final BlogRepository blogRepository;

  BlogUploadUsecase({required this.blogRepository});

  @override
  Future<Either<Faliure, Blog>> call(Blogparams parms) async {
    return await blogRepository.uploadBlog(
      blogTitle: parms.blogTitle,
      blogContent: parms.blogContent,
      posterId: parms.posterId,
      tags: parms.tags,
      image: parms.imageUrl,
    );
  }
}

class Blogparams {
  final String blogTitle;
  final String blogContent;
  final String posterId;
  final File imageUrl;
  final List<String> tags;

  Blogparams({
    required this.blogTitle,
    required this.blogContent,
    required this.posterId,
    required this.imageUrl,
    required this.tags,
  });
}
