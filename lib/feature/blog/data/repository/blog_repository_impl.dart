import 'package:clen_archetecture_bloc_app/core/error/faliure.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/data/data_source/remote_data_source.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/data/models/blog_model.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class BlogRepositoryImpl implements BlogRepository {
  final RemoteDataSource remoteDataSource;

  BlogRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Faliure, List<BlogModel>>> getAllBlogs() async {
    try {
      final blogs = await remoteDataSource.getAllBlogs();
      return right(blogs);
    } catch (e) {
      return left(Faliure(statusCode: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<Faliure, BlogModel>> uploadBlog({
    required BlogModel blog,
  }) async {
    try {
      final blogData = await remoteDataSource.uploadBlog(blog: blog);
      return right(blogData);
    } catch (e) {
      return left(Faliure(statusCode: 500, message: e.toString()));
    }
  }
}
