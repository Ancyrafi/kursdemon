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

  Stream getLesson() {
    return _firebaseDataSource.getLesson();
  }

  Stream getSection({required String lessonID}) {
    return _firebaseDataSource.getSection(lessonID: lessonID);
  }
}
