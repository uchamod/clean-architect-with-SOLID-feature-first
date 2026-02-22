import 'package:clen_archetecture_bloc_app/core/constant/constants.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_colors.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_theme.dart';
import 'package:clen_archetecture_bloc_app/core/utils/snack_bar.dart';
import 'package:clen_archetecture_bloc_app/core/widgets/loading_indicator.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/presentation/bloc/bloc/blog_bloc.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/presentation/pages/add_new_blog.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/presentation/widget/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(Blogfetch());
  }

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
          child: BlocConsumer<BlogBloc, BlogState>(
            listener: (context, state) {
              print("current state $state");
              if (state is BlogFailure) {
                snackBar(context, state.message);
              }
            },
            builder: (context, state) {
              print("current state $state");
              if (state is BlogLoading || state is BlogInitial) {
                return const Loader();
              }
              if (state is BlogSuccsussDisplay) {
                if (state.blogs.isEmpty) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit_document,
                          size: 36,
                          color: AppColorPallete.greyColor,
                        ),
                        Text(
                          "No blogs Avalible",
                          style: AppTheme.titleTextTheme,
                        ),
                      ],
                    ),
                  );
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 16 / 9,
                    ),
                    itemCount: state.blogs.length,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),

                    itemBuilder: (context, index) {
                      return BlogCard(blog: state.blogs[index]);
                    },
                  );
                }
              }
              return SizedBox(
                child: Center(
                  child: Text(
                    "something bad happend",
                    style: AppTheme.subTitleTextTheme,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
