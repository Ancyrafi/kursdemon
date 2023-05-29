import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/repository/repository.dart';

import '../../../model/model.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit(this._repository) : super(BlogState(load: false, blog: []));
  final Repository _repository;
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription = _repository.blogContent().listen((blog) {
      emit(BlogState(load: false, blog: blog));
    })
      ..onError((error) {
        emit(BlogState(load: true, blog: []));
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
