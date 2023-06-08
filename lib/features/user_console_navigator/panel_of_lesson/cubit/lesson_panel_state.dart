part of 'lesson_panel_cubit.dart';

class LessonPanelState {
  LessonPanelState(
      {required this.addLesson,
      required this.errormsg,
      required this.loading,
      required this.lesson,
      required this.lessonID,
      required this.addSection,
      required this.limitLesson,
      required this.limitSection});
  bool addLesson = false;
  bool addSection = false;
  String errormsg;
  String lessonID;
  bool loading = false;
  bool limitLesson = false;
  bool limitSection = false;
  final List<Lesson> lesson;

  LessonPanelState copyWith({
    String? lessonID,
    bool? addSection,
    bool? addLesson,
    String? errormsg,
    bool? loading,
    List<Lesson>? lesson,
    bool? limitLesson,
    bool? limitSection
  }) {
    return LessonPanelState(
      limitLesson: limitLesson ?? this.limitLesson,
      limitSection: limitSection ?? this.limitSection,
      lessonID: lessonID ?? this.lessonID,
      addSection: addSection ?? this.addSection,
      addLesson: addLesson ?? this.addLesson,
      errormsg: errormsg ?? this.errormsg,
      loading: loading ?? this.loading,
      lesson: lesson ?? this.lesson,
    );
  }
}
