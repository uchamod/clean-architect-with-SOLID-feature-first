import 'package:clen_archetecture_bloc_app/core/constant/constants.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_colors.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_theme.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/presentation/pages/add_new_blog.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Bloc Reader", style: AppTheme.titleTextTheme),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => AddNewBlog()));
              },
              icon: Icon(
                Icons.add_circle_outline,
                color: AppColorPallete.greyColor,
                size: 28,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: AppConstants.horizontalPadding,
          ),
          child: SingleChildScrollView(),
        ),
      ),
    );
  }
}
