import 'dart:io';

import 'package:clen_archetecture_bloc_app/feature/blog/domain/usecase/blog_upload_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogUploadUsecase blogUploadUsecase;
  BlogBloc(this.blogUploadUsecase) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_blogUpload);
  }
  void _blogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await blogUploadUsecase.call(
      Blogparams(
        blogTitle: event.blogTitle,
        blogContent: event.blogContent,
        posterId: event.posterId,
        imageUrl: event.imageUrl,
        tags: event.tags,
      ),
    );
    res.fold((l)=>emit(BlogFailure(message: l.message)), (r)=>emit(BlogSuccsuss()));
  }
}
