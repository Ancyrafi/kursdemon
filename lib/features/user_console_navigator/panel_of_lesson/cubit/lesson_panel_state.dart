part of 'lesson_panel_cubit.dart';

class LessonPanelState {
  LessonPanelState(
      {required this.addLesson, required this.errormsg, required this.loading, required this.lesson});
  bool addLesson = false;
  String errormsg;
  bool loading = false;
  final List<Lesson> lesson;
}
