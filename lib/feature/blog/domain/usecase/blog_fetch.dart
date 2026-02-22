import 'package:clen_archetecture_bloc_app/core/error/faliure.dart';
import 'package:clen_archetecture_bloc_app/core/usecase/auth/usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/domain/entity/blog.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/src/either.dart';

// ignore: camel_case_types
class BlogFetchUseCase implements Usecase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  BlogFetchUseCase({required this.blogRepository});
  @override
  Future<Either<Faliure, List<Blog>>> call(NoParams parms) async {
    return await blogRepository.getAllBlogs();
  }
}
