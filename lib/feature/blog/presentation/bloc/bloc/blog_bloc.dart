import 'dart:io';

import 'package:clen_archetecture_bloc_app/core/usecase/auth/usecase.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/domain/entity/blog.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/domain/usecase/blog_fetch.dart';
import 'package:clen_archetecture_bloc_app/feature/blog/domain/usecase/blog_upload_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogUploadUsecase _blogUploadUsecase;
  final BlogFetchUseCase _blogFetchUseCase;
  BlogBloc({
    required BlogUploadUsecase blogUploadUsecase,
    required BlogFetchUseCase blogFetchUseCase,
  }) : _blogUploadUsecase = blogUploadUsecase,
       _blogFetchUseCase = blogFetchUseCase,
       super(BlogInitial()) {
    // on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_blogUpload);
    on<Blogfetch>(_blogFetch);
  }
  void _blogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final res = await _blogUploadUsecase.call(
      Blogparams(
        blogTitle: event.blogTitle,
        blogContent: event.blogContent,
        posterId: event.posterId,
        imageUrl: event.imageUrl,
        tags: event.tags,
      ),
    );
    res.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(BlogSuccsuss()),
    );
  }

  void _blogFetch(Blogfetch event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final res = await _blogFetchUseCase.call(NoParams());
    res.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (blogs) => emit(BlogSuccsussDisplay(blogs: blogs)),
    );
  }
}
