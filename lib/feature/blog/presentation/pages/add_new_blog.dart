import 'dart:io';

import 'package:clen_archetecture_bloc_app/core/constant/constants.dart';
import 'package:clen_archetecture_bloc_app/core/constant/size_extensions.dart';
import 'package:clen_archetecture_bloc_app/core/cubit/app_user_cubit/app_user_cubit.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_colors.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_theme.dart';
import 'package:clen_archetecture_bloc_app/core/utils/functions.dart';
import 'package:clen_archetecture_bloc_app/core/utils/snack_bar.dart';
import 'package:clen_archetecture_bloc_app/core/widgets/loading_indicator.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/widgets/auth_button.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/presentation/bloc/bloc/blog_bloc.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/presentation/pages/home.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/presentation/widget/blog_text_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlog extends StatefulWidget {
  const AddNewBlog({super.key});

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? imageFile;
  //select image from gallery
  void _selectImage() async {
    final pickedImage = await selectImage();
    if (pickedImage != null) {
      setState(() {
        imageFile = pickedImage;
      });
    }
  }

  //upload new blog
  void _uploadBlog() {
    if (_formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        imageFile != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).appUser.id;
      context.read<BlogBloc>().add(
        BlogUpload(
          blogTitle: _titleController.text.trim(),
          blogContent: _bodyController.text.trim(),
          posterId: posterId,
          imageUrl: imageFile!,
          tags: selectedTopics,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _bodyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Reader", style: AppTheme.titleTextTheme),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: AppConstants.horizontalPadding,
        ),
        child: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              print(state.message);
              snackBar(context, state.message);
            } else if (state is BlogSuccsuss) {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => HomePage()));
              snackBar(context, "Add new Blog succsussfuly");
            }
          },
          builder: (context, state) {
            if (context is BlogLoading) {
              return const Loader();
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _selectImage();
                    },
                    child: imageFile != null
                        ? GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: SizedBox(
                              width: double.infinity,
                              height:
                                  ContextSizeExtension(context).screenHeight *
                                  0.2,
                              child: Image.file(
                                imageFile!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        : DottedBorder(
                            options: RectDottedBorderOptions(
                              color: AppColorPallete.greyColor,
                              dashPattern: [10, 4],
                              strokeCap: StrokeCap.round,
                            ),
                            child: Container(
                              width: double.infinity,
                              height:
                                  ContextSizeExtension(context).screenHeight *
                                  0.2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.filter,
                                    color: AppColorPallete.greyColor,
                                    size: 36,
                                  ),
                                  Text(
                                    "Add your blog image here",
                                    style: AppTheme.bodyTextTheme,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          ["Technology", "Sports", "Entertaitment", "Natural"]
                              .map(
                                (text) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (selectedTopics.contains(text)) {
                                        selectedTopics.remove(text);
                                      } else {
                                        selectedTopics.add(text);
                                      }
                                      setState(() {});
                                    },
                                    child: Chip(
                                      padding: EdgeInsets.all(4),
                                      backgroundColor:
                                          AppColorPallete.backgroundColor,
                                      autofocus: true,
                                      color: selectedTopics.contains(text)
                                          ? WidgetStateProperty.all(
                                              AppColorPallete.gradient1,
                                            )
                                          : null,
                                      label: Text(
                                        text,
                                        style: AppTheme.subTitleTextTheme,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //blog title
                        BlogTextEditor(
                          controller: _titleController,
                          hintText: "Blog Title",
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(height: 12),
                        //blog content
                        BlogTextEditor(
                          controller: _bodyController,
                          hintText: "Blog Content",
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(height: 12),
                        //add new blog
                        AuthButton(
                          buttonText: "Add Blog",
                          onPressed: () {
                            _uploadBlog();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
