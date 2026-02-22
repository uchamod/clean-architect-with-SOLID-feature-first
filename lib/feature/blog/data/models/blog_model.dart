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
      blogId: json["id"] as String,
      blogTitle: json["title"] as String,
      blogContent: json["content"] as String,
      posterId: json["poster_id"] as String,
      imageUrl: json["img_url"] as String,
      tags: List<String>.from(json["tags"]) ?? [],
      updatedAt: json["updated_at"] == null
          ? DateTime.now()
          : DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": blogId,
      "title": blogTitle,
      "content": blogContent,
      "poster_id": posterId,
      "img_url": imageUrl,
      "tags": tags,
      "updated_at": updatedAt.toIso8601String(),
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
