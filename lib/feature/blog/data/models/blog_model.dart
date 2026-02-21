import 'package:clen_archetecture_bloc_app/feature/blog/domain/entity/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.blogId,
    required super.blogTitle,
    required super.blogContent,
    required super.posterId,
    required super.imageUrl,
    required super.tags,
    required super.updatedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      blogId: json["blogId"] as String,
      blogTitle: json["blogTitle"] as String,
      blogContent: json["blogContent"] as String,
      posterId: json["posterId"] as String,
      imageUrl: json["imageUrl"] as String,
      tags: List<String>.from(json["tags"]) ?? [],
      updatedAt: json["updatedAt"] == null
          ? DateTime.now()
          : DateTime.parse(json["updatedAt"]),
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
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  BlogModel copyWith({
    String? blogId,
    String? posterId,
    String? blogTitle,
    String? blogContent,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      blogId: blogId ?? this.blogId,
      posterId: posterId ?? this.posterId,
      blogTitle: blogTitle ?? this.blogTitle,
      blogContent: blogContent ?? this.blogContent,
      imageUrl: imageUrl ?? this.imageUrl,
      tags: topics ?? this.tags,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
