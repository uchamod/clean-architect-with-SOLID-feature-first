import 'package:clen_archetecture_bloc_app/core/error/exception.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class RemoteDataSource {
  Future<BlogModel> uploadBlog({required BlogModel blog});
  Future<List<BlogModel>> getAllBlogs();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final SupabaseClient supabaseClient;

  RemoteDataSourceImpl({required this.supabaseClient});
  //get all blogs
  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      return [];
    } on PostgrestException catch (e) {
      throw ServerException(message: e.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  //upload blog data
  @override
  Future<BlogModel> uploadBlog({required BlogModel blog}) async {
    try {
      final blogData = await supabaseClient
          .from("blogs")
          .insert(blog.toJson())
          .select();
      return BlogModel.fromJson(blogData.first);
    } on PostgrestException catch (e) {
      throw ServerException(message: e.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
