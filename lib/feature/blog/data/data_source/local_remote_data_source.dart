import 'package:clen_archetecture_bloc_app/feature/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class LocalRemoteDataSource {
  void loadBlogsToLocal(List<BlogModel> blogs);
  List<BlogModel> getLocalBlogs();
}

class LocalRemoteDataSourceImpl implements LocalRemoteDataSource {
  final Box box;

  LocalRemoteDataSourceImpl({required this.box});
  //get blogs from local db
  @override
  List<BlogModel> getLocalBlogs() {
    List<BlogModel> blogModels = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        blogModels.add(BlogModel.fromJson(box.get(i.toString())));
      }
    });
    return blogModels;
  }

  //add blogs to local db
  @override
  void loadBlogsToLocal(List<BlogModel> blogs) {
    box.clear();
    box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        box.put(i.toString(), blogs[i].toJson());
      }
    });
  }
}
