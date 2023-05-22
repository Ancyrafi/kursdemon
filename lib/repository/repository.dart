import 'package:kursdemo/data/firebase_data_source.dart';

class Repository {
  final FirebaseDataSource _firebaseDataSource = FirebaseDataSource();

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

  Future<void> deleteLesson(String lessonID) async {
    await _firebaseDataSource.deleteLesson(lessonId: lessonID);
  }

  Future<void> deleteSection(
      {required String lessonID, required String sectionID}) async {
    await _firebaseDataSource.deletSection(
        lessonid: lessonID, sectionid: sectionID);
  }
}
