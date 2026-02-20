import 'package:clen_archetecture_bloc_app/feature/blog/domain/entity/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.blogId,
    required super.blogTitle,
    required super.blogContent,
    required super.posterId,
    required super.imageUrl,
    required super.tags,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      blogId: json["blogId"],
      blogTitle: json["blogTitle"],
      blogContent: json["blogContent"],
      posterId: json["posterId"],
      imageUrl: json["imageUrl"],
      tags: json["tags"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "blogId": blogId,
      "blogTitle": blogTitle,
      "blogContent": blogContent,
      "posterId": posterId,
      "imageUrl": imageUrl,
      "tags": tags,
    };
  }
}
