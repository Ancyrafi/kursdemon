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
          addSection: false,
          limitLesson: false,
          limitSection: false,
        ));
  final Repository _repository;
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription = _repository.getLesson().listen((lesson) {
      _repository.limitLesson().then((limitLesson) {
        emit(LessonPanelState(
            addLesson: false,
            errormsg: '',
            lessonID: '',
            loading: false,
            lesson: lesson,
            addSection: false,
            limitLesson: limitLesson,
            limitSection: false));
      });
    })
      ..onError((error) {
        emit(LessonPanelState(
            addSection: false,
            addLesson: false,
            lessonID: '',
            errormsg: error.toString(),
            loading: true,
            lesson: [],
            limitLesson: false,
            limitSection: false));
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
    await _repository.createLesson(lessonTitle: lessonTitle);
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

  Future<void> start2() async {
    _streamSubscription = _repository.getLesson().listen((lesson) async {
      bool limitLesson = await _repository.limitLesson();
      bool limitSection = false;
      for (final oneLesson in lesson) {
        limitSection =
            await _repository.limitSections(lessonID: oneLesson.lessonID);
        if (limitSection) {
          break; // przerywamy pętlę jak tylko znajdziemy lekcję z przekroczonym limitem sekcji
        }
      }
      emit(LessonPanelState(
          addLesson: false,
          errormsg: '',
          lessonID: '',
          loading: false,
          lesson: lesson,
          addSection: false,
          limitLesson: limitLesson,
          limitSection: limitSection));
    })
      ..onError((error) {
        emit(LessonPanelState(
            addSection: false,
            addLesson: false,
            lessonID: '',
            errormsg: error.toString(),
            loading: true,
            lesson: [],
            limitLesson: false,
            limitSection: false));
      });
  }
}
