import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursdemo/model/model.dart';


part 'lesson_panel_state.dart';

class LessonPanelCubit extends Cubit<LessonPanelState> {
  LessonPanelCubit() : super(LessonPanelState(
    lesson: [],
    errormsg: '',
    loading: false,
    addLesson: false,
  ));
}
