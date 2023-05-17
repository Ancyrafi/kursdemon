import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/model/model.dart';
import 'package:kursdemo/repository/repository.dart';

part 'lesson_state.dart';

class LessonCubit extends Cubit<LessonState> {
  LessonCubit(this._repository)
      : super(
          LessonState(
            loading: false,
            errormsg: '',
            lesson: [],

          ),
        );
  final Repository _repository;


  StreamSubscription? _streamSubscription;

Future<void> start() async {
  _streamSubscription = _repository.getLesson().listen(
    (lesson) {
      emit(LessonState(
        loading: false,
        errormsg: '',
        lesson: lesson,
      ));
    },
  )..onError((error) {
      emit(LessonState(
        loading: true,
        errormsg: error.toString(),
        lesson: [],
      ));
    });
}

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
