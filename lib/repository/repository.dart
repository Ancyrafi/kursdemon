import 'package:kursdemo/data/firebase_data_source.dart';

class Repository {
  final FirebaseDataSource _firebaseDataSource = FirebaseDataSource();

  Future<void> createLesson(
      {required String lessonTitle,
      required String sublessonTitle,
      required String videoLink}) async {
    _firebaseDataSource.createLesson(
        lessonTitle: lessonTitle,
        sublessonTitle: sublessonTitle,
        videoLink: videoLink);
  }

  Future<void> creLesson({required String lessonTitle}) async {
    _firebaseDataSource.creaLesson(lessonTitle: lessonTitle);
  }

  Future<void> createSection(
      {required String sublessonTitle,
      required String videoLink,
      required String lessonId}) async {
    _firebaseDataSource.createSection(
        sublessonTitle: sublessonTitle,
        videoLink: videoLink,
        lessonId: lessonId);
  }

  Stream getLesson() {
    return _firebaseDataSource.getLesson();
  }

  Stream getSection({required String lessonID}) {
    return _firebaseDataSource.getSection(lessonID: lessonID);
  }
}
