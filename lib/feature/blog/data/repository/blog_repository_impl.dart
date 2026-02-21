import 'dart:io';

import 'package:clen_archetecture_bloc_app/core/error/exception.dart';
import 'package:clen_archetecture_bloc_app/core/error/faliure.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/data/data_source/remote_data_source.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/data/models/blog_model.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final RemoteDataSource remoteDataSource;

  BlogRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Faliure, BlogModel>> uploadBlog({
    required String blogTitle,
    required String blogContent,
    required String posterId,
    required List<String> tags,
    required File image,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        blogId: Uuid().v1(),
        blogTitle: blogTitle,
        blogContent: blogContent,
        posterId: posterId,
        imageUrl: "",
        tags: tags,
        updatedAt: DateTime.now(),
      );

      final String imageUrl = await remoteDataSource.uploadBlogImage(
        blog: blogModel,
        image: image,
      );
      blogModel.copyWith(imageUrl: imageUrl);

      final blog = await remoteDataSource.uploadBlog(blog: blogModel);
      return right(blog);
    } on ServerException catch (e) {
      return left(Faliure(statusCode: 500, message: e.message));
    } catch (e) {
      return left(Faliure(statusCode: 400, message: e.toString()));
    }
  }

  // @override
  // Future<Either<Faliure, List<BlogModel>>> getAllBlogs() async {
  //   try {
  //     //final blogs = await remoteDataSource.getAllBlogs();
  //     return right(blogs);
  //   } catch (e) {
  //     return left(Faliure(statusCode: 500, message: e.toString()));
  //   }
  // }
}
