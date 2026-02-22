import 'package:clen_archetecture_bloc_app/core/constant/constants.dart';
import 'package:clen_archetecture_bloc_app/core/constant/size_extensions.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_theme.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/domain/entity/blog.dart';
import 'package:flutter/material.dart';

class BlogViwer extends StatelessWidget {
  final Blog blog;
  const BlogViwer({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: AppConstants.horizontalPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(blog.blogTitle, style: AppTheme.titleTextTheme),
              SizedBox(height: 4),
              Text(
                blog.updatedAt.toIso8601String(),
                style: AppTheme.lableTextTheme,
              ),
              SizedBox(height: 4),
              Image.network(
                blog.imageUrl,
                width: double.infinity,
                height: ContextSizeExtension(context).screenHeight * 0.25,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 8),
              Text(blog.blogContent, style: AppTheme.bodyTextTheme),
              SizedBox(height: 8),
              Row(
                children: blog.tags
                    .map(
                      (t) =>
                          Chip(label: Text(t, style: AppTheme.lableTextTheme)),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
