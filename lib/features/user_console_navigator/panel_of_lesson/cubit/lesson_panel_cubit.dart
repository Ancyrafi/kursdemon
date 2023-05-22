import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/model/model.dart';
import 'package:kursdemo/repository/repository.dart';

part 'lesson_panel_state.dart';

class LessonPanelCubit extends Cubit<LessonPanelState> {
  LessonPanelCubit(this._repository)
      : super(LessonPanelState(
            lesson: [],
            errormsg: '',
            loading: false,
            addLesson: false,
            lessonID: '',
            addSection: false));
  final Repository _repository;
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription = _repository.getLesson().listen((lesson) {
      emit(LessonPanelState(
          addLesson: false,
          errormsg: '',
          lessonID: '',
          loading: false,
          lesson: lesson,
          addSection: false));
    })
      ..onError((error) {
        emit(LessonPanelState(
            addSection: false,
            addLesson: false,
            lessonID: '',
            errormsg: error.toString(),
            loading: true,
            lesson: []));
      });
  }

  Future<void> addLesson(bool value) async {
    return emit(state.copyWith(addLesson: value));
  }

  Future<void> exit() async {
    return emit(state.copyWith(addLesson: false, addSection: false));
  }

  Future<void> addSection(String lessonID) async {
    return emit(state.copyWith(addSection: true, lessonID: lessonID));
  }

  Future<void> createLesson(String lessonTitle) async {
    _repository.creLesson(lessonTitle: lessonTitle);
  }

  Future<void> createSection(
      {required String lessonID,
      required String sublessonTitle,
      required String videoLink}) async {
    _repository.createSection(
        sublessonTitle: sublessonTitle,
        videoLink: videoLink,
        lessonId: lessonID);
  }

  Future<void> deleteLesson(String lessonID) async {
    await _repository.deleteLesson(lessonID);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
