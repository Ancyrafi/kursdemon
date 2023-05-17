part of 'lesson_cubit.dart';

class LessonState {
  LessonState({required this.loading, required this.errormsg, required this.lesson, });
  bool loading = false;
  String errormsg = '';
  final List<Lesson> lesson;

}
