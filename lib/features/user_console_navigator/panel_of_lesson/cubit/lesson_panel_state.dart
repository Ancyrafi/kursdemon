part of 'lesson_panel_cubit.dart';

class LessonPanelState {
  LessonPanelState(
      {required this.addLesson,
      required this.errormsg,
      required this.loading,
      required this.lesson,
      required this.lessonID,
      required this.addSection});
  bool addLesson = false;
  bool addSection = false;
  String errormsg;
  String lessonID;
  bool loading = false;
  final List<Lesson> lesson;

  LessonPanelState copyWith({
    String? lessonID,
    bool? addSection,
    bool? addLesson,
    String? errormsg,
    bool? loading,
    List<Lesson>? lesson,
  }) {
    return LessonPanelState(
      lessonID: lessonID ?? this.lessonID,
      addSection: addSection ?? this.addSection,
      addLesson: addLesson ?? this.addLesson,
      errormsg: errormsg ?? this.errormsg,
      loading: loading ?? this.loading,
      lesson: lesson ?? this.lesson,
    );
  }
}
