import 'package:kursdemo/data/firebase_data_source.dart';

class Repository {
  final FirebaseDataSource _firebaseDataSource = FirebaseDataSource();

  Future<void> createLesson({required String lessonTitle}) async {
    _firebaseDataSource.createLesson(lessonTitle: lessonTitle);
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

  Stream getUser() {
    return _firebaseDataSource.getUser();
  }

  Future<void> deleteUser(
      {required String userID,
      required String documentID,
      required String email,
      required String pass}) async {
    await _firebaseDataSource.deleteUser(
        userID: userID, documentID: documentID, email: email, pass: pass);
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

  Future<void> addUser(
      {required String name,
      required String surname,
      required String email,
      required String pass}) async {
    await _firebaseDataSource.addUser(
        name: name, surname: surname, email: email, pass: pass);
  }

  Future<void> socialmedia(
      {required bool showYouTube,
      required bool createSocial,
      required bool showFacebook,
      required bool showInstagram,
      required bool showTwitter,
      required String youtubeLink,
      required String twitterLink,
      required String instagramLink,
      required String facebookLink}) async {
    await _firebaseDataSource.socialMedia(
        showYouTube: showYouTube,
        showFacebook: showFacebook,
        showInstagram: showInstagram,
        showTwitter: showTwitter,
        youtubeLink: youtubeLink,
        twitterLink: twitterLink,
        instagramLink: instagramLink,
        facebookLink: facebookLink,
        createSocial: createSocial);
  }

  Stream getSocialMedia() {
    return _firebaseDataSource.getSocialMedia();
  }
}
