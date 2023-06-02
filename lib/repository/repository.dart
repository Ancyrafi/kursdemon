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

  Future<void> showYoutube(
      {required bool showYT, required String socialID}) async {
    await _firebaseDataSource.showYT(showYT: showYT, socialID: socialID);
  }

  Future<void> showInstagram(
      {required bool showINST, required String socialID}) async {
    await _firebaseDataSource.showInsta(
        showInsta: showINST, socialID: socialID);
  }

  Future<void> showTwitter(
      {required bool showTwitter, required String socialID}) async {
    await _firebaseDataSource.showTt(showTt: showTwitter, socialID: socialID);
  }

  Future<void> showFacebook(
      {required bool showFB, required String socialID}) async {
    await _firebaseDataSource.showFB(showfB: showFB, socialID: socialID);
  }

  Future<void> youtubeLinkSet(
      {required String youtubeLink, required String sociaID}) async {
    await _firebaseDataSource.linkYT(linkYt: youtubeLink, socialID: sociaID);
  }

  Future<void> instaLinkSet(
      {required String instaLink, required String sociaID}) async {
    await _firebaseDataSource.linkInsta(
        linkInsta: instaLink, socialID: sociaID);
  }

  Future<void> twitterLinkSet(
      {required String twitterLink, required String sociaID}) async {
    await _firebaseDataSource.linkTwitter(
        linkTwitter: twitterLink, socialID: sociaID);
  }

  Future<void> facebookLinkSet(
      {required String facebokLink, required String sociaID}) async {
    await _firebaseDataSource.linkFB(linkFB: facebokLink, socialID: sociaID);
  }

  // kod odpowiedzialny za bloga
  Future<void> addBlog(
      {required String blogText, required String title}) async {
    await _firebaseDataSource.addBlogSequence(
        addBlog: blogText, blogTitle: title);
  }

  Future<void> deleteBlogSection({required String blogID}) async {
    await _firebaseDataSource.deleteBlogSequence(blogID: blogID);
  }

  Future<void> editBlogText(
      {required String blogText, required String blogID}) async {
    await _firebaseDataSource.editBlogSequence(
        blogText: blogText, blogID: blogID);
  }

  Stream blogContent() {
    return _firebaseDataSource.getBlogText();
  }

  Future<void> logIn({required String email, required String pass}) async {
    await _firebaseDataSource.logIn(email: email, pass: pass);
  }

  Future<void> logOut() async {
    await _firebaseDataSource.logOut();
  }
}
