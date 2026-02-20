import 'dart:io';

import 'package:clen_archetecture_bloc_app/core/constant/constants.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_colors.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_theme.dart';
import 'package:clen_archetecture_bloc_app/core/utils/functions.dart';
import 'package:clen_archetecture_bloc_app/feature/auth/presentation/widgets/auth_button.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/presentation/widget/blog_text_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

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
  void _selectImage() async {
    final pickedImage = await selectImage();
    if (pickedImage != null) {
      setState(() {
        imageFile = pickedImage;
      });
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
        child: SingleChildScrollView(
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
                          height: double.infinity,
                          child: Image.file(imageFile!, fit: BoxFit.contain),
                        ),
                      )
                    : DottedBorder(
                        options: RectDottedBorderOptions(
                          color: AppColorPallete.greyColor,
                          dashPattern: [10, 4],
                          strokeCap: StrokeCap.round,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ["Technology", "Sports", "Entertaitment", "Natural"]
                      .map(
                        (text) => GestureDetector(
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
                            backgroundColor: AppColorPallete.backgroundColor,
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
                    AuthButton(buttonText: "Add Blog", onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
