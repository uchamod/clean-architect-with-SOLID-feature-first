import 'package:clen_archetecture_bloc_app/core/theme/app_colors.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_theme.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/domain/entity/blog.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/presentation/pages/blog_viwer.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  const BlogCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => BlogViwer(blog: blog)));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColorPallete.gradient3, width: 1),
        ),
        child: Column(
          children: [
            //title
            Text(blog.blogTitle, style: AppTheme.titleTextTheme),
            SizedBox(height: 4),
            //image
            Image.network(blog.imageUrl),
            SizedBox(height: 4),
            //content shink
            Text(
              blog.blogTitle,
              style: AppTheme.titleTextTheme,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
