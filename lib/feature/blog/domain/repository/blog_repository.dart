import 'package:clen_archetecture_bloc_app/core/error/faliure.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/domain/entity/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Faliure, Blog>> uploadBlog({required Blog blog});
  Future<Either<Faliure, List<Blog>>> getAllBlogs();
}
