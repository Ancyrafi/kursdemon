import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/model/model.dart';
import 'package:kursdemo/repository/repository.dart';

part 'my_blog_state.dart';

class MyBlogCubit extends Cubit<MyBlogState> {
  MyBlogCubit(this._repository)
      : super(MyBlogState(
          blogText: [],
          addBlog: false,
          editBlog: false,
        ));
  final Repository _repository;
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription = _repository.blogContent().listen((blogContent) {
      emit(MyBlogState(addBlog: false, editBlog: false, blogText: blogContent));
    })
      ..onError((error) {
        emit(MyBlogState(addBlog: false, editBlog: false, blogText: []));
      });
  }

  Future<void> addBlog(
      {required String blogText, required String title}) async {
    await _repository.addBlog(blogText: blogText, title: title);
  }

  Future<void> deleteBlog({required String blogID}) async {
    await _repository.deleteBlogSection(blogID: blogID);
  }

  Future<void> editBlog(
      {required String blogText, required String blogID}) async {
    _repository.editBlogText(blogText: blogText, blogID: blogID);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
